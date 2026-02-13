elementcattos.Bs_Add(SMODS.Consumable {
	key = "bs_lightbulb",
	set = "bld_obj_ritual",
	atlas = "bs_consumables",
	pos = {x=0,y=0},
    config = {
        min_highlighted = 1,
        max_highlighted = 3,
    },
    can_use = function(self, card)
        if #G.hand.highlighted >= card.ability.consumable.min_highlighted and card.ability.consumeable.max_highlighted <= #G.hand.highlighted then
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