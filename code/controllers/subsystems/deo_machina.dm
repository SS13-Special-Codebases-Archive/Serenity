
//The main controller of verina.  Will manage a few small subsystems, and manage what they are doing based on crew input
/*
SUBSYSTEM_DEF(verina)
	name = "Verina"
	wait = 300  //30 seconds
	priority = 20
	flags = SS_NO_FIRE //TURN THIS ON IF YOU WANT TO MAKE THIS WORK
	var/request_type = /obj/item/stack/material/phoron
	var/obj/request_item = null
	var/request_amount = -1
	var/request_time = -1
	var/visible_shrines = list()
	var/list/requestable_items = list(/obj/item/stack/material/phoron)
	var/list/bannable_items = list()
	var/list/rewards = list()

/datum/controller/subsystem/verina/New()
	//NEW_SS_GLOBAL(SSverina)
	rewards = typesof(/datum/reward) - /datum/reward

/datum/controller/subsystem/verina/fire()
	if(!rewards)  //I hope this doesn't happen every time
		rewards = typesof(/datum/reward) - /datum/reward
	if(state == SS_RUNNING)
		if(request_item)
			request_time -= 30
			if(request_amount <= 0)
				reward()
				generate_request()
			else if (request_time <= 0)
				punish()
				generate_request()
			else
				log_debug("Request for [request_amount] [request_item.name]s in [round(request_time/60)] minutes")
		if(!request_item) //Only generate if a request isn't set
			generate_request()

/datum/controller/subsystem/verina/Initialize(time = null)
	to_world("Good morning!  Your station's Deo Machina sactioned AI is starting up!  The time is [time]")
	..()

/datum/controller/subsystem/verina/stat_entry(msg)
	..("Verina is here")

/datum/controller/subsystem/verina/Recover()
	log_debug("Verina is recovering!")

/datum/controller/subsystem/verina/proc/get_shrine_locations()
	var/shrine_locations = list()
	for(var/obj/old_god_shrine/S in visible_shrines)
		shrine_locations += get_area(S)
	return shrine_locations

/datum/controller/subsystem/verina/proc/generate_request()
	request_type = pick(requestable_items)
	request_item = new request_type
	request_amount = rand(5,30)
	request_time = rand(180,600)

/datum/controller/subsystem/verina/proc/reward()
	rewards = typesof(/datum/reward) - /datum/reward
	var/datum/reward/reward = pick(rewards)
	reward = new reward
	reward.do_reward()

*/