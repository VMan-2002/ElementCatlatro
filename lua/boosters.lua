SMODS.Atlas({
	key = "boosters",
	path = "boosters.png",
	px = 71,
	py = 95
})

elementcattos.boosterPackCard = function(self, card, i)
	local istool = self.key == "p_ecattos_element_tools"
	local tbl = elementcattos.booster_pools[self.ecattos_booster_pool]
	return {
		set = istool and "Tarot" or "Joker",
		key = tbl[math.random(#tbl)]
	}
end

SMODS.Booster {
	key = "element_common",
	config = {extra = 5, choose = 2},
	atlas = "boosters",
	pos = {x = 1, y = 0},
	cost = 3,
	ecattos_booster_pool = 1,
	create_card = elementcattos.boosterPackCard
}

SMODS.Booster {
	key = "element_uncommon",
	config = {extra = 5, choose = 2},
	atlas = "boosters",
	pos = {x = 2, y = 0},
	cost = 4,
	ecattos_booster_pool = 2,
	create_card = elementcattos.boosterPackCard
}

SMODS.Booster {
	key = "element_rare",
	config = {extra = 3, choose = 1},
	atlas = "boosters",
	pos = {x = 3, y = 0},
	cost = 5,
	ecattos_booster_pool = 3,
	create_card = elementcattos.boosterPackCard
}

SMODS.Booster {
	key = "element_tools",
	config = {extra = 4, choose = 1},
	atlas = "boosters",
	pos = {x = 4, y = 0},
	cost = 4,
	ecattos_booster_pool = "tool",
	create_card = elementcattos.boosterPackCard
}

SMODS.Booster {
	key = "element_toolbox",
	config = {extra = 7, choose = 2},
	atlas = "boosters",
	pos = {x = 4, y = 0},
	cost = 8,
	ecattos_booster_pool = "tool",
	create_card = elementcattos.boosterPackCard,
	in_pool = topuplib.returnFalse
}