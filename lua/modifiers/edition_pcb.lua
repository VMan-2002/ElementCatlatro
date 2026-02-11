local a = 0
local shd = SMODS.Shader {
	key = "pcb",
	path = "pcb.fs",
	send_vars = function(spr, card)
		return card.tilt_var and {
			tilt = {
				card.tilt_var.mx * 0.01, card.tilt_var.my * 0.01
			}
		}
	end
}
local pcb_overlay_img = love.graphics.newImage(NFS.read('data', SMODS.current_mod.path .. "assets/gfx/pcb_overlay.png"))
pcb_overlay_img:setFilter("nearest")

local inject_ref = SMODS.injectItems
function SMODS.injectItems(...)
	inject_ref(...)
	G.SHADERS.ecattos_pcb:send("pcb_overlay", pcb_overlay_img)
end

SMODS.Edition {
	key = "pcb",
	shader = "pcb",
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.ecattos_stabilized}}
	end,
	calculate = function(self, card, context)
		if context.end_of_round then
			card.ability.ecattos_stabilized = card.ability.ecattos_stabilized - 1
			if card.ability.ecattos_stabilized <= 0 then
				card.ability.ecattos_stabilized = false
			end
		end
	end
}