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

open Printf

let pp_binop = function
  | Ops.Add -> "+"
  | Ops.Sub -> "-"
  | Ops.Mul -> "*"
  | Ops.Div -> "/"
  | Ops.Rem -> "%"
  | Ops.Lsl -> "lsl"
  | Ops.Lsr -> "lsr"
  | Ops.Eq  -> "="
  | Ops.Neq -> "!="
  | Ops.Lt  -> "<"
  | Ops.Le  -> "<="
  | Ops.Gt  -> ">"
  | Ops.Ge  -> ">="
  | Ops.And -> "&&"
  | Ops.Or  -> "||"

let pp_unop = function
  | Ops.Minus -> "-"
  | Ops.Not   -> "!"


let pp_program prog out_channel =
  let print s = fprintf out_channel s in
  let margin = ref 0 in
  let pp_margin () = let n = !margin in  
                     let n = 3*n in 
                     String.make (n) ' ' in
  let pp_var = function    
    | CVar n -> sprintf "CVar(%i)" n   
    | Name s -> sprintf "%s" s
  in
  let rec pp_expr = function
    | Cst n -> sprintf "%i" n
    | Bool b -> if b then "True" else  "False"
    | Var v -> sprintf "%s" (pp_var v)
    | Unop (op, e) -> sprintf "%s%s" (pp_unop op) (pp_expr e)
    | Binop (op, e1, e2) -> sprintf "(%s %s %s)" (pp_expr e1) (pp_binop op) (pp_expr e2)
    | Tpl l -> sprintf "[%s]" (List.fold_left (fun acc e -> if acc = "" then pp_expr e else acc^" "^(pp_expr e)) "" l)
    | TplGet (e, n) -> sprintf "%s[%i]" (pp_expr e) n
    | FunRef s -> s
    | App(e1, e2) -> sprintf "%s(%s)" (pp_expr e1) (pp_expr e2)
    | If (cond, e1, e2) ->
              (sprintf "if (%s) {\n" (pp_expr cond))^
              (pp_expr e1)^"} else {\n"^
              (pp_expr e2)^"}"
    | LetIn (s, e1, e2) -> sprintf "let %s = %s in %s" s (pp_expr e1) (pp_expr e2)
    | LetRec (s, e1, e2) -> sprintf "let rec %s = %s in %s" s (pp_expr e1) (pp_expr e2)
  in
  let pp_function fdef =
    (sprintf "function %s(%s) {\n" fdef.name fdef.param)^
    (margin := !margin + 1; pp_margin())^
    (pp_expr fdef.code)^
    (margin := !margin - 1; "\n}\n\n")
  in
  List.iter (fun fdef -> print "%s" (pp_function fdef)) prog.functions;
  print "%s" (pp_expr prog.code)  

