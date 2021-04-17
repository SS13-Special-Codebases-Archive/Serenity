/datum/event/samosbor
	var/const/enterBelt		= 30
	var/const/radIntervall 	= 5	// Enough time between enter/leave belt for 10 hits, as per original implementation
	var/const/leaveBelt		= 80
	var/const/revokeAccess	= 135
	startWhen				= 2
	announceWhen			= 1
	endWhen					= revokeAccess
	var/postStartTicks 		= 0

/datum/event/samosbor/announce()
	command_announcement.Announce("ATTENTION! ATTENTION! SAMOSBOR IS NOW, COMRADES! Evacuate into one of the maintenance tunnels or designated shelters.", "[station_name()] SAMOSBOR Control Array", new_sound = 'sound/effects/alert.ogg')

/datum/event/samosbor/start()
	make_maint_all_access()

/datum/event/samosbor/tick()
	if(activeFor == enterBelt)
		command_announcement.Announce("The [station_name()] has entered the samosbor phase. Please remain in a sheltered area and do not attempt to exit.", "[station_name()] SAMOSBOR Control Array", new_sound = 'sound/voice/fta_distant_scream_male2.ogg')
		radiate()

	if(activeFor >= enterBelt && activeFor <= leaveBelt)
		postStartTicks++

	if(postStartTicks == radIntervall)
		postStartTicks = 0
		radiate()

	else if(activeFor == leaveBelt)
		command_announcement.Announce("The [station_name()] has successfully endured during the samosbor. Please allow for up to one minute while the aftereffects dissipate, and prepare to liquidate the consequences. Maintenance will lose all access again shortly.", "[station_name()] SAMOSBOR Control Array", new_sound = 'sound/effects/stealthoff.ogg')

/datum/event/samosbor/proc/radiate()
	var/radiation_level = rand(15, 35)
	for(var/z in GLOB.using_map.station_levels)
		SSradiation.z_radiate(locate(1, 1, z), radiation_level, 1)

	for(var/mob/living/carbon/C in GLOB.living_mob_list_)
		var/area/A = get_area(C)
		if(!A)
			continue
		if(A.area_flags & AREA_FLAG_SAMOSBOR_SHIELDED)
			continue
		if(istype(C,/mob/living/carbon/human))
			C.gib()
			new /mob/living/carbon/human/blank(C.loc)

/datum/event/samosbor/end()
	revoke_maint_all_access()
