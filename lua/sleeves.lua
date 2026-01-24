SMODS.Atlas({
	key = "sleeves",
	path = "sleeves.png",
	px = 71,
	py = 95
})
if CardSleeves then
	CardSleeves.Sleeve({
		key = "elements",
		atlas = "sleeves",
		pos = { x = 0, y = 0 },
		unlocked = true,
		unlock_condition = { deck = "Element Catto Deck", stake = "stake_blue" },
		loc_vars = function(self)
			local key, vars
			if self.get_current_deck_key() == "b_ecattos_elements" then
				keys = self.key .. "_alt"
				--vouchers = {}
				--hand_sizes = -2
				more_optionss = 2
			else
				keys = self.key
				vouchers = {'v_overstock_norm', 'v_overstock_plus'}
				--hand_sizes = 0
				--more_optionss = 0
			end
			return { key = keys, voucher = vouchers, hand_size = hand_sizes, more_options = more_optionss }
		end,
		trigger_effect = function(self, args) end,
		apply = function(self, sleeve)
			if not (G.GAME.selected_back.effect.center.key == 'b_ecattos_elements') then
				for k,v in pairs(G.P_CENTERS) do
					if v.set == "Joker" and not (elementcattos.modsupported[v.key] or (v.original_mod and v.original_mod.id == "ElementCatlatro")) then
						G.GAME.banned_keys[v.key] = true
					end
				end
				G.GAME.starting_params.ecattos_deck = true
				CardSleeves.Sleeve.apply(self, sleeve)
			end
		end, 
		calculate = function(self, sleeve, context)
			if G.GAME.selected_back.effect.center.key == 'b_ecattos_elements' then
				if context.create_card and context.card then
					local card = context.card
					local is_booster_pack = card.ability.set == "Booster"
					local is_catto_pack = is_booster_pack and card.config.center.key:find("p_ecattos_element_")
					if is_catto_pack and sleeve.config.more_options then
						card.ability.extra = card.ability.extra + sleeve.config.more_options
					end
				end
			end
		end
	})
end