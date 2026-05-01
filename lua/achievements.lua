SMODS.Achievement {
	key = "windeck_ecattos",
	unlock_condition = function(self, args)
		return args.win_custom and G.GAME.starting_params.ecattos_deck
	end,
	bypass_all_unlocked = topuplib.debug
}
SMODS.Achievement {
	key = "compoundcreator",
	unlock_condition = function(self, args)
		return args.ecattos_compoundcreator
	end,
	bypass_all_unlocked = topuplib.debug
}
SMODS.Achievement {
	key = "worldend",
	hidden_name = true,
	unlock_condition = function(self, args)
		return args.ecattos_worldend
	end,
	bypass_all_unlocked = topuplib.debug
}