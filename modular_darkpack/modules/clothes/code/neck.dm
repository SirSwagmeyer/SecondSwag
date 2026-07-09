//NECK

//NECK

//NECK

/obj/item/clothing/neck/vampire
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/neck/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 5, "neck", FALSE)

/obj/item/clothing/neck/vampire/scarf
	name = "black scarf"
	desc = "Provides protection against cold."
	icon_state = "scarf"

/obj/item/clothing/neck/vampire/scarf/red
	name = "red scarf"
	icon_state = "scarf_red"

/obj/item/clothing/neck/vampire/scarf/blue
	name = "blue scarf"
	icon_state = "scarf_blue"

/obj/item/clothing/neck/vampire/scarf/green
	name = "green scarf"
	icon_state = "scarf_green"

/obj/item/clothing/neck/vampire/scarf/white
	name = "white scarf"
	icon_state = "scarf_white"

/obj/item/clothing/neck/vampire/prayerbeads
	name = "prayer beads"
	desc = "These beads are used for prayer."
	icon_state = "beads"
// DARKPACK EDIT ADD START - Loadout + Fashion Overhaul

/obj/item/clothing/neck/long_cape
	name = "long cape"
	desc = "A graceful cloak that carefully surrounds your body."
	icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/color_worn.dmi'
	icon_state = "long_cape"
	post_init_icon_state = "long_cape"
	greyscale_config = /datum/greyscale_config/long_cape
	greyscale_config_worn = /datum/greyscale_config/long_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS

/obj/item/clothing/neck/long_cape/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/toggle_icon, "cape")

/obj/item/clothing/neck/wide_cape
	name = "wide cape"
	desc = "A proud, broad-shouldered cloak with which you can protect the honor of your back."
	icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/color_worn.dmi'
	icon_state = "wide_cape"
	post_init_icon_state = "wide_cape"
	greyscale_config = /datum/greyscale_config/wide_cape
	greyscale_config_worn = /datum/greyscale_config/wide_cape/worn
	greyscale_colors = "#867361#4d433d#b2a69c"
	flags_1 = IS_PLAYER_COLORABLE_1
	body_parts_covered = CHEST|ARMS
// DARKPACK EDIT ADD END - Loadout + Fashion Overhaul
