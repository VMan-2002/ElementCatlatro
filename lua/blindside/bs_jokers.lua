elementcattos.bs_joker_current_tier = function(s)
	--s: 1 (small), 2 (big), 3 (boss), 4 (showdown)
	local scale = G.GAME.round_resets.ante / G.GAME.win_ante
	if s == 1 then
		return scale > 0.6 and 2 or 1
	elseif s == 2 then
		return scale > 0.3 and 4 or 3
	elseif s == 3 then
		return scale > 0.4 and 6 or 5
	elseif s == 4 then
		return scale > 1 and 8 or 7
	end
end

elementcattos.bs_joker = function(anum, tier, t)
	if anum > 8 then return end -- TODO: REMOVE THIS LOL
	t.key = "bs_j"..tostring(anum)
	t.boss_colour = t.boss_colour or G.C.RED
	t.order = 300 + (anum * 0.1)
	t.ecattos_conf = t.ecattos_conf or {}
	t.ecattos_conf.tier = tier
	t.ecattos_conf.bs_joker = true
	if t.pos then t.pos.x = 0 end
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
		{mult = 1, base_dollars = 4}, --1: small (initial)
		{mult = 1.1, base_dollars = 4}, --2: small (from ante (win*0.6))
		{mult = 1.5, base_dollars = 4}, --3: big (initial)
		{mult = 1.6, base_dollars = 5}, --4: big (from ante (win*0.3))
		{mult = 2.125, base_dollars = 5}, --5: boss (initial)
		{mult = 2.25, base_dollars = 6}, --6: boss (from ante (win*0.4))
		{mult = 2.5, base_dollars = 7}, --7: showdown
		{mult = 2.75, base_dollars = 9} --8: superboss (showdown after win ante)
	})[tier]) do
		t[k] = t[k] or v
	end
	return elementcattos.Bs_Add(BLINDSIDE.Joker(t))
end

--tier placements are not final


--	TIER 1
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
elementcattos.bs_joker(7, 1, { --nitrogen
	boss_colour = HEX("BFFFFF"),
	pos = {y = 2}
})
elementcattos.bs_joker(5, 1, { --boron
	boss_colour = G.C.BLACK,
	pos = {y = 12}
})

--	TIER 2
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

--	TIER 3
elementcattos.bs_joker(15, 3, { --phosphorus
	
})
elementcattos.bs_joker(16, 3, { --sulfur
	
})
elementcattos.bs_joker(26, 3, { --iron
	
})
elementcattos.bs_joker(14, 3, { --silicon
	
})

--	TIER 4
elementcattos.bs_joker(43, 4, { --technetium
	
})
elementcattos.bs_joker(60, 4, { --neodymium
	
})
elementcattos.bs_joker(73, 4, { --tantalum
	
})
elementcattos.bs_joker(81, 4, { --thallium
	
})

--	TIER 5
elementcattos.bs_joker(20, 5, { --calcium
	
})
elementcattos.bs_joker(47, 5, { --silver
	
})
elementcattos.bs_joker(76, 5, { --osmium
	
})
elementcattos.bs_joker(69, 5, { --thulium
	
})

--	TIER 6
elementcattos.bs_joker(85, 6, { --astatine
	
})
elementcattos.bs_joker(95, 6, { --americium
	
})
elementcattos.bs_joker(63, 6, { --europium
	
})

--	TIER 7
elementcattos.bs_joker(117, 7, { --tennessine
	
})
elementcattos.bs_joker(118, 7, { --oganesson
	
})

--	TIER 8
elementcattos.bs_joker(119, 8, { --ununennium
	
})
elementcattos.bs_joker(120, 8, { --unbinilium
	
})

