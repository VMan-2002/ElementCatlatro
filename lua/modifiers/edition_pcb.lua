local shd = SMODS.Shader {
	key = "pcb",
	path = "pcb.fs",
	send_vars = function(spr, card)
		return card.tilt_var and {
			tilt = {
				card.tilt_var.mx * 0.02, card.tilt_var.my * 0.02
			}
		}
	end
}
local pcb_overlay_img = topuplib.loadGraphic("pcb_overlay", {filter = {"nearest"}})

local inject_ref = SMODS.injectItems
function SMODS.injectItems(...)
	inject_ref(...)
	G.SHADERS.ecattos_pcb:send("pcb_overlay", pcb_overlay_img)
end

SMODS.Edition {
	key = "pcb",
	shader = "pcb",
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function(self, card, context)
	end
}