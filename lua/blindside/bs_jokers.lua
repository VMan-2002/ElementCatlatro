elementcattos.bs_joker_current_tier = function(s)
	--s: 1 (small), 2 (big), 3 (boss), 4 (showdown)
	local f, t, lv, h = (G.GAME.round_resets.ante / G.GAME.win_ante) % 1
	if s == 1 then
		t, lv = 0.6, 1
	elseif s == 2 then
		t, lv = 0.3, 3
	elseif s == 3 then
		t, lv = 0.4, 5
	elseif s == 4 then
		t, lv = 2, 7
	end
	if f > 1 then t = (t / math.ceil(f)) - (f * 0.1) end
	h = f > t
	return h and (lv + 1) or lv, h
end

elementcattos.bs_joker = function(anum, tier, t)
	t.key = "bs_j"..tostring(anum)
	t.boss_colour = t.boss_colour or (tier == 8 and G.C.ETERNAL or G.C.RED)
	t.order = 300 + (anum * 0.1)
	t.ecattos_conf = t.ecattos_conf or {}
	t.ecattos_conf.tier = tier
	t.ecattos_conf.bs_joker = true
	t.ecattos_conf.my_center = t.ecattos_conf.my_center or "j_ecattos_element"..anum
	if t.pos then t.pos.x = t.pos.x or 0 end
	t.pool_override = t.pool_override or function(self)
		local tierCheck = elementcattos.bs_joker_current_tier(bit.rshift(self.ecattos_conf.tier + 1, 1))
		if (not G.GAME.modifiers.bs_ecattos_stake) then
			local conf = self.ecattos_conf
			if conf.tier == 8 and G.GAME.round_resets.ante <= G.GAME.win_ante then return false end
			if conf.min_stakelv and conf.min_stakelv - (G.GAME.round_resets.ante * 0.2) > 1 then return end
			return self.ecattos_conf.tier >= 7 or pseudorandom("ecattos_bs_joker_spawn") > 0.6 - (self.ecattos_conf.tier * 0.08) --don't completely drown blindside's jokers
		end
		return true
	end
	t[({"small", "small", "big", "big", "boss", "boss", "boss", "boss"})[tier]] = tier >= 7 and {showdown = true} or {min = -9}
	t.atlas = "bs_jokers"
	for k,v in pairs(({ --tiers
		{mult = 5.5, base_dollars = 4}, --1: small (initial)
		{mult = 6, base_dollars = 4}, --2: small (from ante (win*0.6))
		{mult = 7.5, base_dollars = 4}, --3: big (initial)
		{mult = 8, base_dollars = 5}, --4: big (from ante (win*0.3))
		{mult = 7, base_dollars = 5}, --5: boss (initial)
		{mult = 10, base_dollars = 6}, --6: boss (from ante (win*0.4))
		{mult = 16, base_dollars = 7}, --7: showdown
		{mult = 30, base_dollars = 9}, --8: superboss (showdown after win ante)
		{mult = 38, base_dollars = 14}, --9: extra 1
		{mult = 48, base_dollars = 18} --10: extra 2
	})[tier]) do
		t[k] = t[k] or v
	end
	if not G.localization.descriptions.Blind["bl_ecattos_"..t.key] then
		t.loc_txt = {name = SMODS.Centers["j_ecattos_element"..anum].loc_txt.name, text = {"no loc!"}}
	end
	
	return elementcattos.Bs_Add(BLINDSIDE.Joker(t))
end

--	Use the Element Cattos jokers in the respective stakes

local get_new_small_ref = get_new_small
function get_new_small(...)
	return elementcattos.bs_get_blind(1, get_new_small_ref, ...)
end

local get_new_big_ref = get_new_big
function get_new_big(...)
	return elementcattos.bs_get_blind(2, get_new_big_ref, ...)
end

local get_new_boss_ref = get_new_boss
function get_new_boss(...)
	return elementcattos.bs_get_blind((G.GAME.round_resets.ante > 1 and G.GAME.round_resets.ante % G.GAME.win_ante == 0) and 4 or 3, get_new_boss_ref, ...)
end

function elementcattos.bs_get_blind(s, orig, ...)
	if not G.GAME.modifiers.bs_ecattos_stake then
		return orig(...)
	end
	
	local tier = elementcattos.bs_joker_current_tier(s)
	if #G.GAME.ecattos_bs_jokers_available[tier] == 0 then
		G.GAME.ecattos_bs_jokers_available[tier] = topuplib.tableShallowCopy(G.GAME.ecattos_bs_jokers_stock[tier])
	end
	print("ecattos select enemy joker lv "..s.." tier "..tier)
	
	local i = math.floor(#G.GAME.ecattos_bs_jokers_available[tier] * pseudorandom("ecattos_bs_joker_spawn")) + 1
	local k = G.GAME.ecattos_bs_jokers_available[tier][i]
	local bl_conf = SMODS.Blinds[k].ecattos_conf
	local tooearly = (bl_conf.min_ante and bl_conf.min_ante > G.GAME.round_resets.ante) or (bl_conf.min_stakelv and bl_conf.min_stakelv > G.GAME.modifiers.bs_ecattos_stake)
	if tooearly or tier >= 4 or pseudorandom("ecattos_bs_joker_spawnkeep") > 0.4 then
		table.remove(G.GAME.ecattos_bs_jokers_available[tier], i)
		if tooearly then
			return elementcattos.bs_get_blind(s, nil, ...)
		end
	end
	return k
end

--tier placements are not final


--	TIER 1 (early small)
elementcattos.bs_joker(1, 1, { --hydrogen
	boss_colour = HEX("EC86DC"),
	pos = {y = 0}
})
elementcattos.bs_joker(2, 1, { --helium
	boss_colour = G.C.ORANGE,
	pos = {y = 10},
	calculate = function(self, blind, context)
	end
})
elementcattos.bs_joker(3, 1, { --lithium
	boss_colour = HEX("B5B1A5"),
	pos = {y = 11}
})
elementcattos.bs_joker(5, 1, { --boron
	boss_colour = HEX("5B5853"),
	pos = {y = 12},
	mult = 6.5,
	debuff_hand = function(self, cards)
		local hues = {count = 0}
		for k,v in pairs(cards) do
			for _,col in ipairs(elementcattos.bs_hues) do
				if hues[col] == nil and v:is_color(col) then
					hues[col] = true
					hues.count = hues.count + 1
					if col == "Faded" or hues.count >= 3 then
						return false
					end
				end
			end
		end
		return true
	end
})

--	TIER 2 (late small)
elementcattos.bs_joker(4, 2, { --beryllium
	boss_colour = G.C.GREEN,
	pos = {y = 13}
})
elementcattos.bs_joker(6, 2, { --carbon
	boss_colour = G.C.BLACK,
	pos = {y = 1},
	ecattos_conf = {min_ante = 2}
})
elementcattos.bs_joker(7, 2, { --nitrogen
	boss_colour = HEX("BFFFFF"),
	pos = {y = 2}
})
elementcattos.bs_joker(8, 2, { --oxygen
	boss_colour = HEX("807FFF"),
	pos = {y = 3}
})
elementcattos.bs_joker(9, 2, { --fluorine
	pos = {y = 16},
	boss_colour = HEX("CEBB80")
})
elementcattos.bs_joker(12, 2, { --magnesium
	pos = {y = 17},
	boss_colour = G.C.GREEN
})

--	TIER 3 (early big)
elementcattos.bs_joker(15, 3, { --phosphorus
	pos = {y = 5}
})
elementcattos.bs_joker(26, 3, { --iron
	boss_colour = HEX("C0C0C0"),
	pos = {y = 14},
	ecattos_conf = {min_ante = 2}
})
elementcattos.bs_joker(14, 3, { --silicon
	pos = {y = 18},
	boss_colour = HEX("8896B9")
})

--	TIER 4 (late big)
elementcattos.bs_joker(16, 4, { --sulfur
	pos = {y = 4},
	boss_colour = G.C.MONEY,
	mult = 6.5,
	ecattos_conf = {min_ante = 2}
})
elementcattos.bs_joker(22, 4, { --titanium
	boss_colour = HEX("B5ACA3"),
	pos = {y = 15},
	mult = 20
})
elementcattos.bs_joker(43, 4, { --technetium,
	pos = {y = 9},
	boss_colour = G.C.PURPLE
})
elementcattos.bs_joker(60, 4, { --neodymium
	ecattos_conf = {min_ante = 2},
	pos = {y = 22},
	boss_colour = HEX("A5B4C2")
})
elementcattos.bs_joker(81, 4, { --thallium
	boss_colour = G.C.BLUE,
	pos = {y = 21}
})

--	TIER 5 (early boss)
elementcattos.bs_joker(20, 5, { --calcium
	boss_colour = G.C.WHITE,
	pos = {y = 23}
})
elementcattos.bs_joker(47, 5, { --silver
	pos = {y = 24},
	boss_colour = HEX("BABEBB") --insane hex code
})
elementcattos.bs_joker(76, 5, { --osmium
	pos = {y = 25},
	boss_colour = HEX("417991")
})
elementcattos.bs_joker(69, 5, { --thulium
	
})

--	TIER 6 (late boss)
elementcattos.bs_joker(73, 6, { --tantalum
	boss_colour = HEX("C87D22"),
	mult = 8,
	ecattos_conf = {min_ante = 3},
	pos = {y = 26}
})
elementcattos.bs_joker(85, 6, { --astatine
	pos = {y = 27},
	boss_colour = HEX("1F203F")
})
elementcattos.bs_joker(95, 6, { --americium
	
})
elementcattos.bs_joker(63, 6, { --europium
	pos = {y = 20}
})

--	TIER 7 (showdown)
elementcattos.bs_joker(117, 7, { --tennessine
	pos = {y = 19},
	boss_colour = HEX("826162")
})
elementcattos.bs_joker(118, 7, { --oganesson
	pos = {y = 8},
	boss_colour = HEX("004C23"),
	ecattos_conf = {min_ante = 2},
	calculate = function(self, blind, context)
		if context.setting_blind and not context.disabled then
			blind.active = true
		end
		if context.after and not G.GAME.blind.disabled and G.GAME.blind.active and SMODS.calculate_round_score() - G.GAME.blind.chips <= 0 then
			G.GAME.blind.active = false
			return elementcattos.bs_chipsmodify{balance = true}
		end
	end
})

--	TIER 8 (superboss)
elementcattos.bs_joker(119, 8, { --ununennium
	pos = {y = 6},
	boss_colour = HEX("6D003A"),
	joker_set = function(self)
		local fuckyou = topuplib.filterContinuous(SMODS.Centers, function(v)
			return getmetatable(v) == BLINDSIDE.Blind and v.curse
		end)
		local fuckyou_stock = topuplib.tableShallowCopy(fuckyou) -- should never be needed but just in case
		for i = 1, 16 do
			local n = math.random(#fuckyou)
			SMODS.add_card{set = "Enhanced", key = fuckyou[n].key, area = G.deck}
			if i > 10 then table.remove(fuckyou, n) end
			if #fuckyou == 0 then fuckyou = topuplib.tableShallowCopy(fuckyou_stock) end
		end
	end,
	calculate = function(self, blind, context)
		--if context.scoring_hand then print("scoring hand") topuplib.inspect(context.scoring_hand) end
		--elementcattos.bs_alert_debuff(self, context, function(h) return next(elementcattos.bs_blind_filter_rarity(h, "curse", true)) end, "Hand contains a non-Crude blind")
		if context.individual and context.other_card.area == G.play and not context.other_card.config.center.curse then
			blind.playingfire_adds = blind.playingfire_adds + 1
			return elementcattos.bs_chipsmodify{emult = 1.025}
		end
	end
})
elementcattos.bs_joker(120, 8, { --unbinilium
	pos = {y = 7},
	boss_colour = HEX("00A9FF"),
	ecattos_conf = {min_ante = 3},
	calculate = function(self, blind, context)
		if context.individual then
			local card = context.other_card
			if card.area == G.play and (card.edition or card.ability.bld_upgrade or card.seal) then
				blind.playingfire_adds = blind.playingfire_adds + 1
				return elementcattos.bs_chipsmodify{emult = 1.05}
			end
		end
	end
})

