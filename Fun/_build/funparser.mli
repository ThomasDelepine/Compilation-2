
(* The type of tokens. *)

type token = 
  | THEN
  | STAR
  | SLASH
  | RPAR
  | REC
  | RBRACKET
  | PLUS
  | OR
  | NOT
  | NEQ
  | MOD
  | MINUS
  | LT
  | LSR
  | LSL
  | LPAR
  | LET
  | LE
  | LBRACKET
  | IN
  | IF
  | IDENT of (string)
  | GT
  | GE
  | FUN
  | EQ
  | EOF
  | ELSE
  | CST of (int)
  | COMMA
  | BOOL of (bool)
  | ARROW
  | AND

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val program: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Fun.program)
