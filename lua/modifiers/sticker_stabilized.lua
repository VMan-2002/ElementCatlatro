SMODS.Sticker {
	key = "stabilized",
	atlas = "modifiers",
	badge_color = HEX("2B72E5"),
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.ecattos_stabilized}}
	end,
	apply = function(self,card,val)
		if val then
			card.ability.ecattos_stabilized = 2
		end
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			card.ability.ecattos_stabilized = card.ability.ecattos_stabilized - 1
			if card.ability.ecattos_stabilized <= 0 then
				card.ability.ecattos_stabilized = false
				return {
					message = localize("ecattos_stabilizer_broke"),
					sound = "ecattos_unstabilized",
					pitch = 1
				}
			end
		end
	end
}