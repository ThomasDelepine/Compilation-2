open Eimp
open Mips

let new_label =
  let count = ref 0 in
  fun () -> incr count; Printf.sprintf "__lab_%i" !count

let tr_fdef fdef =

  let return_label = new_label() in

  let rec tr_instr = function
    | Putchar r          -> move a0 r @@ li v0 11 @@ syscall
    | Input r            -> li v0 5 @@ syscall @@ move r v0

    | Read(rd, Global x) -> la rd x @@ lw rd 0 rd
    | Read(rd, Stack i)  -> subi gp gp (-4*i) @@ lw rd 0 gp @@ subi gp gp (4*i)

    | Write(Global x, r) -> la a1 x @@ sw r 0 a1
    | Write(Stack i, r)  -> subi gp gp (-4*i) @@ sw r 0 gp @@ subi gp gp (4*i)

    | Move(rd, r)        -> if rd = r then Nop else move rd r

    | Li(rd, n)          -> li rd n

    | Push r             -> sw r 0 sp @@ subi sp sp 4
    | Pop n              -> addi sp sp (4*n)
    | Cst(rd, n)         -> li rd n
    | Unop(rd, Addi n, r)    -> addi rd r n
    | Unop(rd, Muli n, r)    -> muli rd r n
    (*| Unop(rd, Sl n, r)    -> failwith "not implemented Sl in Eimp2mips"*)

    | Binop(rd, Add, r1, r2) -> add rd r1 r2

    | Binop(rd, Mul, r1, r2) -> mul rd r1 r2

    | Binop(rd, Lt, r1, r2)  -> slt rd r1 r2

    | Call(f) -> jal f

    | If(r, s1, s2) ->
        let then_label = new_label() in
        let else_label = new_label() in
        bnez r then_label
        @@ tr_seq s2
        @@ b else_label
        @@ label then_label
        @@ tr_seq s1
        @@ label else_label

    | While(s1, r, s2) ->
        let test_label = new_label() in
        let code_label = new_label() in
        b test_label
        @@ label code_label
        @@ tr_seq s2 
        @@ label test_label
        @@ tr_seq s1
        @@ bnez r code_label

    | Return ->
        b return_label 

  and tr_seq (s: Eimp.sequence) = match s with
    | Nop         -> nop
    | Instr i     -> tr_instr i
    | Seq(s1, s2) -> tr_seq s1 @@ tr_seq s2
  in

  let push reg = sw reg 0 sp  @@ subi sp sp 4 in

  (* code de la fonction *)
  push fp
  @@ push ra
  @@ push gp
  @@ push s0
  @@ push s1
  @@ push s2
  @@ push s3
  @@ push s4
  @@ push s5
  @@ push s6
  @@ push s7
  @@ move fp sp
  @@ move gp sp
  @@ tr_seq fdef.code
  @@ label return_label
  (* Restaurations des s_*)
  @@ addi sp sp 4
  @@ lw s7 0 sp
  @@ lw s6 (4) sp
  @@ lw s5 (8) sp
  @@ lw s4 (12) sp
  @@ lw s3 (16) sp
  @@ lw s2 (20) sp
  @@ lw s1 (24) sp
  @@ lw s0 (28) sp
  @@ lw gp (32) sp   
  @@ lw ra (36) sp   (* Récupération de l'adresse de retour *)
  @@ lw fp (40) sp   (* Restauration du pointeur de base de l'appelant *)
  @@ move sp fp       (* Mose à jour du début de la pile *)
  @@ jr ra


let tr_prog prog =
  let init =
    beqz a0 "init_end"
    @@ lw a0 0 a1
    @@ jal "atoi"
    @@ label "init_end"
    @@ move a0 v0
    (* @@ sw v0 0 sp
     * @@ subi sp sp 4 *)
    @@ jal "main"
    (* Après l'exécution de la fonction "main", appel système de fin de
       l'exécution. *)
    @@ li v0 10
    @@ syscall
  and built_ins =
    (* Fonction de conversion chaîne -> entier, à base d'une boucle sur les
       caractères de la chaîne. *)
    comment "built-in atoi"
    @@ label "atoi"
    @@ li   v0 0
    @@ label "atoi_loop"
    @@ lbu  t0 0 a0
    @@ beqz t0 "atoi_end"
    @@ addi t0 t0 (-48)
    @@ bltz t0 "atoi_error"
    @@ bgei t0 10 "atoi_error"
    @@ muli v0 v0 10
    @@ add  v0 v0 t0
    @@ addi a0 a0 1
    @@ b "atoi_loop"
    @@ label "atoi_error"
    @@ li   v0 10
    @@ syscall
    @@ label "atoi_end"
    @@ jr   ra
  in

  (**
     Code principal pour générer le code MIPS associé au programme source.
   *)
  let function_codes = List.fold_right
    (fun fdef code -> label fdef.name @@ tr_fdef fdef @@ code)
    prog.functions nop
  in
  let text = init @@ function_codes @@ built_ins
  and data = List.fold_right
    (fun id code -> label id @@ dword [0] @@ code)
    prog.globals nop
  in
  
  { text; data }
  
