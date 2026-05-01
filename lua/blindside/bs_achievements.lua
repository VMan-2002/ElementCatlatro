SMODS.Achievement {
	key = "bs_defeat_superboss",
	unlock_condition = function(self, args)
		return args.win_custom and G.GAME.starting_params.ecattos_deck
	end,
	bypass_all_unlocked = topuplib.debug
}