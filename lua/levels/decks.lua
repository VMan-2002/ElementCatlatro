SMODS.Atlas({
	key = "decks",
	path = "decks.png",
	px = 71,
	py = 95
})

elementcattos.ecattos_deck_banlist = function()
	for k,v in pairs(G.P_CENTERS) do
		if v.set == "Joker" and not (elementcattos.modsupported[v.key] or (v.original_mod and v.original_mod.id == "ElementCatlatro")) then
			G.GAME.banned_keys[v.key] = true
		end
	end
end

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
		elementcattos.ecattos_deck_banlist()
		G.GAME.starting_params.ecattos_deck = true
	end
})

local bp = {"c_ecattos_recipe_titin"}
SMODS.Back({
	key = "elements_masterwork",
	atlas = "decks",
	pos = {x = 4, y = 0},
	config = {
		joker_slot = 30,
		dollars = 16,
		vouchers = {'v_overstock_norm', 'v_overstock_plus'}
	},
	apply = function()
		elementcattos.ecattos_deck_banlist()
		G.GAME.starting_params.ecattos_deck = true
		G.GAME.starting_params.ecattos_deck_masterwork = true
		G.GAME.win_ante = 16
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0,
			no_delete = true,
			timer = 'REAL',
			func = function()
				SMODS.add_card({set = "Tarot", key = pseudorandom_element(bp, "ecattos_deck_masterwork")})
				return true
			end
		}))
	end,
	unlocked = false,
	check_for_unlock = function(self, args)
		for k,v in pairs(bp) do
			if G.P_CENTERS[v] and G.P_CENTERS[v].discovered then
				return true
			end
		end
	end
})
if next(SMODS.find_mod("HIT")) then
	SMODS.Back({
		key = "elements_blackjack",
		atlas = "decks",
		pos = {x = 2, y = 0},
		config = {
			joker_slot = 24,
			dollars = 8,
			vouchers = {'v_overstock_norm', 'v_overstock_plus'}
		},
		apply = function()
			set_blackjack_mode()
			elementcattos.ecattos_deck_banlist()
			G.GAME.starting_params.ecattos_deck = true
		end
		})
end
if next(SMODS.find_mod("Ortalab")) then
	SMODS.Back({
		key = "elements_ortalab",
		atlas = "decks",
		pos = {x = 3, y = 0},
		config = {
			joker_slot = 20,
			vouchers = {'v_ortalab_catalog', 'v_ortalab_ad_campaign', 'v_clearance_sale'}
		},
		apply = function()
			elementcattos.ecattos_deck_banlist()
			G.GAME.starting_params.ecattos_deck = true
		end
		})
end