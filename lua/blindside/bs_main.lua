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

SMODS.Atlas({
	key = "planets",
	path = "blindside/planets.png",
	px = 71,
	py = 95
})
elementcattos.moon_in_pool = function(self, args)
	if next(SMODS.find_card(self.ecattos_conf.owner_key, true)) then
		return true
	end
	return SMODS.pseudorandom_probability(card, 'ecattos_moon_in_pool', 17, 20)
	--return math.random() > 0.85 --why are we using unseeded rng :sob:
end
elementcattos.Bs_Planet = function(d)
	d.rarity = d.rarity or "bld_trinket"
	d.cost = d.cost or 15
	d.atlas = d.atlas or "planets"
	d.not_in_booster = true
	d.loc_txt = d.loc_txt or {
		name = string.upper(string.sub(d.key, 1, 1)) .. string.sub(d.key, 2)
	}
	d.key = (d.keyprefix or "planet_") .. d.key
	d.keyprefix = nil
	local ret = SMODS.Joker(d)
	table.insert(SMODS.ObjectTypes.bld_obj_blindside.cards, ret.key)
	return ret
end
elementcattos.Bs_Moon = function(d)
	d.rarity = d.rarity or "bld_keepsake"
	d.cost = d.cost or 6
	d.atlas = d.atlas or "planets"
	d.not_in_booster = true
	d.keyprefix = "moon_"
	d.ecattos_conf.owner_key = "j_ecattos_planet_"..d.ecattos_conf.moon_of
	d.in_pool = d.in_pool or elementcattos.moon_in_pool
	return elementcattos.Bs_Planet(d)
end

local rq = {
	"bs_planets_inner_solar_system",
	"bs_planets_outer_solar_system",
	"bs_planets_hoax_objects",
	"modifiers/bs_edition_crescent"
}

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