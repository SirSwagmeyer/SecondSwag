/obj/item/clothing/mask/gas/vampire
	name = "respirator"
	desc = "A face-covering mask that can be connected to an air supply. While good for concealing your identity, it isn't good for blocking gas flow." //More accurate
	icon_state = "respirator"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	flags_inv = HIDEFACE | HIDEFACIALHAIR|HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	resistance_flags = NONE
	custom_price = 30

/obj/item/clothing/mask/vampire
	// This USED to be the default resperatior for wod13 moved that to /obj/item/clothing/mask/gas/vampire
	abstract_type = /obj/item/clothing/mask/vampire
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	icon = 'modular_darkpack/modules/clothes/icons/clothing.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/clothes/icons/clothing_onfloor.dmi')
	inhand_icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	flags_cover = MASKCOVERSMOUTH
	resistance_flags = NONE

/obj/item/clothing/mask/vampire/Initialize(mapload)
	.=..()
	AddComponent(/datum/component/selling, 15, "mask", FALSE)

/obj/item/clothing/mask/vampire/balaclava
	name = "balaclava"
	desc = "LOADSAMONEY"
	icon_state = "balaclava"
	inhand_icon_state = "balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/pentex_balaclava
	name = "Thick balaclava"
	desc = "A black balaclava. This one is particularly thick."
	icon_state = "pentex_balaclava"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/tragedy
	name = "tragedy"
	desc = "The Greek Tragedy mask."
	icon_state = "tragedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/comedy
	name = "comedy"
	desc = "The Greek Comedy mask."
	icon_state = "comedy"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/shemagh
	name = "shemagh"
	desc = "Covers your face pretty well."
	icon_state = "shemagh"
	flags_inv = HIDEFACE | HIDEHAIR | HIDEFACIALHAIR | HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL

/obj/item/clothing/mask/vampire/venetian_mask
	name = "Venetian mask"
	desc = "You could wear this to a real masquerade."
	icon_state = "venetian_mask"
	flags_inv = HIDEFACE | HIDEFACIALHAIR | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH

/obj/item/clothing/mask/vampire/venetian_mask/fancy
	name = "fancy Venetian mask"
	desc = "Weird rich people definitely wear this kind of stuff."
	icon_state = "venetian_mask_fancy"

/obj/item/clothing/mask/vampire/venetian_mask/jester
	name = "jester mask"
	desc = "They will all be amused, every last one of them."
	icon_state = "venetian_mask_jester"

/obj/item/clothing/mask/vampire/venetian_mask/scary
	name = "bloody mask"
	desc = "With this, you'll look ready to butcher someone."
	icon_state = "venetian_mask_scary"
	flags_inv = HIDEFACE
	flags_cover = NONE

/obj/item/clothing/mask/vampire/fomori_chaser
	name = "scary mask"
	desc = "Do you like scary movies?"
	icon_state = "chaser"
//DARKPACK ADD START - Loadout + Fashion Overhaul

/obj/item/clothing/mask/gas/atmos/faceplate
	name = "faceplate mask"
	desc = "A solid mask that completely covers the face, or a lack of one."
	icon = 'icons/map_icons/clothing/mask.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/greyscale_worn.dmi'
	icon_state = "faceplate"
	post_init_icon_state = "faceplate"
	tint = 0
	greyscale_colors = "#FFFFFF"
	greyscale_config = /datum/greyscale_config/faceplate
	greyscale_config_worn = /datum/greyscale_config/faceplate/worn
	flags_inv = HIDEEYES|HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	flags_1 = IS_PLAYER_COLORABLE_1
	actions_types = list(/datum/action/item_action/adjust)
	toggle_message = "You wear the mask tight to your face."
	alt_toggle_message = "You wear the mask loosely, letting you eat."

/obj/item/clothing/mask/gas/atmos/faceplate/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state || initial(post_init_icon_state)]"

/obj/item/clothing/mask/gas/atmos/faceplate/why_so_eyes
	icon_state = "faceplate_eyes"
	post_init_icon_state = "faceplate_eyes"
	greyscale_colors = "#FFFFFF#333333"
	greyscale_config = /datum/greyscale_config/faceplate_eyes
	greyscale_config_worn = /datum/greyscale_config/faceplate_eyes/worn

/obj/item/clothing/mask/neck_gaiter
	name = "neck gaiter"
	desc = "A cloth for covering your neck, and usually a part of your face too, but that part's optional."
	actions_types = list(/datum/action/item_action/adjust)
	alternate_worn_layer = UNIFORM_LAYER
	icon = 'icons/map_icons/clothing/mask.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/greyscale_worn.dmi'
	icon_state = "neck_gaiter"
	post_init_icon_state = "gaiter"
	inhand_icon_state = "balaclava"
	greyscale_config = /datum/greyscale_config/neck_gaiter
	greyscale_config_worn = /datum/greyscale_config/neck_gaiter/worn
	greyscale_colors = "#444444"
	clothing_flags = BLOCK_GAS_SMOKE_EFFECT|MASKINTERNALS
	w_class = WEIGHT_CLASS_SMALL
	flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	visor_flags = BLOCK_GAS_SMOKE_EFFECT | MASKINTERNALS
	visor_flags_inv = HIDEFACIALHAIR | HIDEFACE | HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_cover = MASKCOVERSMOUTH
	flags_1 = IS_PLAYER_COLORABLE_1
	interaction_flags_click = NEED_DEXTERITY|ALLOW_RESTING
	resistance_flags = FIRE_PROOF

/obj/item/clothing/mask/neck_gaiter/attack_self(mob/user)
	adjust_visor(user)

/obj/item/clothing/mask/neck_gaiter/click_alt(mob/user)
	adjust_visor(user)
	return CLICK_ACTION_SUCCESS

/obj/item/clothing/mask/neck_gaiter/click_alt_secondary(mob/user)
	alternate_worn_layer = (alternate_worn_layer == initial(alternate_worn_layer) ? NONE : initial(alternate_worn_layer))
	user.update_clothing(ITEM_SLOT_MASK)
	balloon_alert(user, "wearing [alternate_worn_layer == initial(alternate_worn_layer) ? "below" : "above"] suits")

/obj/item/clothing/mask/neck_gaiter/examine(mob/user)
	. = ..()
	. += span_notice("[src] can be worn above or below your suit. Alt-Right-click to toggle.")
	. += span_notice("Alt-click [src] to adjust it.")

/obj/item/clothing/mask/duelmask
	name = "zorro mask"
	desc = "A black cloth mask for those masked duelists, doesn't grant any protection, but covers your eyes, and your identity... somehow."
	icon = 'icons/map_icons/clothing/mask.dmi'
	icon_state = "duelmask"
	worn_icon = 'modular_darkpack/modules/clothes/icons/clothing/worn/color_worn.dmi'
	flags_inv = HIDEFACE
	body_parts_covered = HEAD
	slot_flags = ITEM_SLOT_MASK
	flags_cover = MASKCOVERSEYES

//DARKPACK ADD END - Loadout + Fashion Overhaul
