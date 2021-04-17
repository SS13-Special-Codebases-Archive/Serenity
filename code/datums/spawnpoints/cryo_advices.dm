/datum/spawnpoint/cryo/proc/give_advice(mob/H)
	var/desc = pick(
	"<span class='notice'>You're feeling normal. The only thing you want to do is eat and start working.</span>",
	"<span class='notice'>You're feeling drowsy. You want to sleep...</span>",
	"<span class='notice'><b>You're feeling confident. You need to keep it up. If not you - then no one!</b></span>",
	"<span class='notice'>You're feeling the taste of blood in your mouth. You wonder why...</span>",
	"<span class='notice'>You feel light-headed. A normal awakening...</span>",
	"<span class='notice'>You're feeling dirty...</span>",
	"<span class='notice'>This smell...cryogenic liquid. Your nose tickles.</span>",
	"<span class='notice'>You forgot something. You definitely wanted to do something today, but forgot what...</span>",
	"<span class='notice'>You're feeling really weak. Maybe this is from space?</span>",
	"<span class='notice'>You don't remember what happened before you woke up. Weird...</span>",
	"<span class='notice'>Huh, shouldn't they pay us in actual money instead of some weird plastic coupons?</span>",
	"<span class='notice'>Maybe I should prank someone? There's nothing else to do on this rust bucket.</span>",
	"<span class='warning'>You're feeling really bad. The stresses of space and the claustrophobic environment of the station really got you.</span>",
	"<span class='warning'>You're feeling that something dangerous to your own life is going to happen today...</span>",
	"<span class='warning'>You feel pain pulsing through your head...</span>",
	"<span class='warning'>You're feeling like something scared you...for no reason.</span>")
	to_chat(H, desc)
	return TRUE