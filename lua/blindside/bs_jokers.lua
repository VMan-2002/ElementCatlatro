elementcattos.bs_joker_current_tier = function(s)
	--s: 1 (small), 2 (big), 3 (boss), 4 (showdown)
	local f, t, lv, h = G.GAME.round_resets.ante / G.GAME.win_ante
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
	t.boss_colour = t.boss_colour or (tier == 8 and G.C.DARK_EDITION or G.C.RED)
	t.order = 300 + (anum * 0.1)
	t.ecattos_conf = t.ecattos_conf or {}
	t.ecattos_conf.tier = tier
	t.ecattos_conf.bs_joker = true
	t.ecattos_conf.my_center = t.ecattos_conf.my_center or "j_ecattos_element"..anum
	if t.pos then t.pos.x = t.pos.x or 0 end
	t.pool_override = t.pool_override or function(self)
		local tierCheck = elementcattos.bs_joker_current_tier(bit.rshift(self.ecattos_conf.tier + 1, 1))
		if (not G.GAME.modifiers.bs_ecattos_stake) then
			return self.ecattos_conf.tier == 8 or pseudorandom("ecattos_bs_joker_spawn") > 0.4 --don't completely drown blindside's jokers
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
		{mult = 30, base_dollars = 9} --8: superboss (showdown after win ante)
	})[tier]) do
		t[k] = t[k] or v
	end
	if not G.localization.descriptions.Blind["bl_ecattos_"..t.key] then
		t.loc_txt = {name = SMODS.Jokers["j_ecattos_element"..anum].loc_txt.name, text = {"no loc!"}}
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
	if tier >= 4 or pseudorandom("ecattos_bs_joker_spawnkeep") > 0.4 then
		table.remove(G.GAME.ecattos_bs_jokers_available[tier], i)
	end
	return k
end

-- Quip
SMODS.JimboQuip({
	key = "bs_lose",
	extra = {
		center = "j_ecattos_element1"
	},
	filter = function(self, type)
		if G.GAME.modifiers.bs_ecattos_stake then
			self.extra.text_key = string.sub(G.GAME.blind.name, 4) .. "_lose1"
			self.extra.center = G.P_BLINDS[G.GAME.blind.name].ecattos_conf.my_center or "j_ecattos_element0"
			return true, {override_base_checks = true, weight = 400}
		end
	end
})

--tier placements are not final


--	TIER 1 (early small)
elementcattos.bs_joker(1, 1, { --hydrogen
	boss_colour = HEX("EC86DC"),
	pos = {y = 0}
})
elementcattos.bs_joker(2, 1, { --helium
	boss_colour = G.C.ORANGE,
	pos = {y = 10}
})
elementcattos.bs_joker(3, 1, { --lithium
	boss_colour = HEX("B5B1A5"),
	pos = {y = 11}
})
elementcattos.bs_joker(6, 1, { --carbon
	boss_colour = G.C.BLACK,
	pos = {y = 1}
})
elementcattos.bs_joker(5, 1, { --boron
	boss_colour = G.C.BLACK,
	pos = {y = 12}
})

--	TIER 2 (late small)
elementcattos.bs_joker(7, 2, { --nitrogen
	boss_colour = HEX("BFFFFF"),
	pos = {y = 2}
})
elementcattos.bs_joker(4, 2, { --beryllium
	boss_colour = G.C.GREEN,
	pos = {y = 13}
})
elementcattos.bs_joker(8, 2, { --oxygen
	boss_colour = HEX("807FFF"),
	pos = {y = 3}
})
elementcattos.bs_joker(9, 2, { --flourine
	
})
elementcattos.bs_joker(12, 2, { --magnesium
	
})

--	TIER 3 (early big)
elementcattos.bs_joker(15, 3, { --phosphorus
	pos = {y = 5}
})
elementcattos.bs_joker(16, 3, { --sulfur
	pos = {y = 4}
})
elementcattos.bs_joker(26, 3, { --iron
	boss_colour = HEX("C0C0C0"),
	pos = {y = 14}
})
elementcattos.bs_joker(14, 3, { --silicon
	
})

--	TIER 4 (late big)
elementcattos.bs_joker(43, 4, { --technetium,
	pos = {y = 9}
})
elementcattos.bs_joker(60, 4, { --neodymium
	
})
elementcattos.bs_joker(73, 4, { --tantalum
	
})
elementcattos.bs_joker(81, 4, { --thallium
	
})

--	TIER 5 (early boss)
elementcattos.bs_joker(20, 5, { --calcium
	
})
elementcattos.bs_joker(47, 5, { --silver
	
})
elementcattos.bs_joker(76, 5, { --osmium
	
})
elementcattos.bs_joker(69, 5, { --thulium
	
})

--	TIER 6 (late boss)
elementcattos.bs_joker(85, 6, { --astatine
	
})
elementcattos.bs_joker(95, 6, { --americium
	
})
elementcattos.bs_joker(63, 6, { --europium
	
})

--	TIER 7 (showdown)
elementcattos.bs_joker(117, 7, { --tennessine
	
})
elementcattos.bs_joker(118, 7, { --oganesson
	pos = {y = 8}
})

--	TIER 8 (superboss)
elementcattos.bs_joker(119, 8, { --ununennium
	pos = {y = 6}
})
elementcattos.bs_joker(120, 8, { --unbinilium
	pos = {y = 7}
})

