/mob/verb/up()
	set name = "Move Upwards"
	set category = "IC"

	if(zMove(UP))
		to_chat(src, "<span class='notice'>You move upwards.</span>")

/mob/verb/down()
	set name = "Move Down"
	set category = "IC"

	if(zMove(DOWN))
		to_chat(src, "<span class='notice'>You move down.</span>")

/mob/proc/zMove(direction)
	if(eyeobj)
		return eyeobj.zMove(direction)
	if(!can_ztravel())
		to_chat(src, "<span class='warning'>You lack means of travel in that direction.</span>")
		return

	var/turf/start = loc
	if(!istype(start))
		to_chat(src, "<span class='notice'>You are unable to move from here.</span>")
	var/turf/simulated/open/O = GetAbove(src)
	var/atom/climb_target
	if(istype(O))
		for(var/turf/T in trange(1,O))
			if(!isopenspace(T) && T.is_floor())
				climb_target = T
			else
				for(var/obj/I in T)
					if(I.obj_flags & OBJ_FLAG_NOFALL)
						climb_target = I
						break
			if(climb_target)
				break

	//if(climb_target)
		//climb_up(climb_target)

/mob/proc/zPull(direction)
	//checks and handles pulled items across z levels
	if(!pulling)
		return 0

	var/turf/start = pulling.loc
	var/turf/destination = (direction == UP) ? GetAbove(pulling) : GetBelow(pulling)

	if(!start.CanZPass(pulling, direction))
		to_chat(src, "<span class='warning'>\The [start] blocked your pulled object!</span>")
		stop_pulling()
		return 0

	if(!destination.CanZPass(pulling, direction))
		to_chat(src, "<span class='warning'>The [pulling] you were pulling bumps up against \the [destination].</span>")
		stop_pulling()
		return 0

	for(var/atom/A in destination)
		if(!A.CanMoveOnto(pulling, start, 1.5, direction))
			to_chat(src, "<span class='warning'>\The [A] blocks the [pulling] you were pulling.</span>")
			stop_pulling()
			return 0

	pulling.forceMove(destination)
	return 1

/atom/proc/CanMoveOnto(atom/movable/mover, turf/target, height=1.5, direction = 0)
	//Purpose: Determines if the object can move through this
	//Uses regular limitations plus whatever we think is an exception for the purpose of
	//moving up and down z levles
	return CanPass(mover, target, height, 0) || (direction == DOWN && (atom_flags & ATOM_FLAG_CLIMBABLE))

/mob/proc/can_overcome_gravity()
	return FALSE

/mob/living/carbon/human/can_overcome_gravity()
	//First do species check
	if(species && species.can_overcome_gravity(src))
		return 1
	else
		for(var/atom/a in src.loc)
			if(a.atom_flags & ATOM_FLAG_CLIMBABLE)
				return 1

		//Last check, list of items that could plausibly be used to climb but aren't climbable themselves
		var/list/objects_to_stand_on = list(
				/obj/item/weapon/stool,
				/obj/structure/bed,
			)
		for(var/type in objects_to_stand_on)
			if(locate(type) in src.loc)
				return 1
	return 0

/mob/observer/zMove(direction)
	var/turf/destination = (direction == UP) ? GetAbove(src) : GetBelow(src)
	if(destination)
		forceMove(destination)
	else
		to_chat(src, "<span class='notice'>There is nothing of interest in this direction.</span>")

/mob/observer/eye/zMove(direction)
	var/turf/destination = (direction == UP) ? GetAbove(src) : GetBelow(src)
	if(destination)
		setLoc(destination)
	else
		to_chat(src, "<span class='notice'>There is nothing of interest in this direction.</span>")

/mob/proc/can_ztravel()
	return 0

/mob/observer/can_ztravel()
	return 1

/mob/living/carbon/human/can_ztravel()
	if(incapacitated())
		return 0

	if(Process_Spacemove())
		return 1

	if(Check_Shoegrip())	//scaling hull with magboots
		for(var/turf/simulated/T in trange(1,src))
			if(T.density)
				return 1

/mob/living/silicon/robot/can_ztravel()
	if(incapacitated() || is_dead())
		return 0

	if(Process_Spacemove()) //Checks for active jetpack
		return 1

	for(var/turf/simulated/T in trange(1,src)) //Robots get "magboots"
		if(T.density)
			return 1

//FALLING STUFF

//Holds fall checks that should not be overriden by children
/atom/movable/proc/fall()
	if(!isturf(loc))
		return

	var/turf/below = GetBelow(src)
	if(!below)
		return

	var/turf/T = loc
	if(!T.CanZPass(src, DOWN) || !below.CanZPass(src, DOWN))
		return

	// No gravity in space, apparently.
	var/area/area = get_area(src)
	if(!area.has_gravity())
		return

	if(throwing)
		return

	if(can_fall())
		// We spawn here to let the current move operation complete before we start falling. fall() is normally called from
		// Entered() which is part of Move(), by spawn()ing we let that complete.  But we want to preserve if we were in client movement
		// or normal movement so other move behavior can continue.
		var/mob/M = src
		var/is_client_moving = (ismob(M) && M.client && M.client.moving)
		spawn(0)
			if(is_client_moving) M.client.moving = 1
			handle_fall(below)
			if(is_client_moving) M.client.moving = 0

//For children to override
/atom/movable/proc/can_fall(var/anchor_bypass = FALSE, var/turf/location_override = loc)
	if(!simulated)
		return FALSE

	if(anchored && !anchor_bypass)
		return FALSE

	//Override will make checks from different location used for prediction
	if(location_override)
		for(var/obj/O in location_override)
			if(O.obj_flags & OBJ_FLAG_NOFALL)
				return FALSE

		var/turf/below = GetBelow(location_override)
		for(var/atom/A in below)
			if(!A.CanPass(src, location_override))
				return FALSE


	return TRUE

/obj/can_fall()
	return ..(anchor_fall)

/obj/effect/can_fall()
	return FALSE

/obj/effect/decal/cleanable/can_fall()
	return TRUE

/obj/item/pipe/can_fall()
	var/turf/simulated/open/below = loc
	below = below.below

	. = ..()

	if(anchored)
		return FALSE

	if((locate(/obj/structure/disposalpipe/up) in below) || locate(/obj/machinery/atmospherics/pipe/zpipe/up) in below)
		return FALSE

/mob/living/carbon/human/can_fall()
	if(..())
		return species.can_fall(src)

/atom/movable/proc/handle_fall(var/turf/landing)
	Move(landing)
	if(locate(/obj/structure/stairs) in landing)
		return 1
	else
		handle_fall_effect(landing)

/atom/movable/proc/handle_fall_effect(var/turf/landing)
	if(istype(landing, /turf/simulated/open))
		visible_message("\The [src] falls from the deck above through \the [landing]!", "You hear a whoosh of displaced air.")
	else
		visible_message("\The [src] falls from the deck above and slams into \the [landing]!", "You hear something slam into the deck.")
		if(fall_damage())
			for(var/mob/living/M in landing.contents)
				visible_message("\The [src] hits \the [M.name]!")
				M.take_overall_damage(fall_damage())

/atom/movable/proc/fall_damage()
	return 0

/obj/fall_damage()
	if(w_class == ITEM_SIZE_TINY)
		return 0
	if(w_class == ITEM_SIZE_NO_CONTAINER)
		return 100
	return base_storage_cost(w_class)

/mob/living/carbon/human/handle_fall_effect(var/turf/landing)
	if(species && species.handle_fall_special(src, landing))
		return

	if(..())
		return

	if(!istype(landing, /turf/simulated/open))
		if(statcheck(stats[STAT_DX], 12, "You completely fail the landing.", "dex") && !lying)  //Gotta be dexterous to land when falling
			to_chat(src, "<span class = 'notice'>You land softly.</span>")
			return
		/* We've fallen badly for sure, now we see how bad, and apply damage accordingly.
		   Best case, we land on our legs and take a bit of damage
		   Worse, we catch ourselves with our arm
		   Even worse, we smash our face into the ground.
		*/
		playsound(src.loc, 'sound/effects/gore/fallsmash.ogg', 75, 1)//Splat
		var/damage = 15
		if(statcheck(stats[STAT_DX], 12, 0, "dex")	)
			to_chat(src, "<span class='danger'>You manage to get your feet under you.</span>")
			apply_damage(rand(0, damage), BRUTE, BP_L_LEG)
			apply_damage(rand(0, damage), BRUTE, BP_R_LEG)
		else if(statcheck(stats[STAT_DX], 8, 0, "dex"))
			to_chat(src, "<span class='danger'>You catch yourself on your hands and feel a jolt of pain.</span>")
			apply_damage(rand(0, damage), BRUTE, BP_L_ARM)
			apply_damage(rand(0, damage), BRUTE, BP_R_ARM)
			apply_damage(rand(0, damage), BRUTE, BP_CHEST)
		else
			damage = 35
			to_chat(src, "<span class='danger'><font size=3>You land square on your face.  Ouch.</font></span>")
			apply_damage(rand(0, damage), BRUTE, BP_HEAD)
		Stun(1)
		Weaken(1)
		updatehealth()


/mob/living/carbon/human/proc/climb_up(atom/A)
	if(!isturf(loc) || !bound_overlay || bound_overlay.destruction_timer || is_physically_disabled())	// This destruction_timer check ideally wouldn't be required, but I'm not awake enough to refactor this to not need it.
		return FALSE

	var/turf/T = get_turf(A)
	var/turf/above = GetAbove(src)
	if(above && T.Adjacent(bound_overlay) && above.CanZPass(src, UP)) //Certain structures will block passage from below, others not
		var/area/location = get_area(loc)
		if(location.has_gravity && !can_overcome_gravity())
			return FALSE

		visible_message("<span class='notice'>[src] starts climbing onto \the [A]!</span>", "<span class='notice'>You start climbing onto \the [A]!</span>")
		if(do_after(src, 50, A))
			visible_message("<span class='notice'>[src] climbs onto \the [A]!</span>", "<span class='notice'>You climb onto \the [A]!</span>")
			src.Move(T)
		else
			visible_message("<span class='warning'>[src] gives up on trying to climb onto \the [A]!</span>", "<span class='warning'>You give up on trying to climb onto \the [A]!</span>")
		return TRUE

/mob/living/verb/lookup()
	set name = "Look Up"
	set desc = "If you want to know what's above."
	set category = "IC"

	if(client && !is_physically_disabled())
		if(z_eye)
			reset_view(null)
			qdel(z_eye)
			z_eye = null
			return
		var/turf/above = GetAbove(src)
		if(istype(above) && above.is_open())
			z_eye = new /atom/movable/z_observer/z_up(src, src)
			to_chat(src, "<span class='notice'>You look up.</span>")
			reset_view(z_eye)
			return
		to_chat(src, "<span class='notice'>You can see \the [above ? above : "ceiling"].</span>")
	else
		to_chat(src, "<span class='notice'>You can't look up right now.</span>")

/mob/living/verb/lookdown()
	set name = "Look Down"
	set desc = "If you want to know what's below."
	set category = "IC"

	if(client && !is_physically_disabled())
		if(z_eye)
			reset_view(null)
			qdel(z_eye)
			z_eye = null
			return
		var/turf/T = get_turf(src)
		if(T && T.is_open() && HasBelow(T.z))
			z_eye = new /atom/movable/z_observer/z_down(src, src)
			to_chat(src, "<span class='notice'>You look down.</span>")
			reset_view(z_eye)
			return
		to_chat(src, "<span class='notice'>You can see \the [T ? T : "floor"].</span>")
	else
		to_chat(src, "<span class='notice'>You can't look below right now.</span>")

/mob/living
	var/atom/movable/z_observer/z_eye

/atom/movable/z_observer
	name = ""
	simulated = FALSE
	anchored = TRUE
	mouse_opacity = FALSE
	var/mob/living/owner

/atom/movable/z_observer/Initialize(mapload, var/mob/living/user)
	. = ..()
	owner = user
	follow()
	GLOB.moved_event.register(owner, src, /atom/movable/z_observer/proc/follow)

/atom/movable/z_observer/proc/follow()

/atom/movable/z_observer/z_up/follow()
	forceMove(get_step(owner, UP))
	if(isturf(src.loc))
		var/turf/T = src.loc
		if(T.is_open())
			return
	owner.reset_view(null)
	owner.z_eye = null
	qdel(src)

/atom/movable/z_observer/z_down/follow()
	forceMove(get_step(owner, DOWN))
	var/turf/T = get_turf(owner)
	if(T && T.is_open())
		return
	owner.reset_view(null)
	owner.z_eye = null
	qdel(src)

/atom/movable/z_observer/Destroy()
	GLOB.moved_event.unregister(owner, src, /atom/movable/z_observer/proc/follow)
	owner = null
	. = ..()

/atom/movable/z_observer/can_fall()
	return FALSE

/atom/movable/z_observer/ex_act()
	return

/atom/movable/z_observer/singularity_act()
	return

/atom/movable/z_observer/singularity_pull()
	return

/atom/movable/z_observer/singuloCanEat()
	return