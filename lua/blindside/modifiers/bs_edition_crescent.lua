local shd = SMODS.Shader {
	key = "crescent",
	path = "crescent.fs",
	send_vars = function(spr, card)
		return {
			tilt = card.tilt_var and {
				(card.tilt_var.mx - 960) * 0.006, (card.tilt_var.my - 440) * 0.006
			},
			phase_time = love.timer.getTime() % 17.5
		}
	end
}
local moon_normal_img = love.graphics.newImage(NFS.read('data', SMODS.current_mod.path .. "assets/gfx/crescent_normal.png"))
--moon_normal_img:setFilter("nearest")
local moon_environment_img = love.graphics.newImage(NFS.read('data', SMODS.current_mod.path .. "assets/gfx/crescent_environment.png"))

local inject_ref = SMODS.injectItems
function SMODS.injectItems(...)
	inject_ref(...)
	G.SHADERS.ecattos_crescent:send("moon_normal", moon_normal_img)
	G.SHADERS.ecattos_crescent:send("moon_environment", moon_environment_img)
end

local crescent = SMODS.Edition {
	key = "crescent",
	shader = "crescent",
    atlas = 'bld_blindrank',
    pos = {x = 3, y = 0},
    in_shop = false,
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
	end,
	prefix_config = {
		atlas = false
	}
}

table.insert(SMODS.ObjectTypes.bld_obj_blindside.cards, crescent.key)