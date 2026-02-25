SMODS.Atlas({
	key = "decks",
	path = "decks.png",
	px = 71,
	py = 95
})

SMODS.Back({
	key = "elements",
	atlas = "decks",
	pos = {x = 0, y = 0},
	config = {
		joker_slot = 24,
		dollars = 8,
		vouchers = {'v_overstock_norm', 'v_overstock_plus'}
	},
	apply = function()
		for k,v in pairs(G.P_CENTERS) do
			if v.set == "Joker" and not (elementcattos.modsupported[v.key] or (v.original_mod and v.original_mod.id == "ElementCatlatro")) then
				G.GAME.banned_keys[v.key] = true
			end
		end
		G.GAME.starting_params.ecattos_deck = true
	end
})