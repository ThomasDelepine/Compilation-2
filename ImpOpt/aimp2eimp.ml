open Eimp
open Register_allocation

(**
   La traduction de AIMP vers EIMP est faite indépendamment pour chaque
   fonction, et contient pour chacune deux tâches principales
   - associer chaque registre virtuel, soit à un registre physique, soit à
     un emplacement dans la pile,
   - lorsqu'une instruction prend ses opérandes ou place son résultat dans la
     pile, ajout d'une instruction de lecture ou d'écriture en mémoire.

   Convention : les valeurs qui viennent de la pile ou doivent y être stockées
   transitent par l'un des deux registres $t0 et $t1, dont on réserve l'usage
   à ce seul cas.
 *)

(* Traduction directe *)

let tr_unop = function
  | Aimp.Addi n -> Addi n
  | Aimp.Muli n -> Muli n
  (*| Aimp.Sl n -> Sl n*)
let tr_binop = function
  | Aimp.Add -> Add
  | Aimp.Mul -> Mul
  | Aimp.Lt -> Lt

(* On donne des noms aux registres temporaires utilisés pour les échanges
avec la pile, selon que l'on parle du résultat d'une instruction, de son
premier opérande, ou de son deuxième opérande. *)

let dst_reg = "$t0"
let op1_reg = "$t0"
let op2_reg = "$t1"

(* Fonction principale, de traduction d'une définition de fonction *)

let tr_fdef fdef =

  (* Première tâche : allocation de registres, telle que définie dans le
  module Register_allocation *)

  let alloc, mx = allocation fdef in

  (* Renvoie l'éventuelle instruction nécessaire pour sauvegarder un résultat
     ou aller chercher un opérande dans la pile, en fonction de la réalisation
     du registre virtuel correspondant. *)  
  let save vr = match Graph.VMap.find vr alloc with
    | Actual r  -> Nop
    | Stacked i -> Instr(Write(Stack(-i), dst_reg))
  in
  let load op vr = match Graph.VMap.find vr alloc with
    | Actual r  -> Nop
    | Stacked i -> Instr(Read(op, Stack(-i)))
  in
  let load1 = load op1_reg in   (*pour le premier operand*)
  let load2 = load op2_reg in   (*pour le second operand*)
(* Renvoie le registre réel où aller placer le résultat d'une instruction ou
     aller chercher un opérande, selon que le registre virtuel correspondant a
     été réalisé par un registre physique ou dans la pile. Dans ce dernier cas,
     le registre sera l'un des deux registres dédiés $t0 ou $t1. *)
  let reg op vr = match Graph.VMap.find vr alloc with
    | Actual r  -> r
    | Stacked i -> op
  in
  let dst = reg dst_reg in
  let op1 = reg op1_reg in
  let op2 = reg op2_reg in

  (* On utilise les registres réels quand il y en a, 
  et à défaut $t0 et $t1. *)


(* Fonction de traduction des instructions. Chaque registre virtuel est
     remplacé par un registre réel, en ajoutant une instruction de lecture
     ou une instruction d'écriture lorsqu'un registre virtuel est réalisé
     par un emplacement de pile. *)
  let rec tr_instr = function          
    | Aimp.Putchar vr -> 
        load1 vr @@ Instr(Putchar(op1 vr))

    | Aimp.Input vr ->
        load1 vr @@ Instr(Input(op1 vr))
        
    | Aimp.Read(vrd, x) ->
        Instr(Read(dst vrd , Global x)) @@ save vrd

    | Aimp.Write(x, vr) -> (*x : string | vr : vreg*)
        load1 vr @@ Instr(Write(Global x, op1 vr))

    | Aimp.Move(vrd, vr) ->
        load1 vr 
        @@ Instr(Move(dst vrd, op1 vr)) 
        @@ save vrd
    | Aimp.Li(vrd, n) ->
        Instr(Li(dst vrd, n)) 
        @@ save vrd

    | Aimp.Push vr ->
        load1 vr @@ Instr(Push (op1 vr))

    | Aimp.Pop n ->
        Instr(Pop n)

    | Aimp.Cst(vrd, n) ->
        Instr(Cst(dst vrd, n)) @@ save vrd

    | Aimp.Unop(vrd, op, vr) ->
       load1 vr
       @@ Instr(Unop(dst vrd, tr_unop op, op1 vr))
       @@ save vrd

    | Aimp.Binop(vrd, op, vr1, vr2) ->
       load1 vr1
       @@ load2 vr2
       @@ Instr(Binop(dst vrd, tr_binop op, op1 vr1, op2 vr2))
       @@ save vrd

    | Aimp.Call(f, n) ->
       Instr(Call f)

    | Aimp.If(vr, s1, s2) ->
        load1 vr 
        @@ Instr(If(op1 vr,  tr_seq s1, tr_seq s2))

    | Aimp.While(s1, vr, s2) ->
       load1 vr 
        @@ Instr(While(tr_seq s1, op1 vr, tr_seq s2))

    | Aimp.Return ->
        Instr(Return)

  and tr_seq = function
    | Aimp.Seq(s1, s2) -> Seq(tr_seq s1, tr_seq s2)
    | Aimp.Instr(_, i) -> tr_instr i
    | Aimp.Nop         -> Nop

  in

(* Traduction presque directe
     La liste des paramètres est résumée à sa taille, et la liste des
     variables locales au nombre d'emplacements utilisés dans la pile. *)
  {
    name = Aimp.(fdef.name);
    params = List.length Aimp.(fdef.params);
    locals = mx;
    code = tr_seq Aimp.(fdef.code);
  }

(* Traduction directe *)

let tr_prog prog = {
    globals = Aimp.(prog.globals);
    functions = List.map tr_fdef Aimp.(prog.functions);
  }
