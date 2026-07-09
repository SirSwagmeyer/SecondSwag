/datum/loadout_category/suits
	category_name = "Outerwear"
	category_ui_icon = FA_ICON_USER_SECRET
	type_to_generate = /datum/loadout_item/suit
	tab_order = /datum/loadout_category/head::tab_order + 10

/*
/datum/loadout_item/suit
	abstract_type = /datum/loadout_item/suit

/datum/loadout_item/suit/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only, loadout_placement_preference)
	if(outfit.suit)
		LAZYADD(outfit.backpack_contents, outfit.suit)
	outfit.suit = item_path
*/

// Coats
/datum/loadout_item/suit/coat
	abstract_type = /datum/loadout_item/suit/coat

/datum/loadout_item/suit/coat/slickbackcoat
	name = "Coat (Purple Fur)"
	item_path = /obj/item/clothing/suit/vampire/slickbackcoat

/datum/loadout_item/suit/coat/labcoat
	name = "Labcoat"
	item_path = /obj/item/clothing/suit/vampire/labcoat

/datum/loadout_item/suit/coat/brown
	name = "Coat (Brown)"
	item_path = /obj/item/clothing/suit/vampire/coat

/datum/loadout_item/suit/coat/green
	name = "Coat (Green)"
	item_path = /obj/item/clothing/suit/vampire/coat/alt

/datum/loadout_item/suit/coat/black
	name = "Coat (Black)"
	item_path = /obj/item/clothing/suit/vampire/coat/winter

/datum/loadout_item/suit/coat/red
	name = "Coat (Red)"
	item_path = /obj/item/clothing/suit/vampire/coat/winter/alt

/datum/loadout_item/suit/coat/leopardcoat
	item_path = /obj/item/clothing/suit/vampire/coat/leopard

// Jackets
/datum/loadout_item/suit/jacket
	abstract_type = /datum/loadout_item/suit/jacket

/datum/loadout_item/suit/jacket/majima_jacket
	name = "Fancy Jacket (Majima)"
	item_path = /obj/item/clothing/suit/vampire/majima_jacket

/datum/loadout_item/suit/jacket/fancy_gray
	name = "Fancy Jacket (Gray)"
	item_path = /obj/item/clothing/suit/vampire/fancy_gray

/datum/loadout_item/suit/jacket/fancy_red
	name = "Fancy Jacket (Red)"
	item_path = /obj/item/clothing/suit/vampire/fancy_red

/datum/loadout_item/suit/jacket/black_leather
	name = "Leather Jacket"
	item_path = /obj/item/clothing/suit/vampire/jacket

/datum/loadout_item/suit/jacket/military
	name = "Jacket (Military)"
	item_path = /obj/item/clothing/suit/jacket/miljacket

/datum/loadout_item/suit/jacket/black_suit
	name = "Jacket (Black Suit)"
	item_path = /obj/item/clothing/suit/toggle/lawyer/black

// Trenchcoats
/datum/loadout_item/suit/trenchcoat
	abstract_type = /datum/loadout_item/suit/trenchcoat

/datum/loadout_item/suit/trenchcoat/black
	name = "Trenchcoat (Black)"
	item_path = /obj/item/clothing/suit/vampire/trench

/datum/loadout_item/suit/trenchcoat/brown
	name = "Trenchcoat (Brown)"
	item_path = /obj/item/clothing/suit/vampire/trench/alt

/datum/loadout_item/suit/trenchcoat/burgundy
	name = "Trenchcoat (Burgundy)"
	item_path = /obj/item/clothing/suit/vampire/trench/archive

// Hoodies
/datum/loadout_item/suit/hoodie
	item_path = /obj/item/clothing/suit/hooded/hoodie

/datum/loadout_item/suit/hoodiezim
	item_path = /obj/item/clothing/suit/hooded/hoodie/hoodie_pim

// Misc
/datum/loadout_item/suit/kasaya
	name = "Kasaya"
	item_path = /obj/item/clothing/suit/vampire/kasaya

/datum/loadout_item/suit/imam
	name = "Imam Robe"
	item_path = /obj/item/clothing/suit/vampire/imam

/datum/loadout_item/suit/orthodox
	name = "Orthodox Robe"
	item_path = /obj/item/clothing/suit/vampire/orthodox

/datum/loadout_item/suit/letterman_red
	name = "Letterman (Red)"
	item_path = /obj/item/clothing/suit/jacket/letterman_syndie

// Robes
/datum/loadout_item/suit/robes
	abstract_type = /datum/loadout_item/suit/robes

/datum/loadout_item/suit/robes/white
	name = "Robes (White)"
	item_path = /obj/item/clothing/suit/hooded/robes

/datum/loadout_item/suit/robes/black
	name = "Robes (Black)"
	item_path = /obj/item/clothing/suit/hooded/robes/black

/datum/loadout_item/suit/robes/grey
	name = "Robes (Grey)"
	item_path = /obj/item/clothing/suit/hooded/robes/grey

/datum/loadout_item/suit/robes/darkred
	name = "Robes (Dark Red)"
	item_path = /obj/item/clothing/suit/hooded/robes/darkred

/datum/loadout_item/suit/robes/yellow
	name = "Robes (Yellow)"
	item_path = /obj/item/clothing/suit/hooded/robes/yellow

/datum/loadout_item/suit/robes/green
	name = "Robes (Green)"
	item_path = /obj/item/clothing/suit/hooded/robes/green

/datum/loadout_item/suit/robes/Red
	name = "Robes (Red)"
	item_path = /obj/item/clothing/suit/hooded/robes/red

/datum/loadout_item/suit/robes/purple
	name = "Robes (Purple)"
	item_path = /obj/item/clothing/suit/hooded/robes/purple

/datum/loadout_item/suit/robes/blue
	name = "Robes (Blue)"
	item_path = /obj/item/clothing/suit/hooded/robes/blue
// DARKPACK EDIT ADD START - Loadout + Fashion Overhaul

/datum/loadout_item/suit/top
	group = "Casual Shirts"
	abstract_type = /datum/loadout_item/suit/top

/datum/loadout_item/suit/top/hawaiian_shirt
	name = "Hawaiian Shirt"
	item_path = /obj/item/clothing/suit/costume/hawaiian

/datum/loadout_item/suit/top/wellwornshirt
	name = "Well-worn Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt

/datum/loadout_item/suit/top/wellworn_graphicshirt
	name = "Well-worn Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic

/datum/loadout_item/suit/top/ianshirt
	name = "Well-worn Ian Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/graphic/ian

/datum/loadout_item/suit/top/wornoutshirt
	name = "Worn-out Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout

/datum/loadout_item/suit/top/wornout_graphicshirt
	name = "Worn-out Graphic Shirt"
	item_path = /obj/item/clothing/suit/costume/wellworn_shirt/wornout/graphic
//Gangsta Jackets

/datum/loadout_item/suit/gang
	group = "Gang Jackets"
	abstract_type = /datum/loadout_item/suit/gang

/datum/loadout_item/suit/gang/tmc
	name = "Bay Bikers Jacket"
	item_path = /obj/item/clothing/suit/costume/tmc

/datum/loadout_item/suit/gang/pg
	name = "Pacific Gangster Jacket"
	item_path = /obj/item/clothing/suit/costume/pg

//Military Coats
/datum/loadout_item/suit/coat/military
	group = "Militant Coats"
	abstract_type = /datum/loadout_item/suit/coat/military

/datum/loadout_item/suit/coat/military/blue
	name = "Formal Parade Blazer"
	item_path = /obj/item/clothing/suit/jacket/hos/blue

/datum/loadout_item/suit/coat/military/badass
	name = "Gilded Trenchcoat"
	item_path = /obj/item/clothing/suit/armor/hos/trenchcoat

/datum/loadout_item/suit/coat/military/badass/large
	name = "Leather Greatcoat"
	item_path = /obj/item/clothing/suit/armor/hos

/datum/loadout_item/suit/coat/military/badass/short
	name = "Tacticool Overcoat"
	item_path = /obj/item/clothing/suit/armor/vest/leather

/datum/loadout_item/suit/coat/military/badass/formal
	name = "Militant Parade Coat (Royal Blue)"
	item_path = /obj/item/clothing/suit/armor/vest/capcarapace/captains_formal

/datum/loadout_item/suit/coat/military/badass/formal/red
	name = "Militant Parade Coat (Crimson Red)"
	item_path = /obj/item/clothing/suit/armor/hos/hos_formal


// DARKPACK EDIT ADD END - Loadout + Fashion Overhaul
