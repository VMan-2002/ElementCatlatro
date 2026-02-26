local registryMenuAddEntry = function(tbl, dat)
	if dat.no_collection then return end
	local c = G.P_CENTERS[dat.center or dat.result_center] or G.P_CENTERS.c_ecattos_compoundcreator
	dat.mod = dat.mod or SMODS.find_mod("ElementCatlatro")
	
	if not topuplib.isDiscovered("ECattos_Compound", dat.key) then
		dat.collection_atlas = "topuplib_common"
		dat.collection_pos = {x=1,y=0}
		dat.collection_soul_pos = {x=0,y=0}
	end
	
	table.insert(tbl, {
		unlocked = true,
		set = "ECattos_Compound",
		name = dat.key,
		key = dat.key,
		discovered = true,
		unlocked = true,
		atlas = dat.collection_atlas or c.atlas or c.set or "Joker",
		pos = dat.collection_pos or c.pos or {x=0,y=0},
		soul_pos = dat.collection_soul_pos or c.soul_pos,
		mod = dat.mod,
		original_mod = dat.mod,
		_order = dat.collection_order or math.huge,
		pixel_size = dat.collection_pixel_size or c.pixel_size,
		config = {}
	})
end

G.FUNCS.your_collection_ecattos_compounds = function(e)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu{
    definition = create_UIBox_your_collection_ecattos_compounds(),
  }
end

create_UIBox_your_collection_ecattos_compounds = function()
	local collect = {}
	for k,v in pairs(elementcattos.compounds) do
		registryMenuAddEntry(collect, {
			key = k,
			no_collection = v[2].no_collection or v.no_collection,
			mod = v[2].mod,
			result_center = type(v[2]) == "table" and v[2].collection_center or v[2] or nil,
			collection_atlas = v[2].collection_atlas,
			collection_pos = v[2].collection_pos,
			collection_soul_pos = v[2].collection_soul_pos,
			collection_order = v[2].collection_order,
			collection_pixel_size = v[2].collection_pixel_size,
		})
	end
    return SMODS.card_collection_UIBox(collect, {6,7,6}, {
        snap_back = true,
        h_mod = 1.03,
        hide_single_page = true,
        collapse_single_page = true,
		back_func = "your_collection_other_gameobjects",
		modify_card = function(card, center)
			if not topuplib.isDiscovered("ECattos_Compound", center.key) then
				card.ecattos_collection_not_discovered = true
			end
		end
    })
end