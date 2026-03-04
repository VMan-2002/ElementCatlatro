local e = elementcattos
local dcp = function(anum, iso) --to allow easier changing later
	return {anum, iso}
end
e.radioactive = {
	j_ecattos_element0 = {
		glowrate = 7,
		hands = 0,
		explode = true
	},
	j_ecattos_element35 = {
		glowonly = true,
		glowrate = 2,
		spr = "bromine",
		blend = "alpha",
		int = 1
	},
	j_ecattos_element43 = {
		hands = e.halflife(e.fromyears(211e3))
	},
	j_ecattos_element49 = {
		hands = e.halflife(e.fromyears(441e12)),
		explode = true
	},
	j_ecattos_element52 = {
		hands = e.halflife(e.fromyears(791e18)),
		explode = true
	},
	j_ecattos_element61 = {
		hands = e.halflife(e.fromyears(2.6)),
		explode = true
	},
	j_ecattos_element75 = {
		hands = e.halflife(e.fromyears(416e8)),
		explode = true
	},
	j_ecattos_element83 = {
		hands = e.halflife(e.fromyears(201e17))
	},
	j_ecattos_element84 = {
		hands = e.halflife(e.fromdays(138.4))
	},
	j_ecattos_element85 = {
		glowrate = 4,
		hands = e.halflife(56)
	},
	j_ecattos_element86 = {
		glowrate = 9,
		spr = "radon",
		hands = e.halflife(e.fromdays(3.8))
	},
	j_ecattos_element87 = {
		glowrate = 4,
		hands = e.halflife(e.fromminutes(4.8))
	},
	j_ecattos_element88 = {
		hands = 0,
		hands = e.halflife(e.fromminutes(4.8)),
		spr = "green"
	},
	j_ecattos_element89 = {
		hands = e.halflife(e.fromyears(1599))
	},
	j_ecattos_element90 = {
		hands = e.halflife(e.fromyears(1405e7))
	},
	j_ecattos_element91 = {
		hands = e.halflife(e.fromyears(32650))
	},
	j_ecattos_element92 = {
		hands = e.halflife(e.fromyears(4468e6)),
		spr = "green"
	},
	j_ecattos_element93 = {
		hands = e.halflife(e.fromyears(2144e3))
	},
	j_ecattos_element94 = {
		hands = e.halflife(e.fromyears(813e5))
	},
	j_ecattos_element95 = {
		hands = e.halflife(e.fromyears(7350))
	},
	j_ecattos_element96 = {
		hands = e.halflife(e.fromyears(156e5)),
		spr = "pink"
	},
	j_ecattos_element97 = {
		hands = e.halflife(e.fromyears(1380))
	},
	j_ecattos_element98 = {
		hands = e.halflife(e.fromyears(898))
	},
	j_ecattos_element99 = {
		hands = e.halflife(e.fromyears(1.3))
	},
	j_ecattos_element100 = {
		hands = e.halflife(e.fromdays(100.5))
	},
	j_ecattos_element101 = {
		hands = e.halflife(e.fromdays(51.6)),
		explode = true --TODO: are there any lower numberd elements that explode?
	},
	j_ecattos_element102 = {
		glowrate = 3,
		hands = e.halflife(e.fromminutes(58)),
		explode = true
	},
	j_ecattos_element103 = {
		glowrate = 2,
		int = 0.6,
		hands = e.halflife(e.fromhours(11)),
		explode = true
	},
	j_ecattos_element104 = {
		glowrate = 3.5,
		hands = e.halflife(e.fromminutes(48)),
		explode = true
	},
	j_ecattos_element105 = {
		glowrate = 2,
		int = 0.6,
		hands = e.halflife(e.fromhours(16)),
		explode = true
	},
	j_ecattos_element106 = {
		glowrate = 5.5,
		hands = e.halflife(e.fromminutes(9.8)),
		explode = true
	},
	j_ecattos_element107 = {
		glowrate = 6,
		hands = e.halflife(e.fromminutes(2.4)),
		explode = true
	},
	j_ecattos_element108 = {
		glowrate = 6,
		hands = e.halflife(e.fromminutes(2.2)),
		explode = true
	},
	j_ecattos_element109 = {
		glowrate = 6,
		hands = e.halflife(4),
		explode = true,
		spr = "yellow"
	},
	j_ecattos_element110 = {
		glowrate = 5,
		hands = e.halflife(14),
		explode = true
	},
	j_ecattos_element111 = {
		glowrate = 5,
		hands = e.halflife(e.fromminutes(2.2)),
		explode = true
	},
	j_ecattos_element112 = {
		glowrate = 6,
		spr = "teal",
		hands = e.halflife(30),
		explode = true
	},
	j_ecattos_element113 = {
		glowrate = 6,
		hands = e.halflife(9.5),
		explode = true
	},
	j_ecattos_element114 = {
		glowrate = 6,
		spr = "yellow",
		hands = e.halflife(2),
		explode = true
	},
	j_ecattos_element115 = {
		glowrate = 6,
		hands = e.halflife(0.7),
		explode = true
	},
	j_ecattos_element116 = {
		glowrate = 6,
		hands = e.halflife(0.1),
		explode = true
	},
	j_ecattos_element117 = {
		glowrate = 6,
		hands = 0,
		explode = true
	},
	j_ecattos_element118 = {
		glowrate = 7,
		hands = 0,
		explode = true,
		spr = "lime"
	},
	j_ecattos_element119 = {
		glowrate = 7.5,
		spr = "violet",
		int = 1,
		hands = 0,
		explode = true
	},
	j_ecattos_element120 = {
		glowrate = 8,
		spr = "violet",
		hands = 0,
		explode = true
	},
	j_ecattos_element_extended = {
		glowrate = 2,
		spr = "extended",
		int = 0.6,
		hands = 0,
		explode = true
	}
}

--Recreated from ecatto decomp
elementcattos.decay = function(card)
	local protons = elementcattos.validTransformElement(card, true)
	local neutrons = elementcattos.getNeutrons(card)
	if not protons then return end
	if protons == 0 then
		if neutrons == 0 then
			topuplib.quickGive("j_ecattos_positron")
			topuplib.quickGive("j_ecattos_electron")
			topuplib.quickGive("j_ecattos_neutrino")
			elementcattos.doExplode(card)
			elementcattos.basicDestroy(card)
		else
			elementcattos.decayInto(card, 2)
		end
	elseif protons == 1 then
		--wip
	end
end

--Also recreated from ecatto decomp
elementcattos.decayInto = function(card, mode, explode)
	local anum = elementcattos.validTransformElement(card, true)
	local protons = anum
	local neutrons = elementcattos.getNeutrons(card)
	local electrons = 0 --TODO
	if mode == 1 then
		protons = protons - 2
		neutrons = neutrons - 2
		elementcattos.gimmeIsotope(2, 2, 0, 0)
	elseif mode == 2 then
		protons = protons + 1
		neutrons = neutrons - 1
		topuplib.quickGive("j_ecattos_electron")
		topuplib.quickGive("j_ecattos_antineutrino")
	elseif mode == 3 then
		protons = protons - 1
		neutrons = neutrons + 1
		topuplib.quickGive("j_ecattos_positron")
		topuplib.quickGive("j_ecattos_neutrino")
	elseif mode == 4 then
		elementcattos.gimmeIsotope(math.ceil(protons / 2), math.ceil(neutrons / 2), math.ceil(electrons / 2), 0)
		protons = math.floor(protons / 2)
		neutrons = math.floor(neutrons / 2)
		electrons = math.floor(electrons / 2)
	elseif mode == 5 then
		topuplib.quickGive("j_ecattos_neutron")
		neutrons = neutrons - 1
	elseif mode == 6 then
		topuplib.quickGive("j_ecattos_neutrino")
		protons = protons - 1
		neutrons = neutrons + 1
		electrons = electrons - 1
	elseif mode == 7 then
		protons = protons - 1
		elementcattos.gimmeIsotope(1, 0, 0, 0)
	end
	if protons ~= anum then
		if protons < 0 then
			elementcattos.doExplode(card)
			elementcattos.basicDestroy(card)
			return
		end
		card:set_ability({center = elementcattos.atomicnumber[protons]})
	end
	card.ability.extra.neutrons = neutrons
	card.ability.extra.electrons = electrons
	card.ability.extra.antimuons = antimuons
	elementcattos.applyIsotopeSprite(card)
end

e.radioactiveCalculate = function()
	local worldend_trigger = false
	G.E_MANAGER:add_event(Event({
	trigger = 'after',
	delay = 0.1,
	blocking = true,
	func = function()
		if worldend_trigger then
			return not elementcattos.worldendanim.instance
		end
		for k,v in pairs(G.jokers.cards) do
			local rd = e.isRadioactive(v)
			if rd and v.ability.ecattos_stabilized == nil then
				v.ability.ecattos_rd_hands = (v.ability.ecattos_rd_hands or rd.hands) - 1
				if v.ability.ecattos_rd_hands <= 0 then
					if elementcattos.validTransformElement(v, true) >= 500 then
						--you are DEAD
						elementcattos.worldendanim.play()
						worldend_trigger = true
						return false
					end
					play_sound("ecattos_explode")
					if rd.explode then
						e.doExplosion(v)
					end
					v.ability.ecattos_rd_hands = nil
					--TODO: implement actual decay results. as placeholder, we destroy the card or become garbage
					if SMODS.is_eternal(v) then
						e.becomeGarbage(v)
					else
						v:start_dissolve()
					end
				end
			elseif v.ability.ecattos_stabilized == false then
				v.ability.ecattos_stabilized = nil
			end
		end
		return true
	end }))
end