/obj/structure/table/rack
	name = "rack"
	desc = "Different from the Middle Ages version."
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

	material = DEFAULT_TABLE_MATERIAL

/obj/structure/table/rack/shelf
	name = "shelf"
	desc = "For collecting dust, heads of the enemies and tools."
	icon_state = "shelf"

/obj/structure/table/rack/New()
	..()
	verbs -= /obj/structure/table/verb/do_flip
	verbs -= /obj/structure/table/proc/do_put

/obj/structure/table/rack/Initialize()
	auto_align()
	. = ..()

/obj/structure/table/rack/update_connections()
	return

/obj/structure/table/rack/update_desc()
	return

/obj/structure/table/rack/update_icon()
	return

/obj/structure/table/rack/holorack/dismantle(obj/item/weapon/wrench/W, mob/user)
	to_chat(user, "<span class='warning'>You cannot dismantle \the [src].</span>")
	return

/obj/structure/table/rack/bograck
	name = "strange rack"
	desc ="Must be the color."
	icon = 'icons/obj/objects.dmi'
	icon_state = "bograck"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

/obj/structure/table/rack/dark
	color = COLOR_GRAY40

/obj/structure/table/rack/spacetable
	name = "space counter"
	desc ="a spacey table that is very common in ships and stations."
	icon = 'icons/obj/tables.dmi'
	icon_state = "spacetable_preview"
	can_plate = 0
	can_reinforce = 0
	flipped = -1

/obj/structure/table/rack/finetable
	name = "fine table"
	desc ="woah! it shines."
	icon_state = "finetable_preview"
	icon = 'icons/obj/tables.dmi'
	can_plate = 0
	can_reinforce = 0
	flipped = -1

/obj/structure/table/rack/ruintable
	name = "steel table"
	desc ="Looks a bit old and dirty."
	icon_state = "ruintable_preview"
	icon = 'icons/obj/tables.dmi'
	can_plate = 0
	can_reinforce = 0
	flipped = -1