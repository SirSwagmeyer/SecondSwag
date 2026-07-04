/datum/discipline/truefaith
	name = "True Faith"
	desc = "A discipline focused on unwavering belief and the power of faith."
	icon_state = "truefaith"
	power_type = /datum/discipline_power/truefaith
	var/action_replaced = FALSE // Track if we've already done the replacement
	selectable = TRUE
	power_type = /datum/discipline_power

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

	//willpower vs courage
	successes = truefaith_check(owner, target, list(STAT_TEMPORARY_WILLPOWER), difficulty = (target.st_get_stat(STAT_WITS) + target.st_get_stat(STAT_COURAGE)))
	if(successes > 0)
		return TRUE

	do_cooldown(cooldown_length)
	return FALSE

/datum/discipline_power/truefaith/vade_retro/activate(mob/living/carbon/human/target)
	. = ..()
	apply_faith_overlay(target)
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
	if(!ishuman(target))
		return FALSE

	if(!iskindred(target))
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		return FALSE

	var/mypower = SSroll.storyteller_roll_datum(owner, applic_stats = list(STAT_TEMPORARY_WILLPOWER))
	var/theirpower = SSroll.storyteller_roll_datum(target, difficulty = 6, mobs_to_show_output = target, numerical = TRUE)

	if(ishuman(target))
		var/mob/living/carbon/human/human_target = target
		if((human_target.morality_path?.alignment != MORALITY_HUMANITY) && (human_target.morality_path?.score >= 4))
			theirpower -= round(human_target.morality_path?.score / 2)

	return (mypower > theirpower)

/datum/discipline_power/truefaith/ward/pre_activation_checks(mob/living/target)
	var/datum/splat/vampire/kindred = target
	if(HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS)) //Per the Baali curse, Ward will always take effect and be much more punishing.
		return TRUE
	if(iskindred(target) && (target.morality_path?.alignment == MORALITY_HUMANITY) && (target.morality_path?.score >= 8))
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
		var/mutable_appearance/faith_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "old_aura", -MUTATIONS_LAYER)
		faith_overlay.pixel_z = 1
		target.overlays_standing[MUTATIONS_LAYER] = faith_overlay
		target.apply_overlay(MUTATIONS_LAYER)

		to_chat(owner, span_warning("You've banished [target]!"))
		to_chat(target, span_userlove("You feel a searing pain. An all-consuming terror courses through your being. You have to get away from here!"))

		var/datum/cb = CALLBACK(target, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
		for(var/i in 1 to 30)
			addtimer(cb, (i - 1) * target.cached_multiplicative_slowdown())
		if(HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS))
			target.emote("scream")
			target.set_confusion(20 SECONDS)
			target.do_jitter_animation(60 SECONDS)
			target.adjust_blurriness(60 SECONDS)
			target.take_overall_damage(burn = 30)
		else
			target.emote("scream")
			target.do_jitter_animation(10 SECONDS)
			target.adjust_blurriness(10 SECONDS)
		SEND_SOUND(target, sound('modular_darkpack/modules/numina/sound/truefaith_ward.ogg'))
	else
		to_chat(owner, span_warning("[target] is unaffected by your gesture."))
		return

/datum/discipline_power/truefaith/ward/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

///BLESS ITEM?
/datum/action/numina/truefaith_action/blessing
	name = "Sanctify"
	desc = "Call upon the powers that be to temporarily empower an object of holy significance."
	button_icon_state = "blessing"
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

	COOLDOWN_DECLARE(blessing)

/datum/action/numina/truefaith_action/blessing/Trigger(trigger_flags)
	. = ..()
	if(!src.use_resources())
		return
	if (!COOLDOWN_FINISHED(src, blessing))
		to_chat(owner, span_warning("You can't empower anything for another [DisplayTimeText(COOLDOWN_TIMELEFT(src, blessing))]!"))
		return
	var/hand_object
	var/mob/living/carbon/human/H = owner
	var/obj/item/owner_held_item = H.get_active_held_item()
	if(!is_type_in_typecache(owner_held_item, GLOB.TFNITEMS_HOLY))
		to_chat(owner, span_warning("You require a holy object to channel your prayer!"))
		return FALSE
	switch(owner_held_item.type)
		if(/obj/item/clothing/neck/vampire/prayerbeads)
			hand_object = new /obj/item/blessed_object/blessed_prayer_beads(H.drop_location())
			qdel(owner_held_item)
			H.put_in_active_hand(hand_object)
		if(/obj/item/vampirebook/bible)
			hand_object = new /obj/item/blessed_object/blessed_bible(H.drop_location())
			qdel(owner_held_item)
			H.put_in_active_hand(hand_object)
		if(/obj/item/vampirebook/quran)
			hand_object = new /obj/item/blessed_object/blessed_quran(H.drop_location())
			qdel(owner_held_item)
			H.put_in_active_hand(hand_object)
		if(/obj/item/card/hunter)
			hand_object = new /obj/item/blessed_object/blessed_cross_necklace(H.drop_location())
			qdel(owner_held_item)
			H.put_in_active_hand(hand_object)
		else
			to_chat(owner, span_notice("Nothing happens."))
			return

	playsound(H.loc, 'modular_darkpack/modules/numina/sound/truefaith_power_small.ogg', 50, FALSE)
	to_chat(owner, span_slime("[owner_held_item] begins to glow softly..."))

///////////////////
/// SIXTH SENSE ///
//////////////////
// SIXTH SENSE allows the user to see past appearances and ascertain what someone truly is.

/datum/discipline_power/truefaith/sixth_sense
	name = "Sixth Sense"
	desc = "Peer past the veneer and see someone for what they truly are."
	deactivate_sound = null

	target_type = TARGET_HUMAN
	range = 12
	level = 3

	cancelable = TRUE

/datum/discipline_power/truefaith/sixth_sense/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(owner, span_slime("You start to focus in on [target]..."))
	owner.face_atom(target)
	if(!do_after(owner, 7 SECONDS, NONE, NONE))
		to_chat(owner, span_warning("You have to focus to get a read on [target]."))
		return
	if(target.st_get_stat(STAT_CHARISMA) <= 2)
		to_chat(owner, span_notice("They are not social or influencing."))
	if(target.st_get_stat(STAT_PERMANENT_WILLPOWER) <= 2)
		to_chat(owner, span_notice("They lack appropiate willpower."))
	if(target.st_get_stat(STAT_STRENGTH) <= 2)
		to_chat(owner, span_notice("Their body is weak and feeble."))
	if(target.st_get_stat(STAT_DEXTERITY) <= 2)
		to_chat(owner, span_notice("They lack coordination."))
	if(iskindred(target))
		sixth_sense_clan_assessment(target, owner)
		sixth_sense_humanity_assessment(target, owner)
	if(isghoul(target))
		to_chat(owner, span_notice("They occasionally twitch and shiver, hungry for something."))
	if(!iskindred(target) && !isghoul(target))
		sixth_sense_numina_assessment(target, owner)

/datum/discipline_power/truefaith/sixth_sense/proc/sixth_sense_clan_assessment(target, owner)
	if(!owner || !target)
		return
	var/datum/splat/vampire/kindred = target
	if(iskindred(vampire))
		switch(clan)
			if(VAMPIRE_CLAN_TOREADOR)
				to_chat(owner, span_notice("[target] stares at little details."))
				return
			if(VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY)
				to_chat(owner, span_notice("[target]'s is constantly humming to themselves."))
				return
			if(VAMPIRE_CLAN_VENTRUE)
				to_chat(owner, span_notice("[target] often looks like they're above it all."))
				return
			if(VAMPIRE_CLAN_LASOMBRA)
				to_chat(owner, span_notice("[target] never seems to look at themselves."))
				return
			if(VAMPIRE_CLAN_TZIMISCE)
				to_chat(owner, span_warning("[target] gives you a horrific, skin-crawling feeling."))
				return
			if(VAMPIRE_CLAN_OLD_TZIMISCE)
				to_chat(owner, span_warning("[target] fills you with an unearthly dread."))
				return
			if(VAMPIRE_CLAN_GANGREL)
				to_chat(owner, span_notice("[target] is particularly twitchy."))
				return
			if(VAMPIRE_CLAN_MALKAVIAN)
				to_chat(owner, span_notice("[target] doesn't seem to be all there."))
				return
			if(VAMPIRE_CLAN_BRUJAH)
				to_chat(owner, span_notice("[target] has this angry look on their face a lot."))
			if(VAMPIRE_CLAN_NOSFERATU)
				to_chat(owner, span_notice("[target] is very concerned about appearances."))
				return
			if(VAMPIRE_CLAN_TREMERE)
				to_chat(owner, span_warning("[target] makes you very, very uneasy."))
				return
			if(VAMPIRE_CLAN_BAALI)
				to_chat(owner, span_boldwarning("[target] is an abomination before God!"))
				return
			if(VAMPIRE_CLAN_BANU_HAQIM)
				to_chat(owner, span_notice("[target] looks like they're judging you."))
				return
			if(VAMPIRE_CLAN_TRUE_BRUJAH)
				to_chat(owner, span_notice("[target] never expresses themselves."))
				return
			if(VAMPIRE_CLAN_SALUBRI)
				to_chat(owner, span_notice("[target] doesn't seem all that special."))
				return
			if(VAMPIRE_CLAN_SALUBRI_WARRIOR)
				to_chat(owner, span_notice("[target] looks like they're stewing on something."))
				return
			if(VAMPIRE_CLAN_GIOVANNI)
				to_chat(owner, span_notice("[target] has a very peculiar last name..."))
				return
			if(VAMPIRE_CLAN_CAPPADOCIAN)
				to_chat(owner, span_warning("[target] smells of rot."))
				return
			if(VAMPIRE_CLAN_KIASYD)
				to_chat(owner, span_notice("[target] has a whimsical air about them."))
				return
			if(VAMPIRE_CLAN_GARGOYLE)
				to_chat(owner, span_notice("[target] moves with a strangely rigid gait."))
				return
			if(VAMPIRE_CLAN_SETITES)
				to_chat(owner, span_warning("[target] fills you with disgust."))
				return
			if(VAMPIRE_CLAN_NAGARAJA)
				to_chat(owner, span_warning("[target] smells of iron and rust."))
				return

			else
				to_chat(owner, span_notice("[target] doesn't seem all that special."))

/datum/discipline_power/truefaith/sixth_sense/proc/sixth_sense_humanity_assessment(target, owner)
	if(!owner || !target)
		return
	var/datum/splat/vampire/kindred = target
	if(iskindred(vampire))
		if(stat_morality?.morality_path?.alignment == MORALITY_HUMANITY)
			switch(stat_morality?.morality_path?.score)
				if(0)
					to_chat(owner, span_ghostalert("Whoever they were is no longer here."))
					return
				if(1 to 3)
					to_chat(owner, span_cult("[target] is possessed by something terrible."))
					return
				if(4)
					to_chat(owner, span_warning("[target] has fallen from grace."))
					return
				if(5 to 9)
					return
				if(10)
					to_chat(owner, span_greenteamradio("[target] may yet be saved."))
					return
				else
					return
		if(stat_morality?.morality_path?.alignment != MORALITY_ENLIGHTENMENT)
			switch(stat_morality?.morality_path?.score)
				if(0)
					to_chat(owner, span_ghostalert("Whoever they were is no longer here."))
					return
				if(1 to 3)
					to_chat(owner, span_alertwarning("[target] teeters on the brink of self destruction."))
					return
				if(4)
					to_chat(owner, span_warning("[target] has lost their way."))
					return
				if(5 to 9)
					to_chat(owner, span_cult("[target] is possessed by something terrible."))
					return
				if(10)
					to_chat(owner, span_phobia("[target] is a shell puppeted by the demonic."))
					return
				else
					return
		else
			return

/datum/discipline_power/truefaith/sixth_sense/proc/sixth_sense_auspice_assessment(target, owner)
	if(!owner || !target)
		return
	var/datum/splat/werewolf/shifter = target
	if(isgarou(target))
		switch(clan)
			if("Ahroun")
				to_chat(owner, span_notice("[target] is seemingly always angry."))
				return
			if("Galliard")
				to_chat(owner, span_notice("[target] seems to have a knack for detail."))
				return
			if("Philodox")
				to_chat(owner, span_notice("[target] seems to be silently judging you."))
				return
			if("Theurge")
				to_chat(owner, span_notice("[target] reminds you of your own spiritual persuasion."))
				return
			if("Ragabash")
				to_chat(owner, span_notice("[target] just seems shifty."))
				return

			else
				to_chat(owner, span_notice("[target] seems lonely."))

/////////////
/// DOGMA ///
/////////////
// DOGMA is an adaptation of one of True Faith's MAGE abilities, since resistance to mental effects is accomplished with their DOT 2 ability.
// DOGMA essentially is just a weaker fortitude that allows you to soak some more damage while active. It has no inactive effects.

/datum/discipline_power/truefaith/dogma
	name = "Dogmatic Assurance"
	desc = "Your faith gives you the strength to go on, even in the face of great adversity."

	activate_sound = 'modular_darkpack/modules/numina/sound/truefaith_power_greater.ogg'

	level = 4

	check_flags = DISC_CHECK_CONSCIOUS

	cooldown_length = 6 MINUTES
	duration_length = 3 MINUTES

	var/dogma_DR = 25

/datum/discipline_power/truefaith/dogma/activate()
	. = ..()
	owner.physiology.damage_resistance = min(60, (owner.physiology.damage_resistance += dogma_DR) )
	owner.remove_overlay(HALO_LAYER)
	var/mutable_appearance/faith_overlay = mutable_appearance('modular_darkpack/modules/powers/icons/auras.dmi', "old_aura_bright", -HALO_LAYER)
	faith_overlay.pixel_z = 1
	owner.overlays_standing[HALO_LAYER] = faith_overlay
	owner.apply_overlay(HALO_LAYER)

/datum/discipline_power/truefaith/dogma/deactivate()
	. = ..()
	owner.physiology.damage_resistance = max(0, (owner.physiology.damage_resistance -= dogma_DR) )
	owner.remove_overlay(HALO_LAYER)

/////////////////
/// PERDITION ///
/////////////////
// At this point of True Faith, the individual is so incredibly Holy that they can cause havoc to the undead by their mere presence.

/datum/discipline_power/truefaith/perdition
	name = "Perdition"
	desc = "In flaming fire taking vengeance on them that know not God, and that obey not the gospel: Who shall be punished with everlasting destruction from the presence of the Lord, and from the glory of his power."
	activate_sound = 'modular_darkpack/modules/numina/sound/truefaith_power_overwhelming.ogg'

	level = 5
	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK

	multi_activate = TRUE
	cooldown_length = 10 MINUTES
	duration_length = 30 SECONDS

/datum/discipline_power/truefaith/perdition/activate()
	. = ..()
	owner.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/perdition_overlay = mutable_appearance('modular_darkpack/modules/numina/icons/numina.dmi', "truefaith", -MUTATIONS_LAYER)
	perdition_overlay.pixel_z = 1
	owner.overlays_standing[MUTATIONS_LAYER] = perdition_overlay
	owner.apply_overlay(MUTATIONS_LAYER)
	for(var/mob/living/carbon/human/target in oviewers(7, owner))
		punish_sinner(target, owner)
	addtimer(CALLBACK(src, PROC_REF(clear_halo), owner), 5 SECONDS)

/datum/discipline_power/truefaith/perdition/proc/punish_sinner(mob/living/target)
	var/mob/living/carbon/human/sinner = target
	var/datum/splat/werewolf/shifter = sinner
	var/fera_affected = FALSE

	if(isgarou(sinner))
		fera_affected = TRUE

	var/mutable_appearance/perdition_overlay = mutable_appearance('modular_darkpack/modules/numina/icons/numina.dmi', "truefaith", -MUTATIONS_LAYER)
	perdition_overlay.pixel_z = 1
	if(!iskindred(sinner) && !isgarou(sinner))
		to_chat(owner, span_warning("[sinner] is unaffected by your power."))
		return
	if(iskindred(sinner) && (sinner.morality_path?.alignment == MORALITY_HUMANITY) && (sinner.morality_path?.score >= 8))
		to_chat(owner, span_warning("[sinner] is unaffected by your power."))
		return

	var/mypower = SSroll.storyteller_roll_datum(owner, applic_stats = list(STAT_TEMPORARY_WILLPOWER))
	var/theirpower = SSroll.storyteller_roll_datum(sinner, difficulty = (fera_affected ? 7 : 9), mobs_to_show_output = sinner, numerical = TRUE)

	if(ishuman(sinner))
		if((sinner.morality_path?.alignment != MORALITY_HUMANITY) && (sinner.morality_path?.score >= 4))
			theirpower -= round(sinner.morality_path?.score / 2)

	if((mypower <= theirpower))
		to_chat(owner, span_warning("[sinner] resists your influence!"))
		return

	sinner.remove_overlay(MUTATIONS_LAYER)
	perdition_overlay = mutable_appearance('modular_darkpack/modules/numina/icons/numina.dmi', "truefaith", -MUTATIONS_LAYER)
	perdition_overlay.pixel_z = 1
	sinner.overlays_standing[MUTATIONS_LAYER] = perdition_overlay
	sinner.apply_overlay(MUTATIONS_LAYER)

	var/datum/cb = CALLBACK(sinner, TYPE_PROC_REF(/mob/living/carbon/human, step_away_caster), owner)
	for(var/i in 1 to 30)
		addtimer(cb, (i - 1) * sinner.total_multiplicative_slowdown())
	if(iskindred(sinner))
		if(HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS))
			sinner.emote("scream")
			sinner.flash_act()
			sinner.set_confusion(60 SECONDS)
			sinner.do_jitter_animation(120 SECONDS)
			sinner.adjust_blurriness(120 SECONDS)
			sinner.take_overall_damage(burn = 85)
			sinner.adjust_fire_stacks(10)
			sinner.IgniteMob()
			playsound(sinner, 'sound/magic/demon_dies.ogg', 50, TRUE, 5)
		if(isgarou(sinner)) //verin said to keep it, so im keeping it.
			fera.flash_act()
			fera.Paralyze(4 SECONDS)
			//fera.transformator.transform(fera, fera.auspice?.breed_form, TRUE) Lupus is currently bugged to fuck. Uncomment when transformator is fixed.
			fera.auspice?.rage = 0
			fera.auspice?.gnosis = 0
			SEND_SOUND(sinner, sound('modular_darkpack/modules/numina/sound/perdition_effect.ogg'))
			addtimer(CALLBACK(src, PROC_REF(deactivate), sinner), 30 SECONDS)
			to_chat(sinner, span_cultlarge("Your body starts to change on its own!"))
			return
		else
			sinner.emote("scream")
			sinner.set_confusion(30 SECONDS)
			sinner.do_jitter_animation(60 SECONDS)
			sinner.adjust_blurriness(30 SECONDS)
			sinner.take_overall_damage(burn = 60)
			sinner.flash_act()
	to_chat(owner, span_warning("[sinner] is rended asunder!"))
	to_chat(sinner, span_cultlarge("OH GOD IT BURNS!"))
	to_chat(sinner, span_userlove("Every part of you shrieks to run! You have to get out of here, <b>now!</b>"))
	SEND_SOUND(sinner, sound('modular_darkpack/modules/numina/sound/perdition_effect.ogg'))

	addtimer(CALLBACK(src, PROC_REF(deactivate), sinner), 30 SECONDS)

/datum/discipline_power/truefaith/perdition/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//this is a general proc to remove the halo for powers that would otherwise keep it too long
/datum/discipline_power/truefaith/proc/clear_halo(mob/living/carbon/human/owner)
	owner.remove_overlay(MUTATIONS_LAYER)

/obj/item/melee/touch_attack/truefaith_heal
	name = "\improper faithful hand"
	desc = "Through the LORD, all things are possible."
	on_use_sound = 'modular_darkpack/modules/numina/sound/truefaith_power_small.ogg'
	catchphrase = null
	icon_state = "fleshtostone"
	inhand_icon_state = "fleshtostone"

/obj/item/melee/touch_attack/truefaith_heal/attack(mob/target, mob/living/user)
	. = ..()
	if(target == user && isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	var/mob/living/M = target //We still want the healing effects to affect animals and such.
	var/mob/living/carbon/human/H = target
	if(iskindred(H) && ((stat_morality?.morality_path?.alignment != MORALITY_HUMANITY) || (stat_morality?.morality_path?.score <= 8)))
		H.do_jitter_animation(10 SECONDS)
		H.apply_damage(10, BURN, user.zone_selected)
		H.apply_damage(25, CLONE, user.zone_selected)
		H.flash_act()
		H.adjust_fire_stacks(1)
		H.IgniteMob()
		playsound(M, 'modular_darkpack/modules/numina/sound/skin_sizzle.ogg', 25, TRUE, 3)
		return
	M.adjustBruteLoss(-10, TRUE)
	M.adjustFireLoss(-10, TRUE)
	M.adjustToxLoss(-25, TRUE)
	M.adjustOxyLoss(-25, TRUE)
	M.adjustCloneLoss(-25, TRUE)
	if((ishuman(M)) && (!iskindred(M)))
		M.reagents.add_reagent(/datum/reagent/determination, 10)
	if(isgarou(H))
		H.auspice.rage -= 4
	return

/datum/action/numina/truefaith_action/miracle
	name = "Miracle"
	desc = "Through faith, give the wounded a push to survive."
	button_icon_state = "faithheal"
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

	COOLDOWN_DECLARE(miracle)

/datum/action/numina/truefaith_action/miracle/Trigger(trigger_flags)
	. = ..()
	if(!src.use_resources())
		return
	if (!COOLDOWN_FINISHED(src, miracle))
		to_chat(owner, span_warning("You can't perform a miracle for another [DisplayTimeText(COOLDOWN_TIMELEFT(src, miracle))]!"))
		return
	if(iscarbon(owner))
		var/mob/living/carbon/H = owner
		H.put_in_active_hand(new /obj/item/melee/touch_attack/truefaith_heal(H))

/obj/item/melee/touch_attack/truefaith_heal
	name = "\improper faithful hand"
	desc = "Through the LORD, all things are possible."
	on_use_sound = 'modular_darkpack/modules/numina/sound/truefaith_power_small.ogg'
	catchphrase = null
	icon_state = "fleshtostone"
	inhand_icon_state = "fleshtostone"

/obj/item/melee/touch_attack/truefaith_heal/attack(mob/target, mob/living/user)
	. = ..()
	if(target == user && isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	var/mob/living/M = target //We still want the healing effects to affect animals and such.
	var/mob/living/carbon/human/H = target
	if(iskindred(H) && ((stat_morality?.morality_path?.alignment != MORALITY_HUMANITY) || (stat_morality?.morality_path?.score <= 8)))
		H.do_jitter_animation(10 SECONDS)
		H.apply_damage(10, BURN, user.zone_selected)
		H.apply_damage(25, CLONE, user.zone_selected)
		H.flash_act()
		H.adjust_fire_stacks(1)
		H.IgniteMob()
		playsound(M, 'modular_darkpack/modules/numina/sound/skin_sizzle.ogg', 25, TRUE, 3)
		return
	M.adjustBruteLoss(-10, TRUE)
	M.adjustFireLoss(-10, TRUE)
	M.adjustToxLoss(-25, TRUE)
	M.adjustOxyLoss(-25, TRUE)
	M.adjustCloneLoss(-25, TRUE)
	if((ishuman(M)))
		M.reagents.add_reagent(/datum/reagent/determination, 10)
	if(isgarou(H))
		H.auspice.rage -= 4
	return
