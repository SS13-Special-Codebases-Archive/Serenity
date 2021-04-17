var/list/flooring_types

/proc/get_flooring_data(var/flooring_path)
	if(!flooring_types)
		flooring_types = list()
	if(!flooring_types["[flooring_path]"])
		flooring_types["[flooring_path]"] = new flooring_path
	return flooring_types["[flooring_path]"]

// State values:
// [icon_base]: initial base icon_state without edges or corners.
// if has_base_range is set, append 0-has_base_range ie.
//   [icon_base][has_base_range]
// [icon_base]_broken: damaged overlay.
// if has_damage_range is set, append 0-damage_range for state ie.
//   [icon_base]_broken[has_damage_range]
// [icon_base]_edges: directional overlays for edges.
// [icon_base]_corners: directional overlays for non-edge corners.

/decl/flooring
	var/name
	var/desc
	var/icon
	var/icon_base
	var/color

	var/has_base_range
	var/has_damage_range
	var/has_burn_range
	var/damage_temperature
	var/apply_thermal_conductivity
	var/apply_heat_capacity

	var/build_type      // Unbuildable if not set. Must be /obj/item/stack.
	var/build_cost = 1  // Stack units.
	var/build_time = 0  // BYOND ticks.

	var/descriptor = "tiles"
	var/flags
	var/can_paint
	var/can_engrave = TRUE

	//How we smooth with other flooring
	var/decal_layer = DECAL_LAYER
	var/floor_smooth = SMOOTH_ALL
	var/list/flooring_whitelist = list() //Smooth with nothing except the contents of this list
	var/list/flooring_blacklist = list() //Smooth with everything except the contents of this list

	//How we smooth with walls
	var/wall_smooth = SMOOTH_ALL
	//There are no lists for walls at this time

	//How we smooth with space and openspace tiles
	var/space_smooth = SMOOTH_ALL
	//There are no lists for spaces

/decl/flooring/proc/on_remove()
	return

/decl/flooring/grass
	name = "grass"
	desc = "Do they smoke grass out in space, Bowie? Or do they smoke AstroTurf?"
	icon = 'icons/turf/flooring/grass.dmi'
	icon_base = "grass"
	has_base_range = 3
	damage_temperature = T0C+80
	flags = TURF_HAS_EDGES | TURF_HAS_CORNERS | TURF_REMOVE_SHOVEL
	build_type = /obj/item/stack/tile/grass
	can_engrave = FALSE
	floor_smooth = SMOOTH_NONE
	wall_smooth = SMOOTH_ALL
	space_smooth = SMOOTH_NONE
	decal_layer = ABOVE_WIRE_LAYER

/decl/flooring/asteroid
	name = "coarse sand"
	desc = "Gritty and unpleasant."
	icon = 'icons/turf/flooring/asteroid.dmi'
	icon_base = "asteroid"
	flags = TURF_HAS_EDGES | TURF_REMOVE_SHOVEL
	build_type = null
	can_engrave = FALSE

/decl/flooring/carpet
	name = "brown carpet"
	desc = "Comfy and fancy carpeting."
	icon = 'icons/turf/flooring/carpet.dmi'
	icon_base = "brown"
	build_type = /obj/item/stack/tile/carpet
	damage_temperature = T0C+200
	flags = TURF_HAS_CORNERS | TURF_HAS_INNER_CORNERS | TURF_REMOVE_CROWBAR | TURF_CAN_BURN
	//footstep_type = FOOTSTEP_CARPET
	floor_smooth = SMOOTH_NONE
	wall_smooth = SMOOTH_NONE
	space_smooth = SMOOTH_NONE
	can_engrave = FALSE

/decl/flooring/carpet/blue
	name = "blue carpet"
	icon_base = "blue1"
	build_type = /obj/item/stack/tile/carpetblue

/decl/flooring/carpet/blue2
	name = "pale blue carpet"
	icon_base = "blue2"
	build_type = /obj/item/stack/tile/carpetblue2

/decl/flooring/carpet/purple
	name = "purple carpet"
	icon_base = "purple"
	build_type = /obj/item/stack/tile/carpetpurple

/decl/flooring/carpet/orange
	name = "orange carpet"
	icon_base = "orange"
	build_type = /obj/item/stack/tile/carpetorange

/decl/flooring/carpet/green
	name = "green carpet"
	icon_base = "green"
	build_type = /obj/item/stack/tile/carpetgreen

/decl/flooring/carpet/red
	name = "red carpet"
	icon_base = "red"
	build_type = /obj/item/stack/tile/carpetred

/decl/flooring/linoleum
	name = "linoleum"
	desc = "It's like the 2390's all over again."
	icon = 'icons/turf/flooring/linoleum.dmi'
	icon_base = "lino"
	can_paint = 1
	build_type = /obj/item/stack/tile/linoleum
	flags = TURF_REMOVE_SCREWDRIVER

/decl/flooring/tiling
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "steel"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/tiling/dark
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "steel2"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/tiling/bright
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "steel3"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/tiling/verybright
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "steel4"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/tiling/barnew
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "os5"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	can_paint = 1

/decl/flooring/tiling/no0
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "n00"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/no1
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "n01"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/bleeky
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "bleeky2"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/lev
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "lev"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/purpleos
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "os11"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/darkpurpleos
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "os12"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/cargo5
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "os7"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/cargochess
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "os8"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/f2
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "F2"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1

/decl/flooring/tiling/f3
	name = "floor"
	desc = "A solid, heavy set of flooring plates."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "F3"
	color = null
	has_damage_range = 4
	damage_temperature = T0C+1400
	flags = TURF_REMOVE_CROWBAR | TURF_CAN_BREAK | TURF_CAN_BURN
//	build_type = /obj/item/stack/tile/floor
	//can_paint = 1



/decl/flooring/tiling/mono
	icon_base = "monotile"
	build_type = /obj/item/stack/tile/mono

/decl/flooring/tiling/white
	desc = "How sterile."
	icon_base = "white"
	color = null
	build_type = /obj/item/stack/tile/floor_white

/decl/flooring/tiling/white/mono
	icon_base = "monotile"

/decl/flooring/tiling/dark
	desc = "How ominous."
	icon_base = "dark"
	color = null
	build_type = /obj/item/stack/tile/floor_dark

/decl/flooring/tiling/dark/mono
	icon_base = "monotile"

/decl/flooring/tiling/freezer
	desc = "Don't slip."
	icon_base = "freezer"
	color = null
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_freezer

/decl/flooring/tiling/bunker
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/bunk.dmi'
	icon_base = "plating"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/bunker

/decl/flooring/tiling/bunker/hydro
	name = "floor"
	desc = "Don't slip."
	icon_base = "hydro"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_hydro

/decl/flooring/tiling/bunker/showroom
	name = "floor"
	desc = "Don't slip."
	icon_base = "hydro"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_showroom

/decl/flooring/tiling/bunker/cafe
	name = "floor"
	desc = "Don't slip."
	icon_base = "cafe"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/floor_cafe

/decl/flooring/tiling/bunker/yellow
	name = "floor"
	desc = "Don't slip."
	icon_base = "old_tile_cargo"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/yellow

/decl/flooring/tiling/bunker/black
	name = "floor"
	desc = "Don't slip."
	icon_base = "old_tile_black"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/black

/decl/flooring/tiling/bunker/red
	name = "floor"
	desc = "Don't slip."
	icon_base = "old_tile_red"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/red

/decl/flooring/tiling/bunker/polar
	name = "floor"
	desc = "Don't slip."
	icon_base = "polar"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR

/decl/flooring/tiling/bunker/polar_white
	name = "floor"
	desc = "Don't slip."
	icon_base = "polar_white"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR

/decl/flooring/tiling/bunker/polar_circuit
	name = "floor"
	desc = "Don't slip."
	icon_base = "polar_circuit"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR

/decl/flooring/tiling/bar
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "bar"
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	build_type = /obj/item/stack/tile/bar

/decl/flooring/tiling/misc
	icon = 'icons/turf/flooring/misc.dmi'
	has_damage_range = null
	flags = TURF_REMOVE_CROWBAR
	can_paint = 0

/decl/flooring/tiling/os4
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os4"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/solarpanel2
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "solarpanel2"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/polar
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "polar"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/lev
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "lev"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os5
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os5"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os7
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os7"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os8
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os8"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os4warn
	name = "floor"
	desc = "Don't slip. Has a warning mark."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os4warn"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os4warn2
	name = "floor"
	desc = "Don't slip. Has a warning mark."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os4warn2"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os6
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os6"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os9
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os9"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/os10
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "os10"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/bet
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "bet"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/sealab
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "sealab"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/w
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "w"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/wb
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "wb"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/wb2
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "wb2"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/plate
	name = "floor"
	desc = "Don't slip."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "plating"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/circuitoff
	name = "floor"
	desc = "Don't slip. Has a strange ornament."
	icon = 'icons/turf/other_floors.dmi'
	icon_base = "circuitoff"
	has_damage_range = null
	//flags = TURF_REMOVE_CROWBAR
	//build_type = /obj/item/stack/tile/floor

/decl/flooring/tiling/misc/sec
	icon_base = "sec_chess"

/decl/flooring/tiling/misc/med
	icon_base = "tealwh_chess"

/decl/flooring/tiling/misc/cargo
	icon_base = "cargo_chess"

/decl/flooring/tiling/misc/blue
	icon_base = "blue_chess"

/decl/flooring/tiling/misc/purple
	icon_base = "prwh_chess"

/decl/flooring/tiling/tech
	icon = 'icons/turf/flooring/techfloor.dmi'
	icon_base = "techfloor_gray"
	build_type = /obj/item/stack/tile/techgrey
	color = null

/decl/flooring/tiling/tech/grid
	icon_base = "techfloor_grid"
	build_type = /obj/item/stack/tile/techgrid

/decl/flooring/tiling/new_tile
	icon_base = "tile_full"
	color = null

/decl/flooring/tiling/new_tile/cargo_one
	icon_base = "cargo_one_full"

/decl/flooring/tiling/new_tile/kafel
	icon_base = "kafel_full"

/decl/flooring/tiling/new_tile/techmaint
	icon_base = "techmaint"
	build_type = /obj/item/stack/tile/techmaint

/decl/flooring/tiling/new_tile/monofloor
	icon_base = "monofloor"
	color = COLOR_GUNMETAL

/decl/flooring/tiling/new_tile/steel_grid
	icon_base = "grid"
	color = COLOR_GUNMETAL
	build_type = /obj/item/stack/tile/grid

/decl/flooring/tiling/new_tile/steel_ridged
	icon_base = "ridged"
	color = COLOR_GUNMETAL
	build_type = /obj/item/stack/tile/ridge

/decl/flooring/wood
	name = "wooden floor"
	desc = "Polished redwood planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "wood"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER

/decl/flooring/reinforced
	name = "reinforced floor"
	desc = "Heavily reinforced with steel plating."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "reinforced"
	flags = TURF_REMOVE_WRENCH | TURF_ACID_IMMUNE
	build_type = /obj/item/stack/material/steel
	build_cost = 1
	build_time = 30
	apply_thermal_conductivity = 0.025
	apply_heat_capacity = 325000
	can_paint = 1

/decl/flooring/reinforced/circuit
	name = "processing strata"
	icon = 'icons/turf/flooring/circuit.dmi'
	icon_base = "bcircuit"
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_WRENCH
	can_paint = 1
	can_engrave = FALSE

/decl/flooring/reinforced/circuit/green
	icon_base = "gcircuit"

/decl/flooring/reinforced/circuit/red
	icon_base = "rcircuit"
	flags = TURF_ACID_IMMUNE
	can_paint = 0

/decl/flooring/reinforced/cult
	name = "engraved floor"
	desc = "Unsettling whispers waver from the surface..."
	icon = 'icons/turf/flooring/cult.dmi'
	icon_base = "cult"
	build_type = null
	has_damage_range = 6
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_WRENCH
	can_paint = null

/decl/flooring/reinforced/cult/on_remove()
	GLOB.cult.remove_cultiness(CULTINESS_PER_TURF)

/decl/flooring/reinforced/shuttle
	name = "floor"
	icon = 'icons/turf/shuttle.dmi'
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK | TURF_REMOVE_WRENCH
	can_paint = 1
	can_engrave = FALSE

/decl/flooring/reinforced/shuttle/blue
	icon_base = "floor"

/decl/flooring/reinforced/shuttle/yellow
	icon_base = "floor2"

/decl/flooring/reinforced/shuttle/white
	icon_base = "floor3"

/decl/flooring/reinforced/shuttle/red
	icon_base = "floor4"

/decl/flooring/reinforced/shuttle/purple
	icon_base = "floor5"

/decl/flooring/reinforced/shuttle/darkred
	icon_base = "floor6"

/decl/flooring/reinforced/shuttle/black
	icon_base = "floor7"

/decl/flooring/diona
	name = "biomass"
	desc = "a mass of small intertwined aliens forming a floor... Creepy."
	icon = 'icons/turf/floors.dmi'
	icon_base = "diona"
	flags = TURF_ACID_IMMUNE | TURF_REMOVE_SHOVEL

/decl/flooring/reinforced/ramp
	name = "foot ramp"
	desc = "An archaic means of locomotion along the Z axis."
	icon = 'icons/turf/flooring/tiles.dmi'
	icon_base = "ramptop"
	build_type = null
	flags = TURF_ACID_IMMUNE | TURF_CAN_BREAK
	can_paint = 1
	footstep_type = "tiles"

/decl/flooring/reinforced/ramp/bottom
	icon_base = "rampbot"

/decl/flooring/diona
	name = "biomass"
	desc = "a mass of small intertwined aliens forming a floor... Creepy."
	icon = 'icons/turf/floors.dmi'
	icon_base = "diona"
	flags = TURF_ACID_IMMUNE | TURF_REMOVE_SHOVEL

/decl/flooring/wood
	name = "wooden floor"
	desc = "Polished redwood planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "wood"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER

/decl/flooring/fancywood
	name = "fancy wooden floor"
	desc = "Polished fancy wooden planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "fancywood"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER

/decl/flooring/thatch1
	name = "thatch floor"
	desc = "Some wooden planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "thatch1"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER

/decl/flooring/thatch2
	name = "fancy wooden floor"
	desc = "Some wooden planks."
	icon = 'icons/turf/flooring/wood.dmi'
	icon_base = "thatch2"
	has_damage_range = 6
	damage_temperature = T0C+200
	descriptor = "planks"
	build_type = /obj/item/stack/tile/wood
	flags = TURF_CAN_BREAK | TURF_IS_FRAGILE | TURF_REMOVE_SCREWDRIVER