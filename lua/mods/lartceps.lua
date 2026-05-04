
SMODS.Atlas({
	key = "lartceps",
	path = "mods/lartceps.png",
	px = 71,
	py = 95
})

SMODS.Consumable{
	set = 'unik_lartceps', 
	atlas = 'lartceps',
	cost = 0,
	pos = {x = 0, y = 0},
	key = 'lartceps_burner',
	config = {},
	can_use = function(self, card)
		return true
	end,
	no_doe = true,
	no_grc = true,
	no_ccd = true,
	use = function(self, card, area, copier)
		G.GAME.ecattos_lartceps_used = true
		G.E_MANAGER:add_event(Event({
			func = (function() play_sound("unik_gore6") return true end)
		}))
		for k,v in pairs(elementcattos.atomicnumber) do
			if k > 4 then
				for _, card in ipairs(find_joker(v)) do
					card:start_dissolve()
				end
				G.GAME.cry_banished_keys[v] = true
			end
		end
	end,
	in_pool = function()
		return (not G.GAME.ecattos_lartceps_used) and lartcepsCheck()
	end
}