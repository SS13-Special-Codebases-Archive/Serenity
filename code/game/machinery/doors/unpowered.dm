/obj/machinery/door/airlock/unpowered
	autoclose = 0
	locked = 0

/obj/machinery/door/airlock/unpowered/Bumped(atom/AM)
	if(src.locked)
		return
	..()
	return

/obj/machinery/door/airlock/unpowered/attackby(obj/item/I as obj, mob/user as mob)
	if(istype(I, /obj/item/weapon/melee/energy/blade))	return
	if(src.locked)	return
	..()
	return

/obj/machinery/door/airlock/unpowered/emag_act()
	return -1

/obj/machinery/door/airlock/unpowered/shuttle
	icon = 'icons/turf/shuttle.dmi'
	name = "door"
	icon_state = "door1"
	opacity = 1
	density = 1
