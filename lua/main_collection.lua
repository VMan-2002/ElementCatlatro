local function lolTitles()
	local g_options = BLINDSIDE and {{"periodic", "compounds", "other", "planets"}, {}} or {{"periodic", "compounds", "other"}, {}}
	for k,v in pairs(g_options[1]) do
		g_options[2][k] = localize("ecattos_collection_jokers_"..v)
	end
	return g_options
end

local lolxd = nil
local function coolio(func, rows, args, n)
	local pool = {}
	
	for k,v in pairs(G.P_CENTER_POOLS.Joker) do
		if v.original_mod == SMODS.Mods.ElementCatlatro and func(v) then
			table.insert(pool, v)
		end
	end
	args.no_materialize = true
	args.h_mod = 0.95
	args.hide_single_page = true
	lolxd = n
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = SMODS.card_collection_UIBox(pool, rows, args)
	}
	lolxd = nil
end

local isBlindside = function(v)
	return BLINDSIDE and topuplib.getValueIndex(SMODS.ObjectTypes.bld_obj_blindside.cards, v.key)
end

G.FUNCS.your_collection_ecattos_page = function(e)
	local onum = e.cycle_config.current_option
	local opt = lolTitles()[1][onum]
	if opt == "periodic" then
		G.FUNCS.your_collection_jokers()
	elseif opt == "compounds" then
		coolio(function(v)
			return v.compound_formula
		end, {6,7,6}, {}, onum)
	elseif opt == "other" then
		coolio(function(v)
			return not v.compound_formula and not (v.atomic_number and v.atomic_number >= 1 and v.atomic_number <= 120) and not isBlindside(v)
		end, {5,5,5}, {}, onum)
	elseif opt == "planets" then
		coolio(isBlindside, {6,7,6}, {}, onum)
	else
		print("this is not SWAGGY")
	end
end

uibox_generic_options_ref = create_UIBox_generic_options
create_UIBox_generic_options = function(t, ...)
	if lolxd then
		table.insert(t.contents, {n=G.UIT.R, config={align = "cm", padding = -0.2}, nodes={
		create_option_cycle({options = lolTitles()[2], w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_ecattos_page', current_option = lolxd, colour = G.ACTIVE_MOD_UI and (G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or G.C.RED, focus_args = {snap_to = true, nav = 'wide'}})
		}})
	end
	return uibox_generic_options_ref(t, ...)
end

create_UIBox_your_collection_ecattos_periodic = function()
	local rows = {
		{l = {s=1}, m = {p = 16.5}, r = {s=2}},
		{l = {s=3,e=4}, m = {p = 10.4}, r = {s=5,e=10}, r2 = {p = 0.5}},
		{l = {s=11,e=12}, m = {p = 10.4}, r = {s=13,e=18}, r2 = {p = 0.5}},
		{m = {s=19,e=36}},
		{m = {s=37,e=54}},
		{l = {s=55,e=56}, m = {p = 0.95}, r = {s=72,e=86}, r2 = {p = 0.4}},
		{l = {s=87,e=88}, m = {p = 0.95}, r = {s=104,e=118}, r2 = {p = 0.4}},
		{l = {s=119,e=120}, m = {p = 0.95}, r = {s=57,e=71}, r2 = {p = 0.4}},
		{l = {p = 3}, r = {s=89,e=103}}
	}
	local caws = {
		[1] = 2.46,
		[2] = 3.7,
		[6] = 6.23,
		[18] = 16.4,
		[15] = 13.9
	}
	local o = {"l", "m", "r", "r2"}
	
    args = args or {}
    args.w_mod = args.w_mod or 0.4
    args.h_mod = args.h_mod or 0.4
    args.card_scale = args.card_scale or 0.4
    local deck_tables = {}

    G.your_collection = {}
    for j = 1, #rows do
		local edges = {}
		for _,a in ipairs(o) do
			local x = rows[j][a]
			if x then
				if x.s then
					local cind = #G.your_collection + 1
					local count = (x.e or x.s) + 1 - x.s
					G.your_collection[cind] = CardArea(
						G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
						caws[count],
						args.h_mod*G.CARD_H,
						{card_limit = count + 0.01, type = args.area_type or 'title_2', highlight_limit = 0, collection = true, lr_padding = -1}
					)
					for i = x.s, x.e or x.s do
						local center = G.P_CENTERS["j_ecattos_element"..i]
						if not center then error("wowie "..i) end
						local card = Card(G.your_collection[cind].T.x + G.your_collection[cind].T.w/2, G.your_collection[cind].T.y, G.CARD_W*args.card_scale, G.CARD_H*args.card_scale, G.P_CARDS.empty, (args.center and G.P_CENTERS[args.center]) or center)
						if args.modify_card then args.modify_card(card, center, i, j) end
						G.your_collection[cind]:emplace(card)
					end
					table.insert(edges,
						{n=G.UIT.C, config={align = "c"..a, padding = -args.w_mod * G.CARD_W, no_fill = true}, nodes={
							{n=G.UIT.O, config={object = G.your_collection[cind]}}
						}}
					)
				else
					local space = Moveable(0,0,args.w_mod*x.p*G.CARD_W,0)
					space.states.drag.can = false
					table.insert(edges,
						{n=G.UIT.C, config={align = "c"..a, padding = 0.01, no_fill = true}, nodes={
							{n=G.UIT.O, config={object = space}}
						}}
					)
				end
			end
		end
		table.insert(deck_tables,
		{n=G.UIT.R, config={align = "cm", padding = 0.01, no_fill = true}, nodes=edges})
		if j == #rows then break end
		table.insert(deck_tables,
		{n=G.UIT.R, config={align = "cm", padding = 0.01, no_fill = true}, nodes={
			{n=G.UIT.O, config={object = Moveable(0,0,0,args.w_mod * G.CARD_W * 0.3)}}
		}})
	end
	table.insert(deck_tables, 1,
	{n=G.UIT.R, config={align = "cm", padding = -0.1, no_fill = true}, nodes={}})
	table.insert(deck_tables,
	{n=G.UIT.R, config={align = "cm", padding = -0.1, no_fill = true}, nodes={}})

	INIT_COLLECTION_CARD_ALERTS()

	local t = create_UIBox_generic_options({
		colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_colour or (G.ACTIVE_MOD_UI.ui_config or {}).colour),
		bg_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_bg_colour or (G.ACTIVE_MOD_UI.ui_config or {}).bg_colour),
		back_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_back_colour or (G.ACTIVE_MOD_UI.ui_config or {}).back_colour),
		outline_colour = G.ACTIVE_MOD_UI and ((G.ACTIVE_MOD_UI.ui_config or {}).collection_outline_colour or
			(G.ACTIVE_MOD_UI.ui_config or {}).outline_colour),


		back_func = (args and args.back_func) or G.ACTIVE_MOD_UI and "openModUI_"..G.ACTIVE_MOD_UI.id or 'your_collection', snap_back = args.snap_back, infotip = args.infotip,
		contents = {
		{n=G.UIT.R, config={align = "cm", padding = 0.4, r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables},
		{n=G.UIT.R, config={align = "cm", padding = -0.3}, nodes={
		create_option_cycle({options = lolTitles()[2], w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_ecattos_page', current_option = 1, colour = G.ACTIVE_MOD_UI and (G.ACTIVE_MOD_UI.ui_config or {}).collection_option_cycle_colour or G.C.RED, focus_args = {snap_to = true, nav = 'wide'}})
		}},
		}
	})
	return t
end

local collection_jokers_ref = create_UIBox_your_collection_jokers
function create_UIBox_your_collection_jokers(...)
	if G.ACTIVE_MOD_UI == SMODS.Mods.ElementCatlatro then
		return create_UIBox_your_collection_ecattos_periodic()
	end
	return collection_jokers_ref()
end