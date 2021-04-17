/mob/living/carbon/human
	hud_type = /datum/hud/human

/datum/hud/human/FinalizeInstantiation(var/ui_style='icons/mob/screen1_White.dmi', var/ui_color = "#ffffff", var/ui_alpha = 255)
	var/mob/living/carbon/human/target = mymob
	var/datum/hud_data/hud_data
	if(!istype(target))
		hud_data = new()
	else
		hud_data = target.species.hud

	if(hud_data.icon)
		ui_style = 'icons/mob/screen/dark.dmi'//hud_data.icon
	else
		ui_style = 'icons/mob/screen/dark.dmi'

	src.adding = list()
	src.other = list()
	src.hotkeybuttons = list() //These can be disabled for hotkey usersx
	mymob.using_alt_hud = 1

	var/list/hud_elements = list()
	var/obj/screen/using
	var/obj/screen/inventory/inv_box

	using = new /obj/screen() //Right hud bar
	using.dir = SOUTH
	using.icon = ui_style
	using.icon_state = "bg"
	using.screen_loc = "EAST+1,SOUTH to EAST+1,NORTH"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new"
	using.screen_loc = "-1,15"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new2"
	using.screen_loc = "0,1 to 0,4"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new3"
	using.screen_loc = "0,4 to 0,8"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new2"
	using.screen_loc = "0,8 to 0,14"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new4"
	using.screen_loc = "-2,1 to -2,14"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen() //Upper bar
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "middle"
	using.screen_loc = "-1,1 to -1,4"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen() //Upper bar
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "middle2"
	using.screen_loc = "-1,5"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen() //Upper bar
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "middle"
	using.screen_loc = "-1,6 to -1,14"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new5"
	using.screen_loc = "0,15"
	using.layer = UNDER_HUD_LAYER
	adding += using

	using = new /obj/screen()
	using.dir = NORTH
	using.icon = ui_style
	using.icon_state = "new6"
	using.screen_loc = "-2,15"
	using.layer = UNDER_HUD_LAYER
	adding += using


	// Draw the various inventory equipment slots.
	var/has_hidden_gear
	for(var/gear_slot in hud_data.gear)

		inv_box = new /obj/screen/inventory()
		inv_box.icon = ui_style
		inv_box.color = ui_color
		inv_box.alpha = ui_alpha

		var/list/slot_data =  hud_data.gear[gear_slot]
		inv_box.name =        gear_slot
		inv_box.screen_loc =  slot_data["loc"]
		inv_box.slot_id =     slot_data["slot"]
		inv_box.icon_state =  slot_data["state"]

		if(slot_data["dir"])
			inv_box.set_dir(slot_data["dir"])

		if(slot_data["toggle"])
			//src.other += inv_box
			has_hidden_gear = 0
			src.adding += inv_box
		else
			src.adding += inv_box

	if(has_hidden_gear)
		using = new /obj/screen()
		using.name = "toggle"
		using.icon = ui_style
		using.icon_state = "other"
		using.screen_loc = ui_inventory
		using.color = ui_color
		using.alpha = ui_alpha
		src.adding += using

	if(ishuman(mymob))
		var/mob/living/carbon/human/H = mymob
		H.hovertext = new /obj/screen/text/atm
		H.hovertext.maptext = ""
		H.hovertext.maptext_height = 100
		H.hovertext.maptext_width = 480
		H.hovertext.screen_loc = "CENTER-7, CENTER+7"
		hud_elements |= H.hovertext

	// Draw the attack intent dialogue.
	if(hud_data.has_a_intent)

		using = new /obj/screen/intent()
		using.icon = ui_style
		src.adding += using
		action_intent = using

		hud_elements |= using

	// Draw the combat intent dialogue.
	if(hud_data.has_c_intent)

		using = new /obj/screen/combat()
		src.adding += using

		hud_elements |= using

	// Draw the skill/family dialogue.
	if(hud_data.has_skills_family)

		using = new /obj/screen/skills_family()
		src.adding += using

		hud_elements |= using

	if(hud_data.has_m_intent)
		using = new /obj/screen()
		using.name = "mov_intent"
		using.icon = ui_style
		using.icon_state = (mymob.m_intent == "run" ? "running" : "walking")
		using.screen_loc = ui_movi
		using.color = ui_color
		using.alpha = ui_alpha
		src.adding += using
		move_intent = using

	if(hud_data.has_drop)
		using = new /obj/screen()
		using.name = "drop"
		using.icon = ui_style
		using.icon_state = "act_drop"
		using.screen_loc = ui_dropbutton
		using.color = ui_color
		using.alpha = ui_alpha
		src.hotkeybuttons += using

	if(hud_data.has_hands)
		/*
		using = new /obj/screen()
		using.name = "equip"
		using.icon = ui_style
		using.icon_state = "act_equip"
		using.screen_loc = ui_tg_equip
		using.color = ui_color
		using.alpha = ui_alpha
		src.adding += using
		*/

		inv_box = new /obj/screen/inventory()
		inv_box.name = "r_hand"
		inv_box.icon = ui_style
		inv_box.icon_state = "r_hand_inactive"
		if(mymob && !mymob.hand)	//This being 0 or null means the right hand is in use
			inv_box.icon_state = "r_hand_active"
		inv_box.screen_loc = ui_rhand
		inv_box.slot_id = slot_r_hand
		inv_box.color = ui_color
		inv_box.alpha = ui_alpha

		src.r_hand_hud_object = inv_box
		src.adding += inv_box

		inv_box = new /obj/screen/inventory()
		inv_box.name = "l_hand"
		inv_box.icon = ui_style
		inv_box.icon_state = "l_hand_inactive"
		if(mymob && mymob.hand)	//This being 1 means the left hand is in use
			inv_box.icon_state = "l_hand_active"
		inv_box.screen_loc = ui_lhand
		inv_box.slot_id = slot_l_hand
		inv_box.color = ui_color
		inv_box.alpha = ui_alpha
		src.l_hand_hud_object = inv_box
		src.adding += inv_box
	/*
		using = new /obj/screen/inventory()
		using.name = "hand"
		using.icon = ui_style
		using.icon_state = "hand"
		using.screen_loc = ui_swaphand1
		using.color = ui_color
		using.alpha = ui_alpha
		src.adding += using

		using = new /obj/screen/inventory()
		using.name = "hand"
		using.icon = ui_style
		using.icon_state = "hand2"
		using.screen_loc = ui_swaphand2
		using.color = ui_color
		using.alpha = ui_alpha
		src.adding += using
		*/

		using = new /obj/screen/inventory()
		using.name = "hand"
		using.dir = NORTH
		using.icon = ui_style
		using.icon_state = "hand"
		using.screen_loc = ui_swaphand1
		src.swaphands_hud_object = using
		src.adding += using

	if(hud_data.has_resist)
		using = new /obj/screen()
		using.name = "resist"
		using.icon = ui_style
		using.icon_state = "act_resist"
		using.screen_loc = ui_resist
		using.color = ui_color
		using.alpha = ui_alpha
		src.hotkeybuttons += using

	if(hud_data.has_throw)
		mymob.throw_icon = new /obj/screen()
		mymob.throw_icon.icon = ui_style
		mymob.throw_icon.icon_state = "act_throw_off"
		mymob.throw_icon.name = "throw"
		mymob.throw_icon.screen_loc = ui_dropbutton
		mymob.throw_icon.color = ui_color
		mymob.throw_icon.alpha = ui_alpha
		src.hotkeybuttons += mymob.throw_icon
		hud_elements |= mymob.throw_icon

		mymob.pullin = new /obj/screen()
		mymob.pullin.icon = ui_style
		mymob.pullin.icon_state = "pull0"
		mymob.pullin.name = "pull"
		mymob.pullin.screen_loc = ui_pull
		src.hotkeybuttons += mymob.pullin
		hud_elements |= mymob.pullin

	if(hud_data.has_internals)
		mymob.internals = new /obj/screen()
		mymob.internals.icon = ui_style
		mymob.internals.icon_state = "internal0"
		mymob.internals.name = "internal"
		mymob.internals.screen_loc = ui_internal
		hud_elements |= mymob.internals

	if(hud_data.has_warnings)
		mymob.oxygen = new /obj/screen()
		mymob.oxygen.icon = ui_style
		mymob.oxygen.icon_state = "oxy0"
		mymob.oxygen.name = "oxygen"
		mymob.oxygen.screen_loc = ui_oxygen
		hud_elements |= mymob.oxygen

		mymob.toxin = new /obj/screen()
		mymob.toxin.icon = ui_style
		mymob.toxin.icon_state = "tox0"
		mymob.toxin.name = "toxin"
		mymob.toxin.screen_loc = ui_toxin
		hud_elements |= mymob.toxin

		mymob.fire = new /obj/screen()
		mymob.fire.icon = ui_style
		mymob.fire.icon_state = "fire0"
		mymob.fire.name = "fire"
		mymob.fire.screen_loc = ui_fire
		hud_elements |= mymob.fire

		mymob.healths = new /obj/screen()
		mymob.healths.icon = ui_style
		mymob.healths.icon_state = "health0"
		mymob.healths.name = "health"
		mymob.healths.screen_loc = ui_health
		hud_elements |= mymob.healths

	if(hud_data.has_pressure)
		mymob.pressure = new /obj/screen()
		mymob.pressure.icon = ui_style
		mymob.pressure.icon_state = "pressure0"
		mymob.pressure.name = "pressure"
		mymob.pressure.screen_loc = ui_pressure
		hud_elements |= mymob.pressure

	if(hud_data.has_bodytemp)
		mymob.bodytemp = new /obj/screen()
		mymob.bodytemp.icon = ui_style
		mymob.bodytemp.icon_state = "temp1"
		mymob.bodytemp.name = "body temperature"
		mymob.bodytemp.screen_loc = ui_temp
		hud_elements |= mymob.bodytemp

	if(target.isSynthetic())
		target.cells = new /obj/screen()
		target.cells.icon = 'icons/mob/screen1_robot.dmi'
		target.cells.icon_state = "charge-empty"
		target.cells.name = "cell"
		target.cells.screen_loc = ui_nutrition
		hud_elements |= target.cells

	else if(hud_data.has_nutrition)
		mymob.nutrition_icon = new /obj/screen()
		mymob.nutrition_icon.icon = ui_style
		mymob.nutrition_icon.icon_state = "nutrition1"
		mymob.nutrition_icon.name = "nutrition"
		mymob.nutrition_icon.screen_loc = ui_nutrition
		hud_elements |= mymob.nutrition_icon

		mymob.hydration_icon = new /obj/screen/drink()
		mymob.hydration_icon.icon = ui_style
		mymob.hydration_icon.icon_state = "hydration1"
		mymob.hydration_icon.SetName("hydration")
		mymob.hydration_icon.screen_loc = ui_nutrition
		hud_elements |= mymob.hydration_icon

	mymob.stamina_icon = new /obj/screen()//STAMINA
	mymob.stamina_icon.icon = ui_style
	mymob.stamina_icon.icon_state = "stamina0"
	mymob.stamina_icon.name = "stamina"
	mymob.stamina_icon.screen_loc = ui_stamina
	hud_elements |= mymob.stamina_icon

	mymob.film_grain = new()
	mymob.film_grain.icon = 'icons/effects/static.dmi'
	mymob.film_grain.icon_state = "7 moderate"
	mymob.film_grain.screen_loc = ui_entire_screen
	mymob.film_grain.alpha = 110
	mymob.film_grain.layer = FULLSCREEN_LAYER
	mymob.film_grain.mouse_opacity = 0
	hud_elements |= mymob.film_grain

	mymob.rest = new /obj/screen()
	mymob.rest.name = "rest"
	mymob.rest.icon = ui_style
	mymob.rest.icon_state = "rest[mymob.resting]"
	mymob.rest.screen_loc =  ui_resist
	hud_elements |= mymob.rest
	if (mymob.resting)
		mymob.rest.icon_state = "rest1"
	else
		mymob.rest.icon_state = "rest0"

	mymob.kick_icon = new /obj/screen()
	mymob.kick_icon.icon = ui_style
	mymob.kick_icon.icon_state = "kick"
	mymob.kick_icon.name = "kick"
	mymob.kick_icon.screen_loc = ui_atk
	hud_elements |= mymob.kick_icon

	mymob.jump_icon = new /obj/screen()
	mymob.jump_icon.icon = ui_style
	mymob.jump_icon.icon_state = "jump"
	mymob.jump_icon.name = "jump"
	mymob.jump_icon.screen_loc = ui_atk
	hud_elements |= mymob.jump_icon

	mymob.fixeye = new /obj/screen()
	mymob.fixeye.icon = ui_style
	mymob.fixeye.icon_state = "fixeye"
	mymob.fixeye.name = "fixeye"
	mymob.fixeye.screen_loc = ui_fixeye
	hud_elements |= mymob.fixeye

	mymob.pain = new /obj/screen( null )
	mymob.pain.icon = ui_style
	mymob.pain.icon_state = "blank"
	mymob.pain.name = "pain"
	mymob.pain.screen_loc = "WEST,SOUTH to EAST,NORTH"
	mymob.pain.layer = UNDER_HUD_LAYER
	mymob.pain.mouse_opacity = 0
	hud_elements |= mymob.pain

	mymob.noise = new /obj/screen()
	mymob.noise.icon = 'icons/mob/noise.dmi'
	mymob.noise.icon_state = "[rand(1,9)]"
	mymob.noise.name = " "
	mymob.noise.screen_loc = "1,1 to 15,15"
	mymob.noise.mouse_opacity = 0
	hud_elements |= mymob.noise

	mymob.combat_icon = new /obj/screen()//combat mode
	mymob.combat_icon.name = "combat mode"
	mymob.combat_icon.icon = ui_style//'icons/mob/screen/dark.dmi'
	mymob.combat_icon.icon_state = "combat0"
	mymob.combat_icon.screen_loc = ui_combat
	hud_elements |= mymob.combat_icon

	mymob.dodge_intent_icon = new /obj/screen()//dodge or parry
	mymob.dodge_intent_icon.name = "dodge intent"
	mymob.dodge_intent_icon.icon = ui_style//'icons/mob/screen/dark.dmi'
	mymob.dodge_intent_icon.icon_state = "dodge"
	mymob.dodge_intent_icon.screen_loc = ui_combat_intent
	hud_elements |= mymob.dodge_intent_icon

	mymob.surrender = new /obj/screen()
	mymob.surrender.name = "surrender"
	mymob.surrender.icon = ui_style//'icons/mob/screen/dark.dmi'
	mymob.surrender.icon_state = "surrender"
	mymob.surrender.screen_loc = ui_surrender
	hud_elements |= mymob.surrender

	mymob.wield_icon = new /obj/screen()
	mymob.wield_icon.name = "wield"
	mymob.wield_icon.icon = ui_style
	mymob.wield_icon.icon_state = "wield"
	mymob.wield_icon.screen_loc = ui_atk
	hud_elements |= mymob.wield_icon

	mymob.happiness_icon = new /obj/screen()
	mymob.happiness_icon.name = "mood"
	mymob.happiness_icon.icon = ui_style
	mymob.happiness_icon.icon_state = "mood4"
	mymob.happiness_icon.screen_loc = ui_happiness
	hud_elements |= mymob.happiness_icon


	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.icon = 'icons/mob/puppet_new.dmi'//'icons/mob/puppet.dmi'
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel_newer.dmi', "[mymob.zone_sel.selecting]")
	hud_elements |= mymob.zone_sel

	/*
	mymob.zone_sel = new /obj/screen/zone_sel( null )
	mymob.zone_sel.icon = ui_style
	mymob.zone_sel.color = ui_color
	mymob.zone_sel.alpha = ui_alpha
	mymob.zone_sel.overlays.Cut()
	mymob.zone_sel.overlays += image('icons/mob/zone_sel.dmi', "[mymob.zone_sel.selecting]")
	hud_elements |= mymob.zone_sel
	*/

	//Handle the gun settings buttons
	mymob.gun_setting_icon = new /obj/screen/gun/mode(null)
	mymob.gun_setting_icon.icon = ui_style
	mymob.gun_setting_icon.color = ui_color
	mymob.gun_setting_icon.alpha = ui_alpha
	//hud_elements |= mymob.gun_setting_icon

	mymob.item_use_icon = new /obj/screen/gun/item(null)
	mymob.item_use_icon.icon = ui_style
	mymob.item_use_icon.color = ui_color
	mymob.item_use_icon.alpha = ui_alpha

	mymob.gun_move_icon = new /obj/screen/gun/move(null)
	mymob.gun_move_icon.icon = ui_style
	mymob.gun_move_icon.color = ui_color
	mymob.gun_move_icon.alpha = ui_alpha

	mymob.radio_use_icon = new /obj/screen/gun/radio(null)
	mymob.radio_use_icon.icon = ui_style
	mymob.radio_use_icon.color = ui_color
	mymob.radio_use_icon.alpha = ui_alpha

	if(ishuman(mymob))
		var/mob/living/carbon/human/H = mymob
		H.fov = new /obj/screen()
		H.fov.icon = 'icons/mob/hide.dmi'
		H.fov.icon_state = "combat"
		H.fov.name = " "
		H.fov.screen_loc = "1,1"
		H.fov.mouse_opacity = 0
		H.fov.layer = UNDER_HUD_LAYER
		hud_elements |= H.fov

	mymob.client.screen = list()

	mymob.client.screen += hud_elements
	mymob.client.screen += src.adding + src.hotkeybuttons
	inventory_shown = 1

/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = "This disables or enables the user interface buttons which can be used with hotkeys."

	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = 0
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = 1

/obj/screen/food/Click(var/location, var/control, var/params)
	if(istype(usr) && usr.nutrition_icon == src)
		switch(icon_state)
			if("nutrition0")
				to_chat(usr, SPAN_WARNING("You are completely stuffed."))
			if("nutrition1")
				to_chat(usr, SPAN_NOTICE("You are not hungry."))
			if("nutrition2")
				to_chat(usr, SPAN_NOTICE("You are a bit peckish."))
			if("nutrition3")
				to_chat(usr, SPAN_WARNING("You are quite hungry."))
			if("nutrition4")
				to_chat(usr, SPAN_DANGER("You are starving!"))

/obj/screen/drink/Click(var/location, var/control, var/params)
	if(istype(usr) && usr.hydration_icon == src)
		switch(icon_state)
			if("hydration0")
				to_chat(usr, SPAN_WARNING("You are overhydrated."))
			if("hydration1")
				to_chat(usr, SPAN_NOTICE("You are not thirsty."))
			if("hydration2")
				to_chat(usr, SPAN_NOTICE("You are a bit thirsty."))
			if("hydration3")
				to_chat(usr, SPAN_WARNING("You are quite thirsty."))
			if("hydration4")
				to_chat(usr, SPAN_DANGER("You are dying of thirst!"))