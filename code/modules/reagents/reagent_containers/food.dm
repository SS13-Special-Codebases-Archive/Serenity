////////////////////////////////////////////////////////////////////////////////
/// Food.
////////////////////////////////////////////////////////////////////////////////
/obj/item/weapon/reagent_containers/food
	randpixel = 6
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	possible_transfer_amounts = null
	volume = 50 //Sets the default container amount for all food items.
	var/filling_color = "#ffffff" //Used by sandwiches.
	var/trash = null

/obj/item/weapon/reagent_containers/food/snacks/poo
	icon = 'icons/obj/poop.dmi'
	
/obj/item/weapon/reagent_containers/food/snacks/poo/New()
	..()
	icon_state = pick("poop1", "poop2", "poop3", "poop4", "poop5", "poop6", "poop7")
	reagents.add_reagent(/datum/reagent/poo, 10)
	bitesize = 3

/obj/item/weapon/reagent_containers/food/snacks/poo/throw_impact(atom/hit_atom)
	//if(prob(50)) //this is so we actually have a chance of recovering some from disposal.
	//	return
	playsound(src.loc, "sound/effects/squishy.ogg", 40, 1)
	var/turf/T = src.loc
	if(!istype(T, /turf/space))
		new /obj/effect/decal/cleanable/poo(T)
	qdel(src)// THIS IS BAD AND YOU SHOULD FEEL BAD.
	..()