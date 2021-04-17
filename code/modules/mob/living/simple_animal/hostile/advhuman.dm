

#define MOVING_TO_TARGET 3

//basic spider mob, these generally guard nests
/mob/living/simple_animal/hostile/advhuman
	name = "test human"
	desc = "This human is mad!."
	icon_state = "alien1"
	icon_living = "alien1"
	icon_dead = "alien2_dead"
	speak_emote = list("curses")
	emote_hear = list("curses")
	speak_chance = 5
	turns_per_move = 6
	see_in_dark = 7
	meat_type = /obj/item/weapon/reagent_containers/food/snacks/xenomeat
	response_help  = "pets"
	response_disarm = "gently pushes aside"
	response_harm   = "pokes"
	stop_automated_movement_when_pulled = 0
	maxHealth = 200
	health = 200
	melee_damage_lower = 60
	melee_damage_upper = 60
	heat_damage_per_tick = 20
	cold_damage_per_tick = 20
	faction = "spiders"
	var/busy = 0
	move_to_delay = 6
	speed = 3


#undef MOVING_TO_TARGET

