local names, ids, card
local selectedItem = 1

local confirm = topuplib.addUniqueFunc(function(arg)
	local toCreate = elementcattos.compounds[ids[selectedItem]]
	local formula = toCreate[1]
	local inputs = elementcattos.hasFormula(formula, G.jokers.highlighted)
	if not inputs then
		inputs = elementcattos.hasFormula(formula)
	end
	if inputs then
		--consume the inputs
		local resultEdition
		for k,v in pairs(inputs) do
			if not resultEdition then
				resultEdition = v.edition and v.edition.key
			end
			v:shatter()
		end
		--create output
		if type(toCreate[2]) == "table" then
			toCreate[2].func(resultEdition, inputs)
		else
			SMODS.add_card({
				set = "Joker",
				key = toCreate[2],
				edition = resultEdition
			})
		end
		--consume compound creator
		card.ability.extra.ready = false
		G.FUNCS.use_card({
			config = {ref_table = card}
		})
		G.FUNCS.exit_overlay_menu()
	end
end)

local UIBox_ecatto_compound_creator = function(_card)
	card = _card
	names, ids, selectedItem = {}, {}, 1
	for k,v in pairs(elementcattos.compounds) do
		if elementcattos.hasFormula(v[1]) then
			local name = tostring(type(v[2]) == "table" and localize(v[2].name) or topuplib.nameFromKey(v[2]))
			names[#names+1] = name .. ": " .. elementcattos.formatFormula(v[1], true)
			ids[#names] = k
		end
	end
	local thing0 = create_option_cycle({
		label = localize("ecattos_compoundcreator_tocreate"),
		options = names,
		current_option = 1,
		w = 7,
		opt_callback = topuplib.addUniqueFunc(function(arg)
			selectedItem = arg.cycle_config.current_option
		end)
	})
	local confirmbtn = UIBox_button({button = confirm, label = {localize("ecattos_compoundcreator_confirm")}, minw = 5, focus_args = {snap_to = true}})
	
	if #names == 0 then
		names[1] = "None"
		confirmbtn = nil
	end

	local t = create_UIBox_generic_options({ contents = {
		thing0,
		confirmbtn
	}})
	return t
end

elementcattos.ui_compound_creator = function(self, card)
	if not card.ability.extra.ready then return end
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu{
		definition = UIBox_ecatto_compound_creator(card),
	}
	topuplib.music = "ecattos"
end