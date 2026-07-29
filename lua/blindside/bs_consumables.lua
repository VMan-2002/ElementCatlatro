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
	pos = {x=1,y=0},
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

SMODS.Atlas {
	key = "bs_coolglobe",
	path = "blindside/coolglobe.png",
	px = 150,
	py = 150
}

elementcattos.Bs_Add(SMODS.Consumable {
	key = "bs_sudoscience",
	set = "bld_obj_ritual",
	atlas = "bs_coolglobe",
	pos = {x=0,y=0},
	soul_pos = {x=1,y=0,draw = function(self, scale_mod, rotate_mod)
		--self.children.floating_sprite:draw_shader('dissolve', 0,   nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03*math.sin(1.8*G.TIMERS.REAL),nil, 0.6)
		self.children.floating_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, scale_mod, rotate_mod)
	end},
	display_size = {w=150,h=150},
	can_use = function(self, card)
		
	end,
	use = function(self, card, area)
	end
})