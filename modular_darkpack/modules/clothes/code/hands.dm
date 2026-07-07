//GLOVES

//GLOVES

//GLOVES

/obj/item/clothing/gloves/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	undyeable = TRUE

/obj/item/clothing/gloves/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 4, "gloves", FALSE)

/obj/item/clothing/gloves/vampire/leather
	name = "leather gloves"
	desc = "Looks dangerous. Provides some kind of protection."
	icon_state = "leather"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/leather_gloves

/datum/armor/leather_gloves
	acid = 30

/obj/item/clothing/gloves/vampire/work
	name = "work gloves"
	desc = "Provides fire protection for working in extreme environments."
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/work_gloves

/datum/armor/work_gloves
	fire = 70
	acid = 30

/obj/item/clothing/gloves/vampire/investigator
	name = "investigator gloves"
	desc = "Standard issue FBI workgloves tailored for investigators. Made out of latex outer lining and padded for acid and fire protection."
	icon_state = "work"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor_type = /datum/armor/investigator_gloves

/datum/armor/investigator_gloves
	fire = 70
	acid = 70

/obj/item/clothing/gloves/vampire/cleaning
	name = "cleaning gloves"
	desc = "Provides acid protection."
	icon_state = "cleaning"
	armor_type = /datum/armor/anti_acid_gloves

/datum/armor/anti_acid_gloves
	acid = 70

/obj/item/clothing/gloves/vampire/latex
	name = "latex gloves"
	desc = "Provides acid protection."
	icon_state = "latex"
	armor_type = /datum/armor/anti_acid_gloves

/obj/item/clothing/gloves/vampire/white
	name = "white gloves"
	desc = "A pair of fine, white gloves, a symbol of of cleanliness and quality, and not much else. Getting them dirty shows how unprofessional you are."
	icon_state = "white_gloves"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
//DARKPACK ADD START - Loadout + Fashion Overhaul

/obj/item/clothing/gloves/rugged
	name = "leather gloves"
	desc = "Calfskin gloves with a generous cut and fit."
	icon = 'modular_darkpack/modules/clothes/icons/clothing/gloves.dmi'
	icon_state = "rugged_1"
	worn_icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/color_worn.dmi'
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	worn_icon_state = "rugged_1"

/obj/item/clothing/gloves/rugged/work_gloves
	name = "work gloves"
	desc = "Textile work gloves with a close fit, cut and sewn from a synthetic tech fabric."
	icon_state = "rugged_2"
	worn_icon_state = "rugged_2"

/obj/item/clothing/gloves/rugged/colorblock_gauntlets
	name = "colorblock gauntlets"
	desc = "Brown leather gauntlets with nylon fingertips."
	icon_state = "rugged_3"
	worn_icon_state = "rugged_3"

/obj/item/clothing/gloves/rugged/gauntlets
	name = "leather gauntlets"
	desc = "A pair of leather gauntlets that reach halfway up the forearms."
	icon_state = "rugged_4"
	worn_icon_state = "rugged_4"

/obj/item/clothing/gloves/rugged/fingerless
	name = "fingerless gloves"
	desc = "Soft nubuck gloves with raw cut edges where the fingertips were severed in a hasty moment of rear warehouse passion."
	icon_state = "rugged_fingerless"
	worn_icon_state = "rugged_fingerless"
	clothing_traits = list(TRAIT_FINGERPRINT_PASSTHROUGH)
//DARKPACK ADD END- Loadout + Fashion Overhaul
