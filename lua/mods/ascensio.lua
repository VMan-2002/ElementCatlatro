local myExotics = {
	119 = {function(self,card,context)
		
	end, ex = {echips = 1.2, echips_gain = 0.1}, loc_vars = {"echips", "echips_gain"}}
}

for k,v in pairs(myExotics) do
	if type(v.loc_vars) == "table" then
		v.loc_vars = elementcattos.simpleLocVars(v.loc_vars)
	end
	local original_key = "j_ecattos_element"..k
	local original_center = SMODS.Centers[original_key]
	SMODS.Joker {
		key = "lockin" .. k,
		atlas = "elements", --TODO: lock-innized atlas
		pos = original_center.pos,
		cost = 50,
		rarity = "cry_exotic",
		pronouns = original_center.pronouns
		config = v.ex and {extra = ex},
		loc_vars = v.loc_vars or original_center.loc_vars,
		ecattos_conf = {
			original = original_key
		},
		calculate = v[1] or original_center.calculate
	}
	
end

topuplib.afterInit(function()
	for k,v in pairs(myExotics) do
		Ascensio.Ascensionable["j_ecattos_element"..k] = "j_ecattos_lockin"..k
	end
end)