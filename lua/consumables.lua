local legitimate

elementcattos.validTransformElement = function(card, allowEternal)
	return (allowEternal or not SMODS.is_eternal(card)) and ((card.ability.extra and card.ability.extra.atomic_number) or card.config.center.atomic_number)
end

elementcattos.getFusion = function()
	if not G.jokers then return end
	--TARGET: Special fusion check
	do
		local dudes = {"naium", {}}
		local lol = 0
		local ind = 0
		for k,v in pairs(G.jokers.highlighted) do
			if v.config.center.key == "j_ecattos_naium" and not SMODS.is_eternal(v) then
				lol = lol + 1
				ind = k
			elseif elementcattos.validTransformElement(v, true) or elementcattos.othercattos[v.config.center.key] then
				table.insert(dudes[2], k)
			else return end
		end
		if lol == 1 and #dudes[2] ~= 0 and #dudes[2] <= 3 then
			dudes[3] = ind
			return dudes
		end
	end
	if #G.jokers.highlighted ~= 2 then return end
	local a = elementcattos.validTransformElement(G.jokers.highlighted[1])
	local b = elementcattos.validTransformElement(G.jokers.highlighted[2])
	if a and b then
		return a + b
	end
end

elementcattos.getFission = function()
	if not G.jokers or #G.jokers.highlighted ~= 1 then return end
	local a = elementcattos.validTransformElement(G.jokers.highlighted[1])
	if not a then return end
	local r1, r2 = math.floor(a * 0.5), math.ceil(a * 0.5)
	if a and elementcattos.atomicnumber[r1] and elementcattos.atomicnumber[r2] then
		return "j_ecattos_element" .. tostring(r1), "j_ecattos_element" .. tostring(r2)
	end
end

SMODS.Atlas({
	key = "tools",
	path = "tools.png",
	px = 71,
	py = 95
})

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "fusion",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 0, y = 0},
	loc_vars = function(self, info_queue, card)
		local fuse = elementcattos.getFusion()
		if type(fuse) == "table" then
			if fuse[1] == "naium" then
				fuse = localize("ecattos_fusion_negative")
			end
		elseif fuse then
			local em = elementcattos.atomicnumber[fuse]
			fuse = em and topuplib.nameFromKey(em, G.P_CENTERS[em].loc_txt.name) or topuplib.localize("misc").ecattos_extended_element.name(fuse)
		end
		return {
			vars = {fuse or localize("ecattos_fusion_none")}
		}
	end,
	can_use = elementcattos.getFusion,
	use = function()
		local result = elementcattos.getFusion()
		if not result then return print("Wrong use for Fusion Reactor") end
		if type(result) == "table" then
			--TARGET: Special fusion result
			if result[1] == "naium" then
				for k,v in pairs(result[2]) do
					G.jokers.highlighted[v]:set_edition("e_negative")
				end
				G.jokers.highlighted[result[3]]:start_dissolve()
			end
			return
		end
		local j1 = G.jokers.highlighted[1]
		local j2 = G.jokers.highlighted[2]
		local resultEdition = (j1.edition and j1.edition.key) or (j2.edition and j2.edition.key)
		j2:start_dissolve()
		j1:start_dissolve()
		local extended = not elementcattos.atomicnumber[result]
		local key = extended and "j_ecattos_element_extended" or ("j_ecattos_element" .. tostring(result))
		local result_card = SMODS.add_card({
			set = "Joker",
			key = key,
			edition = resultEdition
		})
		if extended then
			result_card.ability.extra.atomic_number = result
		end
	end
}.key)

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "fission",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 1, y = 0},
	loc_vars = function(self, info_queue, card)
		local a, b = elementcattos.getFission()
		return {
			vars = a and {topuplib.nameFromKey(a), topuplib.nameFromKey(b)} or {localize("ecattos_fission_none"), localize("ecattos_fission_none")}
		}
	end,
	can_use = function()
		return #G.jokers.highlighted == 1 and elementcattos.validTransformElement(G.jokers.highlighted[1])
	end,
	use = function()
		local r1, r2 = elementcattos.getFission()
		if not r1 then return print("Wrong use for Fission Hammer") end
		local j1 = G.jokers.highlighted[1]
		local resultEdition = (j1.edition and j1.edition.key)
		j1:start_dissolve()
		SMODS.add_card({
			set = "Joker",
			key = r1,
			edition = resultEdition
		})
		SMODS.add_card({
			set = "Joker",
			key = r2
		})
	end
}.key)

--Todo: implement the rest of the consumables
if topuplib.debug then
	table.insert(elementcattos.tools, SMODS.Consumable {
		key = "weakray",
		set = "Tarot",
		atlas = "tools",
		pos = {x = 4, y = 0},
		can_use = function()
			--return #G.jokers.highlighted == 1 and elementcattos.isRadioactive(G.jokers.highlighted[1])
			return false
		end,
		use = function() end
	}.key)
	
	table.insert(elementcattos.tools, SMODS.Consumable {
		key = "tweezers",
		set = "Tarot",
		atlas = "tools",
		pos = {x = 2, y = 0},
		can_use = function()
			return #G.jokers.highlighted == 1 and elementcattos.validTransformElement(G.jokers.highlighted[1], true) and elementcattos.getNeutrons(G.jokers.highlighted[1]) > 0
		end,
		use = function()
			local target = G.jokers.highlighted[1]
			target.ability.extra = target.ability.extra or {}
			target.ability.extra.neutrons = (target.ability.extra.neutrons or elementcattos.getNeutrons(target)) - 1
			SMODS.add_card({
				set = "Joker",
				key = "j_ecattos_neutron",
				no_edition = true
			})
			if elementcattos.applyIsotopeSprite then
				elementcattos.applyIsotopeSprite(target)
			end
		end
	}.key)
	
	table.insert(elementcattos.tools, SMODS.Consumable {
		key = "electromagnet",
		set = "Tarot",
		atlas = "tools",
		pos = {x = 3, y = 0},
		can_use = function()
			return false
		end,
		use = function() end
	}.key)
	
	table.insert(elementcattos.tools, SMODS.Consumable {
		key = "lightbulb",
		set = "Tarot",
		atlas = "tools",
		pos = {x = 1, y = 1},
		can_use = function()
			return false
		end
	}.key)

	--there should be a better way of doing this
	local titin_i = {
		j_ecattos_element6 = true,
		j_ecattos_element1 = true,
		j_ecattos_element7 = true,
		j_ecattos_element8 = true,
		j_ecattos_element16 = true
	}
	table.insert(elementcattos.tools, SMODS.Consumable {
		key = "recipe_titin",
		set = "Tarot",
		atlas = "tools",
		pos = {x = 7, y = 1}, --let's not make a sprite yet until we know we absolutely need this
		soul_pos = {x = 6, y = 1},
		config = { extra = { ready = false, i_instance = 0 } },
		can_use = topuplib.returnTrue,
		keep_on_use = function(self, card)
			return not card.ability.extra.ready
		end,
		loc_vars = function(self, info_queue, card)
			if not card.ability.extra.i_instance then
				if topuplib.viewedFromCollection(card) then return {vars = {0, 0, 0, 0, 0}} end
				local i = 0
				while not legitimate.titin_recipe[i] do
					i = i + 1
				end
				card.ability.extra.i_instance = i
				legitimate.titin_recipe[i] = {0, 0, 0, 0, 0}
			end
			return {vars = legitimate.titin_recipe[card.ability.extra.i_instance]}
		end,
		in_pool = function()
			for v,_ in ipairs(titin_i) do
				if elementcattos.countJokers(v) >= 50 then return true end
			end
			return false
		end,
		use = function()
			for k,v in pairs(G.jokers.cards) do
				--if 
			end
		end
	}.key)
end

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "stabilizer",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 0, y = 1},
	can_use = function()
		return #G.jokers.highlighted == 1 and elementcattos.cardFromMod(G.jokers.highlighted[1])
	end,
	use = function()
		local j = G.jokers.highlighted[1]
		j.ability.ecattos_stabilized = (j.ability.ecattos_stabilized or 0) + 2
		j:juice_up()
		play_sound("ecattos_stabilized")
	end
}.key)
SMODS.Sound({
	key = "stabilized",
	path = "stabilized.ogg"
})
SMODS.Sound({
	key = "unstabilized",
	path = "unstabilized.ogg"
})

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "duplicator",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 5, y = 0},
	can_use = function()
		if #G.jokers.highlighted ~= 1 or not elementcattos.cardFromMod(G.jokers.highlighted[1]) then return false end
		return topuplib.cardAreaHasRoom()
	end,
	use = function()
		for i = 1, ((G.jokers.highlighted[1].config.center.rarity or 1) == 1) and 2 or 1 do
			SMODS.add_card({
				set = "Joker",
				key = G.jokers.highlighted[1].config.center.key,
				--edition = resultEdition
			})
			if not topuplib.cardAreaHasRoom() then return end
		end
	end
}.key)

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "eraser",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 6, y = 0},
	can_use = function()
		return #G.jokers.highlighted == 1 and elementcattos.cardFromMod(G.jokers.highlighted[1]) and not G.jokers.highlighted[1].ability.entr_aleph
	end,
	use = function()
		local card = G.jokers.highlighted[1]
		if card.ability.entr_aleph or card.ability.cry_absolute or card.ability.ecattos_placeholder then
			local aleph_bypass = card.ability.bypass_aleph
			card.ability.bypass_aleph = true
			elementcattos.becomeGarbage(card)
			card.ability.bypass_aleph = aleph_bypass
			return
		end
		card:start_dissolve()
	end
}.key)

table.insert(elementcattos.tools, SMODS.Consumable {
	key = "compoundcreator",
	set = "Tarot",
	atlas = "tools",
	pos = {x = 7, y = 1},
	soul_pos = {x = 6, y = 1},
	config = { extra = { ready = true } },
	can_use = topuplib.returnTrue,
	keep_on_use = function(self, card)
		return card.ability.extra.ready
	end,
	use = elementcattos.ui_compound_creator
}.key)
elementcattos.radioactive.c_ecattos_compoundcreator = {
	glowrate = 2,
	spr = "compoundcreator",
	int = 0.5,
	glowonly = true
}

return function(t)
	legitimate = t.legitimate
end