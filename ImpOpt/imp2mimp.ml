(**
   La traduction de IMP vers MIMP rassemble deux objectifs :
   - simplifier les expressions qui peuvent l'être
   - remplacer certaines opérations génériques par des opérations
     spécifiques de MIPS.

   L'essentiel de la traduction est un morphisme direct entre les deux
   syntaxes. On utilise des "smart constructors" comme la fonction [mk_add]
   pour faire à la volée les simplifications qui peuvent être faites.
 *)

open Mimp

(* L'appel [mk_add e1 e2] doit renvoyer une expression équivalente à la
   construction [Binop(Add, e1, e2)]. La fonction [mk_add] peut simplifier
   l'expression construite tant que cela préserve le comportement du
   programme en toute circonstantes. L'expression éventuellement simplifiée
   doit donc toujours produire
   -> le même résultat,
   -> ET les mêmes effets de bord éventuels. *)
let mk_add e1 e2 = match e1, e2 with
  | Cst n1, Cst n2 -> 
     Cst(n1+n2)
  | Cst 0, e | e, Cst 0 ->
     e
  | Cst n1, Unop(Addi n2, e) | Unop(Addi n2, e), Cst n1 ->
     Unop(Addi(n1+n2), e)
  | Cst n, e | e, Cst n ->
     Unop(Addi n, e)
  | Unop(Addi n1, e1), Unop(Addi n2, e2) ->
     (* Normalement, sous un Addi, pas d'autre élément simplifiable,
        mais à généraliser. *)
     Unop(Addi(n1+n2), Binop(Add, e1, e2))
  | _ ->
     Binop(Add, e1, e2)

let mk_mul e1 e2 = match e1, e2 with
   | Cst n1, Cst n2 -> 
      Cst(n1*n2)
   | Cst 1, e | e, Cst 1 ->
      e
   | Cst n1, Unop(Muli n2, e) | Unop(Muli n2, e), Cst n1 ->
      Unop(Muli(n1*n2), e)
   | Cst n, e | e, Cst n ->
      Unop(Muli n, e)

   | _ ->
      Binop(Mul, e1, e2)

(*faire mk_mul*)

(* Traduction directe *)
let tr_binop = function
  | Imp.Add -> Add
  | Imp.Mul -> Mul
  | Imp.Lt  -> Lt

(* Traduction directe, avec appel de "smart constructors" *)
let rec tr_expr = function
  | Imp.Cst n -> Cst n
  | Imp.Bool b -> Cst (if b then 1 else 0)
  | Imp.Var x -> Var x
  | Imp.Binop(Add, e1, e2) -> mk_add (tr_expr e1) (tr_expr e2)
  | Imp.Binop(Mul, e1, e2) -> mk_mul (tr_expr e1) (tr_expr e2)
  | Imp.Binop(op, e1, e2) -> Binop(tr_binop op, tr_expr e1, tr_expr e2)
  | Imp.Call(f, args) -> Call(f, List.map tr_expr args)

(* Traduction directe *)
let rec tr_instr = function
  | Imp.Putchar e -> Putchar(tr_expr e)
  | Imp.Set(x, e) -> Set(x, tr_expr e)
  | Imp.If(e, s1, s2) -> If(tr_expr e, tr_seq s1, tr_seq s2)
  | Imp.While(e, s) -> While(tr_expr e, tr_seq s)
  | Imp.Return e -> Return(tr_expr e)
  | Imp.Expr e -> Expr(tr_expr e)
and tr_seq s =
  List.map tr_instr s

(* Traduction directe *)
let tr_function fdef = {
    name = Imp.(fdef.name);
    params = Imp.(fdef.params);
    locals = Imp.(fdef.locals);
    code = tr_seq Imp.(fdef.code)
  }

(* Traduction directe *)
let tr_program prog = {
    globals = Imp.(prog.globals);
    functions = List.map tr_function Imp.(prog.functions)
  }
