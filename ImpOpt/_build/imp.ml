(**
   Syntaxe abstraite pour le langage IMP. 
   On définit les structures de données qui permettent de représenter
   et manipuler en caml les éléments constituant un programme IMP.
 *)

(**
   Opérateurs binaires : +, *, <
 *)
type binop = Add | Mul | Lt

(**  
   Structure de données pour représenter les expressions
   sous forme arborescente.
 *)
type expression =
  (* Constante entière : 0, -1, 42, ... *)
  | Cst   of int
  (* Constante booléenne : true, false *)
  | Bool  of bool
  (* Variable, identifiée par une chaîne de caractères *)
  | Var   of string
  (* Opération binaire, avec un opérateur et deux opérandes *)
  | Binop of binop * expression * expression
  (* Appel de fonction, avec un identifiant de fonction et une 
     liste de paramètres *)
  | Call  of string * expression list
(**
   Exemple d'expression :
     (1 + x) * f(3, true)
 *)
let e = Binop(Mul,
              Binop(Add, Cst 1, Var "x"),
              Call("f", [Cst 3; Bool true]))

(**
   Structure de données pour représenter les instructions,
   sous forme arborescente.
*)
type instruction =
  (* Primitive d'affichage d'un caractère, donné en code ASCII *)
  | Putchar of expression
  (* Affectation d'une nouvelle valeur à une variable *)
  | Set     of string * expression
  (* Branchement conditionnel *)
  | If      of expression * sequence * sequence
  (* Boucle conditionnelle *)
  | While   of expression * sequence
  (* Fin d'une fonction *)
  | Return  of expression
  (* Utiliser une expression à la place d'une instruction,
     par exemple un appel de fonction *)
  | Expr    of expression
(* Séquence d'instructions *)
and sequence = instruction list
(**
   Exemple d'instruction :
     while (c < 58) {
       putchar(c);
       c = c+1;
     }
 *)
let i = While(Binop(Lt, Var "c", Cst 58),
              [ Putchar(Var "c");
                Set("c", Binop(Add, Var "x", Cst 1)) ]
          )

(** 
   Structure de données pour représenter une fonction 
 *)
type function_def = {
    (* Identifiant de la fonction *)
    name: string;
    (* Liste des paramètres, identifiés par des chaînes *)
    params: string list;
    (* Liste des variables locales, identifiés par des chaînes *)
    locals: string list;
    (* Les instructions *)
    code: sequence;
  }
(**
   Exemple de fonction :
     function chiffres(depart) {
       var c;
       c = depart + 48;
       while (c < 58) {
         putchar(c);
         c = c+1;
       }
     }
 *)
let f = {
    name = "chiffres";
    params = ["depart"];
    locals = ["c"];
    code = [ Set("c", Binop(Add, Var "depart", Cst 48)); i ]
  }

(**
   Structure de données pour représenter un programme complet
 *)
type program = {
    (* Liste des variables globales, identifiés par des chaînes *)
    globals: string list;
    (* Ensemble des fonctions *)
    functions: function_def list;
  }
(**
   Exemple de programme :
     var zero;

     function main() {
       zero = 0;
       chiffres(zero);
     }

     function chiffres(depart) {
       var c;
       c = depart + 48;
       while (c < 58) {
         putchar(c);
         c = c+1;
       }
     }
 *)
let p = {
    globals = ["zero"];
    functions = [ f;
                  { name = "main";
                    params = [];
                    locals = [];
                    code = [ Set("zero", Cst 0);
                             Expr(Call("chiffres", [Var "zero"])) ] } ]
  }


(**
   Définition d'un interprète pour IMP, c'est-à-dire de fonctions
   prenant en entrées des éléments de syntaxe abstraite IMP et
   calculant le résultat ou produisant l'effet attendu.
 *)

(**
   Représentation des valeurs : entiers, booléens, ou [Undef] pour une
   valeur non initialisée
 *)
type value =
  | VInt of int
  | VBool of bool
  | Undef

(* Fonctions auxiliaires : en supposant que la valeur prise en argument
   est un entier (resp. un booléen), extraction de cet entier (resp.
   booléen). *)
let vint = function
  | VInt n -> n
  | _ -> assert false

let vbool = function
  | VBool b -> b
  | _ -> assert false

(** 
   Pour sortir de l'interprétation d'une fonction, on utilisera le
   mécanisme des exceptions.
 *)
exception EReturn of value

(**
   Nous allons maintenant pouvoir définir les fonctions d'interprétation.

   À prévoir : lors de l'interprétation d'une instruction donnée, on se
   place dans un environnement associant à chaque variable sa valeur.
   L'environnement sera décomposé en deux tables de hachage :

     - une table [global_env] pour les variables globales du programme, 
       qui servira d'un bout à l'autre de l'interprétation,

     - une table [local_env] pour les variables locales et les paramètres
       de l'appel de fonction en cours, qui est créée au début de l'appel
       et abandonnée à la fin.

   Les fonctions [eval_expr] et [exec_instr] interprétant les expressions 
   et les instructions doivent être paramétrées par la table globale et 
   une table locale. La fonction [exec_call] interprétant un appel de 
   fonction doit être paramétrée par la table globale. Pour éviter de 
   passer explicitement ces tables en argument on imbrique les définitions.
 *)
                   
(**
   Fonction principale d'interprétation d'un programme, prenant en
   paramètres la représentation d'un programme et un argument entier.
   Les autres fonctions seront définies à l'intérieur.
 *)
let exec_prog prog arg =
  (* Environnement global : table de hachage pour les variables globales,
     initialisées avec [Undef]. *)
  let global_env = Hashtbl.create 16 in
  List.iter (fun id -> Hashtbl.add global_env id Undef) prog.globals;

  (**
     Fonction d'interprétation d'un appel de fonction, prenant en paramètres
     l'identifiant de la fonction et une liste d'arguments.
     Cette fonction a accès à [global_env] et à [prog].
   *)
  let rec exec_call f args =
    (* Récupération de la description de la fonction à partir de son
       identifiant. *)
    let fdef = List.find (fun fdef -> fdef.name = f) prog.functions in
    (* Environnement local de l'appel : table de hachage contenant :
       - les paramètres formels de la fonction, associés aux valeurs 
         effectives données lors de l'appel,
       - les variables locales de la fonction, initialisées avec [Undef].
       Une variable locale ayant le même nom qu'un paramètre formel masque
       le paramètre. *)
    let local_env = Hashtbl.create 16 in
    List.iter2 (fun id arg -> Hashtbl.add local_env id arg) fdef.params args;
    List.iter (fun id -> Hashtbl.add local_env id Undef) fdef.locals;

    (** 
       Fonction d'interprétation d'une expression, prenant en paramètre
       une expression et renvoyant une valeur (représentée par le type
       [value]).
       Cette fonction a accès à [global_env] et [local_env] pour gérer
       les variables. Cette fonction peut aussi effectuer des appels
       à [exec_call], qui est récursive.
     *)
    let rec eval_expr = function
      (* Constantes entières ou booléennes : on renvoie la valeur, étiquetée
         avec [VInt] ou [VBool] selon sa nature. *)
      | Cst n -> VInt n
      | Bool b -> VBool b
      (* Variable : on consulte d'abord l'environnement local. Si la variable
         n'y est pas on consulte ensuite l'environnement global.
         Note : l'appel [Hashtbl.find global_env id] échouera si la variable 
         n'apparaît pas dans l'environnement global. *)
      | Var id -> begin
          match Hashtbl.find_opt local_env id with
          | Some v -> v
          | None -> Hashtbl.find global_env id
        end
      (* Opérations binaires : on évalue les deux opérandes [e1] et [e2],
         puis on combine leurs résultats avec une fonction correspondant
         à l'opérateur. *)
      | Binop(op, e1, e2) ->
         let v1 = eval_expr e1 in
         let v2 = eval_expr e2 in
         let op = match op with
           (* Note : les valeurs [v1] et [v2] obtenues ont le type [value].
              Chacune des opérations traitée ici suppose que ses opérandes 
              ont pour valeur des entiers. On s'attend donc à ce que [v1]
              ait la forme [VInt n1], avec [n1] de type [int]. On utilise 
              la fonction [vint] pour extraire cet entier [n1]. Si en
              revanche [v1] est d'une autre nature ([VBool] ou [Undef])
              l'appel à [vint] échoue. *)
           | Add -> fun a b -> VInt (vint a + vint b)
           | Mul -> fun a b -> VInt (vint a * vint b)
           | Lt  -> fun a b -> VBool (vint a < vint b)
         in
         op v1 v2
      (* Appel de fonction : on évalue les arguments et on déclenche un
         nouvel appel à [exec_call]. *)
      | Call(f, args) ->
         exec_call f (List.map eval_expr args)
    in

    (**
       Fonctions d'interprétation d'une instruction et d'une séquence
       d'instructions.
       Ces fonctions ont accès à [global_env] et à [local_env].
       Elles peuvent aussi appeler l'autre fonction locale [eval_expr].
     *)
    let rec exec_seq s =
      (* Interprétation d'une séquence : on interprète toutes les 
         instructions dans l'ordre. Notez que l'interprétation de la
         séquence sera interrompue si une exception est déclenchée,
         ce qui sera le cas si on trouve une instruction [Return]. *)
      List.iter exec_instr s

    and exec_instr = function
      (* Affichage d'un caractère. À nouveau, on suppose que l'évalution
         de [e] a produit un entier, d'où l'appel à [vint]. *)
      | Putchar e -> print_char (char_of_int (vint (eval_expr e)))
      (* Affectation, on évalue [e] puis on met à jour l'environnement.
         Comme pour l'accès à une variable, on teste si l'identifiant 
         apparaît dans l'environnement local pour décider quelle table 
         mettre à jour. *)
      | Set(id, e) ->
         let v = eval_expr e in
         if Hashtbl.mem local_env id then
           Hashtbl.replace local_env id v
         else
           Hashtbl.replace global_env id v
      (* Branchement et boucle.
         On s'attend à ce que l'interprétation de la condition [e]
         fournisse un booléen, d'où l'appel à [vbool]. *)
      | If(e, s1, s2) ->
         if vbool(eval_expr e) then
           exec_seq s1
         else
           exec_seq s2
      | While(e, s) as i ->
         if vbool(eval_expr e) then
           (exec_seq s; exec_instr i)
      (* Terminaison de l'appel. On déclenche une exception qui
         interrompt l'interprétation des séquences d'instructions
         en cours. L'exception sert également de véhicule à la valeur
         renvoyée. *)
      | Return e -> raise (EReturn(eval_expr e))
      (* Expression utilisée à la place d'une instruction.
         On ne fait rien de sa valeur. Il s'agira typiquement d'un
         appel de fonction effectué pour ses effets (de mémoire ou
         d'affichage). *)
      | Expr e -> ignore (eval_expr e)

    in

    (* Code principal de l'interprétation d'un appel de fonction.
       On exécude le code et on se tient prêt à intercepter une exception
       [EReturn] donnant le résultat. Au cas où aucune exception n'est
       déclenchée, ce qui arrive lorsque l'interprétation du code termine
       sans rencontrer d'instruction [Return], on renvoie [Undef]. *)
    try
      exec_seq fdef.code; Undef
    with
      EReturn v -> v
    
  in

  (* Code principel de l'interprétation d'un programme.
     On exécute un appel à la fonction [main] en lui fournissant l'unique
     argument [arg]. *)
  exec_call "main" [arg]
  

(**
   Pretty-printer
 *)

open Printf

let pp_binop = function
  | Add -> "+"
  | Mul -> "*"
  | Lt  -> "<"

let rec pp_params = function
  | [] -> ""
  | [x] -> x
  | x::params -> sprintf "%s,%s" x (pp_params params)

let rec pp_expr = function
  | Cst n -> string_of_int n
  | Bool b -> if b then "true" else "false"
  | Var x -> x
  | Binop(op, e1, e2) -> 
     sprintf "(%s%s%s)" (pp_expr e1) (pp_binop op) (pp_expr e2)
  | Call(f, args) ->
     sprintf "%s(%s)" f (pp_args args)
and pp_args = function
  | [] -> ""
  | [a] -> pp_expr a
  | a::args -> sprintf "%s,%s" (pp_expr a) (pp_args args)

let pp_program prog out_channel =
  let print s = fprintf out_channel s in
  let margin = ref 0 in
  let print_margin () = for i=1 to !margin do print "  " done in

  let rec pp_instr = function
    | Putchar e ->
       print "putchar(%s);" (pp_expr e)
    | Set(x, e) ->
       print "%s = %s;" x (pp_expr e)
    | If(e, s1, s2) ->
       print "if (%s) {\n" (pp_expr e);
       incr margin; pp_seq s1; decr margin;
       print_margin(); print "} else {\n";
       incr margin; pp_seq s2; decr margin;
       print_margin(); print "}"
    | While(e, s) ->
       print "while (%s) {\n" (pp_expr e);
       incr margin; pp_seq s; decr margin;
       print_margin(); print "}"
    | Return e ->
       print "return(%s);" (pp_expr e)
    | Expr e ->
       print "%s;" (pp_expr e)
  and pp_seq = function
    | [] -> ()
    | i::seq -> print_margin(); pp_instr i; print "\n"; pp_seq seq
  in

  let pp_var x = print_margin(); print "var %s;\n" x in
  let rec pp_vars = function
    | [] -> ()
    | [x] -> pp_var x; print "\n";
    | x::vars -> pp_var x; pp_vars vars
  in

  let pp_function fdef =
    print "function %s(%s) {\n" fdef.name (pp_params fdef.params);
    incr margin;
    pp_vars fdef.locals;
    pp_seq fdef.code;
    decr margin;
    print "}\n\n"
  in
  
  pp_vars prog.globals;
  List.iter pp_function prog.functions;
  
