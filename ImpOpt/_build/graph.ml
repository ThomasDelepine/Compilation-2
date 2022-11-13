type tag = Conflict | Preference
module VMap = Map.Make(String)
type graph = tag VMap.t VMap.t  (*map : entrée id noeud 
                                        ->
                                        map : entrée id noeud 
                                              ->
                                              tag*)

(* Graphe :

"r1" ----I---- "r2"
"r1" ----P---- "r3"

r1 |--> ( r2 |--> I,  r3 |--> P )
r2 |--> ( r1 |--> I )
r3 |--> ( r1 |--> P )

*)



let empty = VMap.empty
let add_vertex x g =
  if VMap.mem x g then g
  else VMap.add x VMap.empty g

let update_edge x y t g =
  assert (VMap.mem x g);
  let v = VMap.find x g in
  match VMap.find_opt y v, t with
  | None, _ | Some Preference, Conflict ->
     VMap.add x (VMap.add y t v) g
  | _ -> g

(*t : tag : si c'est un lien d'interférence ou de préférence*
      rappel : type tag = Conflict | Preference
*)

let add_edge x y t g =
  assert (x <> y);
  let g = add_vertex x (add_vertex y g) in
  update_edge x y t (update_edge y x t g)

let remove_vertex x g =
  VMap.map (VMap.remove x) (VMap.remove x g)

module VSet = Set.Make(String)

let neighbours x t g =        (*renvoie les voisins de x ayant le tag t*)
  if not (VMap.mem x g) then
    (Printf.printf "Vertex %s not found (function neighbours).\n" x;
     assert false)
  else
    VMap.fold 
      (fun y u v -> if t = u then VSet.add y v else v) (*si u est le bon tag, ajoute u à v sinon conserve v*)
      (VMap.find x g)
      VSet.empty

let degree x g =
  VSet.cardinal (neighbours x Conflict g)

let conflict x y g =
  match VMap.find_opt x g with
  | None -> false
  | Some v -> VMap.find_opt y v = Some Conflict

let has_pref x g =
  VMap.exists (fun _ t -> t = Preference) (VMap.find x g)

let remove_prefs x g =
  VMap.add x (VMap.filter (fun _ t -> t <> Preference) (VMap.find x g)) g

let merge_vertices x y v =
  let v' = VMap.remove x v in
  match VMap.find_opt x v, VMap.find_opt y v with
  | None, None -> v'
  | Some Conflict, _ | _, Some Conflict -> VMap.add y Conflict v'
  | _ -> VMap.add y Preference v'

let merge_neighbours =
  VMap.union (fun k t1 t2 -> 
      match t1, t2 with
      | Conflict, _ | _, Conflict -> Some Conflict
      | Preference, Preference    -> Some Preference) 

let merge x y g =
  Printf.printf "Merge %s into %s.\n" x y;
  VMap.filter_map (fun z v ->
      if z = x then
        None
      else if z = y then
        Some (VMap.remove x (VMap.remove y (merge_neighbours (VMap.find x g) v)))
      else
        Some (merge_vertices x y v)
    ) g

let print_graph g =
  Printf.(
    printf "Graphe d'interférence :\n";
    VMap.iter (fun x _ ->
        printf "  %s:" x;
        VSet.iter (printf " %s") (neighbours x Conflict g);
        printf "\n    | ";
        VSet.iter (printf " %s") (neighbours x Preference g);
        printf "\n")
      g
  )

