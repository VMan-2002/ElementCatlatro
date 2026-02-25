elementcattos.worldendanim = {
	class = Moveable:extend(),
	play = function(n)
		elementcattos.worldendanim.instance = elementcattos.worldendanim.class(n)
		G.CONTROLLER.locks.ecattos_worldend = true
	end
}
local WorldEndAnim = elementcattos.worldendanim.class

SMODS.Sound {
	key = "music_ecattos_silent",
	path = "music_silent.ogg",
	select_music_track = function(self) return (elementcattos.worldendanim.instance) and math.huge end,
	no_collection = true
}

local wipeoff_ref = G.FUNCS.wipe_off
G.FUNCS.wipe_off = function(...)
	G.E_MANAGER:add_event(Event({
		trigger = 'after',
		delay = 0,
		no_delete = true,
		timer = 'REAL',
		func = function()
			elementcattos.worldendanim.instance = nil
			return true
		end
	}))
	wipeoff_ref(...)
end

WorldEndAnim.GameOver = function()
	G.CONTROLLER.locks.ecattos_worldend = false
	if false then --TESTING
		elementcattos.worldendanim.instance = nil
		return
	end
	check_for_unlock({ecattos_worldend = true})
	-- yoink from ellejokers
	G.STATE = G.STATES.GAME_OVER
	if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
		G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
	end
	G:save_settings()
	G.FILE_HANDLER.force = true
	G.STATE_COMPLETE = false
end

elementcattos.WorldEndAnims = {
	earth_explodes = {
		events = {
			{
				0, function(self)
					self.vars.earth = self:addAnimObject({elementcattos.loadGraphic("worldend/earth"),
						ox = 202, oy = 202,
						x = 10, y = 6
					})
					self.vars.moon = self:addAnimObject({elementcattos.loadGraphic("worldend/moon"),
						ox = 76, oy = 76,
						x = 14, y = 2
					})
				end
			}, {
				1.2, function(self)
					self:removeAnimObject(self.vars.earth)
					
					self.vars.pieces = {}
					local piece = elementcattos.loadGraphic("worldend/asteroid")
					for i = 1, 100 do
						local r = math.random() * 360
						local s = math.random() * 10
						table.insert(self.vars.pieces, self:addAnimObject({piece,
							ox = 150, oy = 150,
							vx = math.cos(r) * s,
							vy = math.sin(r) * s,
							sx = 0.3 + (math.random() * 0.1),
							r = math.random() * 360,
							vr = (0.5 - math.random()) * 20,
							x = 10, y = 6
						}))
					end
					
					self.vars.moon.vr = 1
					self.vars.moon.vx = 1
					self.vars.moon.vy = -1
					
					self.vars.flash = self:addAnimObject({elementcattos.loadGraphic("worldend/zoomcloud0"),
						x = 10, y = 6,
						xs = 0.1, ys = 0.1,
						vsx = 0.15, vsy = 0.15,
						ox = 256, oy = 256,
						col = {1,0.8,0.7,1},
						vcol = {0,-0.02,-0.05,-0.05},
						blend = "add"
					})
					play_sound("ecattos_explode")
				end
			}, {
				6, WorldEndAnim.GameOver
			}
		}
	}
}

function WorldEndAnim:init(anm)
	Moveable.init(self, 0, 0, 90, 90)
	self.states.drag.can = false
	self.animobjects = {}
	self.timer = 0
	self.vars = {}
	local a = elementcattos.WorldEndAnims[anm or "earth_explodes"]
	self.events = topuplib.tableShallowCopy(a.events)
	self.animupdate = a.update or topuplib.returnFalse
end

--Initial scale XY are multiplied by 0.01
function WorldEndAnim:addAnimObject(obj)
	obj.x = obj.x or 0
	obj.vx = obj.vx or 0
	obj.y = obj.y or 0
	obj.vy = obj.vy or 0
	obj.r = obj.r or 0
	obj.vr = obj.vr or 0
	obj.sx = (obj.sx or 1) * 0.01
	obj.vsx = obj.vsx or 0
	obj.sy = (obj.sy and obj.sy * 0.01) or obj.sx
	obj.vsy = obj.vsy or 0
	obj.kx = obj.kx or 0
	obj.vkx = obj.vkx or 0
	obj.ky = obj.ky or 0
	obj.vky = obj.vky or 0
	obj.blend = obj.blend or "alpha"
	obj.col = obj.col or {1,1,1,1}
	obj.vcol = obj.vcol or {0,0,0,0}
	self.animobjects[#self.animobjects + 1] = obj
	return obj
end

function WorldEndAnim:removeAnimObject(obj)
	return table.remove(self.animobjects, topuplib.getValueIndex(self.animobjects, obj))
end

function WorldEndAnim:draw()
	local dt = love.timer.getDelta()
	self.timer = self.timer + dt
	if next(self.events) and self.events[1][1] <= self.timer then
		self.events[1][2](self)
		table.remove(self.events, 1)
		print("Anim event play, "..tostring(#self.events).." left")
	end
	
	prep_draw(self, 1)
	local bmold = love.graphics.getBlendMode()
	love.graphics.setColor(0,0,0,1)
	love.graphics.rectangle("fill",-99,-99,999,999)
	self:animupdate()
	for k,v in pairs(self.animobjects) do
		v.x = v.x + (v.vx * dt)
		v.y = v.y + (v.vy * dt)
		v.r = v.r + (v.vr * dt)
		v.sx = v.sx + (v.vsx * dt)
		v.sy = v.sy + (v.vsy * dt)
		v.kx = v.kx + (v.vkx * dt)
		v.ky = v.ky + (v.vky * dt)
		v.col[1] = v.col[1] + (v.vcol[1] * dt)
		v.col[2] = v.col[2] + (v.vcol[2] * dt)
		v.col[3] = v.col[3] + (v.vcol[3] * dt)
		v.col[4] = v.col[4] + (v.vcol[4] * dt)
		love.graphics.setColor(v.col)
		love.graphics.setBlendMode(v.blend)
		love.graphics.draw(v[1], v.x, v.y, v.r, v.sx, v.sy, v.ox, v.oy, v.kx, v.ky)
	end
	love.graphics.pop()
	love.graphics.setColor(1,1,1,1)
	love.graphics.setBlendMode(bmold)
end