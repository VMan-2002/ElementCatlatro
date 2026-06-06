--	so uhh yeah
--	cattos this is!

local mod = SMODS.current_mod
local config = mod.config
elementcattos.loc_txt_planet = function(d)
	d.text = d.text and topuplib.asub(d.text) or nil
	local xline = {}
	--TODO: localize these currently english-only strings
	--not relevant for planets
	--[[if d.anum then xline[1] = "Atomic number: " .. tostring(d.anum) end
	if d.sym then xline[#xline + 1] = "Symbol: " .. d.sym end
	if d.compound then
		xline[#xline + 1] = "Formula: " .. (elementcattos.compounds[d.compound] and elementcattos.formatFormula(elementcattos.compounds[d.compound][1]) or ("INVALID ("..tostring(d.compound)..")"))
		--todo: why does this crash?
		--d.unlock = d.unlock or localize("ecattos_unlock_compound")
	end]]
	if d.extra then
		if type(d.extra) == "table" then
			for k,v in ipairs(d.extra) do
				xline[#xline + 1] = v
			end
		else
			xline[#xline + 1] = d.extra
		end
	end
	if #xline ~= 0 then
		d.text = d.text or {}
		d.text[#d.text + 1] = "{C:inactive}" .. table.concat(xline, ", ")
	end
	return {
		name = d.name,
		text = d.text,
		unlock = d.unlock
	}
end

if not SMODS.Rarities.bld_trinket then error("UPDATE BLINDSIDE!!!!!!!!!") end
local oldPlanet = config.old_planet_sprites

SMODS.Atlas({
	key = "planets",
	path = oldPlanet and "blindside/planets-old.png" or "blindside/planets.png",
	px = 71,
	py = 95
})
SMODS.Atlas({
	key = "sun",
	path = oldPlanet and "blindside/sun-old.png" or "blindside/sun.png",
	px = 71,
	py = 95
})
--[[SMODS.Atlas({
	key = "sun_stellar",
	path = "blindside/sun-stellar.png",
	px = 71,
	py = 95
})]]
SMODS.Atlas({
	key = "bs_consumables",
	path = "blindside/consumables.png",
	px = 71,
	py = 95
})
SMODS.Atlas({
	key = "bs_jokers",
	path = "blindside/jokers.png",
	px = 34,
	py = 34
})
SMODS.Rarity {
	key = "bs_hypothetical", --Also used for hoax
	pools = {},
	badge_colour = G.C.BLACK,
	default_weight = 0
}
elementcattos.moon_in_pool = function(self, args)
	if next(SMODS.find_card(self.ecattos_conf.owner_key, true)) then
		return true
	end
	return SMODS.pseudorandom_probability(self, 'ecattos_moon_in_pool', 3, 20, nil, true)
end
elementcattos.moonsRemaining = function(key)
	local center = G.P_CENTERS[key]
	if not center.ecattos_conf or not center.ecattos_conf.child_keys then return {} end
	local result = {}
	for k,v in pairs(G.P_CENTERS[key].ecattos_conf.child_keys) do
		if not next(SMODS.find_card(v, true)) then result[#result+1] = v end
	end
	return result
end
elementcattos.Bs_Planet = function(d)
	d.rarity = d.rarity or "bld_trinket"
	d.cost = d.cost or 12
	d.atlas = d.atlas or "planets"
	d.not_in_booster = true
	d.loc_txt = d.loc_txt or {
		name = string.upper(string.sub(d.key, 1, 1)) .. string.sub(d.key, 2)
	}
	d.soul_pos = d.soul_pos or {x = d.pos.x, y = d.pos.y + 1}
	d.key = (d.keyprefix or "planet_") .. d.key
	d.keyprefix = nil
	if type(d.loc_vars) == "table" then
		d.loc_vars = elementcattos.simpleLocVars(d.loc_vars)
	end
	d.ecattos_conf = d.ecattos_conf or {}
	d.ecattos_conf.t_planet = true
	return elementcattos.Bs_Add(SMODS.Joker(d))
end
elementcattos.Bs_Moon = function(d)
	d.rarity = d.rarity or "bld_keepsake"
	d.cost = d.cost or 5
	d.not_in_booster = true
	d.keyprefix = "moon_"
	
	d.ecattos_conf.owner_key = string.sub(d.ecattos_conf.moon_of, 1, 2) ~= "j_" and ("j_ecattos_planet_"..d.ecattos_conf.moon_of) or d.ecattos_conf.moon_of
	
	local oconf = SMODS.Centers[d.ecattos_conf.owner_key].ecattos_conf
	oconf.child_keys = oconf.child_keys or {}
	
	d.in_pool = d.in_pool or elementcattos.moon_in_pool
	local r = elementcattos.Bs_Planet(d)
	table.insert(oconf.child_keys, r.key)
	return r
end
elementcattos.Bs_Add = function(obj)
	table.insert(SMODS.ObjectTypes.bld_obj_blindside.cards, obj.key)
	return obj
end
elementcattos.Bs_Pronoun = function(primary, classical)
	--[[if config.planet_pronoun == 0 then
		return
	end
	return (config.planet_pronoun == 1 and primary or classical) or primary]]
	return primary --Might remove this function idk
end

local rq = {
	"bs_util",
	
	--Planets
	"bs_planets_inner_solar_system",
	"bs_planets_outer_solar_system",
	"bs_planets_hoax_objects",
	
	--Others
	"bs_consumables",
	"bs_levels",
	"bs_patches",
	"bs_jokers",
	"bs_quip",
	"modifiers/bs_edition_crescent",
	--CardPronouns and "bs_pronouns" or false -- Handled in main lua file
}

--[[local edition_hook = BLINDSIDE.get_blindside_editions
function BLINDSIDE.get_blindside_editions()
	local r = edition_hook()
	r[#r+1] = "e_ecattos_crescent"
	return r
end]]

for i, v in ipairs(rq) do
	if v then
		local a = assert(SMODS.load_file("lua/blindside/"..v..".lua"))()
		if type(a) == "function" then
			a({
				legitimate = legitimate
			})
		end
	end
end