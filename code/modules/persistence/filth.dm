/obj/effect/decal/cleanable/filth
	name = "filth"
	desc = "Disgusting. Someone from last shift didn't do their job properly."
	icon = 'icons/effects/blood.dmi'
	icon_state = "mfloor1"
	random_icon_states = list("mfloor1", "mfloor2", "mfloor3", "mfloor4", "mfloor5", "mfloor6", "mfloor7")
	color = "#1a0000"
	persistent = TRUE

/obj/effect/decal/cleanable/filth/Initialize()
	. = ..()
	icon_state = pick(list("mfloor1", "mfloor2", "mfloor3", "mfloor4", "mfloor5", "mfloor6", "mfloor7"))
	alpha = rand(200/(age * 5),250 - (age * 50)) //Gets more transparent as it ages out
