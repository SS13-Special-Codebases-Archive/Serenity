/mob/living/carbon/human/proc/handle_eye_blink()
	eye_blink()

/mob/living/carbon/human
	var/eye_color_back = null
	var/eye_close_stat = 0

/mob/living/carbon/human/proc/create_eye_blink()
	eye_color_back = r_eyes

/mob/living/carbon/human/proc/eye_blink_spawn()
	change_eye_color(eye_color_back)
	eye_close_stat = 0

/mob/living/carbon/human/proc/eye_blink()
	var/RED
	var/GREEN
	var/BLUE
	switch(get_species())
		if(SPECIES_HUMAN)
			RED = 225 + s_tone
			GREEN = 172 + s_tone
			BLUE = 119 + s_tone
		else
			return

	if(!stat)

		if(rand(1,100) <= 20)

			if(!eye_close_stat)

				create_eye_blink()

			change_eye_color(rgb(RED, GREEN, BLUE))
			addtimer(CALLBACK(src, .proc/eye_blink_spawn), 1)

		else if(eye_close_stat)

			change_eye_color(eye_color_back)

	else if(!eye_close_stat)

		if(!eye_close_stat)

			create_eye_blink()

		change_eye_color(rgb(RED, GREEN, BLUE))
		eye_close_stat = 1