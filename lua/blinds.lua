SMODS.Atlas {
	key = "blinds",
	path = "blindchips.png",
	px = 34,
	py = 34,
	atlas_table = "ANIMATION_ATLAS",
	frames = 21
}

SMODS.Blind {
	key = "final_pocket",
	atlas = "blinds", pos = {0,0},
	dollars = 8,
	mult = 2,
	boss = {showdown = true},
	boss_colour = HEX('D884FF'),
	config = {extra = {}},
	collection_loc_vars = function(vars, key)
		return {vars = {localize("ecattos_blind_pocket_placeholder")}}
	end
}