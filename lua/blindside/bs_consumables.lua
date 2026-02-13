elementcattos.Bs_Add(SMODS.Consumable {
	key = "bs_lightbulb",
	set = "bld_obj_ritual",
	atlas = "bs_consumables",
	pos = {x=0,y=0},
    config = {
        max_highlighted = 3,
    },
    can_use = function(self, card)
        if #G.hand.highlighted ~= 0 and card.ability.consumeable.max_highlighted <= #G.hand.highlighted then
            return next(SMODS.find_card("j_ecattos_planet_sun"))
        end
    end,
    use = function(self, card, area)
		for k,v in pairs(G.hand.highlighted) do
			v:set_edition("e_bld_finish")
		end
    end,
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_bld_finish
		info_queue[#info_queue+1] = G.P_CENTERS.j_ecattos_planet_sun
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end
})

elementcattos.Bs_Add(SMODS.Consumable {
	key = "bs_mooncreate",
	set = "bld_obj_ritual",
	atlas = "bs_consumables",
	pos = {x=0,y=0},
    config = {
        max_highlighted = 1,
    },
    can_use = function(self, card)
        if #G.jokers.highlighted ~= 0 and card.ability.consumeable.max_highlighted <= #G.jokers.highlighted then
            for k,v in pairs(G.jokers.highlighted) do
				if not next(elementcattos.moonsRemaining(v.config.center_key)) then return false end
			end
			return true
        end
    end,
    use = function(self, card, area)
		for k,v in pairs(G.jokers.highlighted) do
			local n = pseudorandom_element(elementcattos.moonsRemaining(v.config.center_key), "ecattos_mooncreate")
			if n then SMODS.add_card({set = "Joker", key = n, no_edition = true}) end
		end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.max_highlighted
            }
        }
    end
})