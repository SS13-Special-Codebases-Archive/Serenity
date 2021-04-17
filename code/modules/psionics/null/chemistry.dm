/datum/chemical_reaction/nullglass
	name = "Soulstone"
	result = null
	required_reagents = list(/datum/reagent/blood = 15, /datum/reagent/crystal = 1)
	result_amount = 1

/datum/chemical_reaction/nullglass/on_reaction(var/datum/reagents/holder, var/created_volume, var/reaction_flags)
	var/location = get_turf(holder.my_atom)
	if(reaction_flags)
		for(var/i = 1, i <= created_volume, i++)
			new /obj/item/device/soulstone(location)
	else
		for(var/i = 1, i <= created_volume*2, i++)
			new /obj/item/weapon/material/shard(location, MATERIAL_NULLGLASS)

/datum/reagent/crystal
	name = "crystallizing agent"
	taste_description = "sharpness"
	reagent_state = LIQUID
	color = "#13bc5e"

/datum/reagent/crystal/affect_blood(var/mob/living/carbon/M, var/alien, var/removed)
	var/result_mat = MATERIAL_NULLGLASS
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		for(var/obj/item/organ/external/E in shuffle(H.organs.Copy()))
			if(E.is_stump())
				continue

			else if(E.organ_tag != BP_CHEST && E.organ_tag != BP_GROIN && prob(15))
				to_chat(H, ("Your [E.name] is being lacerated from within!"))
				if(E.can_feel_pain())
					H.emote("scream")
				if(prob(25))
					for(var/i = 1 to rand(3,5))
						new /obj/item/weapon/material/shard(get_turf(E), result_mat)
					E.droplimb(0, DROPLIMB_BLUNT)
				else
				//this used to do something, but since no new baymed we are gucci

		for(var/obj/item/organ/internal/I in shuffle(H.internal_organs.Copy()))
			if(I.damage <= 0 || I.organ_tag == BP_BRAIN)
				continue
			if(prob(35))
				to_chat(M, ("You feel a deep, sharp tugging sensation as your [I.name] is mended."))
				I.damage -= rand(0,3)
			break
	else
		to_chat(M, ("Your flesh is being lacerated from within!"))
		M.adjustBruteLoss(rand(3,6))
		if(prob(10))
			new /obj/item/weapon/material/shard(get_turf(M), result_mat)
