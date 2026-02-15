elementcattos.radioglow_sprites = {
	default = "radioglow",
	yellow = "radioglow_yellow",
	teal = "radioglow_teal",
	radon = "radioglow_radon",
	purple = "radioglow_violet",
	extended = "radioglow_extended"
}

for k,v in pairs(elementcattos.radioglow_sprites) do
	elementcattos.radioglow_sprites[k] = love.graphics.newImage(NFS.read('data', SMODS.current_mod.path .. "assets/gfx/"..v..".png"))
end

SMODS.DrawStep {
	key = "radioglow",
	order = -950,
	conditions = {
		vortex = false
	},
	func = function(card, layer)
		if card.ecattos_radioglow == nil then
			local rd = elementcattos.isRadioactive(card)
			if not rd or not rd.glowrate then
				card.ecattos_radioglow = false
				return
			end
			card.ecattos_radioglow = {1/(rd.glowrate - 0.05), 1/rd.glowrate, {}, rd.spr or "default", rd.int or 0.9}
			if rd.spr ~= nil and not elementcattos.radioglow_sprites[rd.spr] then
				print("Radioglow sprite "..(rd.spr).." not found")
				card.ecattos_radioglow[4] = "default"
			end
		elseif card.ecattos_radioglow == false then return end
		
		local rg = card.ecattos_radioglow
		local dt = love.timer.getDelta()
		rg[1] = rg[1] + dt
		if rg[1] >= rg[2] then
			rg[1] = rg[1] - rg[2]
			table.insert(rg[3], {math.random() * 360, 2})
		end
		
		prep_draw(card, 1)
		love.graphics.scale(0.1, 0.1)
		local bmold = love.graphics.getBlendMode()
		local px = card.config.center.pixel_size
		local x = (px and px.x or 71) * 0.13
		local y = (px and px.y or 95) * 0.13
		local spr = elementcattos.radioglow_sprites[rg[4]]
		love.graphics.setBlendMode("add")
		for k,v in pairs(rg[3]) do
			v[2] = v[2] - dt
			local a = 1 - math.abs(v[2] - 1)
			love.graphics.setColor(rg[5],rg[5],rg[5],a)
			love.graphics.draw(spr, x, y, v[1], 1, 1, 32, 32)
		end
		if rg[3][1][2] < 0 then
			table.remove(rg[3], 1)
		end
		love.graphics.setColor(1,1,1,1)
		love.graphics.pop()
		love.graphics.setBlendMode(bmold)
	end
}