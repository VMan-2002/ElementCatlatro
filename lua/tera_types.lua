--[[type_sticker_applied = function(card)
  if not card then return false end
  if card.ability.grass_sticker then
    return "Grass"
  elseif card.ability.fire_sticker then
    return "Fire"
  elseif card.ability.water_sticker then
    return "Water"
  elseif card.ability.lightning_sticker then
    return "Lightning"
  elseif card.ability.psychic_sticker then
    return "Psychic"
  elseif card.ability.fighting_sticker then
    return "Fighting"
  elseif card.ability.colorless_sticker then
    return "Colorless"
  elseif card.ability.dark_sticker then
    return "Dark"
  elseif card.ability.metal_sticker then
    return "Metal"
  elseif card.ability.fairy_sticker then
    return "Fairy"
  elseif card.ability.dragon_sticker then
    return "Dragon"
  elseif card.ability.earth_sticker then
    return "Earth"
  else
    return false
  end
end]]
local function in_list(list, value)
    for _, v in ipairs(list) do
        if v == value then
            return true
        end
    end
    return false
end

local poketype_list = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth"}
local fire_types = { 1, 8, 11, 19 }
local grass_types = { 6, 7 }
local water_types = { }
local lighting_types = { 3, 29, 60, 79 }
local psychic_types = { 34, 43 }
local fighting_types = { 37, 38, 55, 56 }
local normal_types = { 2, 5, 10, 18, 36, 54 }
local dark_types = { 9, 15, 16, 17, 33, 35, 53 }
local fairy_types = { }
local earth_types = { 4, 12, 20 } --also 57 to 71, minus the gay boy (60)
--defalt is metal for <= 82 or dragon for >= 83
local create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
	local n = card.ability.name
	local a = card.ability.atomic_number or -1
	if n == "water" then
		card.ability.water_sticker = true
	end
	if n == "neodymium_magnet" or in_list(lighting_types, a) then 
	if a == -1 then return end
	if a >= 57 and a <= 71 and not a == 60 then card.ability.earth_sticker = true
    else if a <= 82 then card.ability.metal_sticker = true
		else card.ability.dragon_sticker = true end
	end
