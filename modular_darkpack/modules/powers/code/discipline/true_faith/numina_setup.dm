/datum/discipline/truefaith/post_gain()
	. = ..()

	if(action_replaced || !owner)
		return

	addtimer(CALLBACK(src, PROC_REF(replace_bugged_disc)), 1 SECONDS)

/datum/discipline/truefaith/proc/replace_bugged_disc() //Avoiding similar problems to Chaz's paths. If the method ain't broke I'm not gonna reinvent it.
	if(!owner)
		return

	var/datum/action/discipline/dummy_disc = null
	for(var/datum/action/discipline/action in owner.actions)
		if(action.discipline == src && action.type == /datum/action/discipline)
			dummy_disc = action
			break

	if(dummy_disc)
		var/datum/action/discipline/truefaith/desired_overwrite = new /datum/action/discipline/truefaith(src)

		desired_overwrite.Grant(owner)

		dummy_disc.Remove(owner)
		qdel(dummy_disc)

		action_replaced = TRUE

/datum/action/discipline/truefaith //Setup to overwrite icon sources; otherwise, we will always be pulling from WOD's file.
	check_flags = NONE
	button_icon = 'modular_darkpack/modules/numina/icons/numina.dmi'
	background_icon_state = "default"
	overlay_icon = 'modular_darkpack/modules/numina/icons/numina.dmi'
	button_icon_state = "default"

/datum/action/
	var/truefaith = FALSE

/datum/action/discipline/truefaith/New(datum/discipline/discipline)
	. = ..()
