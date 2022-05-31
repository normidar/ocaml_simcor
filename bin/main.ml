
(*建物情報*)
type building_status = {
  b_name: string;
  cost: int;
  build_time: float;
  worker_wage: float;
}


(*製品情報*)
type seihin_status = {
  name: string;
  price: float;  (* 売る時の値段 *)
  use_building: string;  (*使用する建物*)
  need: (string * float) list;
  cost: float; (*必要品以外のコスト、人件費、管理費など*)
  produce_speed: float;  (*生産速度/毎時間*)
  transport: float;
}

let product_list = [
  {name = "power"; price = 0.25; use_building = "power_plant"; need = []; cost = 0.02; produce_speed = 2465.54; transport = 0.;};
  {name = "water"; price = 0.32; use_building = "water_reservoir"; need = [("power",0.2)]; cost = 0.03; produce_speed = 1575.34;transport = 0.;};
  {name = "seeds"; price = 0.2; use_building = "plantation"; need = [("water",0.1)]; cost = 0.01; produce_speed = 887.37; transport = 0.1;};
  {name = "wood"; price = 3.; use_building = "plantation"; need = [("water",4.);("seeds",1.)]; cost = 0.17; produce_speed = 76.64; transport = 1.;};
  {name = "limestone"; price = 1.39; use_building = "quarry"; need = [("power",2.)]; cost = 0.05; produce_speed = 683.24; transport = 1.;};
  {name = "cement"; price = 6.; use_building = "concrete_plant"; need = [("limestone",3.)]; cost = 0.16; produce_speed = 287.89; transport = 1.;};
  {name = "sand"; price = 1.14; use_building = "quarry"; need = [("power",2.)]; cost = 0.03; produce_speed = 1220.07; transport = 1.;};
  {name = "iron_ore"; price = 4.5; use_building = "mine"; need = [("power",7.);("water",0.5)]; cost = 0.22; produce_speed = 156.17; transport = 1.;};
  {name = "minerals"; price = 11.; use_building = "mine"; need = [("power",20.);("water",1.)]; cost = 0.33; produce_speed = 102.49; transport = 1.;};
  {name = "chemicals"; price = 14.9; use_building = "factory"; need = [("power",0.2);("minerals",1.)]; cost = 0.25; produce_speed = 205.46; transport = 1.;};
  {name = "steel"; price = 11.2; use_building = "factory"; need = [("power",5.);("iron_ore",1.);("chemicals",0.1)]; cost = 0.28; produce_speed = 184.92; transport = 1.;};
  {name = "reinforced_concrete"; price = 184.; use_building = "concrete_plant"; need = [("cement",15.);("sand",20.);("water",20.);("steel",5.)]; cost = 0.20; produce_speed = 181.59; transport = 10.;};
  {name = "clay"; price = 0.82; use_building = "quarry"; need = [("power",1.)]; cost = 0.04; produce_speed = 927.25; transport = 1.;};
  {name = "bricks"; price = 2.6; use_building = "concrete_plant"; need = [("clay",0.5)]; cost = 0.13; produce_speed = 354.32; transport = 1.;};
  {name = "cement"; price = 5.9; use_building = "concrete_plant"; need = [("limestone",3.)]; cost = 0.16; produce_speed = 287.89; transport = 1.;};
  {name = "steel_beams"; price = 20.; use_building = "construction_factory"; need = [("steel",1.);("power",4.)]; cost = 0.37; produce_speed = 123.8;transport = 5.;};
  {name = "planks"; price = 9.1; use_building = "construction_factory"; need = [("wood",0.5)]; cost = 0.41; produce_speed = 109.65; transport = 1.;};
  {name = "bauxite"; price = 10.; use_building = "mine"; need = [("power",14.);("water",0.5)]; cost = 0.33; produce_speed = 82.96; transport = 1.;};
  {name = "aluminium"; price = 19.8; use_building = "factory"; need = [("power",15.);("bauxite",1.)]; cost = 0.36; produce_speed = 115.06; transport = 1.;};
  {name = "silicon"; price = 7.8; use_building = "factory"; need = [("power",3.);("sand",2.)]; cost = 0.28; produce_speed = 147.93; transport = 1.;};
  {name = "glass"; price = 13.9; use_building = "factory"; need = [("power",2.);("silicon",1.)]; cost = 0.34; produce_speed = 123.28; transport = 1.;};
  {name = "windows"; price = 115.; use_building = "construction_factory"; need = [("aluminium",2.);("glass",1.)]; cost = 3.03; produce_speed = 15.29; transport = 1.;};
  {name = "electronic_components"; price = 56.5; use_building = "electronics_factory"; need = [("silicon",3.);("chemicals",1.)]; cost = 0.95; produce_speed = 39.86; transport = 1.;};
  {name = "batteries"; price = 92.; use_building = "electronics_factory"; need = [("chemicals",4.)]; cost = 1.56; produce_speed = 24.36; transport = 1.;};
  {name = "tools"; price = 192.; use_building = "construction_factory"; need = [("steel",0.5);("planks",0.5);("electronic_components",1.);("batteries",1.)]; cost = 1.95; produce_speed = 24.76; transport = 1.;};
  {name = "car_body"; price = 760.; use_building = "car_factory"; need = [("aluminium",30.);("glass",5.);("steel",5.)]; cost = 1.96; produce_speed = 22.88; transport = 2.;};
  {name = "combustion_engine"; price = 645.; use_building = "propulsion_factory"; need = [("steel",6.);("chemicals",5.);("electronic_components",5.)]; cost = 11.85; produce_speed = 5.24; transport = 2.;};
  {name = "bulldozer"; price = 2260.; use_building = "car_factory"; need = [("steel",4.);("car_body",1.);("combustion_engine",2.)]; cost = 8.4; produce_speed = 5.34; transport = 5.;};
  {name = "crude_oil"; price = 31.; use_building = "oil_rig"; need = [("power",25.)]; cost = 1.49; produce_speed = 34.66; transport = 1.;};
  {name = "sugarcane"; price = 1.3; use_building = "plantation"; need = [("water",3.);("seeds",1.)]; cost = 0.02; produce_speed = 645.36; transport = 0.1;};
  {name = "ethanol"; price = 23.; use_building = "beverage_factory"; need = [("power",20.);("sugarcane",10.)]; cost = 0.40; produce_speed = 59.77; transport = 1.;};
  {name = "diesel"; price = 40.75; use_building = "refinery"; need = [("power",15.);("crude_oil",0.75);("ethanol",0.25)]; cost = 0.44; produce_speed = 109.65; transport = 1.;};
  {name = "construction_unit"; price = 2610.; use_building = "general_contractor"; need = [("bulldozer",0.125);("diesel",5.);("windows",4.);("steel_beams",8.);("tools",4.)]; cost = 36.14; produce_speed = 0.95; transport = 0.;};
  {name = "processors"; price = 122.; use_building = "electronics_factory"; need = [("silicon",4.);("chemicals",1.)]; cost = 4.03; produce_speed = 8.86; transport =1.;};
  {name = "on-board_computer"; price = 478.; use_building = "electronics_factory"; need = [("processors",2.);("electronic_components",3.)]; cost = 2.69; produce_speed = 13.29; transport =1.;};
  {name = "electric_motor"; price = 222.; use_building ="propulsion_factory"; need = [("steel",2.);("electronic_components",3.)]; cost = 2.03; produce_speed = 28.83; transport =2.;};
  {name = "displays"; price = 125.; use_building ="electronics_factory"; need = [("silicon",5.);("chemicals",4.)]; cost = 1.15; produce_speed = 31.; transport =1.;};
]

let building_list = [
  {b_name = "plantation"; worker_wage = 104.; cost = 6_900; build_time = 1.0};
  {b_name = "farm"; worker_wage = 138.; cost = 10_350; build_time = 2.0};
  {b_name = "bakery"; worker_wage = 449.; cost = 6_900; build_time = 1.0};
  {b_name = "mill"; worker_wage = 380.; cost = 27_600; build_time = 3.0};
  {b_name = "power_plant"; worker_wage = 414.; cost = 51_750; build_time = 3.0};
  {b_name = "slaughterhouse"; worker_wage = 414.; cost = 20_700; build_time = 4.0};
  {b_name = "food_processing_plant"; worker_wage = 380.; cost = 86_250; build_time = 6.0};
  {b_name = "catering"; worker_wage = 656.; cost = 103_500; build_time = 4.0};
  {b_name = "beverage_factory"; worker_wage = 241.; cost = 13_800; build_time = 2.0};
  {b_name = "concrete_plant"; worker_wage = 380.; cost = 58_650; build_time = 5.0};
  {b_name = "quarry"; worker_wage = 276.; cost = 24_150; build_time = 3.0};
  {b_name = "construction_factory"; worker_wage = 483.; cost = 72_450; build_time = 6.0};
  {b_name = "general_contractor"; worker_wage = 380.; cost = 27_600; build_time = 3.0};
  {b_name = "fashion_factory"; worker_wage = 138.; cost = 13_800; build_time = 2.0}; 
  {b_name = "oil_rig"; worker_wage = 518.; cost = 69_000; build_time = 4.0};
  {b_name = "refinery"; worker_wage = 483.; cost = 69_000; build_time = 4.0};
  {b_name = "electronics_factory"; worker_wage = 380.; cost = 82_800; build_time = 5.0};
  {b_name = "propulsion_factory"; worker_wage = 621.; cost = 103_500; build_time = 7.0};
  {b_name = "car_factory"; worker_wage = 449.; cost = 93_150; build_time = 6.0};
  {b_name = "aerospace_factory"; worker_wage = 587.; cost = 106_950; build_time = 6.0};
  {b_name = "aerospace_electronics"; worker_wage = 725.; cost = 141_450; build_time = 6.0};
  {b_name = "water_reservoir"; worker_wage = 345.; cost = 20_700; build_time = 2.0};
  {b_name = "shipping_depot"; worker_wage = 311.; cost = 51_750; build_time = 3.0};
  {b_name = "mine"; worker_wage = 276.; cost = 24_150; build_time = 4.0};
  {b_name = "factory"; worker_wage = 414.; cost = 48_300; build_time = 3.0};
  {b_name = "aerospace_factory"; worker_wage = 587.; cost = 106_950; build_time = 6.0};(*下は研究センター*)
  {b_name = "plant_research_center"; worker_wage = 449.; cost = 103_500; build_time = 5.0};
  {b_name = "physics_laboratory"; worker_wage = 587.; cost = 165_600; build_time = 7.0};
  {b_name = "breeding_laboratory"; worker_wage = 414.; cost = 96_600; build_time = 5.0};
  {b_name = "chemistry_laboratory"; worker_wage = 414.; cost = 96_600; build_time = 5.0};
  {b_name = "software_r&d"; worker_wage = 587.; cost = 65_550; build_time = 3.0};
  {b_name = "automotive_r&d"; worker_wage = 552.; cost = 138_000; build_time = 6.0};
  {b_name = "fashion_&_design"; worker_wage = 449.; cost = 72_450; build_time = 2.0};
  {b_name = "launch_pad"; worker_wage = 518.; cost = 124_200; build_time = 9.0};
  {b_name = "kitchen"; worker_wage = 518.; cost = 82_800; build_time = 4.0};
]

let rec get_worker_wage building lst = match lst with
| [] -> 0.
| x :: xs -> if x.b_name = building then x.worker_wage else get_worker_wage building xs

(*人件費の計算*)
let worker_cost p = 
    let rec count_worker_cost product lst = match lst with
    | [] -> 0.
    | x :: xs -> if x.name = product then 
      (get_worker_wage x.use_building building_list) /. x.produce_speed else count_worker_cost product xs in
  count_worker_cost p product_list
let _ = worker_cost
(* let () = print_endline ("Worker cost " ^ (string_of_float (worker_cost "power"))) *)

(*produce cost equal worker_cost + cost + metarial_cost*)
(*each hour earn equal (price - produce_cost) * produce_speed *)

(*取り出し*)
let get_product product =
  let rec get_product_price _product lst = match lst with
    | [] -> None
    | x :: xs -> if x.name = _product then Some x else get_product_price _product xs in
get_product_price product product_list
let _ = get_product

(*材料費の計算*)
let product_price product =
  let rec get_product_price _product lst = match lst with
    | [] -> 0.
    | x :: xs -> if x.name = _product then x.price else get_product_price _product xs in
get_product_price product product_list

let rec count_metarial_cost = function 
| [] -> 0.
| x :: xs -> 
  let name, count = x in
  (product_price name) *. count +. count_metarial_cost xs

let metarial_cost product = 
  let rec _product_metarial_lst p = function
  | [] -> []
  | x :: xs -> if x.name = p then x.need else _product_metarial_lst p xs in
count_metarial_cost (_product_metarial_lst product product_list)

(* let () = print_endline (string_of_float (metarial_cost "reinforced_concrete")) *)

(*生産コストの計算*)
let produce_cost product = 
  let rec _produce_cost p = function
  | [] -> 0.
  | x :: xs -> if x.name = p then 
    x.cost +. worker_cost p +. metarial_cost p +. x.transport *. 0.36 else
    _produce_cost p xs in
_produce_cost product product_list
let _ = produce_cost

(* let () = print_endline (string_of_float ( (produce_cost "wood"))) *)

(*produce cost equal worker_cost + cost + metarial_cost*)
(*each hour earn equal (price - produce_cost) * produce_speed *)

(*毎時間利益計算*)
let product = get_product "construction_unit"
let count_earn = function
  | None -> min_float
  | Some x -> (x.price *. 0.97 -. produce_cost x.name) *. x.produce_speed
let _ = count_earn product
(* let () = print_endline (string_of_float (count_earn product)) *)

(* let rec ff = function
| [] -> ()
| x :: xs -> print_endline (x.name ^ " + " ^ string_of_float(count_earn (Some x))) ;ff xs

let () = ff product_list *)




(*周期計算*)
let _get_return_time p = 
  let rec _get_build_time_cost building_name = function
    | [] -> (max_float, max_int)
    | x :: xs -> if x.b_name = building_name then (x.build_time, x.cost) else _get_build_time_cost building_name xs in
  let (_time, _cost) = _get_build_time_cost p.use_building building_list in
  let cost = (float_of_int _cost) in
  let earn = count_earn (Some p) in
  if earn < 0. then 0. else cost /. earn +. _time *. 2.

(* let rec ff = function
  | [] -> ()
  | x :: xs -> print_endline (x.name ^ " + " ^ string_of_float((get_return_time x) /. 24.)) ;ff xs
  
let () = ff product_list *)


(*パワー計算*)
let rec get_product_power = function
| None -> -1.
| Some p ->
  let rec _count_power = function
  | [] -> 0.
  | x :: xs -> let (_name,_count) = x in
    (get_product_power (get_product _name)) *. _count +. _count_power xs in
  if p.name = "power" then 1. else _count_power p.need

  let rec ff = function
  | [] -> ()
  | x :: xs -> print_endline (x.name ^ " + " ^ string_of_float(get_product_power (Some x))) ;ff xs
  
let () = ff product_list