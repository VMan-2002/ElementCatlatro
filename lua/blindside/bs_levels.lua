SMODS.Atlas({
	key = "bs_stakes",
	path = "blindside/stakes.png",
	px = 29,
	py = 29,
})

function elementcattos.bs_stake_setup()
	G.GAME.modifiers.bs_ecattos_stake = true
	G.GAME.ecattos_bs_jokers_available = {{},{},{},{},{},{},{},{}}
	G.GAME.ecattos_bs_jokers_stock = {{},{},{},{},{},{},{},{}}
	for k,v in pairs(SMODS.Blinds) do
		if v.ecattos_conf and v.ecattos_conf.bs_joker then
			table.insert(G.GAME.ecattos_bs_jokers_stock[v.ecattos_conf.tier], v.key)
		end
	end
end

SMODS.Stake{
    key = 'bs_ecattos_deck',

    applied_stakes = {'bld_red_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = elementcattos.bs_stake_setup,
    
    --colour = ,

    pos = {x = 0, y = 0},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bs_stakes',
    --sticker_atlas = 
}

--[[SMODS.Stake{
    key = 'bs_ecattos_deck2',

    applied_stakes = {'bs_ecattos_deck'},
    prefix_config = {above_stake = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
		G.GAME.modifiers.bs_ecattos_stake_exlv = 1
	end,
    
    --colour = ,

    pos = {x = 0, y = 0},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bs_stakes',
    --sticker_atlas = 
}]]