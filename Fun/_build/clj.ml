(**
   Langage intermédiaire Clj
   Similaire à Fun, mais sans fonctions anonymes.
   Les fonctions sont toutes définies au niveau global ("toplevel"),
   et attendent invariablement **un argument et une clôture**.
 *)

(* Distinction des variables en deux catégories *)
type var =
  | CVar of int    (* variable de clôture, désignée par un numéro *)
  | Name of string (* autres variables, désignées par leur nom    *)

(* Expressions, similaire à celles de Fun mais sans fonctions anonymes *)
type expression =
  | Cst   of int
  | Bool  of bool
  | Var   of var
  | Unop  of Ops.unop * expression
  | Binop of Ops.binop * expression * expression
  | Tpl   of expression list
  | TplGet of expression * int

  | FunRef of string (* Référence au nom d'une fonction globale *)

  | App   of expression * expression
  | If    of expression * expression * expression
  | LetIn of string * expression * expression
  | LetRec of string * expression * expression

let rec print_exp e = match e with
  | Cst n -> print_string "("; print_int n; print_string ")\n"
  | Bool b -> print_string "("; print_string (if b then "True" else "False"); print_string ")\n"
  | Var (CVar n) -> print_string "(CVar("; print_int n; print_string "))\n"
  | Var (Name s)  -> print_string "(Name("; print_string s; print_string "))\n"
  | Unop (_, e)  -> print_string "(Unop("; print_exp e; print_string "))\n"
  | Binop (_, e1, e2) -> print_string "(Binop("; print_exp e1; print_string ", "; print_exp e2; print_string "))\n"
  | Tpl l -> print_string "(("; List.iter (fun e -> print_exp e; print_string " ") l; print_string "))\n"
  | TplGet (e, n) -> print_string "("; print_exp e; print_string "["; print_int n; print_string "])\n"

  | FunRef s -> print_string "(FunRef("; print_string s; print_string "))\n"

  | App (e1, e2) -> print_string "(App("; print_exp e1; print_string ", "; print_exp e2; print_string "))\n"
  | If  (e1, e2, e3) ->  print_string "(If("; print_exp e1; print_string ", "; print_exp e2; print_string ", "; print_exp e3; print_string "))\n"
  | LetIn (s, e1, e2) -> print_string "(let "; print_string s; print_string " = "; print_exp e1; print_string " in "; print_exp e2; print_string ")\n"
  | _ -> print_string "NI\n"
(* Définition d'une fonction globale *)
type function_def = {
  name: string; (* nom de la fonction, tel qu'il peut être désigné par FunRef *)
  code: expression;
  param: string; (* nom de l'unique paramètre *)
}

(* Un programme est défini par une expression et un ensemble de définitions
   de fonctions globales. *)
type program = {
  functions: function_def list;
  code: expression;
}
