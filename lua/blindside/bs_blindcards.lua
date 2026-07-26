SMODS.Atlas({
	key = "bs_blindcards",
	path = "blindside/blindcards.png",
	px = 71,
	py = 95,
})

BLINDSIDE.Blind {
	key = "bs_final_pocket",
	atlas = "bs_blindcards",
	config = {extra = {}},
	upgrade = function(card) 
		if not card.ability.extra.upgraded then
			card.ability.extra.upgraded = true
		end
	end,
	hues = {"Purple"},
	legendary = true
}