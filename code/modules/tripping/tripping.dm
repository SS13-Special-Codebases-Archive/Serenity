/obj
	var/trip_chance = 1

/obj/Crossed(mob/living/carbon/human/H as mob)
	. = ..()
	if(trip_chance && prob(trip_chance) && trip_check(H))
		H.trip_act(src)

/obj/proc/trip_check(mob/user as mob)
	if(!ishuman(user) || !has_gravity(src) || user.resting || user.can_overcome_gravity() || !user.m_intent == "run")
		return FALSE
	return TRUE

/mob/living/carbon/human/proc/trip_act(var/obj/O)
	apply_damage(5, BRUTE)
	slip(src, 6)
	visible_message(\
		"<span class='warning'[src] trips over \the [O]!</span>",\
		"<span class='danger'You trip over \the [O]!</span>")

// Pipes
/obj/machinery/atmospherics/pipe/trip_check(mob/user as mob)
	var/turf/T = src.loc
	if(!T.is_plating())
		return FALSE
	if(initialize_directions & user.dir)
		return FALSE
	. = ..()

// Cables
/obj/structure/cable/trip_check(mob/user as mob)
	var/turf/T = src.loc
	if(!T.is_plating())
		return FALSE
	if((user.dir == d1 || user.dir == d2))
		return FALSE
	. = ..()

// Disposals
/obj/structure/disposalpipe/trip_check(mob/user as mob)
	var/turf/T = src.loc
	if(!T.is_plating())
		return FALSE
	if(dpdir & user.dir)
		return FALSE
	. = ..()