GLOBAL_DATUM_INIT(crusaders, /datum/antagonist/crusade, new)

/datum/antagonist/crusade
	id = MODE_CRUSADE
	role_text = "Crusade"
	antag_indicator = "hudsyndicate"
	role_text_plural = "Crusaders"
	landmark_id = "Crusade-Spawn"
	leader_welcome_text = "You are the supreme arbiter of an Inquisition detachment, subservant to the King. Make sure this station becomes purified."
	welcome_text = "To speak on the strike team's private channel use :t."
	flags = ANTAG_VOTABLE | ANTAG_OVERRIDE_JOB | ANTAG_CLEAR_EQUIPMENT | ANTAG_CHOOSE_NAME | ANTAG_HAS_LEADER
	antaghud_indicator = "hudoperative"

	hard_cap = 4
	hard_cap_round = 6
	initial_spawn_req = 2
	initial_spawn_target = 4
	min_player_age = 14

	faction = "crusader"

/datum/antagonist/mercenary/create_global_objectives()
	if(!..())
		return 0
	global_objectives = list()
	global_objectives |= new /datum/objective/nuclear
	return 1

/datum/antagonist/mercenary/equip(var/mob/living/carbon/human/player, var/mob/living/carbon/human/H)
	if(!..())
		return 0

	var/decl/hierarchy/outfit/job/arbiter = outfit_by_type(/decl/hierarchy/outfit/job/arbiter)
	arbiter.equip(player)

	H.generate_stats(STAT_ST)
	H.generate_skills(list("melee", "ranged"))

	return 1
