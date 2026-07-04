/datum/action/truefaith
	name = "true faith action"
	desc = "true faith desc."

	icon_icon = 'modular_darkpack/modules/numina/icons/actions.dmi'
	button_icon = 'modular_darkpack/modules/numina/icons/actions.dmi'

	var/cool_down = 0
	numina = TRUE

/datum/action/truefaith/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	icon_icon = 'modular_darkpack/modules/numina/icons/actions.dmi'
	button_icon = 'modular_darkpack/modules/numina/icons/actions.dmi'
	. = ..()
