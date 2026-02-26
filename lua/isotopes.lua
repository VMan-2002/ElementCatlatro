--Dont register unique Jokers for isotopes, if we do, that would result in probably infinite registered Jokers
elementcattos.gimmeIsotope = function(element, isotope)
	local key = "j_ecattos_element"..tostring(element)
	if type(element) == "string" then
		local s = string.lower(element)
		for k,v in pairs(elementcattos.atomicnumber) do
			local center = G.P_CENTERS[v]
			if center.loc_txt and string.lower(center.loc_txt.name) == s or string.lower(center.element_symbol) == s then
				key = v
				break
			end
		end
		return print("Could not find an element by \""..element.."\"")
	elseif not elementcattos.atomicnumber[element] then
		key = "j_ecattos_element_extended"
	end
	local c = SMODS.add_card({
		key = key,
		set = "Joker",
		no_edition = true
	})
	if key == "j_ecattos_element_extended" then
		c.ability.extra.atomic_number = element
	end
end