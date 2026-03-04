

elementcattos.gimmeIsotope = function(element, neutrons, electrons, antimuons)
	local key = "j_ecattos_element"..tostring(element)
	if type(element) == "string" then
		local s = string.lower(element)
		for k,v in pairs(elementcattos.atomicnumber) do
			local center = G.P_CENTERS[v]
			if center.loc_txt and string.lower(center.loc_txt.name) == s or string.lower(center.element_symbol) == s then
				element = s
				key = v
				break
			end
		end
		return print("Could not find an element by \""..element.."\"")
	elseif not elementcattos.atomicnumber[element] then
		key = "j_ecattos_element_extended"
	end
	neutrons = neutrons or G.P_CENTERS[key].ecattos_conf.neutrons
	electrons = electrons or 0 --TODO
	if protons == 0 then electrons = 1 end
	antimuons = antimuons or 0
	local c = SMODS.add_card({
		key = key,
		set = "Joker",
		no_edition = true
	})
	if key == "j_ecattos_element_extended" then
		c.ability.extra.atomic_number = element
	end
	c.ability.extra.neutrons = neutrons
	elementcattos.applyIsotopeSprite(c)
	return c
end