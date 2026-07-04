/datum/status_effect/vade_retro //Used for extended effect of vade_retro
	id = "true_faith"
	status_type = STATUS_EFFECT_UNIQUE
	duration = 5 SECONDS
	alert_type = /atom/movable/screen/alert/status_effect/vade_retro

/datum/status_effect/vade_retro/on_creation(mob/living/new_owner, generation, time)
	. = ..()
	if(time)
		duration = time
	owner.st_add_stat_mod(STAT_DEXTERITY, -4)	//Nukes your dex temporarily

/atom/movable/screen/alert/status_effect/vade_retro
	name = "Supernatural Fear"
	desc = "GOD HAS FORSAKEN ME. I AM A FOOL AND A WRETCHED CREATURE. I MUST FLEE UNTIL THIS SENSATION FADES."
	icon_state = "hypnosis"
