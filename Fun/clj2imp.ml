(**
   Traduction de Clj vers Imp

   Pour éviter les collisions entre noms, la traduction introduit à la volée
   de nouveaux noms pour chacune des variables.
 *)

(* Module pour représenter les renommages de variables *)
module STbl = Map.Make(String)

(* Traduction d'une variable, 
   - soit par un accès via le "nom unique", si un tel nom a été renseigné
     dans l'environnement env,
   - soit par un accès direct pour les autres variables nommées,
   - soit par un accès à la clôture. *)
let tr_var v env = match v with
  | Clj.Name(x) ->
    Imp.(if STbl.mem x env then Var(STbl.find x env) else Var x)
      
  | Clj.CVar(n) ->
    Imp.(array_get (Var "closure") (Cst n))
      
(* Traduction d'une expression.

   Paramètres :
   - e   : expression à traduire
   - env : renommage des variables

   Résultat : triplet (s, e', vars)
   - s    : séquence d'instructions
   - e'   : expression
   - vars : ensemble des variables introduites par les renommages
   
   Idée : exécuter s puis évaluer e' dans IMP est équivalent à évaluer e dans CLJ
*)
let tr_expr e env =
  (* Compteur pour générer des noms de variables uniques *)
  let cpt = ref (-1) in
  (* Liste des noms de variables uniques générés *)
  let vars = ref [] in
  (* Création d'un nom de variable de la forme x_N avec enregistrement dans vars *)
  let new_var id =
    incr cpt;
    let v = Printf.sprintf "%s_%i" id !cpt in
    vars := v :: !vars;
    v
  in
  
  (* Fonction principale de traduction d'une expression.
     Renvoie la paire (s, e'), et enregistre à la volée les variables dans vars *)
  let rec tr_expr (e: Clj.expression) (env: string STbl.t):
      Imp.sequence * Imp.expression =
    match e with
      | Clj.Cst(n) ->
         [], Imp.Cst(n)

      | Clj.Bool(b) ->
         [], Imp.Bool(b)

      | Clj.Var(v) ->
         [], tr_var v env

      | Clj.Unop(op, e) ->
         let is, te = tr_expr e env in
         is, Imp.Unop(op, te)
          
      | Clj.Binop(op, e1, e2) ->
         let is1, te1 = tr_expr e1 env in
         let is2, te2 = tr_expr e2 env in
         is1 @ is2, Imp.Binop(op, te1, te2)

      | Clj.Tpl l ->  
         let x = new_var "t" in

         let rec set l n accs acct = match l with  (* renvoie seq * seq : les instructions à réaliser puis les set du tableau*)
            |[] -> accs, acct
            |e::s -> let is, te = tr_expr e env in set s (n + 1) (is @ accs) ((Imp.array_set (Var x) (Cst(n)) te)::acct)
         in                   
         let expr_malloc = Imp.Set(x, Imp.array_create (Cst(List.length l))) in
         let iss, tes = (set l 0 [] []) in

         iss @ (expr_malloc::(List.rev tes)), Imp.Var x

      | Clj.TplGet (e, n) ->      
         let se, te = tr_expr e env in
         se, Imp.array_get te (Cst n)

      | Clj.FunRef s -> [], Imp.Var(s)

      | Clj.App (e1, e2) -> 
         let is1, te1 = tr_expr e1 env in
         let is2, te2 = tr_expr e2 env in
         (* ICI, afficher e1*)
         Clj.print_exp e1;
         print_string "\n";
         Imp.print_exp te1;
         (match te1 with
            |Var x -> 
                  is1 @ is2, Call(x, [te2])
            |Deref(Binop(_, Var x, _)) -> is1 @ is2, Call(x, [te2])
            |_ -> print_string "?"; is1 @ is2, te1)

      | Clj.If (cond, e1, e2) ->                                    
         let iscond, tcond = tr_expr cond env in
         let is1, te1 = tr_expr e1 env in
         let is2, te2 = tr_expr e2 env in
         let lv = new_var "var" in
         iscond @ [Imp.If(tcond, is1 @ [Set(lv, te1)], is2 @ [Set(lv, te2)])], Var(lv)
          
      | Clj.LetIn(x, e1, e2) ->
         (* Création d'un nom unique pour 'x', à utiliser à la place de 'x'
            dans l'expression e2. *)
         let lv = new_var x in

         let is1, t1 = tr_expr e1 env in
         let is2, t2 = tr_expr e2 (STbl.add x lv env) in

         is1 @ [Imp.Set(lv, t1)] @ is2, t2

      | Clj.LetRec (x, e1, e2) ->
         let lv = new_var x in

         let is1, t1 = tr_expr e1 env in
         let is2, t2 = tr_expr e2 (STbl.add x lv env) in

         is1 @ [Imp.Set(lv, t1)] @ is2, t2

      | _ ->
         failwith "todo clj2imp _ "

  in
    
  let is, te = tr_expr e env in
  is, te, !vars

    
(* Traduction d'une fonction globale *)
let tr_fdef fdef =
  let env =
    let x = Clj.(fdef.param) in
    (* On renomme 'param_x' le paramètre 'x' *)
    STbl.add x ("param_" ^ x) STbl.empty
  in
  (* L'ensemble des variables créées est pris comme ensemble de 
     variables locales *)
  let is, te, locals = tr_expr Clj.(fdef.code) env in
  Imp.({
    name = Clj.(fdef.name);
    code = is @ [Return te];
    (* Deux paramètres : le paramètre et la clôture *)
    params = ["param_" ^ Clj.(fdef.param); "closure"];
    locals = locals;
  })


(* Traduction du programme complet *)
let translate_program prog =
  let functions = List.map tr_fdef Clj.(prog.functions) in
  (* Les variables de l'expression principale forment l'ensemble des
     variables globales *)
  let is, te, globals = tr_expr Clj.(prog.code) STbl.empty in
  (* Insertion d'un affichage du résultat de l'expression principale *)
  let main = Imp.(is @ [Expr(Call("print_int", [te]))]) in
  Imp.({main; functions; globals})
    
