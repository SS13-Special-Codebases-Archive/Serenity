/obj/item/weapon/material/star
	name = "shuriken"
	desc = "A sharp, perfectly weighted piece of metal."
	icon_state = "star"
	randpixel = 12
	force_divisor = 0.1 // 6 with hardness 60 (steel)
	thrown_force_divisor = 0.75 // 15 with weight 20 (steel)
	throw_speed = 10
	throw_range = 15
	sharp = 1
	edge =  1

/obj/item/weapon/material/star/New()
	..()

/obj/item/weapon/material/star/throw_impact(atom/hit_atom)
	..()
	if(material.radioactivity>0 && istype(hit_atom,/mob/living))
		var/mob/living/M = hit_atom
		var/urgh = material.radioactivity
		M.adjustToxLoss(rand(urgh/2,urgh))

/obj/item/weapon/material/star/ninja
	default_material = "uranium"

/obj/item/weapon/material/knife/throwing
	name = "throwing knife"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "throwing"
	item_state = "knife"
	desc = "Knife designed specially for throwing."
	drop_sound = 'sound/items/knife_drop.ogg'
	drawsound = 'sound/items/unholster_knife.ogg'
	attack_verb = list("slashed", "stabbed")
	w_class = ITEM_SIZE_SMALL
	force_divisor = 0.10
	sharpness = 17
	weapon_speed_delay = 17
	thrown_force_divisor = 0.58
	throw_speed = 8
	throw_range = 15
	sharp = 1
	edge = 1
	randpixel = 5

/obj/item/weapon/material/knife/throwing/hos
	name = "throwing knife"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "throwing_hos"
	item_state = "knife"
	desc = "Knife designed specially for throwing. This one looks expensive and has engraving."
	drop_sound = 'sound/items/knife_drop.ogg'
	drawsound = 'sound/items/unholster_knife.ogg'
	attack_verb = list("slashed", "stabbed")
	w_class = ITEM_SIZE_SMALL
	force_divisor = 0.10
	sharpness = 18
	weapon_speed_delay = 17
	thrown_force_divisor = 0.63
	throw_speed = 9
	throw_range = 15
	sharp = 1
	edge = 1
	randpixel = 3

/obj/item/weapon/material/knife/throwing/hos
	default_material = "gold"

/obj/item/weapon/material/knife/throwing/athrowing
	name = "throwing knife"
	icon = 'icons/obj/weapons.dmi'
	icon_state = "athrowing"
	item_state = "knife1"
	desc = "A hard steel throwing knife."
	drop_sound = 'sound/items/knife_drop.ogg'
	drawsound = 'sound/items/unholster_knife.ogg'
	attack_verb = list("slashed", "stabbed")
	w_class = ITEM_SIZE_SMALL
	force_divisor = 0.10
	sharpness = 19
	weapon_speed_delay = 17
	thrown_force_divisor = 0.58
	throw_speed = 8
	throw_range = 15
	sharp = 1
	edge = 1
	randpixel = 5
