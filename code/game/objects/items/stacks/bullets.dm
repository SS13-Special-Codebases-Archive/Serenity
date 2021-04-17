/obj/item/stack/bullets
	name = "bullets"
	desc = "It's a stack of bullets"
	singular_name = "bullet"
	icon = 'icons/obj/ammo.dmi'
	icon_state = null
	w_class = ITEM_SIZE_TINY
	max_amount = 5
	item_flags = ITEM_FLAG_NO_BLUDGEON

/obj/item/stack/bullets/New(var/amount = 1)
	if(isnum_safe(amount))
		amount = amount
	update_icon()

/obj/item/stack/bullets/afterattack(var/obj/item/I as obj, mob/user as mob, proximity)
	if(amount <= 0)
		Destroy()
	update_icon()

/obj/item/stack/bullets/attack_self(var/mob/user)
	var/take_amount = input(user, "How many?:", "Character Name")  as num|null
	if(take_amount && take_amount < amount)
		amount -= take_amount
		var/obj/item/stack/bullets/new_stack = new src.type
		new_stack.amount = take_amount
		new_stack.update_icon()
		if(user.put_in_inactive_hand(new_stack))
			to_chat(user, "<span class='notice'>You remove [take_amount] from the [new_stack.name]</span>")
		else
			new_stack.dropInto(user.loc)

		update_icon()


/obj/item/stack/bullets/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, stacktype))
		if(add(1))
			W.Destroy()
	..()
	update_icon()

/obj/item/stack/bullets/update_icon()
	icon_state = "[initial(icon_state)][amount]"

/obj/item/stack/bullets/shotgun/
	name = "12 gauge slug"
	desc = "It's a stack of 12 gauge slugs"
	singular_name = "12 gauge slug"
	icon_state = "slshell"
	w_class = ITEM_SIZE_TINY
	max_amount = 5
	amount = 1
	item_flags = ITEM_FLAG_NO_BLUDGEON
	stacktype = /obj/item/ammo_casing/shotgun

/obj/item/stack/bullets/shotgun/buckshot
	name = "buckshot shells"
	desc = "It's a stack of buckshot"
	singular_name = "buckshot"
	icon_state = "gshell"
	stacktype = /obj/item/ammo_casing/shotgun/pellet

/obj/item/stack/bullets/shotgun/beanbag
	name = "beanbag shells"
	desc = "It's a stack of beanbag shells"
	singular_name = "buckshol"
	icon_state = "bshell"
	stacktype = /obj/item/ammo_casing/shotgun/beanbag

/obj/item/stack/bullets/shotgun/blank
	name = "blank shotgun shells"
	desc = "It's a stack of blank shells"
	singular_name = "blanks"
	icon_state = "blshell"
	stacktype =	/obj/item/ammo_casing/shotgun/blank

/obj/item/stack/bullets/shotgun/stun
	name = "stun shells"
	desc = "It's a stack of stun shells"
	singular_name = "stun shell"
	icon_state = "stunshell"
	stacktype =	/obj/item/ammo_casing/shotgun/stunshell

/obj/item/stack/bullets/shotgun/flash
	name = "flash shells"
	desc = "It's a stack of flash shells"
	singular_name = "flash shell"
	icon_state = "fshell"
	stacktype = /obj/item/ammo_casing/shotgun/flash

/obj/item/stack/bullets/shotgun/practice
	name = "practice shells"
	desc = "It's a stack of practice shells"
	singular_name = "practice shell"
	icon_state = "pshell"
	stacktype =	/obj/item/ammo_casing/shotgun/practice

/obj/item/stack/bullets/rifle
	name = "Rifle bullets"
	desc = "An old worn out looking bullet casing."
	singular_name = "Rifle bullet"
	icon_state = "rifle-casing"
	w_class = ITEM_SIZE_TINY
	max_amount = 5
	amount = 1
	item_flags = ITEM_FLAG_NO_BLUDGEON
	stacktype = /obj/item/ammo_casing/brifle