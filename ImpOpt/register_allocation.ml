(**
   Allocation de registres.
   On travaille sur la représentation intermédiaire AIMP.

   Objectif : 
     dans chaque fonction, associer chaque registre virtuel
     à un emplacement mémoire physique (on dit qu'on "réalise"
     le registre virtuel), les emplacements pouvant être :
     - des registres réels
     - des emplacements dans le tableau d'activation (pile)
   Deux critères antagonistes :
     - deux registres virtuels dont les valeurs doivent être
       mémorisées simultanément ne peuvent partager une même
       réalisation (OBLIGATOIRE)
     - il faut s'efforcer d'utiliser au mieux les registres,
       et minimiser l'utilisation d'emplacements de pile
   Cette question cache un problème NP-complet : on ne cherche
   pas la solution optimale, mais on fait des efforts pour
   trouver une solution convenable.

   La procédure est découpée en trois parties.
   1/ analyse de vivacité : en chaque point du programme, on
      détermine quels registres virtuels sont "vivants" et
      doivent être présents en mémoire,
   2/ construction d'un graphe d'interférence : sur la base
      de l'analyse de vivacité, déterminer quels registres
      virtuels ne peuvent pas partager une même réalisation,
   3/ allocation de registres : associer à chaque registre
      virtuel une réalisation qui respecte les interférences.

   Raffinement de la procédure : lorsque deux registres virtuels
   sont des copies l'un de l'autre, on essaie de leur faire
   partager une même réalisation.
 *)

open Aimp
open Graph

module VSet = Set.Make(String)

let v0 = "$v0"

(**
   1/ Analyse de vivacité.
   En un point de programme donné, ont dit qu'une variable est
   "vivante" si sa valeur actuelle est susceptible d'être utilisée
   plus tard. Autrement dit : s'il existe un scénario d'exécution
   future dans lequel cette variable est utilisée, sans avoir été
   modifiée au préalable.
   
   L'information de vivacité à un point donné vient donc du "futur",
   c'est-à-dire des instructions suivantes. Une lecture d'une variable
   crée de la vivacité (dans son passé), et une écriture détruit la
   vivacité. Comme chaque instruction est un point de modification de
   la vivacité, on distingue les variables vivantes "en entrée" et
   "en sortie" de chaque instruction (c'est-à-dire avant ou après)

   En notant 
   - IN[i] les variables vivantes en entrée de i
   - OUT[i] les variables vivantes en sortie de i
   - USE[i] les variables lues par i
   - DEF[i] les variables modifiées par i
   on exprime IN[i] en fonction de OUT[i] par l'équation
     IN[i] = (OUT[i] \ DEF[i]) u USE[i]

   Lorsque deux instructions i1; i2 se suivent, les variables vivantes
   en sortie de [i1] sont celles qui sont vivantes en entrée de [i2]
     OUT[i1] = IN[i2]
   Lors d'un branchement où deux blocs [s1] et [s2] peuvent suivre
   une instruction [i], il faut faire l'union des variables vivantes
   dans chacun des futurs possibles
     OUT[i] = IN[s1] u IN[s2]
 *)

let liveness fdef =
     (* Table associant à chaque instruction l'ensemble des variables qui
     sont vivantes en sortie. Rappel : en AIMP, chaque instruction
     atomique est identifiée par un numéro unique, que l'on utilise ici
     comme clé dans la table. *)
   let liveness = Hashtbl.create 64 in

   (** Calcul de vivacité pour une séquence.

      Utilisation :
        sequence s out
      en supposant que les variables vivantes en sortie de la séquence [s]
      sont données par [out], cet appel calcule et renvoie les variables
      vivantes en entrée de [s].

      Effet de bord : met à jour la table [liveness] pour toutes les
      instructions de la séquence. *)
   
   (* sequence s out ->
      en supposant que les variables vivantes en sortie de [s] sont
      données par [out], calcule et renvoie les variables vivantes
      en entrée de [s]
      Note : effet de bord :  met à jour la table liveness pour toutes
                              les instructions vues lors du calcul
   *) 
   let rec sequence s out = match s with
    | Nop -> out
    | Instr(n, i) ->
       Hashtbl.replace liveness n out;
       instr i out
    | Seq(s1, s2) ->
       (* dans une séquence [s1 @@ s2], l'ensemble des variables vivantes
          en sortie de [s1] est donnée par l'ensemble des variables vivantes
          en entrée de [s2] *)
       sequence s1 (sequence s2 out)

(** Calcul de vivacité pour une instruction.

      Utilisation :
        instr i out
     en supposant que les variables vivantes en sortie de l'instruction [i]
     sont données par [out], calcule et renvoie les variables vivantes
     en entrée de [i].

     Effet de bord : du fait d'appels à [sequence] dans les cas des branchements
     et des boucles, met à jour la table [liveness] pour toutes les 
     sous-instructions de [i]. *)

   (* instr i out ->
      en supposant que les variables vivantes en sortie de [i] sont
      données par [out], calcule et renvoie les variables vivantes
      en entrée de [i]
      Note : effet de bord :  met à jour la table liveness pour toutes
                              les instructions vues lors du calcul
   *)
   and instr i out = match i with  (* i : instruction | out : vreg VSet *)  
      | Putchar r ->
         (* Attention : réaliser putchar en MIPS nécessite d'écrire dans les
          registres réels $a0 et $v0. *)
         let out' = VSet.remove "$a0" out in
         let out' = VSet.remove "$v0" out' in
         VSet.add r out'
      | Write(x, r) ->
      (* Écriture dans une variable globale : le registre virtuel [r] est lu,
          et aucun registre n'est modifié. On ne fait donc qu'ajouter [r] aux
          registres vivants. *)
         (*si x est locale :*)
         if List.mem x (fdef.locals) then 
            VSet.add r (VSet.remove x out)
         (*si x est globale : *)
         else
            VSet.add r out
      | Read(rd, _) | Cst(rd, _) ->
         (* Lecture d'une variable globale, ou chargement d'une constante :
         aucun registre virtuel n'est lu, et un registre [rd] de destination
         est modifié. Le registre [rd] n'est donc pas vivant en entrée. *)
         VSet.remove rd out
      | Move(rd, r) | Unop(rd, _, r) -> 
         (* Le registre [r] est lu, le registre [rd] est modifié. *)
         if rd = r then out 
         else VSet.add r (VSet.remove rd out)
      | Li(rd, _) ->
         VSet.remove rd out
      | Binop(rd, _, r1, r2) -> 
         if rd = r1 && rd = r2 then out
         else if rd = r1 then VSet.add r2 out
         else if rd = r2 then VSet.add r1 out
         else VSet.remove rd (VSet.add r1 (VSet.add r2 out))
      | Push r ->
         VSet.add r out 
      | Pop _ ->
         out
      | Call(_, n) ->                                                         (*$ti : de $t0 à $t9 | $si : de $s0 à $s7*)
         (* Pour un appel de fonction :
          - les registres lus sont les éventuels registres $ai utilisés pour
            le passage des paramètres (selon la convention utilisée)
          - les registres caller-saved sont considérés comme modifiés par
            l'appel (on ne sait pas s'ils le seront pour de vrai, mais on ne
            peut pas l'exclure, alors on se protège en supposant le pire cas)
          Les registres caller-saved sont :
          - les registres $ti (sauf $t0 et $t1 qu'on garde en réserve)
          - le registre $v0
        *) 
        (*on rajoute les $ai utilisés, on supprime les $ti, et $v0*)

        (* Dans la version simplifiée des appels, on utilise pas les ai*)
         let out = VSet.remove "$t2" out in
         let out = VSet.remove "$t3" out in
         let out = VSet.remove "$t4" out in
         let out = VSet.remove "$t5" out in
         let out = VSet.remove "$t6" out in
         let out = VSet.remove "$t7" out in
         let out = VSet.remove "$t8" out in
         let out = VSet.remove "$t9" out in
         VSet.remove "$v0" out 

      | Return ->
         (* Rappel de la convention : on renvoie la valeur contenue dans $v0.
          Ce registre est donc considéré comme lu.
          En outre, on suppose que les registres callee-saved sont vivants
          en sortie de la fonction (on ne sait pas si l'appelant veut
          effectivement récupérer leur valeur, mais on doit faire comme si)
          Les registres callee-saved sont :
          - les registres $si
        *)
        (*ajouter v0 et les si*)
         let out = VSet.add "$s0" out in
         let out = VSet.add "$s1" out in
         let out = VSet.add "$s2" out in
         let out = VSet.add "$s3" out in
         let out = VSet.add "$s4" out in
         let out = VSet.add "$s5" out in
         let out = VSet.add "$s6" out in
         let out = VSet.add "$s7" out in
         VSet.add "$v0" out
      | If(r, s1, s2) ->
         (* En sortie du test de la valeur de [r], les blocs [s1] et [s2]
         sont deux futurs possibles. Les variables vivantes dans ces deux
         blocs doivent donc être combinées. *)
         let live_in_s1 = sequence s1 out in
         let live_in_s2 = sequence s2 out in
         let out' = VSet.union live_in_s1 live_in_s2 in
         VSet.add r out'

      | While(st, r, s) ->
         (* La boucle induit une dépendance circulaire dans les équations
         de vivacité. Cela nécessite de calculer un point fixe à ces
         équations (qui existe en vertu d'un théorème général de Tarski).
         Dans ce cas particulier, on sait qu'on atteint le point fixe
         en faisant deux fois le calcul. *)
         (* Premier calcul en prenant [out] comme ensemble de sortie *)
         let live_in_body = sequence s out in
         let live_in_test = sequence st (VSet.add r live_in_body) in
         (* Deuxième calcul en prenant comme ensemble de sortie ce qui a
          été calculé lors du premier tour. *)
         let live_in_body = sequence s live_in_test in
         sequence st (VSet.add r live_in_body)
  in
       
  (* Pour remplir la table [liveness] d'une fonction, il suffit d'appliquer
     la fonction d'analyse précédente au code de cette fonction. *)
  ignore(sequence fdef.code VSet.empty);
  (* Remarque technique caml : [ignore] ne signifie pas que le code n'est
     pas exécuté ! Il s'agit simplement de déclarer que l'on n'utilisera
     pas le résultat renvoyé par l'appel [sequence fdef.code VSet.empty]
     (sans cette déclaration, le compilateur caml émettrait un avertissement).
     À propos de ce résultat qui ne sera pas utilisé : s'il est différent de
     [VSet.empty], on a risque d'accès à des variables non initialisées. *)

  (* À la fin, on renvoie la table de vivacité *)
  liveness




(**
   2/ Construction du graphe d'interférence

   On construit un graphe dont les sommets sont les registres (virtuels ou
   réels), et chaque arête dénote une interférence entre deux registres,
   c'est-à-dire l'impossibilité de leur affecter une même réalisation.

   Le critère principal pour ajouter une arête est :
   - si une instruction [i] modifie un registre [rd], alors [rd] est en
     interférence avec tous les registres [r] vivants en sortie de [i]
     (à part [rd] lui-même, le cas échéant).

   Exception à ce critère : dans le cas d'une instruction
     rd <- r
   de copie du registre [r] dans le registre [rd] (move), on ne déclare
   pas d'interférence entre [r] et [rd] : à ce stade du programme les
   deux registres contiennent la même valeur, et on peut imaginer les
   partager. Au contraire : on va placer entre les deux registres [r]
   et [rd] une arête de "préférence" indiquant qu'il serait judicieux
   de réaliser ces deux registres par le même emplacement physique,
   pour éviter une copie superflue.

   Attention toutefois, les arêtes d'interférence sont prioritaires sur
   les arêtes de préférence : si deux instructions affectent les deux
   types d'arêtes à la même paire (r, rd), on ne conserve que l'arête
   d'interférence.
 *)

let interference_graph fdef =
   (* Table de hachage contenant les informations de vivacité en sortie
     de chaque instruction, qu'on consultera pour appliquer le critère
     précédent. *)
  let live_out = liveness fdef in
  (* Initialisation d'un graphe sans arêtes, avec un sommet pour chaque
     variables locale (ie. chaque registre virtuel). *)
  let g = List.fold_left (fun g x -> Graph.add_vertex x g) Graph.empty fdef.locals in

  (* La bibliothèque Graph donne une structure immuable. Les fonctions de
     construction du graphe renvoient donc le graphe construit. *)

  (** Recherche des interférences dans une séquence.

      Utilisation :
        seq s g
      renvoie le graphe obtenu en ajoutant au graphe [g] les
      interférences trouvées dans la séquence [s].

      Cette fonction se contente d'itérer la fonction [instr] de
      recherche d'interférences dans une instruction, en chaînant
      les résultats.      
   *)
  let rec seq s g = match s with
    | Nop -> g
    | Instr(n, i) -> instr n i g
    | Seq(s1, s2) -> seq s1 (seq s2 g)

   (** Recherche des interférences dans une instruction.

      Utilisation :
        instr n i g
      renvoie le graphe obtenu en ajoutant au graphe [g] les
      interférences trouvées dans l'instruction [i], de numéro [n].
   *)
  and instr n i g = match i with
    | Read(rd, _) | Move (rd, _) | Li(rd, _) | Write (rd, _) | Cst(rd, _) | Unop(rd, _, _) | Binop(rd, _, _, _) ->
      (*ajouter à g une arête entre rd et chaque registre virtuel vivant en sortie*)
      (* Dans chacun de ces cas l'instruction écrit uniquement dans le
          registre [rd]. On ajouter à g une arête entre rd et chaque
          (autre) registre virtuel vivant en sortie. *)
      let out = Hashtbl.find live_out n in
      VSet.fold (* itérateur fold f s init*)
         (fun r g' -> if r <> rd then
                        Graph.add_edge r rd Conflict g'
                      else g')
         out
         g
    | If(_, s1, s2) | While(s1, _, s2) ->     (* If ne modifie pas le registre r, on n'y touche donc pas.*)
      let g' = seq s1 g in (* En revanche, on calcul pour s1 et s2, les modifications*)
      seq s2 g'            (* qu'ils peuvent apporter à g*)
      
    | Putchar _  | Return | Push _ | Pop _ -> 
       g
    | Call(_, _) ->
       g
  in
  (* Pour calculer le graphe d'interférence d'une fonction, il suffit
     de lancer la recherche d'interférence sur la séquence globale de
     la fonction. *)
  seq fdef.code g

(**
   3/ Coloration du graphe d'interférence
   Objectif : associer à chaque registre virtuel une "couleur",
   représentée par un numéro.

   Idée de base : algorithme glouton
     1. sélectionner un sommet v de petit degré
     2. colorier récursivement le graphe obtenu en retirant v
     3. donner à v la plus petite couleur non utilisée par ses voisins
   On raffine cette idée de base pour tenir compte de spécificités du
   problème d'origine :
     - on veut de préférence utiliser les couleurs entre 0 et K-1,
       pour une constante K donnant le nombre de registres réels,
       mais on s'autorise à utiliser les suivantes au besoin,
     - les arêtes de préférence indiquent des paires de sommets auxquels
       on veut affecter la même couleur si cela est possible,
     - les sommets peuvent avoir des "coûts" différents, en fonction de
       la fréquence à laquelle le registre correspondant est utilisé
       dans le programme.
*)

(* Un coloriage est une association entre des chaînes de caractères
   (les registres virtuesl) et des entiers (les couleurs). *)

type color = int VMap.t


(* Renvoie la plus petit couleur non utilisée par l'ensemble [v]. *)
(** Fonction auxiliaire pour le choix de la couleur d'un sommet.
    
    Utilisation :
      choose_color v colors
    renvoie la plus petite couleur non utilisée par la coloration
    [colors] de l'ensemble de sommets [v].
    On peut supposer que tous les sommets de [v] ont bien une
    couleur définie dans [colors].
 *)
let choose_color v colors =
   (*v : ensemble de sommets (string liste)*)
   (*colors : map de couleurs*)
   let n = List.length v in            (*n = |v|*)
   let mark = Array.make (n + 2) false in    (*tableau de false de taille n*)
   let () = List.iter (fun e -> let color = VMap.find_opt e colors in 
                                match color with
                                 |Some(c) -> if c < n + 2 then Array.set mark c true
                                 |_ -> ()
                              ) v in
   let rec firstOccur e arr n = if Array.get arr n = e then n else firstOccur e arr (n + 1)
   in
   firstOccur false mark 0

   
   (*!!!reste à trouver le premier false de mark, et renvoyer la position!!!*)


(** Fonction principale de coloriage.

    Utilisation :
      color g k
    renvoie un coloriage des sommets du graphe [g], calculé sous
    l'hypothèse qu'il y a [k] registres réels.

    La procédure de coloriage combine 5 fonctions mutuellement
    récursives :
      simplify g   cherche un sommet à écarter et à garder pour la fin
      coalesce g   cherche deux sommets à fusionner
      freeze g     abandonne des arêtes de préférence
      spill g      cherche un sommet à sacrifier
      select x g   colorie le graphe obtenu en retirant x, puis x
    (détail ci-dessous).
 *)

let color g k =

   (** Critère de George pour la fusion de sommets.
      
      Utilisation :
        george x y g
      renvoie [true] si le critère de fusion permet de fusionner 
      le sommet [x] avec le sommet [y] de [g].
      Hypothèse : les sommets [x] et [y] sont liés par une arête de
      préférence (et donc ne sont pas en interférence).

      Détail du critère :
      - [x] ne doit pas être un registre réel
      - tous les voisins de [x] de degré >= K ou qui sont des registres
        réels doivent être des voisins de [y]
      - si [y] est un registre réel, alors [x] ne peut pas avoir
        de registre réel parmi ses voisins

      Objectif de ce critère : s'il était possible de colorier le graphe
      d'origine avec [k] couleurs, alors cela reste possible après avoir
      fusionné [x] avec [y], c'est-à-dire après avoir ajouté des arêtes
      entre [y] et tous les voisins de [x].
   *)

   let george x y g =                                       (*critère de fusion : 1-tous les voisins de x de deg >= k sont voisins de y, 2-...*)
      VMap.for_all                                          (* On cherche si tous les voisins de x suivent la bonne propriété*)
      (fun key _ -> if Graph.degree key g < k then true     (* Si deg(key) < k, alors c'est ok*)
                    else VMap.mem key (VMap.find y g))      (* Sinon on veut qu'il soit voisin de y*)
      g

      (*meilleur critère :
         si y réel -> tout voisin de x virtuel ou de degré >= k est voisin de y
         si y est virtuel -> tout voisin de x réel ou de degré >= k est voisin de y
      *)
   in

   (** Recherche d'un sommet à colorier.
      On cherche un sommet [x] de degré < K, et qui n'a pas d'arêtes de
      préférence. Si on en trouve un on appelle [select x g], et sinon
      on passe à [coalesce].

      Heuristique : parmi les sommets sélectionnables, prendre un sommet
      de faible degré.
   *)
   let rec simplify g =
      (* On cherche un noeud de degré < k, et sans arêtes de préférences*)
      let g' = VMap.filter (fun x _ -> Graph.degree x g < k && not (Graph.has_pref x g)) 
                           g 
      in
      let x = VMap.min_binding_opt g' in (* Parmis les noeuds légaux, on choisis un noeud quelconque, choix à préciser...*) (*x : option*)                            
      match x with
         |None -> coalesce g              (* Si on a None, alors la Map était vide et aucuns noeuds ne pouvais être pris*)
         |Some(key, _) -> select key g    (* Sinon, alors on récupère Some(key, _) et key à les bonnes propriétés*)

   (** Recherche de deux sommets à fusionner.
      Parmi les sommets liés par des arêtes de préférence, on en cherche
      deux qui satisfont le critère de George. Si on trouve une telle
      paire (x, y), on colorie avec [simplify] le graphe [g'] obtenu en
      fusionnant [x] avec [y], puis on propage à [x] la couleur qui a
      été affectée à [y]. Dans le cas contraire, on passe à [freeze]
   *)
   and coalesce g =
      (* On cherche 2 sommets reliés par une arête de préférence, fusionable*)

      let tmp = VMap.fold (fun x s acc ->                              (* On parcours tous les noeuds x du graphe*)
                        let tmp2 = VMap.fold (fun y tag acc2 ->         (* On parcours tous les voisons y de x*)
                              if tag = Preference && george x y g       (* Si x et y partagent un lien Pref et sont fusionables, on conserve Some y*)
                                 then Some(y)                           (* Sinon, on conserve l'accumulateur*)
                              else acc2
                        ) s None
                        in
                        match tmp2 with                                 
                           |None -> acc                                 (* Si on trouve None, alors pour x il n'existe pas un bon y, on conserve acc*)
                           |Some(y) -> Some(x, y)                       (* Sinon, on conserve Some(x, y)*)
      ) g None
      in
      match tmp with
         |Some(x, y) -> let g' = Graph.merge x y g in simplify g'       (*si on trouve, on fusionne les deux sommets puis on appel simplify*)
         |None -> freeze g                                              (*sinon, on appel freeze*)
   
   (** Abandon d'arêtes de préférence. 
      On cherche un sommet de degré < K. S'il existe un tel sommet [x],
      celui-ci a nécessairement des arêtes de préférence. On les retire
      et on revient à [simplify]. Sinon, on passe à [spill].
   *)  
   and freeze g =
      (* On  cherche un sommet x tq deg(x) < K*)
      (* Même technique que précédemment avec  la valeur stockée en option*)
      let x_opt = VMap.fold (fun x _ acc -> if Graph.degree x g < k then Some(x) else acc
      ) g None
      in
      match x_opt with
         |Some(x) ->  let g' = Graph.remove_prefs x g in simplify g'    (* Si on a trouvé un tel x, on oublie ses arêtes de pref et on continue*)
         |None ->     spill g                                           (* Sinon, on appel spill*)

   
   (** Sacrifice d'un sommet.
      On se résigne à ne (peut-être) pas pouvoir donner à l'un des sommets
      une couleur < K. On choisit un sommet [x] et on appelle [select x g].
      Note : le fait qu'un sommet [x] ait un degré >= K signifie qu'il n'est
      pas certain qu'il puisse recevoir une couleur < K après que ses voisins
      auront été coloriés. Mais avec un peu de chance cela fonctionnera
      quand même !

      Exception : on peut également arriver ici dans le cas où tous les
      sommets restants sont déjà coloriés (car il ne reste que des sommets
      correspondant à des registres réels). Dans ce cas on a atteint le cas
      de base de notre récursion.

      Heuristiques :
      - favoriser un sommet correspondant à un registre peu utilisé, pour
        limiter le nombre d'accès à la mémoire dans l'hypothèse où le sommet
        sacrifié serait effectivement associé à un emplacement de pile
        (note : ce critère demande d'avoir collecté des infos sur la
        fréquence d'utilisation estimée des différents registres),
      - favoriser des sommets de fort degré, dont la suppression va donc
        supprimer de nombreuses arêtes et faciliter le coloriage des autres
        registres.
   *)
   and spill g =
      (* On choisit le sommet de plus petit degré*)
      let tmp = VMap.choose_opt g in                         (* On choisit un sommet aléatoire*)
      match tmp with
      |Some(init_sommet, _ ) ->                                      (* Si on trouve un sommet :*)
      let init_degree = Graph.degree init_sommet g in               (* On calcul son degré*)
      let x, _ = VMap.fold (fun x _ (max_sommet, max_degree) ->         (* On parcours les noeuds*)
                     let courant_degree = Graph.degree x g in
                     if courant_degree > max_degree then (x, courant_degree) (* Si on tombe sur un sommet de plus petit degré, on le conserve*)
                     else (max_sommet, max_degree)                      (* Sinon, on conserve l'accumulateur*)
      ) g (init_sommet, init_degree)                                    (* On initialise avec le sommet aléatoire préalablement calculé*)              
      in 
      select x g
      |None -> let m = VMap.empty in m                    (* Sinon, alors cas de base :*)

   (** Mettre de côté un sommet [x] et colorier récursivement le graphe [g']
      ainsi obtenu. À la fin, on choisit une couleur pour [x] compatible
      avec les couleurs sélectionnées pour ses voisins.
   *)
   and select x g =            
      (*g' = g \ x*)
      (*table_color = simplify g'*)
      (*x_color = find_color x table_color*)
      (*table_color[x] = x_color*)
      (*return table_color*)
      (* Retirer x de g*)
      let g' = Graph.remove_vertex x g in
      (* Colorier g'*)
      let coloration = simplify g' in
      (* Colorier x*)
      let v = VSet.elements (VSet.union (Graph.neighbours x Preference g) (Graph.neighbours x Conflict g)) in (* Liste de tous les voisins de x *)
      let color = choose_color v coloration in
      let color = color in
      let coloration = VMap.add x color coloration in       (*x : Graph.VMap.key = string | color : int | coloration : int Graph.VMap.t*)
      coloration                                                           
    
   in
   simplify g

let print_colors c =
  Printf.(printf "Coloration : \n";
          VMap.iter (printf "  %s: %i\n") c)

(**
   4/ Conclusion
   Les couleurs sont des numéros. Les numéros de 0 à K-1 sont associés
   aux K registres physiques utilisés, et les numéros suivants à des
   emplacements dans la pile.   
 *)

type register =
  | Actual  of string
  | Stacked of int

let allocation (fdef: function_def): register Graph.VMap.t * int =
   (* Calculer les vivacités, en déduire un graphe d'interférence, 
     le colorier, puis en déduire :
     - une affectation concrète de chaque sommet à un registre réel
       ou un emplacement de pile,
     - le nombre d'emplacements de pile utilisés.
   *)
   let k = 8 in
   let g = interference_graph fdef in
   let c = color g k in
   let cptStacked = ref 0 in
   let color2register co = 
      if co = 0 then Actual "$s0"
      else if co = 1 then Actual "$s1"
      else if co = 2 then Actual "$s2"
      else if co = 3 then Actual "$s3"
      else if co = 4 then Actual "$s4"
      else if co = 5 then Actual "$s5"
      else if co = 6 then Actual "$s6"
      else if co = 7 then Actual "$s7"
      else (incr cptStacked; Stacked (co - k))

   in
   let map' =  List.fold_left 
               (fun map (key, co) ->  if List.mem key fdef.params then map else VMap.add key (color2register co) map) VMap.empty (VMap.bindings c) in
   let map', _ = List.fold_left (fun (map, n) key -> incr cptStacked; (VMap.add key (Stacked(-11 - n)) map, n + 1)) (map', 0) (fdef.params) in
   map', !cptStacked
