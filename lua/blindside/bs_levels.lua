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
    end,
    
    --colour = ,

    pos = {x = 0, y = 0},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bs_stakes',
    --sticker_atlas = 
}