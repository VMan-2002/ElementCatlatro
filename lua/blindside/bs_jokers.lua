elementcattos.bs_joker = function(k, tier, t)
	t.key = "bs_j"..tostring(k)
	t.ecattos_conf = t.ecattos_conf or {}
	t.ecattos_conf.tier = tier
	t.ecattos_conf.bs_joker = true
	t.atlas = "bs_jokers"
	for k,v in pairs({ --tiers
		{mult = 1, dollars = 4}, --1: small (initial)
		{mult = 1.1, dollars = 4}, --2: small (from ante 4)
		{mult = 1.5, dollars = 4}, --3: big (initial)
		{mult = 1.6, dollars = 5}, --4: big (from ante 3)
		{mult = 2.125, dollars = 5}, --5: boss (initial)
		{mult = 2.25, dollars = 6}, --6: boss (from ante 3)
		{mult = 2.5, dollars = 7} --7: showdown
		{mult = 2.75, dollars = 9} --8: superboss
	}[tier]) do
		t[k] = v
	end
	elementcattos.Bs_Add(SMODS.Blind(t))
end

local j = elementcattos.bs_joker

--tier placements are not final

--	TIER 1
j(1, 1 { --hydrogen
	
})
j(2, 1 { --helium
	
})
j(3, 1 { --lithium
	
})
j(6, 1 { --carbon
	
})
j(7, 1 { --nitrogen
	
})

--	TIER 2
j(4, 2 { --beryllium
	
})
j(8, 2 { --oxygen
	
})
j(9, 2 { --flourine
	
})
j(12, 2 { --magnesium
	
})

--	TIER 3
j(15, 3 { --phosphorus
	
})
j(16, 3 { --sulfur
	
})
j(26, 3 { --iron
	
})
j(14, 3 { --silicon
	
})

--	TIER 4
j(43, 4 { --technetium
	
})
j(60, 4 { --neodymium
	
})
j(73, 4 { --tantalum
	
})
j(81, 4 { --thallium
	
})

--	TIER 5
j(20, 5 { --calcium
	
})
j(47, 5 { --silver
	
})
j(76, 5 { --osmium
	
})
j(69, 5 { --thulium
	
})

--	TIER 6
j(81, 6 { --astatine
	
})
j(95, 6 { --americium
	
})
j(63, 6 { --europium
	
})
j(81, 6 { --astatine
	
})

--	TIER 7
j(117, 7 { --tennessine
	
})
j(118, 7 { --oganesson
	
})

--	TIER 8
j(119, 8 { --ununennium
	
})
j(120, 8 { --unbinilium
	
})