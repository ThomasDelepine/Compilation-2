
module MenhirBasics = struct
  
  exception Error
  
  let _eRR =
    fun _s ->
      raise Error
  
  type token = 
    | WHILE
    | VAR
    | STAR
    | SET
    | SEMI
    | RPAR
    | RETURN
    | PUTCHAR
    | PLUS
    | LT
    | LPAR
    | IF
    | IDENT of (
# 13 "impparser.mly"
       (string)
# 27 "impparser.ml"
  )
    | FUNCTION
    | EOF
    | END
    | ELSE
    | CST of (
# 11 "impparser.mly"
       (int)
# 36 "impparser.ml"
  )
    | COMMA
    | BOOL of (
# 12 "impparser.mly"
       (bool)
# 42 "impparser.ml"
  )
    | BEGIN
  
end

include MenhirBasics

# 1 "impparser.mly"
  

  open Lexing
  open Imp


# 57 "impparser.ml"

type ('s, 'r) _menhir_state = 
  | MenhirState00 : ('s, _menhir_box_program) _menhir_state
    (** State 00.
        Stack shape : .
        Start symbol: program. *)

  | MenhirState05 : (('s, _menhir_box_program) _menhir_cell1_variable_decl, _menhir_box_program) _menhir_state
    (** State 05.
        Stack shape : variable_decl.
        Start symbol: program. *)

  | MenhirState08 : (('s, _menhir_box_program) _menhir_cell1_list_variable_decl_, _menhir_box_program) _menhir_state
    (** State 08.
        Stack shape : list(variable_decl).
        Start symbol: program. *)

  | MenhirState11 : (('s, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_program) _menhir_state
    (** State 11.
        Stack shape : FUNCTION IDENT.
        Start symbol: program. *)

  | MenhirState13 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 13.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState18 : ((('s, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_IDENT__, _menhir_box_program) _menhir_state
    (** State 18.
        Stack shape : FUNCTION IDENT loption(separated_nonempty_list(COMMA,IDENT)).
        Start symbol: program. *)

  | MenhirState19 : (((('s, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_IDENT__, _menhir_box_program) _menhir_cell1_list_variable_decl_, _menhir_box_program) _menhir_state
    (** State 19.
        Stack shape : FUNCTION IDENT loption(separated_nonempty_list(COMMA,IDENT)) list(variable_decl).
        Start symbol: program. *)

  | MenhirState21 : (('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_state
    (** State 21.
        Stack shape : WHILE.
        Start symbol: program. *)

  | MenhirState22 : (('s, _menhir_box_program) _menhir_cell1_LPAR, _menhir_box_program) _menhir_state
    (** State 22.
        Stack shape : LPAR.
        Start symbol: program. *)

  | MenhirState24 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 24.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState31 : (('s, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 31.
        Stack shape : expression.
        Start symbol: program. *)

  | MenhirState33 : (('s, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 33.
        Stack shape : expression.
        Start symbol: program. *)

  | MenhirState35 : (('s, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 35.
        Stack shape : expression.
        Start symbol: program. *)

  | MenhirState37 : (('s, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 37.
        Stack shape : expression.
        Start symbol: program. *)

  | MenhirState43 : ((('s, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 43.
        Stack shape : WHILE expression.
        Start symbol: program. *)

  | MenhirState44 : (('s, _menhir_box_program) _menhir_cell1_RETURN, _menhir_box_program) _menhir_state
    (** State 44.
        Stack shape : RETURN.
        Start symbol: program. *)

  | MenhirState48 : (('s, _menhir_box_program) _menhir_cell1_PUTCHAR, _menhir_box_program) _menhir_state
    (** State 48.
        Stack shape : PUTCHAR.
        Start symbol: program. *)

  | MenhirState53 : (('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_state
    (** State 53.
        Stack shape : IF.
        Start symbol: program. *)

  | MenhirState56 : ((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_state
    (** State 56.
        Stack shape : IF expression.
        Start symbol: program. *)

  | MenhirState58 : (('s, _menhir_box_program) _menhir_cell1_IDENT, _menhir_box_program) _menhir_state
    (** State 58.
        Stack shape : IDENT.
        Start symbol: program. *)

  | MenhirState64 : (((('s, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_cell1_list_instruction_, _menhir_box_program) _menhir_state
    (** State 64.
        Stack shape : IF expression list(instruction).
        Start symbol: program. *)

  | MenhirState67 : (('s, _menhir_box_program) _menhir_cell1_instruction, _menhir_box_program) _menhir_state
    (** State 67.
        Stack shape : instruction.
        Start symbol: program. *)

  | MenhirState77 : (('s, _menhir_box_program) _menhir_cell1_function_def, _menhir_box_program) _menhir_state
    (** State 77.
        Stack shape : function_def.
        Start symbol: program. *)


and ('s, 'r) _menhir_cell1_expression = 
  | MenhirCell1_expression of 's * ('s, 'r) _menhir_state * (Imp.expression)

and ('s, 'r) _menhir_cell1_function_def = 
  | MenhirCell1_function_def of 's * ('s, 'r) _menhir_state * (Imp.function_def)

and ('s, 'r) _menhir_cell1_instruction = 
  | MenhirCell1_instruction of 's * ('s, 'r) _menhir_state * (Imp.instruction)

and ('s, 'r) _menhir_cell1_list_instruction_ = 
  | MenhirCell1_list_instruction_ of 's * ('s, 'r) _menhir_state * (Imp.sequence)

and ('s, 'r) _menhir_cell1_list_variable_decl_ = 
  | MenhirCell1_list_variable_decl_ of 's * ('s, 'r) _menhir_state * (string list)

and ('s, 'r) _menhir_cell1_loption_separated_nonempty_list_COMMA_IDENT__ = 
  | MenhirCell1_loption_separated_nonempty_list_COMMA_IDENT__ of 's * ('s, 'r) _menhir_state * (string list)

and ('s, 'r) _menhir_cell1_variable_decl = 
  | MenhirCell1_variable_decl of 's * ('s, 'r) _menhir_state * (string)

and ('s, 'r) _menhir_cell1_FUNCTION = 
  | MenhirCell1_FUNCTION of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_IDENT = 
  | MenhirCell1_IDENT of 's * ('s, 'r) _menhir_state * (
# 13 "impparser.mly"
       (string)
# 204 "impparser.ml"
)

and 's _menhir_cell0_IDENT = 
  | MenhirCell0_IDENT of 's * (
# 13 "impparser.mly"
       (string)
# 211 "impparser.ml"
)

and ('s, 'r) _menhir_cell1_IF = 
  | MenhirCell1_IF of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_LPAR = 
  | MenhirCell1_LPAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_PUTCHAR = 
  | MenhirCell1_PUTCHAR of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_RETURN = 
  | MenhirCell1_RETURN of 's * ('s, 'r) _menhir_state

and ('s, 'r) _menhir_cell1_WHILE = 
  | MenhirCell1_WHILE of 's * ('s, 'r) _menhir_state

and _menhir_box_program = 
  | MenhirBox_program of (Imp.program) [@@unboxed]

let _menhir_action_01 =
  fun n ->
    (
# 63 "impparser.mly"
        ( Cst(n) )
# 237 "impparser.ml"
     : (Imp.expression))

let _menhir_action_02 =
  fun b ->
    (
# 64 "impparser.mly"
         ( Bool(b) )
# 245 "impparser.ml"
     : (Imp.expression))

let _menhir_action_03 =
  fun id ->
    (
# 65 "impparser.mly"
           ( Var(id) )
# 253 "impparser.ml"
     : (Imp.expression))

let _menhir_action_04 =
  fun e ->
    (
# 66 "impparser.mly"
                         ( e )
# 261 "impparser.ml"
     : (Imp.expression))

let _menhir_action_05 =
  fun e1 e2 ->
    let op = 
# 72 "impparser.mly"
       ( Add )
# 269 "impparser.ml"
     in
    (
# 67 "impparser.mly"
                                       ( Binop(op, e1, e2) )
# 274 "impparser.ml"
     : (Imp.expression))

let _menhir_action_06 =
  fun e1 e2 ->
    let op = 
# 73 "impparser.mly"
       ( Mul )
# 282 "impparser.ml"
     in
    (
# 67 "impparser.mly"
                                       ( Binop(op, e1, e2) )
# 287 "impparser.ml"
     : (Imp.expression))

let _menhir_action_07 =
  fun e1 e2 ->
    let op = 
# 74 "impparser.mly"
     ( Lt )
# 295 "impparser.ml"
     in
    (
# 67 "impparser.mly"
                                       ( Binop(op, e1, e2) )
# 300 "impparser.ml"
     : (Imp.expression))

let _menhir_action_08 =
  fun f xs ->
    let params = 
# 229 "<standard.mly>"
    ( xs )
# 308 "impparser.ml"
     in
    (
# 68 "impparser.mly"
                                                             ( Call(f, params) )
# 313 "impparser.ml"
     : (Imp.expression))

let _menhir_action_09 =
  fun code locals name xs ->
    let params = 
# 229 "<standard.mly>"
    ( xs )
# 321 "impparser.ml"
     in
    (
# 47 "impparser.mly"
    ( {name; code; params; locals} )
# 326 "impparser.ml"
     : (Imp.function_def))

let _menhir_action_10 =
  fun e ->
    (
# 51 "impparser.mly"
                                      ( Putchar(e) )
# 334 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_11 =
  fun e id ->
    (
# 52 "impparser.mly"
                                 ( Set(id, e) )
# 342 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_12 =
  fun c s1 s2 ->
    (
# 55 "impparser.mly"
                                        ( If(c, s1, s2) )
# 350 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_13 =
  fun c s ->
    (
# 57 "impparser.mly"
                                  ( While(c, s) )
# 358 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_14 =
  fun e ->
    (
# 58 "impparser.mly"
                           ( Return(e) )
# 366 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_15 =
  fun e ->
    (
# 59 "impparser.mly"
                    ( Expr(e) )
# 374 "impparser.ml"
     : (Imp.instruction))

let _menhir_action_16 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 382 "impparser.ml"
     : (Imp.function_def list))

let _menhir_action_17 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 390 "impparser.ml"
     : (Imp.function_def list))

let _menhir_action_18 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 398 "impparser.ml"
     : (Imp.sequence))

let _menhir_action_19 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 406 "impparser.ml"
     : (Imp.sequence))

let _menhir_action_20 =
  fun () ->
    (
# 208 "<standard.mly>"
    ( [] )
# 414 "impparser.ml"
     : (string list))

let _menhir_action_21 =
  fun x xs ->
    (
# 210 "<standard.mly>"
    ( x :: xs )
# 422 "impparser.ml"
     : (string list))

let _menhir_action_22 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 430 "impparser.ml"
     : (string list))

let _menhir_action_23 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 438 "impparser.ml"
     : (string list))

let _menhir_action_24 =
  fun () ->
    (
# 139 "<standard.mly>"
    ( [] )
# 446 "impparser.ml"
     : (Imp.expression list))

let _menhir_action_25 =
  fun x ->
    (
# 141 "<standard.mly>"
    ( x )
# 454 "impparser.ml"
     : (Imp.expression list))

let _menhir_action_26 =
  fun functions globals ->
    (
# 30 "impparser.mly"
    ( {functions; globals} )
# 462 "impparser.ml"
     : (Imp.program))

let _menhir_action_27 =
  fun _startpos__1_ ->
    let _ = let _startpos = _startpos__1_ in
    (
# 31 "impparser.mly"
        ( let pos = _startpos in
          let message =
            Printf.sprintf
              "Syntax error at %d, %d"
              pos.pos_lnum (pos.pos_cnum - pos.pos_bol)
          in
          failwith message )
# 477 "impparser.ml"
     : (Imp.program)) in
    prerr_string "Menhir: misuse: the semantic action associated with the production\nprogram -> error\nis expected to abort the parser, but does not do so.\n";
    assert false

let _menhir_action_28 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 487 "impparser.ml"
     : (string list))

let _menhir_action_29 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 495 "impparser.ml"
     : (string list))

let _menhir_action_30 =
  fun x ->
    (
# 238 "<standard.mly>"
    ( [ x ] )
# 503 "impparser.ml"
     : (Imp.expression list))

let _menhir_action_31 =
  fun x xs ->
    (
# 240 "<standard.mly>"
    ( x :: xs )
# 511 "impparser.ml"
     : (Imp.expression list))

let _menhir_action_32 =
  fun id ->
    (
# 41 "impparser.mly"
                    ( id )
# 519 "impparser.ml"
     : (string))

let _menhir_print_token : token -> string =
  fun _tok ->
    match _tok with
    | BEGIN ->
        "BEGIN"
    | BOOL _ ->
        "BOOL"
    | COMMA ->
        "COMMA"
    | CST _ ->
        "CST"
    | ELSE ->
        "ELSE"
    | END ->
        "END"
    | EOF ->
        "EOF"
    | FUNCTION ->
        "FUNCTION"
    | IDENT _ ->
        "IDENT"
    | IF ->
        "IF"
    | LPAR ->
        "LPAR"
    | LT ->
        "LT"
    | PLUS ->
        "PLUS"
    | PUTCHAR ->
        "PUTCHAR"
    | RETURN ->
        "RETURN"
    | RPAR ->
        "RPAR"
    | SEMI ->
        "SEMI"
    | SET ->
        "SET"
    | STAR ->
        "STAR"
    | VAR ->
        "VAR"
    | WHILE ->
        "WHILE"

let _menhir_fail : unit -> 'a =
  fun () ->
    Printf.eprintf "Internal failure -- please contact the parser generator's developers.\n%!";
    assert false

include struct
  
  [@@@ocaml.warning "-4-37-39"]
  
  let rec _menhir_run_75 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_list_variable_decl_ -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_list_variable_decl_ (_menhir_stack, _, globals) = _menhir_stack in
      let functions = _v in
      let _v = _menhir_action_26 functions globals in
      MenhirBox_program _v
  
  let rec _menhir_run_78 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_function_def -> _ -> _menhir_box_program =
    fun _menhir_stack _v ->
      let MenhirCell1_function_def (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_17 x xs in
      _menhir_goto_list_function_def_ _menhir_stack _v _menhir_s
  
  and _menhir_goto_list_function_def_ : type  ttv_stack. ttv_stack -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _v _menhir_s ->
      match _menhir_s with
      | MenhirState77 ->
          _menhir_run_78 _menhir_stack _v
      | MenhirState08 ->
          _menhir_run_75 _menhir_stack _v
      | _ ->
          _menhir_fail ()
  
  let rec _menhir_run_02 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMI ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let id = _v in
              let _v = _menhir_action_32 id in
              let _menhir_stack = MenhirCell1_variable_decl (_menhir_stack, _menhir_s, _v) in
              (match (_tok : MenhirBasics.token) with
              | VAR ->
                  _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState05
              | BOOL _ | CST _ | END | EOF | FUNCTION | IDENT _ | IF | LPAR | PUTCHAR | RETURN | WHILE ->
                  let _v = _menhir_action_20 () in
                  _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_06 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_variable_decl -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_variable_decl (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_21 x xs in
      _menhir_goto_list_variable_decl_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_list_variable_decl_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState18 ->
          _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState00 ->
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState05 ->
          _menhir_run_06 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_19 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_IDENT__ as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_variable_decl_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | RETURN ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | PUTCHAR ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | IF ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState19
      | IDENT _v_0 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState19
      | CST _v_1 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_1 in
          let _v = _menhir_action_01 n in
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState19 _tok
      | BOOL _v_3 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v_3 in
          let _v = _menhir_action_02 b in
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState19 _tok
      | END ->
          let _v = _menhir_action_18 () in
          _menhir_run_73 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_20 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_WHILE (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState21
          | IDENT _v ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState21
          | CST _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v in
              let _v = _menhir_action_01 n in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState21 _tok
          | BOOL _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let b = _v in
              let _v = _menhir_action_02 b in
              _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState21 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_22 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_LPAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState22
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState22 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_23 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | LT | PLUS | RPAR | SEMI | STAR ->
          let id = _v in
          let _v = _menhir_action_03 id in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_24 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState24
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState24
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState24 _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState24 _tok
      | RPAR ->
          let _v = _menhir_action_24 () in
          _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_30 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState37
          | IDENT _v_0 ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState37
          | CST _v_1 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_1 in
              let _v = _menhir_action_01 n in
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState37 _tok
          | BOOL _v_3 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let b = _v_3 in
              let _v = _menhir_action_02 b in
              _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState37 _tok
          | _ ->
              _eRR ())
      | RPAR ->
          let x = _v in
          let _v = _menhir_action_30 x in
          _menhir_goto_separated_nonempty_list_COMMA_expression_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_run_31 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState31
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState31
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_32 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok ->
      let MenhirCell1_expression (_menhir_stack, _menhir_s, e1) = _menhir_stack in
      let e2 = _v in
      let _v = _menhir_action_06 e1 e2 in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_goto_expression : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match _menhir_s with
      | MenhirState19 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState43 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState56 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState64 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState67 ->
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState58 ->
          _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState53 ->
          _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState48 ->
          _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState44 ->
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState21 ->
          _menhir_run_41 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState22 ->
          _menhir_run_39 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState35 ->
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState33 ->
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState31 ->
          _menhir_run_32 _menhir_stack _menhir_lexbuf _menhir_lexer _v _tok
      | MenhirState37 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | MenhirState24 ->
          _menhir_run_30 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_69 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let e = _v in
          let _v = _menhir_action_15 e in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_instruction : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_instruction (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | WHILE ->
          _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | RETURN ->
          _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | PUTCHAR ->
          _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | IF ->
          _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState67
      | IDENT _v_0 ->
          _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState67
      | CST _v_1 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v_1 in
          let _v = _menhir_action_01 n in
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | BOOL _v_3 ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v_3 in
          let _v = _menhir_action_02 b in
          _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState67 _tok
      | END ->
          let _v = _menhir_action_18 () in
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _eRR ()
  
  and _menhir_run_44 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_RETURN (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState44
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState44
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState44 _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_45 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState44 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_45 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_RETURN as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_RETURN (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_14 e in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_33 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState33
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState33
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState33 _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_34 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState33 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_34 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | LT | PLUS | RPAR | SEMI ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_05 e1 e2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_35 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState35
      | IDENT _v ->
          _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState35
      | CST _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let n = _v in
          let _v = _menhir_action_01 n in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState35 _tok
      | BOOL _v ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let b = _v in
          let _v = _menhir_action_02 b in
          _menhir_run_36 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState35 _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_36 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | COMMA | LT | RPAR | SEMI ->
          let MenhirCell1_expression (_menhir_stack, _menhir_s, e1) = _menhir_stack in
          let e2 = _v in
          let _v = _menhir_action_07 e1 e2 in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_47 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_PUTCHAR (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState48
          | IDENT _v ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState48
          | CST _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v in
              let _v = _menhir_action_01 n in
              _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState48 _tok
          | BOOL _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let b = _v in
              let _v = _menhir_action_02 b in
              _menhir_run_49 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState48 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_49 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_PUTCHAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | SEMI ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let MenhirCell1_PUTCHAR (_menhir_stack, _menhir_s) = _menhir_stack in
              let e = _v in
              let _v = _menhir_action_10 e in
              _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
          | _ ->
              _eRR ())
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_52 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_IF (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | LPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState53
          | IDENT _v ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState53
          | CST _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v in
              let _v = _menhir_action_01 n in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState53 _tok
          | BOOL _v ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let b = _v in
              let _v = _menhir_action_02 b in
              _menhir_run_54 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState53 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_54 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IF as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
              | RETURN ->
                  _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
              | PUTCHAR ->
                  _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
              | LPAR ->
                  _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
              | IF ->
                  _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState56
              | IDENT _v_0 ->
                  _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState56
              | CST _v_1 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_1 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
              | BOOL _v_3 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let b = _v_3 in
                  let _v = _menhir_action_02 b in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56 _tok
              | END ->
                  let _v = _menhir_action_18 () in
                  _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState56
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_57 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | SET ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState58
          | IDENT _v_0 ->
              _menhir_run_23 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState58
          | CST _v_1 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let n = _v_1 in
              let _v = _menhir_action_01 n in
              _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState58 _tok
          | BOOL _v_3 ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              let b = _v_3 in
              let _v = _menhir_action_02 b in
              _menhir_run_59 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState58 _tok
          | _ ->
              _eRR ())
      | LPAR ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          _menhir_run_24 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT | PLUS | SEMI | STAR ->
          let id = _v in
          let _v = _menhir_action_03 id in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | _ ->
          _eRR ()
  
  and _menhir_run_59 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | SEMI ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_IDENT (_menhir_stack, _menhir_s, id) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_11 e id in
          _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_61 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expression as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_list_instruction_ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | ELSE ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
              | RETURN ->
                  _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
              | PUTCHAR ->
                  _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
              | LPAR ->
                  _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
              | IF ->
                  _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState64
              | IDENT _v_0 ->
                  _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState64
              | CST _v_1 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_1 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState64 _tok
              | BOOL _v_3 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let b = _v_3 in
                  let _v = _menhir_action_02 b in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState64 _tok
              | END ->
                  let _v = _menhir_action_18 () in
                  _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_65 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_IF, _menhir_box_program) _menhir_cell1_expression, _menhir_box_program) _menhir_cell1_list_instruction_ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_list_instruction_ (_menhir_stack, _, s1) = _menhir_stack in
      let MenhirCell1_expression (_menhir_stack, _, c) = _menhir_stack in
      let MenhirCell1_IF (_menhir_stack, _menhir_s) = _menhir_stack in
      let s2 = _v in
      let _v = _menhir_action_12 c s1 s2 in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_68 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_instruction -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_instruction (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_19 x xs in
      _menhir_goto_list_instruction_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_goto_list_instruction_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState19 ->
          _menhir_run_73 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState43 ->
          _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState67 ->
          _menhir_run_68 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState64 ->
          _menhir_run_65 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState56 ->
          _menhir_run_61 _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_73 : type  ttv_stack. (((ttv_stack, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT, _menhir_box_program) _menhir_cell1_loption_separated_nonempty_list_COMMA_IDENT__, _menhir_box_program) _menhir_cell1_list_variable_decl_ -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_list_variable_decl_ (_menhir_stack, _, locals) = _menhir_stack in
      let MenhirCell1_loption_separated_nonempty_list_COMMA_IDENT__ (_menhir_stack, _, xs) = _menhir_stack in
      let MenhirCell0_IDENT (_menhir_stack, name) = _menhir_stack in
      let MenhirCell1_FUNCTION (_menhir_stack, _menhir_s) = _menhir_stack in
      let code = _v in
      let _v = _menhir_action_09 code locals name xs in
      let _menhir_stack = MenhirCell1_function_def (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | FUNCTION ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState77
      | EOF ->
          let _v = _menhir_action_16 () in
          _menhir_run_78 _menhir_stack _v
      | _ ->
          _eRR ()
  
  and _menhir_run_09 : type  ttv_stack. ttv_stack -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _menhir_s ->
      let _menhir_stack = MenhirCell1_FUNCTION (_menhir_stack, _menhir_s) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | IDENT _v ->
          let _menhir_stack = MenhirCell0_IDENT (_menhir_stack, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | LPAR ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | IDENT _v ->
                  _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState11
              | RPAR ->
                  let _v = _menhir_action_22 () in
                  _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState11
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_12 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | COMMA ->
          let _menhir_stack = MenhirCell1_IDENT (_menhir_stack, _menhir_s, _v) in
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | IDENT _v ->
              _menhir_run_12 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState13
          | _ ->
              _eRR ())
      | RPAR ->
          let x = _v in
          let _v = _menhir_action_28 x in
          _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_IDENT_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState11 ->
          _menhir_run_15_spec_11 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState13 ->
          _menhir_run_14 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_15_spec_11 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_23 x in
      _menhir_run_16 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState11
  
  and _menhir_run_16 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_FUNCTION _menhir_cell0_IDENT as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      let _menhir_stack = MenhirCell1_loption_separated_nonempty_list_COMMA_IDENT__ (_menhir_stack, _menhir_s, _v) in
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | BEGIN ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | VAR ->
              _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState18
          | BOOL _ | CST _ | END | IDENT _ | IF | LPAR | PUTCHAR | RETURN | WHILE ->
              let _v = _menhir_action_20 () in
              _menhir_run_19 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState18 _tok
          | _ ->
              _eRR ())
      | _ ->
          _eRR ()
  
  and _menhir_run_14 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_29 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_IDENT_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_71 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_expression (_menhir_stack, _, c) = _menhir_stack in
      let MenhirCell1_WHILE (_menhir_stack, _menhir_s) = _menhir_stack in
      let s = _v in
      let _v = _menhir_action_13 c s in
      _menhir_goto_instruction _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_41 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_WHILE as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | STAR ->
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          (match (_tok : MenhirBasics.token) with
          | BEGIN ->
              let _tok = _menhir_lexer _menhir_lexbuf in
              (match (_tok : MenhirBasics.token) with
              | WHILE ->
                  _menhir_run_20 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
              | RETURN ->
                  _menhir_run_44 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
              | PUTCHAR ->
                  _menhir_run_47 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
              | LPAR ->
                  _menhir_run_22 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
              | IF ->
                  _menhir_run_52 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState43
              | IDENT _v_0 ->
                  _menhir_run_57 _menhir_stack _menhir_lexbuf _menhir_lexer _v_0 MenhirState43
              | CST _v_1 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let n = _v_1 in
                  let _v = _menhir_action_01 n in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState43 _tok
              | BOOL _v_3 ->
                  let _tok = _menhir_lexer _menhir_lexbuf in
                  let b = _v_3 in
                  let _v = _menhir_action_02 b in
                  _menhir_run_69 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState43 _tok
              | END ->
                  let _v = _menhir_action_18 () in
                  _menhir_run_71 _menhir_stack _menhir_lexbuf _menhir_lexer _v
              | _ ->
                  _eRR ())
          | _ ->
              _eRR ())
      | PLUS ->
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_run_39 : type  ttv_stack. ((ttv_stack, _menhir_box_program) _menhir_cell1_LPAR as 'stack) -> _ -> _ -> _ -> ('stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      match (_tok : MenhirBasics.token) with
      | STAR ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_31 _menhir_stack _menhir_lexbuf _menhir_lexer
      | RPAR ->
          let _tok = _menhir_lexer _menhir_lexbuf in
          let MenhirCell1_LPAR (_menhir_stack, _menhir_s) = _menhir_stack in
          let e = _v in
          let _v = _menhir_action_04 e in
          _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
      | PLUS ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_33 _menhir_stack _menhir_lexbuf _menhir_lexer
      | LT ->
          let _menhir_stack = MenhirCell1_expression (_menhir_stack, _menhir_s, _v) in
          _menhir_run_35 _menhir_stack _menhir_lexbuf _menhir_lexer
      | _ ->
          _eRR ()
  
  and _menhir_goto_separated_nonempty_list_COMMA_expression_ : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s ->
      match _menhir_s with
      | MenhirState37 ->
          _menhir_run_38 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | MenhirState24 ->
          _menhir_run_27_spec_24 _menhir_stack _menhir_lexbuf _menhir_lexer _v
      | _ ->
          _menhir_fail ()
  
  and _menhir_run_38 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_expression -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let MenhirCell1_expression (_menhir_stack, _menhir_s, x) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_31 x xs in
      _menhir_goto_separated_nonempty_list_COMMA_expression_ _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s
  
  and _menhir_run_27_spec_24 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let x = _v in
      let _v = _menhir_action_25 x in
      _menhir_run_28 _menhir_stack _menhir_lexbuf _menhir_lexer _v
  
  and _menhir_run_28 : type  ttv_stack. (ttv_stack, _menhir_box_program) _menhir_cell1_IDENT -> _ -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      let MenhirCell1_IDENT (_menhir_stack, _menhir_s, f) = _menhir_stack in
      let xs = _v in
      let _v = _menhir_action_08 f xs in
      _menhir_goto_expression _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok
  
  and _menhir_run_08 : type  ttv_stack. ttv_stack -> _ -> _ -> _ -> (ttv_stack, _menhir_box_program) _menhir_state -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer _v _menhir_s _tok ->
      let _menhir_stack = MenhirCell1_list_variable_decl_ (_menhir_stack, _menhir_s, _v) in
      match (_tok : MenhirBasics.token) with
      | FUNCTION ->
          _menhir_run_09 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState08
      | EOF ->
          let _v = _menhir_action_16 () in
          _menhir_run_75 _menhir_stack _v
      | _ ->
          _eRR ()
  
  let rec _menhir_run_00 : type  ttv_stack. ttv_stack -> _ -> _ -> _menhir_box_program =
    fun _menhir_stack _menhir_lexbuf _menhir_lexer ->
      let _tok = _menhir_lexer _menhir_lexbuf in
      match (_tok : MenhirBasics.token) with
      | VAR ->
          _menhir_run_02 _menhir_stack _menhir_lexbuf _menhir_lexer MenhirState00
      | EOF | FUNCTION ->
          let _v = _menhir_action_20 () in
          _menhir_run_08 _menhir_stack _menhir_lexbuf _menhir_lexer _v MenhirState00 _tok
      | _ ->
          let _startpos = _menhir_lexbuf.Lexing.lex_start_p in
          let _startpos__1_ = _startpos in
          let _v = _menhir_action_27 _startpos__1_ in
          MenhirBox_program _v
  
end

let program =
  fun _menhir_lexer _menhir_lexbuf ->
    let _menhir_stack = () in
    let MenhirBox_program v = _menhir_run_00 _menhir_stack _menhir_lexbuf _menhir_lexer in
    v
