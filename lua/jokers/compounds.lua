local legitimate

local compounds = {
	{
		id = "water",
		pronouns = "she_her",
		formula = {{"H", 2}, "O"},
		pos = {x = 1, y = 0},
		calculate = function(self, card, context)
			if context.modify_scoring_hand and not context.blueprint then
				return { add_to_hand = true }
			end
		end
	},
	{
		id = "heavy_water",
		pronouns = "she_her",
		formula = {{"H", 2, 2}, "O"},
		pos = {x = 1, y = 0},
		calculate = function(self, card, context)
			if context.modify_scoring_hand and not context.blueprint then
				return { add_to_hand = true }
			end
			if (context.individual and context.cardarea == G.play and context.poker_hands and not topuplib.getValueIndex(context.poker_hands[context.scoring_name][1], context.other_card)) or context.forcetrigger then
				return {mult = 2}
			end
		end
	},
	{
		id = "starch",
		pronouns = "she_her",
		formula = {"_(", {"C", 6}, {"H", 10}, {"O", 5}, "_)n"},
		rarity = 2,
		cost = 18, functional = false
	},
	{
		id = "oobleck",
		pronouns = "she_her",
		formula = {{"starch"}, "_+", {"water"}},
		rarity = 3,
		cost = 24,
		config = {extra = {big_xmult = 4, mult_threshold = 25, small_xmult = 0.5}},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.big_xmult, card.ability.extra.small_xmult, card.ability.extra.mult_threshold } }
		end,
		calculate = function(self, card, context)
			if context.joker_main then
				return {x_mult = card.ability.extra.xmult or 1}
			end
			if context.initial_scoring_step then
				card.ability.extra.xmult = card.ability.extra[mult > card.ability.extra.mult_threshold and "small_xmult" or "big_xmult"]
			end
		end
	},
	{
		id = "silica",
		pronouns = "unknown",
		formula = {"Si", {"O", 2}},
		cost = 3,
		config = {extra = {mult = 2}},
		loc_vars = function(self, info_queue, card)
			return { vars = { card.ability.extra.mult } }
		end, functional = false
	},
	{
		id = "neodymium_magnet",
		pronouns = "they_them",
		formula = {{"Nd", 2}, {"Fe", 14}, "B"},
		rarity = 2,
		cost = 19,
		pos = {x = 2, y = 0},
		config = {extra = {odds = 4}},
		loc_vars = function(self, info_queue, card)
			local aaa, bbb = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "ECattos_NeodymiumMagnet")
			return { vars = { aaa, bbb } }
		end,
		calculate = function(self, card, context)
			if context.before then
				for k,v in pairs(G.hand.cards) do
					if v.config.center_key == "m_steel" and not v.edition and SMODS.pseudorandom_probability(card, 'ECattos_NeodymiumMagnet', 1, card.ability.extra.odds) then
						v:set_edition("e_negative")
					end
				end
			end
		end
	},
	{
		id = "estradiol",
		pronouns = "she_her",
		formula = {{"C",18}, {"H",24}, {"O", 2}},
		cost = 44,
		calculate = function(self, card, context)
			if context.using_consumeable and next(G.hand.highlighted) then
				local cards = topuplib.tableShallowCopy(G.hand.highlighted)
				local suitwas = {}
				for k,v in pairs(cards) do
					suitwas[k] = v.config.card.suit
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0,
					no_delete = true,
					timer = 'REAL',
					blocking = false,
					func = function()
						if G.STATE == G.STATES.PLAY_TAROT then return false end
						for k,v in pairs(cards) do
							if v and (v.config.card.suit ~= suitwas[k]) then
								SMODS.change_base(v, nil, "Queen")
							end
						end
						return true
					end
				}))
			end
		end
	},
	{
		id = "testosterone",
		pronouns = "he_him",
		formula = {{"C",19}, {"H",28}, {"O", 2}},
		cost = 49,
		calculate = function(self, card, context) --TODO: This can be cheesed using any infinitely-usable consumable
			if context.using_consumeable and next(G.hand.highlighted) then
				local cards = topuplib.tableShallowCopy(G.hand.highlighted)
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0,
					no_delete = true,
					timer = 'REAL',
					blocking = false,
					func = function()
						if G.STATE == G.STATES.PLAY_TAROT then return false end
						if cards[1] then
							SMODS.change_base(cards[1], nil, "King")
						end
						return true
					end
				}))
			end
		end
	},
	{
		id = "cortisol",
		pronouns = "she_her",
		formula = {{"C",21}, {"H",30}, {"O", 5}},
		cost = 56,
		config = {extra = {chips = 6}},
		calculate = function(self, card, context)
			if context.discard then
				context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
				return {
					extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
					card = card
				}
			end
		end
	},
	{
		id = "titin",
		pronouns = "he_they",
		formula = {{"C", 169719}, {"H", 270446}, {"N", 45688}, {"O", 52238}, {"S", 911}},
		rarity = elementcattos.exotic_rarity(),
		cost = 500000,
		config = {extra = {emult = 3}},
		loc_vars = function(self, info_queue, card)
			--return { vars = { card.ability.extra.emult }}
			--return { vars = { legitimate.titin }}
		end,
		calculate = function(self, card, context)
			--if not legitimate.titin then return end
			--todo: fix conditional
			if context.joker_main then
				return {Emult = card.ability.extra.emult}
			end
		end,
		--no_collection = Cryptid ~= nil,
		in_pool = topuplib.returnFalse,
		not_in_booster = true
	},
	{
		id = "pkzilla1",
		pronouns = nil,
		formula = {{"C", 208516}, {"H", 334220}, {"N", 60758}, {"O", 63313}, {"S", 1733}},
		rarity = elementcattos.exotic_rarity(),
		cost = 500000,
		--no_collection = Cryptid ~= nil,
		in_pool = topuplib.returnFalse,
		not_in_booster = true,
		config = {extra = {odds = 2, emult = 1, emult_gain = 0.25}},
		calculate = function(self, card, context)
			if context.discard and not SMODS.is_eternal(context.other_card) and SMODS.pseudorandom_probability(card, "ECattos_Pkzilla1", 1, card.ability.extra.odds) then
				SMODS.scale_card(card, {ref_value = "emult", scalar_value = "emult_gain"})
				return {remove = true}, true
			end
			if context.forcetrigger then
				SMODS.scale_card(card, {ref_value = "emult", scalar_value = "emult_gain"})
			end
			if context.joker_main or context.forcetrigger then
				return {e_mult = card.ability.extra.emult}
			end
		end,
		loc_vars = function(self, info_queue, card)
			local aaa, bbb = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "ECattos_Pkzilla1")
			return {vars = {aaa, bbb, card.ability.extra.emult_gain, card.ability.extra.emult}}
		end
	},
	{
		id = "pg5", --will not be the blueygray design btw
		pronouns = nil,
		formula = {{"C", -1}}, --TODO: i am having so much trouble finding the answer to this
		rarity = elementcattos.exotic_rarity(),
		cost = 500000,
		--no_collection = Cryptid ~= nil,
		in_pool = topuplib.returnFalse,
		not_in_booster = true
	}
}

SMODS.Atlas({
	key = "compounds",
	path = "compounds.png",
	px = 71,
	py = 95
})

local inpool = function(self, args)
	if self.rarity == 1 and pseudorandom("ecatto_spawnrate") > 0.65 then return true end
	if self.rarity == 2 and pseudorandom("ecatto_spawnrate") > 0.85 then return true end
	return false
end

for k,v in ipairs(compounds) do
	v.desc = v.desc or {}
	table.insert(v.desc, "{C:inactive}Formula: " .. elementcattos.formatFormula(v.formula))
	local j = SMODS.Joker({
		key = "compound_" .. v.id,
		loc_txt = {
			name = v.name or v.id,
			text = v.desc
		},
		atlas = "compounds",
		pos = v.pos or {x=0, y=0},
		pronouns = elementcattos.pronoun(v.pronouns),
		cost = v.cost or 6,
		compound_formula = v.formula,
		element_symbol = v.id,
		rarity = elementcattos.ishandmade(v.rarity, v.functional),
		in_pool = inpool,
		config = v.config,
		loc_vars = v.loc_vars,
		calculate = v.calculate,
		no_collection = v.no_collection,
		not_in_booster = v.not_in_booster,
		ecattos_conf = {compound = true}
	})
	elementcattos.compounds[v.id] = {v.formula, j.key}
end

return function(t)
	legitimate = t.legitimate
end