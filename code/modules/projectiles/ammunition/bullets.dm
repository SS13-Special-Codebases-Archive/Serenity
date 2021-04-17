/obj/item/ammo_casing/a357
	desc = "A .357 bullet casing."
	caliber = "357"
	projectile_type = /obj/item/projectile/bullet/pistol/strong/revolver
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a50
	desc = "A .50AE bullet casing."
	caliber = ".50"
	projectile_type = /obj/item/projectile/bullet/pistol/strong
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/a75
	desc = "A 20mm bullet casing."
	caliber = "75"
	projectile_type = /obj/item/projectile/bullet/gyro
	origin_tech = list(TECH_COMBAT = 6)

/obj/item/ammo_casing/c38
	desc = "A .38 bullet casing."
	caliber = "38"
	projectile_type = /obj/item/projectile/bullet/pistol
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/c38/rubber
	desc = "A .38 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/c9mm
	desc = "A 9mm bullet casing."
	caliber = "9mm"
	projectile_type = /obj/item/projectile/bullet/pistol
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/c9mm/flash
	desc = "A 9mm flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/c9mm/rubber
	desc = "A 9mm rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/c9mm/practice
	desc = "A 9mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/c44
	desc = "A .44 magnum bullet casing."
	caliber = ".44"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/revolver
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/c44/rubber
	desc = "A .44 magnum rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/c45
	desc = "A .45 bullet casing."
	caliber = ".45"
	projectile_type = /obj/item/projectile/bullet/pistol/medium
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/c45/practice
	desc = "A .45 practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/practice
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/c45/rubber
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/item/projectile/bullet/pistol/rubber
	icon_state = "r-casing"
	spent_icon = "r-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/c45/flash
	desc = "A .45 flash shell casing."
	projectile_type = /obj/item/projectile/energy/flash

/obj/item/ammo_casing/a10mm
	desc = "A 10mm bullet casing."
	caliber = "10mm"
	projectile_type = /obj/item/projectile/bullet/pistol/medium/smg
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/shotgun
	name = "shotgun slug"
	desc = "A 12 gauge slug."
	icon_state = "slshell"
	spent_icon = "slshell-spent"
	caliber = "shotgun"
	projectile_type = /obj/item/projectile/bullet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)
	fall_sounds = list('sound/weapons/guns/shotgun_fall.ogg')
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/shotgun/pellet
	name = "shotgun shell"
	desc = "A 12 gauge shell."
	icon_state = "gshell"
	spent_icon = "gshell-spent"
	projectile_type = /obj/item/projectile/bullet/pellet/shotgun
	matter = list(DEFAULT_WALL_MATERIAL = 360)
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/shotgun/blank
	name = "shotgun shell"
	desc = "A blank shell."
	icon_state = "blshell"
	spent_icon = "blshell-spent"
	projectile_type = /obj/item/projectile/bullet/blank
	matter = list(DEFAULT_WALL_MATERIAL = 90)
	origin_tech = list(TECH_COMBAT = 1)

/obj/item/ammo_casing/shotgun/practice
	name = "shotgun shell"
	desc = "A practice shell."
	icon_state = "pshell"
	spent_icon = "pshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/practice
	matter = list("metal" = 90)
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/shotgun/beanbag
	name = "beanbag shell"
	desc = "A beanbag shell."
	icon_state = "bshell"
	spent_icon = "bshell-spent"
	projectile_type = /obj/item/projectile/bullet/shotgun/beanbag
	matter = list(DEFAULT_WALL_MATERIAL = 180)
	origin_tech = list(TECH_COMBAT = 2)

//Can stun in one hit if aimed at the head, but
//is blocked by clothing that stops tasers and is vulnerable to EMP
/obj/item/ammo_casing/shotgun/stunshell
	name = "stun shell"
	desc = "A 12 gauge taser cartridge."
	icon_state = "stunshell"
	spent_icon = "stunshell-spent"
	projectile_type = /obj/item/projectile/energy/electrode/stunshot
	leaves_residue = 0
	matter = list(DEFAULT_WALL_MATERIAL = 360, "glass" = 720)
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/shotgun/stunshell/emp_act(severity)
	if(prob(100/severity)) BB = null
	update_icon()

//Does not stun, only blinds, but has area of effect.
/obj/item/ammo_casing/shotgun/flash
	name = "flash shell"
	desc = "A chemical shell used to signal distress or provide illumination."
	icon_state = "fshell"
	spent_icon = "fshell-spent"
	projectile_type = /obj/item/projectile/energy/flash/flare
	matter = list(DEFAULT_WALL_MATERIAL = 90, "glass" = 90)
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a25
	desc = "A .25 bullet casing."
	caliber = "a25"
	projectile_type = /obj/item/projectile/bullet/a25
	icon_state = "s-casing"
	spent_icon = "s-casing-spent"
	origin_tech = list(TECH_COMBAT = 2)

/obj/item/ammo_casing/a32
	desc = "A .32 bullet casing."
	caliber = "a32"
	projectile_type = /obj/item/projectile/bullet/a32
	icon_state = "revolver-casing"
	spent_icon = "revolver-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a9mm
	desc = "A 19x19mm bullet casing."
	caliber = "a9mm"
	projectile_type = /obj/item/projectile/bullet/a9mm
	icon_state = "s-casing"
	spent_icon = "s-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a45acp
	desc = "A .45 ACP bullet casing."
	caliber = "a45acp"
	projectile_type = /obj/item/projectile/bullet/a45acp
	icon_state = "revolver-casing"
	spent_icon = "revolver-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/reaper
	desc = "A .45 REAPER bullet casing."
	caliber = "reaper"
	projectile_type = /obj/item/projectile/bullet/reaper
	icon_state = "reaper-casing"
	spent_icon = "revolver-casing-spent"
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/a556
	desc = "A 5.56mm bullet casing."
	caliber = "a556"
	projectile_type = /obj/item/projectile/bullet/rifle/a556
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a762x51
	desc = "A 7.62x51 bullet casing."
	caliber = "a762x51"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x51
	icon_state = "b-casing"
	spent_icon = "b-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a762x54
	desc = "A 7.62x54 bullet casing."
	caliber = "a762x54"
	projectile_type = /obj/item/projectile/bullet/rifle/a762x54
	icon_state = "b-casing"
	spent_icon = "b-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a50bmg
	desc = "A .50 BMG bullet casing."
	caliber = "a50bmg"
	projectile_type = /obj/item/projectile/bullet/rifle/a50bmg
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a145
	name = "shell casing"
	desc = "A 14.5mm shell."
	icon_state = "lcasing"
	spent_icon = "lcasing-spent"
	caliber = "14.5mm"
	projectile_type = /obj/item/projectile/bullet/rifle/a145
	matter = list(DEFAULT_WALL_MATERIAL = 1250)
	origin_tech = list(TECH_COMBAT = 4)

/obj/item/ammo_casing/a145/apds
	name = "APDS shell casing"
	desc = "A 14.5mm Armour Piercing Discarding Sabot shell."
	projectile_type = /obj/item/projectile/bullet/rifle/a145/apds
	origin_tech = list(TECH_COMBAT = 5)

/obj/item/ammo_casing/a762
	desc = "A 7.62mm bullet casing."
	caliber = "a762"
	projectile_type = /obj/item/projectile/bullet/rifle/a762
	icon_state = "rifle-casing"
	spent_icon = "rifle-casing-spent"
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/a762/practice
	desc = "A 7.62mm practice bullet casing."
	projectile_type = /obj/item/projectile/bullet/rifle/a762/practice
	origin_tech = list(TECH_COMBAT = 3)

/obj/item/ammo_casing/rocket
	name = "rocket shell"
	desc = "A high explosive designed to be fired from a launcher."
	icon_state = "rocketshell"
	projectile_type = /obj/item/missile
	caliber = "rocket"
	origin_tech = list(TECH_COMBAT = 5)

/obj/item/ammo_casing/cap
	name = "cap"
	desc = "A cap for children toys."
	caliber = "caps"
	color = "#ff0000"
	projectile_type = /obj/item/projectile/bullet/pistol/cap

// EMP ammo.
/obj/item/ammo_casing/c38/emp
	name = ".38 haywire round"
	desc = "A .38 bullet casing fitted with a single-use ion pulse generator."
	icon_state = "empcasing"
	projectile_type = /obj/item/projectile/ion/small
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/c45/emp
	name = ".45 haywire round"
	desc = "A .45 bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "empcasing"
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/a10mm/emp
	name = "10mm haywire round"
	desc = "A 10mm bullet casing fitted with a single-use ion pulse generator."
	projectile_type = /obj/item/projectile/ion/small
	icon_state = "empcasing"
	matter = list(DEFAULT_WALL_MATERIAL = 130, "uranium" = 100)

/obj/item/ammo_casing/shotgun/emp
	name = "haywire slug"
	desc = "A 12-gauge shotgun slug fitted with a single-use ion pulse generator."
	icon_state = "empshell"
	spent_icon = "empshell-spent"
	projectile_type  = /obj/item/projectile/ion
	matter = list(DEFAULT_WALL_MATERIAL = 260, "uranium" = 200)
