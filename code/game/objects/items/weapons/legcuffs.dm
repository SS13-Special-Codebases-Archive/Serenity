/obj/item/weapon/handcuffs/legcuffs
	name = "legcuffs"
	 desc = "Use this to keep prisoners in line."
	gender = PLURAL
	icon = 'icons/obj/items.dmi'
	icon_state = "handcuff"
	obj_flags = OBJ_FLAG_CONDUCTIBLE
	slot_flags = SLOT_BELT
	throwforce = 5
	w_class = ITEM_SIZE_SMALL
	throw_speed = 2
	throw_range = 5
	origin_tech = list(TECH_MATERIAL = 1)
	matter = list(DEFAULT_WALL_MATERIAL = 500)
	var/dispenser = 0
	var/breakouttime = 1800 //Deciseconds = 180s = 3 minutes - it's legcuffs after all
	var/cuff_sound = 'sound/weapons/handcuffs.ogg'
	var/cuff_type = "handcuffs"

/obj/item/weapon/handcuffs/legcuffs/beartrap
	name = "beartrap"
	desc = "A trap used to catch bears and other legged creatures."
	breakouttime = 300 //Deciseconds = 30s = 0.5 minute
	var/armed = 0

/obj/item/weapon/handcuffs/legcuffs/beartrap/verb/arm()
	set name = "Arm"
	set category = "Object"

	if(ishuman(usr) && !usr.stat && !usr.restrained())
		armed = !armed
		usr << "\blue \the [src] is now [(armed)?"armed":"disarmed"]"

/obj/item/weapon/handcuffs/legcuffs/beartrap/HasEntered(AM as mob|obj)
	if(armed)
		if(ishuman(AM))
			if(isturf(src.loc))
				var/mob/living/carbon/H = AM
				if(H.m_intent == "run")
					armed = 0
					usr.legcuffed = src
					src.loc = usr
					usr.update_inv_legcuffed()
					H << "\red <B>You step on \the [src]!</B>"
					for(var/mob/O in viewers(H, null))
						if(O == H)
							continue
						O.show_message("\red <B>[H] steps on \the [src].</B>", 1)
			if(isanimal(AM))
				armed = 0
			 var/mob/living/simple_animal/SA = AM
			SA.health = 0
	..()