SMODS.Atlas({
	key = "bs_stakes",
	path = "blindside/stakes.png",
	px = 29,
	py = 29,
})

SMODS.Stake{
    key = 'bs_ecattos_deck',

    applied_stakes = {'bld_red_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.modifiers.bs_ecattos_stake = true
		G.GAME.ecattos_bs_jokers_available = {{},{},{},{},{},{},{},{}}
		G.GAME.ecattos_bs_jokers_seen = {{},{},{},{},{},{},{},{}}
		for k,v in pairs(SMODS.Blinds) do
			if v.ecattos_conf.bs_joker then
				table.insert(G.GAME.ecattos_bs_jokers_available[v.ecattos_conf.tier], v.key)
			end
		end
    end,
    
    --colour = ,

    pos = {x = 0, y = 0},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bs_stakes',
    --sticker_atlas = 
}