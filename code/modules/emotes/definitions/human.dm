/decl/emote/human
	key = "vomit"

/decl/emote/human/check_user(var/mob/living/carbon/human/user)
	return (istype(user) && user.check_has_mouth() && !user.isSynthetic())

/decl/emote/human/do_emote(var/mob/living/carbon/human/user)
	user.vomit()

/decl/emote/human/deathgasp
	key = "deathgasp"

/decl/emote/human/deathgasp/get_emote_message_3p(var/mob/living/carbon/human/user)
	return "USER [user.species.get_death_message()]"

/decl/emote/human/swish
	key = "swish"

/decl/emote/human/swish/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_once()

/decl/emote/human/wag
	key = "wag"

/decl/emote/human/wag/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_start()

/decl/emote/human/sway
	key = "sway"

/decl/emote/human/sway/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_start()

/decl/emote/human/qwag
	key = "qwag"

/decl/emote/human/qwag/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_fast()

/decl/emote/human/fastsway
	key = "fastsway"

/decl/emote/human/fastsway/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_fast()

/decl/emote/human/swag
	key = "swag"

/decl/emote/human/swag/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_stop()

/decl/emote/human/stopsway
	key = "stopsway"

/decl/emote/human/stopsway/do_emote(var/mob/living/carbon/human/user)
	user.animate_tail_stop()

//Shitty stuff starts here.
/decl/emote/human/poo
	key = "poo"

/decl/emote/human/poo/do_emote(var/mob/living/carbon/human/user)
	user.handle_shit()

/decl/emote/human/pee
	key = "pee"

/decl/emote/human/pee/do_emote(var/mob/living/carbon/human/user)
	user.handle_piss()

/decl/emote/human/dance
	key ="dance"
	emote_message_3p = "USER dances around!"

/decl/emote/human/dance/do_emote(var/mob/living/carbon/human/user)
	user.do_dancing_animation()
	addtimer(CALLBACK(user, /mob/living/carbon.proc/do_dancing_animation, 10), 20) //dance immediately, then again after 2 and 4 seconds
	addtimer(CALLBACK(user, /mob/living/carbon.proc/do_dancing_animation, 10), 40)

	user.handle_emote_CD() // No endless dancing.

/mob/living/proc/do_dancing_animation()
	var/amplitude = min(4, (35/100) + 1)
	var/pixel_x_diff = rand(-amplitude, amplitude)
	var/pixel_y_diff = rand(-amplitude/3, amplitude/2)
	var/pixel_z_diff = rand(amplitude, amplitude)
	var/final_pixel_x = get_standard_pixel_x_offset(lying)
	var/final_pixel_y = get_standard_pixel_y_offset(lying)
	var/final_pixel_z = get_standard_pixel_z_offset(lying)
	animate(src, pixel_x = pixel_x + pixel_x_diff + 1, pixel_y = pixel_y + pixel_y_diff + 3 , pixel_z = pixel_z + pixel_z_diff + 2, time = 4, loop = 9)
	animate(pixel_x = final_pixel_x , pixel_y = final_pixel_y , pixel_z = final_pixel_z , time = 4)

/mob/living/proc/get_standard_pixel_x_offset()
	return initial(pixel_x)

/mob/living/proc/get_standard_pixel_y_offset()
	return initial(pixel_y)

/mob/living/proc/get_standard_pixel_z_offset()
	return initial(pixel_z)