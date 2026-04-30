
SMODS.JimboQuip({
	key = "bs_lose",
	extra = {
		center = "j_ecattos_element1"
	},
	filter = function(self, type)
		if G.GAME.modifiers.bs_ecattos_stake then
			local k_base, i = string.sub(G.GAME.blind.name, 4) .. "_lose", 1
			while G.localization.misc.quips[k_base .. i] do
				i = i + 1
			end
			if i == 1 then return false end
			self.extra.text_key = i == 2 and (k_base .. "1") or (k_base .. math.random(i - 1))
			self.extra.center = G.P_BLINDS[G.GAME.blind.name].ecattos_conf.my_center or "j_ecattos_element0"
			return true, {override_base_checks = true, weight = 400}
		end
	end
})