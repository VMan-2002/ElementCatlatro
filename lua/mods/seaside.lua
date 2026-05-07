for _,v in pairs({
	0,1,2,4,6,8,11,13,14,16,19,20,26,29,30,34,36,50,60,
	"compound_water",
	"purrcent",
	"bungy"
}) do
	local k
	if type(v) == "number" then
		k = "j_ecattos_element"..v
	else
		k = "j_ecattos_"..v
	end
	local center = SMODS.Centers[k]
	assert(center, "Not found "..k)
	center.pools = center.pools or {}
	local p = ({"uv_cside_common", "uv_cside_uncommon", "uv_cside_rare"})[center.rarity]
	if p then center.pools[p] = true end
end