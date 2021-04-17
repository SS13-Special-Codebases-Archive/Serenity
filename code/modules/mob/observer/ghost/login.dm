/mob/observer/ghost/Login()
	..()

	if (ghost_image)
		ghost_image.appearance = src
		ghost_image.appearance_flags = RESET_ALPHA | NO_CLIENT_COLOR
		ghost_image.filters = filter(type = "blur", size = 3)
	updateghostimages()
	add_client_color(/datum/client_color/noir)
