//The main controller of old gods stuff.  Basically the plan is for this subprocess to just juggle the old gods, and leave most of the variables and work to them.
SUBSYSTEM_DEF(old_gods)
	name = "Old God Subsystem"
	wait = 600
	priority = 20

/datum/controller/subsystem/old_gods/New()
	NEW_SS_GLOBAL(SSold_gods)

/datum/controller/subsystem/old_gods/fire()
	for(var/G in GLOB.all_religions)
		var/datum/religion/selected_religion = GLOB.all_religions[G]
		if(selected_religion.name != LEGAL_RELIGION)
			if(prob(5)) 
				if(selected_religion.request == null)
					selected_religion.request(G)
				else
					for(var/mob/living/carbon/human/player in GLOB.player_list)
						if(player.religion == G)
							selected_religion.punish(player)
							selected_religion.request = null
			if(prob(15))
				selected_religion.whisper_to_followers()

/datum/controller/subsystem/old_gods/Initialize(time = null)
	..()

/datum/controller/subsystem/old_gods/stat_entry(msg)
	..("old god is here")

/datum/controller/subsystem/old_gods/Recover()
	log_debug("Old Gods are recovering!")