elementcattos.Bs_Planet {
	key = "sun",
	atlas = "sun",
	pos = {x=0, y=0},
	cost = 19,
	topuplib_anim = {
		vars = {x = true, soulx = true},
		frameCount = 6,
		rate = 8
	},
	config = {extra = {money_per = 1}},
	loc_vars = {"money_per"},
	pronouns = elementcattos.Bs_Pronoun("")
}
elementcattos.radioactive.j_ecattos_planet_sun = {
	glowrate = 3,
	spr = "sun",
	int = 0.6,
	glowonly = true
}
elementcattos.Bs_Planet {
	key = "mercury",
	pos = {x=3, y=0}
}
elementcattos.Bs_Planet {
	key = "venus",
	pos = {x=2, y=4}
}
elementcattos.Bs_Planet {
	key = "earth",
	pos = {x=2, y=0}
}
do --Earth's moons
	elementcattos.Bs_Moon {
		key = "luna",
		ecattos_conf = {
			moon_of = "earth"
		},
		config = {extra = {xmult = 1.3}},
		pos = {x=6, y=0},
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = G.P_CENTERS.m_bld_tablet
			return {vars = {card.ability.extra.xmult}}
		end
	}
	local iss_money_total = function(self, card)
		return (G.jokers and G.GAME.ecattos_iss) and (G.GAME.ecattos_iss.unique_count * card.ability.extra.money_per) or 0
	end
	elementcattos.Bs_Moon {
		key = "iss",
		ecattos_conf = {
			moon_of = "earth",
			as = "satellite"
		},
		config = {extra = {money_per = 2}},
		pos = {x=0, y=4},
		loc_vars = function(self, info_queue, card)
			return {vars = {card.ability.extra.money_per, iss_money_total(self, card)}}
		end,
		calc_dollar_bonus = iss_money_total
	}
end
elementcattos.Bs_Planet {
	key = "mars",
	pos = {x=0, y=2},
	config = {extra = {xmult = 1.2}},
	loc_vars = {"xmult"}
}
do --Mars's moons
	elementcattos.Bs_Moon {
		key = "phobos",
		ecattos_conf = {
			moon_of = "mars",
		},
		pos = {x=1, y=2},
		config = {extra = {money = 1}},
		loc_vars = {"money"}
	}
	elementcattos.Bs_Moon {
		key = "deimos",
		ecattos_conf = {
			moon_of = "mars",
		},
		pos = {x=2, y=2},
		config = {extra = {counter = 0, max = 9, discardgain = 1}},
		loc_vars = {"counter", "max", "discardgain"}
	}
end