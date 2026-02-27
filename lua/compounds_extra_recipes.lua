elementcattos.compounds._stonecards = {
	{"Ca", {"H", 2}, "C", {"O", 3}},
	{
		name = "ecattos_recipe_name_stone_cards",
		func = function(edition, inputs)
			--1 card is guaranteed to be no edition.
			--2 other card is 66% chance to be foil or holo.
			for i = 1, 3 do
				SMODS.add_card({
					set = "Enhanced",
					no_edition = i == 1,
					enhancement = "m_stone",
					edition = i == 2 and edition,
					area = G.deck
				})
				SMODS.add_card({
					set = "Enhanced",
					enhancement = "m_stone",
					edition = i <= 2 and (pseudoandom("edition_generic") > 0.3333 and (pseudoandom("edition_generic") >= 0.5 and "e_holographic" or "e_foil") or nil) or nil,
					area = G.deck
				})
			end
		end,
		collection_center = "m_stone",
		collection_atlas = "centers"
	}
}
elementcattos.compounds.j_splash = {
	{{"water"}, "J"},
	"j_splash"
}
elementcattos.compounds.j_blueprint = {
	{"Co", "O", {"Al", 2}, {"O", 3}, "J"},
	"j_blueprint"
}
elementcattos.compounds.j_burnt = {
	{"P", "Photon", "O",  "J"},
	"j_burnt"
}
elementcattos.compounds.j_jolly = {
	{{"J", 2},},
	"j_jolly"
}


--[[
if 
	elementcattos.compounds.j_ortalab_fools_gold = { --Replace with Pyrite when she's added
		{"Fe", {"S", 2}},
		"j_ortalab_fools_gold"
	}
	elementcattos.compounds.j_ortalab_fools_gold = { --Replace with Basalt when she's added
		{"Fe", "Mg"},
		"j_ortalab_fools_gold"
	}
elementcattos.compounds.j_steel_joker = {
	{"steel", "J"},
	"j_ortalab_fools"
}
elementcattos.compounds.j_stone = {
	{"Ca", {"H", 2}, "C", {"O", 3} "J"}, --Copper(II) Carbonate
	"j_stone"
}
elementcattos.compounds.j_steel_joker = {
	{"steel", "J"},
	"j_ortalab_fools"
}
]]--