-- for cattos that don't do anything by themself (i.e. garbage)
-- also used for nonfunctional cattos with `disable_nonfunctional_cattos` enabled
SMODS.Rarity{ 
    key = "handmade",
    badge_colour = HEX("D2DBE2")
}
--for cattos that don't appear in shops, with power below epic/masterwork
--used for trans-Unbinilium cattos and Jimbonium
SMODS.Rarity{ 
	key = "safari",
	badge_colour = HEX("F2C74E")

}
--for non-Legendary cattos that don't appear in shops, with power above Rare.
--used for Titin (without Cryptid)
SMODS.Rarity { 
	key = "masterwork",
	badge_colour = HEX("774FCC"),

}
--for Strange Matter..
--..how does she spawn?
SMODS.Rarity {
	key = "strange",
	badge_color = HEX("ACF4B9")
}

function ishandmade(rarity, nonfunctional)
    if nonfunctional and SMODS.current_mod.config["disable_nonfunctional_cattos"] then
        return "ecattos_handmade"
    end
    return rarity or 3
end

function safari_rarity()
    --[[if next(SMODS.find_mod("Pokermon")) then
        return "poke_safari"
    end]]
    return "ecattos_safari"
end

function epic_rarity()
	local talisman = next(SMODS.find_mod("Talisman"))
    local cryptid  = next(SMODS.find_mod("Cryptid"))
    if talisman and cryptid then
        return "cry_epic"
    end
    return "ecattos_masterwork"
end

function exotic_rarity()    
	local talisman = next(SMODS.find_mod("Talisman"))
    local cryptid  = next(SMODS.find_mod("Cryptid"))
    if talisman and cryptid then
        return "cry_exotic"
    end
    return "ecattos_masterwork"
end