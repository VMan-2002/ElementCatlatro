elementcattos.radioglow_sprites = {
	default = "radioglow",
	yellow = "radioglow_yellow",
	teal = "radioglow_teal",
	radon = "radioglow_radon",
	violet = "radioglow_violet",
	lime = "radioglow_lime",
	pink = "radioglow_pink",
	white = "radioglow_white",
	
	extended = "radioglow_extended",
	sun = SMODS.current_mod.config.old_planet_sprites and "radioglow_sun" or "radioglow_sun_new",
	nibiru = "radioglow_nibiru",
	compoundcreator = "radioglow_compoundcreator",
	bromine = "radioglow_bromine"
}

elementcattos.radioglow_pride_f = {
	default = true,
	yellow = true,
	teal = true,
	radon = true,
	violet = true,
	lime = true,
	pink = true,
	white = true
}

elementcattos.radioglow_pride_r = topuplib.tableShallowCopy(elementcattos.radioglow_pride_f)
elementcattos.radioglow_pride_r.sun = true

for k,v in pairs(elementcattos.radioglow_sprites) do
	elementcattos.radioglow_sprites[k] = elementcattos.loadGraphic("radioglow/"..v)
end

elementcattos.purrcentCopyRadioactive = function(src, target)
	target.ecattos_radioglow = topuplib.tableShallowCopy(src.ecattos_radioglow)
	target.children.center:set_sprite_pos({x=4,y=1})
	if elementcattos.companieswhen then
		target.ecattos_radioglow_rainbow = {0,0,0}
	end
end

local rb_update = elementcattos.companieswhen and function(card)
	local b = card.ecattos_radioglow_rainbow
	if not b.n then
		b.n = (-card.ID % 3) + 1
		b[b.n == 3 and 1 or (b.n + 1)] = 1
		b.f = 1
	end
	b[b.n] = b[b.n] + (love.timer.getDelta() * b.f)
	if (b.f == 1 and b[b.n] >= 1) then
		b[b.n] = 1
		b.f = -1
	elseif b.f == -1 and b[b.n] <= 0 then
		b[b.n] = 0
		b.f = 1
	else
		return
	end
	b.n = b.n == 1 and 3 or (b.n - 1)
end or topuplib.returnFalse
local rb_color = elementcattos.companieswhen and function(i,card)
	return card.ecattos_radioglow_rainbow[1] * i, card.ecattos_radioglow_rainbow[2] * i, card.ecattos_radioglow_rainbow[3] * i
end or function(i) return i,i,i end

SMODS.DrawStep {
	key = "radioglow",
	order = -950,
	conditions = {
		vortex = false
	},
	func = function(card, layer)
		if card.ecattos_radioglow == nil then
			local rd = elementcattos.isRadioactive(card, true)
			if not rd or not rd.glowrate then
				card.ecattos_radioglow = false
				return
			end
			card.ecattos_radioglow = {1/(rd.glowrate - 0.05), 1/rd.glowrate, {}, rd.spr or "default", rd.int or 0.9, rd.blend or "add"}
			if elementcattos.companieswhen then
				card.ecattos_radioglow_rainbow = {0,0,0}
				if elementcattos.radioglow_pride_f[card.ecattos_radioglow[3]] then
					card.ecattos_radioglow[3] = "white"
				end
			end
			if rd.spr ~= nil and not elementcattos.radioglow_sprites[rd.spr] then
				print("Radioglow sprite "..(rd.spr).." not found")
				card.ecattos_radioglow[4] = "default"
			end
			if card.area and not topuplib.viewedFromCollection(card) then
				for k,v in pairs(card.area.cards) do
					if v.config.center_key == "j_ecattos_purrcent" then
						elementcattos.purrcentCopyRadioactive(card, v)
					end
				end
			end
		elseif card.ecattos_radioglow == false or topuplib.detail == 1 then return end
		
		local rg = card.ecattos_radioglow
		local dt = love.timer.getDelta()
		rg[1] = rg[1] + dt
		if rg[1] >= rg[2] then
			rg[1] = rg[1] - rg[2]
			table.insert(rg[3], {math.random() * 360, 2})
		end
		rb_update(card)
		local r,g,b = rb_color(rg[5], card)
		
		prep_draw(card, 1)
		love.graphics.scale(0.1, 0.1)
		local bmold = love.graphics.getBlendMode()
		local px = card.config.center.pixel_size
		local scale = card.VT.w / G.CARD_W
		local x = (px and px.x or 71) * 0.13 * scale
		local y = (px and px.y or 95) * 0.13 * scale
		local spr = elementcattos.radioglow_sprites[rg[4]]
		love.graphics.setBlendMode(rg[6])
		for k,v in pairs(rg[3]) do
			v[2] = v[2] - dt
			local a = 1 - math.abs(v[2] - 1)
			love.graphics.setColor(r,g,b,a)
			love.graphics.draw(spr, x, y, v[1], scale, scale, 32, 32)
		end
		if rg[3][1][2] < 0 then
			table.remove(rg[3], 1)
		end
		love.graphics.setColor(1,1,1,1)
		love.graphics.pop()
		love.graphics.setBlendMode(bmold)
	end
}