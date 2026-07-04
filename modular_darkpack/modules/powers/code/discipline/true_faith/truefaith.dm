/datum/discipline/truefaith
	name = "True Faith"
	desc = "Allows you to attract, sway, and control crowds through supernatural allure and emotional manipulation."
	icon_state = "truefaith"
	power_type = /datum/discipline_power/truefaith

/datum/discipline/truefaith/post_gain()
	. = ..()
	ADD_TRAIT(owner, TRAIT_TRUE_FAITH, /datum/discipline/truefaith)

/datum/discipline_power/truefaith
	name = "True Faith power name"
	desc = "True Faith power description"
	activate_sound = 'modular_darkpack/modules/jobs/sounds/cross.ogg'
	deactivate_sound = 'sound/effects/magic/magic_block_holy.ogg'
	vitae_cost = 0 //This isn't a vitae-consuming ability.

//lets not have people be able to cast this through walls

/datum/discipline_power/truefaith/proc/truefaith_check(mob/living/carbon/human/owner, mob/living/carbon/human/target, using_stats, difficulty)
	if(!ishuman(target))
		return FALSE

	var/theirpower = difficulty || target.st_get_stat(STAT_TEMPORARY_WILLPOWER)

	// Do we have traits to modify our difficulties?
	if((!(owner.obscured_slots & HIDEFACE))&(HAS_TRAIT(owner, TRAIT_DISFIGURED_APPEARANCE))) // Are we visibly disfigured?
		theirpower += 2 // Increase the difficulty by two.

	if(!get_kindred_splat(target)) // Is our target mortal?
		if(HAS_TRAIT(owner, TRAIT_GRAVE_SMELL)) // Are we stinky?
			theirpower += 1
		if((HAS_TRAIT(owner, TRAIT_GLOWING_EYES)) && (!owner.is_eyes_covered()) && (STAT_INTIMIDATION in using_stats)) // Are we intimidating a mortal with uncovered eyes?
			theirpower -= 1

	var/successes = SSroll.storyteller_roll_datum(owner, target, difficulty = theirpower, applic_stats = using_stats, numerical = TRUE)

	//number of successes is rather critical for the efficacy of the power
	return successes

/datum/discipline_power/truefaith/proc/apply_faith_overlay(mob/living/carbon/target)
	target.remove_overlay(POWERS_LAYER)
	var/mutable_appearance/faith_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "old_aura", -POWERS_LAYER)
	faith_overlay.pixel_z = 1
	target.overlays_standing[POWERS_LAYER] = faith_overlay
	target.apply_overlay(POWERS_LAYER)
	SEND_SOUND(target, sound('modular_darkpack/modules/jobs/sounds/cross.ogg'))

//V20 doesn't elaborate on who gets affected first, so we'll just be using what awe uses, which is to affect the targets of lowest willpower first if affecting multiple targets.
/datum/discipline_power/truefaith/proc/sort_targets_by_willpower(list/targets)
	var/list/sorted = list()
	for(var/mob/living/carbon/target in targets)
		var/target_willpower = target.st_get_stat(STAT_TEMPORARY_WILLPOWER)
		var/inserted = FALSE

		for(var/i = 1; i <= length(sorted); i++)
			var/mob/living/carbon/existing = sorted[i]
			if(target_willpower < existing.st_get_stat(STAT_TEMPORARY_WILLPOWER))
				sorted.Insert(i, target)
				inserted = TRUE
				break

		if(!inserted)
			sorted += target
	return sorted

// VADE RETRO
/datum/discipline_power/truefaith/vade_retro
	name = "VIA DOLOROSA"
	desc = "BRANDISH THY SYMBOL OF FAITH OR UTTER THY PRAYER - WARD OFF THE UNHOLY ABOMINATIONS. ROLL YOUR WILLPOWER AGAINST THEIRS."
	level = 1
	vitae_cost = 0
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK | DISC_CHECK_DIRECT_SEE
	target_type = TARGET_VAMPIRE
	range = 7
	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 10 SECONDS
	var/successes = 0


/datum/discipline_power/truefaith/vade_retro/pre_activation_checks(mob/living/target)

	//charisma + intimidation, difficulty equal to the victims wits + courage
	successes = presence_check(owner, target, list(STAT_TEMPORARY_WILLPOWER), difficulty = (target.st_get_stat(STAT_TEMPORARY_WILLPOWER)))
	if(successes > 0)
		return TRUE

	do_cooldown(cooldown_length)
	return FALSE

/datum/discipline_power/truefaith/vade_retro/activate(mob/living/carbon/human/target)
	. = ..()
	apply_presence_overlay(target)
	if(successes >= (target.st_get_stat(STAT_TEMPORARY_WILLPOWER)))	//We check if you just flat out have more successes than their dice pool total.
		var/extended_action_prompt = tgui_input_list(owner, "Attempt to force your target to repent for their wretched sins? This action will take time to preform, and will force the target to flee.", "VADE RETRO, SATANA", list("Yes", "No"), "No")
		switch(extended_action_prompt)
			if("Yes")
				if(do_after(owner, 3 SECONDS))
					to_chat(owner, span_warning("You expose [target] to a brief glimpse of your radiant faith!"))
					to_chat(target, span_userdanger("Your body moves against your will, there is something terribly wrong that you can't quite place. [owner]'s mere presence compels you to flee, NOW."))
					GLOB.move_manager.move_away(target, owner, 20, target.cached_multiplicative_slowdown)
					target.emote("tremble")	//Shaking emote for visibility
					target.emote(pick("scream","cry"))	//Audible emote
					target.apply_status_effect(/datum/status_effect/vade_retro)	//Debuffs for set time
				return TRUE
	if(successes <= 3) // already checked for above 0 in pre_activation
		to_chat(target, span_userdanger("You are consumed with a deep unease toward [owner]. You feel compelled to step away from them..."))
		to_chat(owner, span_warning("Away, foul beast! [target]'s heart feels a pang of unease!"))
	else
		to_chat(target, span_userdanger("This feeling is terribly wrong. Something is out of place. You must get away from [owner]!"))
		to_chat(owner, span_warning("Your holy aura sends [target] flee, overcome with unholy dread."))

		// The number of successes indicates the number of steps backward the vampire is forced to take. For the sake of scaling, we'll just give them a flat distance according to the number of successes.
		GLOB.move_manager.move_away(target, owner, 10, target.cached_multiplicative_slowdown)

/datum/discipline_power/truefaith/vade_retro/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(POWERS_LAYER)


//WARD
/datum/discipline_power/truefaith/ward
	name = "VADE RETRO"
	desc = "Brandish a holy symbol, empowered with prayer, to terrify your enemies."
	activate_sound = 'modular_darkpack/modules/numina/sound/truefaith_ward.ogg'

	level = 2

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN

	cooldown_length = 8 SECONDS
	duration_length = 7 SECONDS
	range = 7
	var/banish_succeed = FALSE

/datum/discipline_power/truefaith/ward/proc/ward_check(mob/living/carbon/human/owner, mob/living/target, base_difficulty = 4, banish_succeed = FALSE)
	var/owner_held_item = owner.get_active_held_item()
	owner.face_atom(target)
	if(!is_type_in_typecache(owner_held_item, GLOB.TFNITEMS_HOLY))
		to_chat(owner, span_warning("You require a holy object to channel your prayer!"))
		return FALSE

	if(!ishuman(target))
		return FALSE

	if(!iskindred(target))
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		return FALSE

	var/mypower = SSroll.storyteller_roll(owner.get_total_mentality(), difficulty = base_difficulty, mobs_to_show_output = owner, numerical = TRUE)
	var/theirpower = SSroll.storyteller_roll(target.get_total_mentality(), difficulty = 6, mobs_to_show_output = target, numerical = TRUE)

	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if((human_target.morality_path?.alignment != MORALITY_HUMANITY) && (human_target.morality_path?.score >= 4))
			theirpower -= round(human_target.morality_path?.score / 2)

	return (mypower > theirpower)

/datum/discipline_power/truefaith/ward/pre_activation_checks(mob/living/target)
	var/mob/living/carbon/human/vampire = target
	if(iskindred(vampire) && (vampire.clan?.name == CLAN_BAALI)) //Per the Baali curse, Ward will always take effect and be much more punishing.
		return TRUE
	if(iskindred(target) && (vampire.morality_path?.alignment == MORALITY_HUMANITY) && (vampire.morality_path?.score >= 8))
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		do_cooldown(cooldown_length)
		return FALSE
	banish_succeed = ward_check(owner, target, base_difficulty = 4)
	if(banish_succeed)
		return TRUE
	else
		do_cooldown(cooldown_length)
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		to_chat(target, span_warning("An overwhelming aura radiates from [owner], scorching hot. However, you manage to steel yourself."))
		return FALSE

/datum/discipline_power/truefaith/ward/activate(mob/living/carbon/human/target) //This is basically the same as the Presence "LEAVE" command.
	. = ..()
	if(banish_succeed)
		target.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "presence", -MUTATIONS_LAYER)
		presence_overlay.pixel_z = 1
		target.overlays_standing[MUTATIONS_LAYER] = presence_overlay
		target.apply_overlay(MUTATIONS_LAYER)

		to_chat(owner, span_warning("You've banished [target]!"))
		to_chat(target, span_userlove("You feel a searing pain. An all-consuming terror courses through your being. You have to get away from here!"))

		var/datum/cb = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
		for(var/i in 1 to 30)
			addtimer(cb, (i - 1) * target.total_multiplicative_slowdown())
		if(target.clan?.name == CLAN_BAALI)
			target.emote("scream")
			target.set_confusion(20 SECONDS)
			target.do_jitter_animation(60 SECONDS)
			target.adjust_blurriness(60 SECONDS)
			target.take_overall_damage(burn = 30)
		else
			target.emote("scream")
			target.do_jitter_animation(10 SECONDS)
			target.adjust_blurriness(10 SECONDS)
		SEND_SOUND(target, sound('modular_tfn/modules/numina/sound/truefaith_ward.ogg'))
	else
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		return

/datum/discipline_power/truefaith/ward/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
