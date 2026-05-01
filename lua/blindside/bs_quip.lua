elementcattos.bs_quip_voices = {
	snd = {
		jimbo = {str = "voice", max = 11},
		bit = {str = "ecattos_bit", max = 1},
		vm = {str = "ecattos_vm"}
	},
	presets = {
		j_ecattos_element22 = {snd = "bit", pitch = 0.8}
	}
}

for k,v in pairs({"bit"}) do
	for i = 1, elementcattos.bs_quip_voices.snd[v].max or 8 do
		SMODS.Sound({
			key = v .. i,
			path = "voice_" .. v .. i .. ".ogg"
		})
	end
end

--not sure why i have to do this when smods could just uhhhhhhh
local play_sound_ref = play_sound
function play_sound(a, ...)
	if a == "ecattos_bs_quip_talk" and elementcattos.bs_quip_voices then
		return elementcattos.speak_you_fool()
	end
	return play_sound_ref(a, ...)
end

elementcattos.speak_you_fool = function()
	local p = elementcattos.bs_quip_voices.presets[elementcattos.bs_quip_voices.speakname] or {}
	local v = elementcattos.bs_quip_voices.snd[p.snd] or elementcattos.bs_quip_voices.snd.jimbo
	play_sound_ref(
		v.str .. math.random(1, v.max or 8),
		(v.pitch or 1.1) * (0.9 + (math.random() * 0.2)),
		v.vol or 0.5
	)
end

--1: condition, 2: values to apply to "bs_lose" quip's "extra" table
elementcattos.lose_quips_special_conditions = {
	{ --Lose against Tantalum after defeating Titanium
		function(enemyname)
			return enemyname == "bld_ecattos_bs_j73" and false --todo
		end,
		{text_key = "ecattos_bs_j73_after22_lose"}
	}
}

SMODS.JimboQuip({
	key = "bs_lose",
	extra = {
		center = "j_ecattos_element1",
		sound = "ecattos_bs_quip_talk" --Don't change this
	},
	type = "loss",
	filter = function(self, type)
		if G.GAME.modifiers.bs_ecattos_stake then
			local k_base, i, mergevals = string.sub(G.GAME.blind.name, 4) .. "_lose", 1
			for k,v in pairs(elementcattos.lose_quips_special_conditions) do
				if v[1](G.GAME.blind.name) then
					mergevals = v[2]
					break
				end
			end
			while G.localization.misc.quips[k_base .. i] do
				i = i + 1
			end
			if i == 1 then return false end
			self.extra.text_key = i == 2 and (k_base .. "1") or (k_base .. math.random(i - 1))
			self.extra.center = G.P_BLINDS[G.GAME.blind.name].ecattos_conf.my_center or "j_ecattos_element0"
			if mergevals then
				for k,v in pairs(mergevals) do
					SMODS.JimboQuips.ecattos_bs_lose.extra[k] = v
				end
			end
			elementcattos.bs_quip_voices.speakname = self.extra.center
			return true, {override_base_checks = true, weight = 400}
		end
	end
})