/datum/loadout_category/hands
	category_name = "Hands"
	category_ui_icon = FA_ICON_HANDS
	type_to_generate = /datum/loadout_item/hands
	tab_order = 1

/datum/loadout_item/hands
	abstract_type = /datum/loadout_item/hands

/datum/loadout_item/hands/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.gloves)
		LAZYADD(outfit.backpack_contents, outfit.gloves)
	outfit.gloves = item_path

/datum/loadout_item/hands/leather_gloves
	name = "Gloves (Leather)"
	item_path = /obj/item/clothing/gloves/vampire/leather

/datum/loadout_item/hands/work_gloves
	name = "Gloves (Work)"
	item_path = /obj/item/clothing/gloves/vampire/work

/datum/loadout_item/hands/cleaning_gloves
	name = "Gloves (Cleaning)"
	item_path = /obj/item/clothing/gloves/vampire/cleaning

/datum/loadout_item/hands/latex_gloves
	name = "Gloves (Latex)"
	item_path = /obj/item/clothing/gloves/vampire/latex

/datum/loadout_item/hands/coroner
	name = "Gloves (Morbid)"
	item_path = /obj/item/clothing/gloves/latex/coroner

/datum/loadout_item/hands/aerostatic
	name = "Gloves (Aerostatic)"
	item_path = /obj/item/clothing/gloves/kim

/datum/loadout_item/hands/nitrile
	name = "Gloves (Nitrile)"
	item_path = /obj/item/clothing/gloves/latex/nitrile

/datum/loadout_item/hands/leather
	name = "Gloves (Deerskin)"
	item_path = /obj/item/clothing/gloves/rugged

/datum/loadout_item/hands/leather/work
	name = "Gloves (Textile)"
	item_path = /obj/item/clothing/gloves/rugged/work_gloves

/datum/loadout_item/hands/leather/rugged
	name = "Gauntlets (Rugged)"
	item_path = /obj/item/clothing/gloves/rugged/colorblock_gauntlets

/datum/loadout_item/hands/leather/gauntlets
	name = "Gauntlets (Leather Gauntlets)"
	item_path = /obj/item/clothing/gloves/rugged/gauntlets

/datum/loadout_item/hands/leather/fingerless
	name = "Gauntlets (Fingerless Leather)"
	item_path = /obj/item/clothing/gloves/rugged/fingerless
