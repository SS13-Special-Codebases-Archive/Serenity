//Lallander was here
/mob/living/carbon/human/whisper(message as text)
	message = sanitize(message)

	if (src.client)
		if (src.client.prefs.muted & MUTE_IC)
			to_chat(src, "<span class='warning'>You cannot whisper (muted).</span>")
			return

	if (src.stat == 2)
		return src.say_dead(message)

	var/alt_name = ""
	if(name != GetVoice())
		if(get_id_name("Unknown") != GetVoice())
			alt_name = "(as [get_id_name("Unknown")])"
		else
			SetName(get_id_name("Unknown"))

	if ((health < maxHealth/4) || is_asystole())
		var/verb = "whispers in their final breath"
		whisper_say(message, speaking = null, alt_name = alt_name, verb = verb)
		src.adjustBrainLoss(src.health + src.maxHealth * 2) // Deal 2x health in BrainLoss damage, as before but variable.
		updatehealth()

	if (src.stat)
		return

	whisper_say(message, alt_name = alt_name)


//This is used by both the whisper verb and human/say() to handle whispering
/mob/living/carbon/human/proc/whisper_say(var/message, var/datum/language/speaking = null, var/alt_name="", var/verb="whispers")
	say(message, speaking, verb, alt_name, whispering = 1)