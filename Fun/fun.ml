(**
   Langage FUN
   Essentiellement un fragment de Caml (purement fonctionnel)
 *)

type expression =
  | Cst   of int     (*  1     *)
  | Bool  of bool    (*  true  *)
  | Var   of string  (*  x     *)

  | Unop  of Ops.unop * expression                (*  -e       *)
  | Binop of Ops.binop * expression * expression  (*  e1 + e2  *)

  | Tpl   of expression list    (*  (e1, e2, ..., eN)  *)
  | TplGet of expression * int  (*  t[i]               *)

  | Fun   of string * expression      (*  fun x -> e  *)
  | App   of expression * expression  (*  e1 e2       *)

  | If    of expression * expression * expression  (*  if c then e1 else e2  *)

  | LetIn of string * expression * expression   (*  let x = e1 in e2      *)
  | LetRec of string * expression * expression  (*  let rec x = e1 in e2  *)
      
type program = expression

(* Fonction auxiliaire pour générer  fun x1 -> fun x2 -> ... -> fun xN -> e
   à partir de e et de la liste des paramètres.
   Utilisée par l'analyseur lexical pour générer l'AST. *)
let rec mk_fun xs e = match xs with
  | [] -> e
  | x::xs -> Fun(x, mk_fun xs e)
  
