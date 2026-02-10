SMODS.Atlas {
	key = "suits",
	path = "suits.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "suits_hc",
	path = "suits_hc.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "suits_icon",
	path = "suits_icons.png",
	px = 18,
	py = 18
}

SMODS.Atlas {
	key = "suits_icon_hc",
	path = "suits_icons_hc.png",
	px = 18,
	py = 18
}

SMODS.Suit {
	key = "strange",
	card_key = "STRANGE",
	pos = {y=0},
	lc_atlas = "suits",
	hc_atlas = "suits_hc",
	lc_ui_atlas = "suits_icon",
	hc_ui_atlas = "suits_icon_hc",
	ui_pos = {x=0,y=0},
	lc_color = HEX("ACF4B9"),
	hc_color = HEX("93FFAE"),
	px = 71,
	py = 95,
	in_pool = topuplib.returnFalse
}