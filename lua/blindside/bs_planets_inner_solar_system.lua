elementcattos.Bs_Planet {
	key = "sun",
	pos = {x=1, y=0}
}
elementcattos.Bs_Planet {
	key = "mercury",
	pos = {x=3, y=0}
}
elementcattos.Bs_Planet {
	key = "venus",
	pos = {x=0, y=0}
}
elementcattos.Bs_Planet {
	key = "earth",
	pos = {x=2, y=0}
}
do --Earth's moons
	elementcattos.Bs_Moon {
		key = "luna",
		ecattos_conf = {
			moon_of = "earth",
		},
		config = {extra = {xmult = 1.3}},
		pos = {x=6, y=0},
		loc_vars = function(self, info_queue, card)
			info_queue[#info_queue+1] = G.P_CENTERS.m_bld_tablet
			return {vars = {card.ability.extra.xmult}}
		end
	}
end
elementcattos.Bs_Planet {
	key = "mars",
	pos = {x=0, y=2}
}
do --Mars's moons
	elementcattos.Bs_Moon {
		key = "phobos",
		ecattos_conf = {
			moon_of = "mars",
		},
		pos = {x=1, y=2}
	}
	elementcattos.Bs_Moon {
		key = "deimos",
		ecattos_conf = {
			moon_of = "mars",
		},
		pos = {x=2, y=2}
	}
end