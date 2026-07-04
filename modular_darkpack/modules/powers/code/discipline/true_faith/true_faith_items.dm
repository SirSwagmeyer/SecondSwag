GLOBAL_LIST_INIT(TFNITEMS_HOLY, typecacheof(list(
	/obj/item/blessed_object,
	/obj/item/clothing/neck/vampire/prayerbeads,
	/obj/item/vampirebook/bible,
	/obj/item/vampirebook/quran,
	/obj/item/card/hunter,
)))

/obj/item/blessed_object
	name = "generic blessed object"
	desc = "Perfectly generic."
	icon_state = "quran"
	icon = 'modular_darkpack/modules/numina/icons/blessed_objects.dmi'
	onflooricon = 'modular_darkpack/modules/numina/icons/blessed_objects.dmi'
	w_class = WEIGHT_CLASS_NORMAL
	damtype = BURN
	force = 1 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	var/base_object = /obj/item/vampirebook/quran

	var/dupe_protection = FALSE //Fuck it.

/obj/item/blessed_object/attack(mob/target, mob/living/user)
	. = ..()
	if(target == user && isliving(target))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	var/mob/living/M = target
	if(!HAS_TRAIT(target, TRAIT_SILVER_WEAKNESS))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	var/datum/splat/vampire/kindred = target
	if(iskindred(target) && ((target.morality_path?.alignment != MORALITY_HUMANITY) || (target.morality_path?.score <= 8)))
		return COMPONENT_CANCEL_ATTACK_CHAIN
	if(!HAS_TRAIT(target, TRAIT_REPELLED_BY_HOLINESS))
		target.do_jitter_animation(10 SECONDS)
		target.adjust_blurriness(1 SECONDS)
		target.adjust_fire_stacks(2)
		target.IgniteMob()
	target.apply_damage(burn_damage, BURN, user.zone_selected)
	target.apply_damage(agg_damage, AGG, user.zone_selected)
	playsound(target, 'modular_darkpack/modules/numina/sound/skin_sizzle.ogg', 25, TRUE, 3)
	return

/obj/item/blessed_object/proc/dispel(mob/user)
	playsound(src, 'modular_darkpack/modules/numina/sound/truefaith_deactivate_generic.ogg', 25, FALSE)
	src.visible_message(span_notice("The strange aura surrounding [src] dissipates..."))
	//Originally this proc handled a lot more, but it resulted in item dupes.
	//It being here at least still means im not repeating a bunch of sound and message procs. Small victories, right?

/obj/item/blessed_object/dropped(mob/user)
	. = ..()
	if(!dupe_protection) //FUCK IT. WE'LL DO IT LIVE.
		new base_object(user.drop_location())
		dispel()
		qdel(src)

/obj/item/blessed_object/pickup(mob/user)
	. = ..()
	dispel()
	dupe_protection = TRUE
	var/obj/item/hand_object = new base_object(user.drop_location())
	user.put_in_active_hand(hand_object)
	qdel(src)
	return

/obj/item/blessed_object/attack_self(mob/user)
	. = ..()
	dispel()
	dupe_protection = TRUE
	var/obj/item/hand_object = new base_object(user.drop_location()) //God is dead. Which is ironic, considering what this is for.
	qdel(src)
	user.put_in_active_hand(hand_object)
	return

/obj/item/blessed_object/blessed_prayer_beads
	name = "glowing prayer beads"
	desc = "For the Lord is my shepherd."
	icon_state = "beads"
	damtype = BURN
	force = 1 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	base_object = /obj/item/clothing/neck/vampire/prayerbeads

/obj/item/blessed_object/blessed_cross_necklace
	name = "glowing cross"
	desc = "Though I walk through the valley of death, I shall fear no evil."
	icon_state = "id11"
	damtype = BURN
	force = 2 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	base_object = /obj/item/card/hunter

/obj/item/blessed_object/blessed_bible
	name = "glowing bible"
	desc = "You will know them by their works."
	icon_state = "bible"
	lefthand_file = 'icons/mob/inhands/items/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/books_righthand.dmi'
	damtype = BURN
	force = 2 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	base_object = /obj/item/vampirebook/bible

/obj/item/blessed_object/blessed_quran
	name = "glowing quran"
	desc = "Do not despair of the mercy of Allāh."
	icon_state = "quran"
	damtype = BURN
	force = 2 TTRPG_DAMAGE
	damtype = AGGRAVATED // Based on V20
	base_object = /obj/item/vampirebook/quran
