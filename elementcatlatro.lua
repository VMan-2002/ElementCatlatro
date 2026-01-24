--	so uhhh yeah
--	this is cattos!

local mod = SMODS.current_mod
local config = mod.config
--anticheat? okay
local legitimate = topuplib.debug and {titin = true, titin_recipe = {}} or nil
elementcattos = {
	loc_txt = function(d)
		d.text = d.text and topuplib.asub(d.text) or nil
		local xline = {}
		--TODO: localize these currently english-only strings
		if d.anum then xline[1] = "Atomic number: " .. tostring(d.anum) end
		if d.sym then xline[#xline + 1] = "Symbol: " .. d.sym end
		if d.compound then
			xline[#xline + 1] = "Formula: " .. (elementcattos.compounds[d.compound] and elementcattos.formatFormula(elementcattos.compounds[d.compound][1]) or ("INVALID ("..tostring(d.compound)..")"))
			--todo: why does this crash?
			--d.unlock = d.unlock or localize("ecattos_unlock_compound")
		end
		if d.extra then
			if type(d.extra) == "table" then
				for k,v in ipairs(d.extra) do
					xline[#xline + 1] = v
				end
			else
				xline[#xline + 1] = d.extra
			end
		end
		if #xline ~= 0 then
			d.text = d.text or {}
			d.text[#d.text + 1] = "{C:inactive}" .. table.concat(xline, ", ")
		end
		return {
			name = d.name,
			text = d.text,
			unlock = d.unlock
		}
	end,
	loc_txt_planet = function(d)
		return {name = d.name}
	end,
	--Radioactive
	isRadioactive = function(card)
		return elementcattos.radioactive(card.config.center.key) ~= nil
	end,
	fromyears = function(n)
		return n * 315570000
	end,
	fromminutes = function(n)
		return n * 60
	end,
	fromhours = function(n)
		return n * 3600
	end,
	fromdays = function(n)
		return n * 86400
	end,
	halflife = function(n)
		return math.floor((math.log(n) * 0.999) + (n * 0.001))
	end,
	--Cards
	defaultJokerCalculate = function(self, card, context)
		if context.joker_main and card.ability.extra then
			return {
				mult = card.ability.extra.mult,
				chips = card.ability.extra.chips,
				Xmult = card.ability.extra.xmult,
				Xchips = card.ability.extra.xchips
			}
		end
	end,
	simpleLocVars = function(properties)
		local prop_vars = ""
		for k,v in ipairs(properties) do
			prop_vars = prop_vars .. "c.ability.extra." .. v .. ","
		end
		return assert(loadstring([[
			return function(a,b,c) if not c.ability.extra then return end return {vars = {]]..prop_vars..[[}} end
		]]), "simpleLocTxt failed")()
	end,
	atomicnumber = {},
	tools = {},
	cardFromMod = function(card)
		return card.config.center and card.config.center.original_mod and card.config.center.original_mod.id == SMODS.Mods.ElementCatlatro.id
	end,
	modsupported = { -- Keys of jokers to consider "part of Element Catlatro" for Element Cattos deck
		j_ecattos_element1 = true
	},
	othercattos = { -- Keys of jokers that are cattos
	
	},
	getAtomicMass = function(card)
		if not card.config.center.element_base_mass then
			return nil
		end
		return card.config.center.element_base_mass + ((card.ability.extra and card.ability.extra.atomic_mass_offset) or 0)
	end,
	pronoun = function(n)
		if not CardPronouns then return end
		if CardPronouns.badge_types[n] then return n end
		return "ecatto_" .. n
	end,
	fallbacks = {
		"j_ecattos_element1", "j_ecattos_element2", "j_ecattos_element6", "j_ecattos_element8"
	},
	countJokers = function(key, isotope)
		--TODO: implement isotope lol
		-- (to, if specified, check if the joker is the right isotope)
		if not G.jokers then return 0 end
		local result = 0
		for k,v in pairs(G.jokers.cards) do
			if key == v.config.center_key then
				result = result + 1
			end
		end
		return result
	end,
	--Compounds
	compounds = {},
	formatFormula = function(formula, method)
		local result = ""
		for k,v in ipairs(formula) do
			if type(v) == "table" then
				if #v == 1 or v[2] == 1 then
					local c = elementcattos.compounds[v[1]]
					if not c then error("Compound subpart "..v[1].." does not exist") end
					result = result .. elementcattos.formatFormula(c[1], method)
				elseif #v == 2 then
					local subnum = ""
					local ns = tostring(v[2])
					result = result .. v[1] .. (method and ("("..ns..")") or topuplib.formatText({{ns, "small"}, {"", "inactive"}}))
				end
			else
				if type(v) == "string" and string.sub(v, 1, 1) == "_" then
					v = string.sub(v, 2)
				end
				result = result .. v
			end
		end
		return result
	end,
	hasFormula = function(formula, source)
		local inputs = {}
		local source = source or G.jokers.cards
		formula = topuplib.tableShallowCopy(formula)
		local count, element, iscompound
		for k,v in pairs(formula) do
			iscompound = false
			if type(v) == "table" then
				if #v == 1 then
					count = 1
					element = v[1]
					iscompound = true
				else
					count, element = v[2], v[1]
				end
			else
				local firstlet = string.sub(v, 1, 1)
				if firstlet == "_" then
					count = 0
				else
					count, element = 1, v
				end
			end
			if count ~= 0 then
				for k,v in ipairs(source) do
					if count ~= 0 and v.config.center.element_symbol == element and not inputs[k] then
						inputs[k] = v
						count = count - 1
					end
				end
				if count ~= 0 then
					if iscompound then
						for _,v2 in ipairs(elementcattos.compounds[element][1]) do
							table.insert(formula, v2)
						end
					else
						return
					end
				end
			end
		end
		return inputs
	end
}
--todo: element decaying and isotopes are gonna be a thing to figure out
elementcattos.radioactive = {
	ecatto_element82_214 = { --lead 214
		hands = elementcattos.halflife(elementcattos.fromminutes(27.06)),
		result = "ecatto_element83_214"
	},
	ecatto_element84 = { --polonium
		hands = elementcattos.halflife(elementcattos.fromdays(138.38)),
		result = "ecatto_element82_214"
	},
	ecatto_element86 = { --radium
		hands = elementcattos.halflife(elementcattos.fromdays(3.8)),
		result = "ecatto_element84"
	},
	ecatto_element88 = { --radium
		hands = elementcattos.halflife(elementcattos.fromdays(11.43)),
		result = "ecatto_element86"
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		hands = 0
	},
	ecatto_element118 = { --oganesson
		explode = true,
		hands = 0
	}
}

local rq = {
	"elements",
	"compoundcreator",
	"consumables",
	"compounds",
	"compounds_extra_recipes",
	"decks",
	"boosters",
	"sleeves",
	"special",
	"sticker_stabilized",
	"patches",
	BLINDSIDE and "blindside/bs_main" or nil
}

--Pronouns
if CardPronouns then
	local in_pool = topuplib.returnFalse
	CardPronouns.Pronoun {
		colour = HEX("F0FF9F"),
		text_colour = G.C.BLACK,
		pronoun_table = { "Hse", "Ehr" },
		in_pool = in_pool,
		key = "ecatto_hse_ehr"
	}
	CardPronouns.Pronoun {
		colour = HEX("8823FF"),
		text_colour = G.C.WHITE,
		pronoun_table = { "They", "It", "Xe" },
		in_pool = in_pool,
		key = "ecatto_they_it_xe"
	}
	CardPronouns.Pronoun {
		colour = G.C.BLACK,
		text_colour = G.C.WHITE,
		pronoun_table = { "Unknown" },
		in_pool = in_pool,
		key = "ecatto_unknown"
	}
	CardPronouns.Pronoun {
		colour = CardPronouns.badge_types.they_them.colour,
		text_colour = G.C.WHITE,
		pronoun_table = { "They", "Any" },
		in_pool = in_pool,
		key = "ecatto_they_any"
	}
	CardPronouns.Pronoun {
		colour = HEX("C492FE"),
		text_colour = G.C.WHITE,
		pronoun_table = { "She", "He" },
		in_pool = in_pool,
		key = "ecatto_she_he"
	}
	CardPronouns.Pronoun {
		colour = HEX("89A0FE"),
		text_colour = G.C.WHITE,
		pronoun_table = { "He", "She" },
		in_pool = in_pool,
		key = "ecatto_he_she"
	}
	CardPronouns.Pronoun {
		colour = CardPronouns.badge_types.he_him.colour,
		text_colour = G.C.WHITE,
		pronoun_table = { "He", "Any" },
		in_pool = in_pool,
		key = "ecatto_he_any"
	}
	CardPronouns.Pronoun {
		colour = HEX("9137E6"),
		text_colour = G.C.WHITE,
		pronoun_table = { "Xe", "Xem" },
		in_pool = in_pool,
		key = "ecatto_xe_xem"
	}
	CardPronouns.Pronoun {
		colour = G.C.GREEN,
		text_colour = G.C.WHITE,
		pronoun_table = { "Tree", "Trim" },
		in_pool = in_pool,
		key = "ecatto_tree_trim"
	}
	CardPronouns.Pronoun {
		colour = G.C.RED,
		text_colour = G.C.WHITE,
		pronoun_table = { "*Eagle noise*", "Any" },
		in_pool = in_pool,
		key = "ecatto_eaglenoise_any"
	}
	CardPronouns.Pronoun {
		colour = G.C.DARK_EDITION,
		text_colour = G.C.WHITE,
		pronoun_table = { "None", "All" },
		in_pool = in_pool,
		key = "ecatto_na"
	}
	
	elementcattos.usa_flag = love.graphics.newImage(NFS.read('data', SMODS.current_mod.path .. "assets/gfx/usa.png"))
end

topuplib.addFontOption("Century Schoolbook", "lua/fonts/centuryschoolbook")
topuplib.addDebugCollectionItem("c_ecattos_stabilizer")

local meme = topuplib.createFallbackPoolItem
topuplib.createFallbackPoolItem = function(type, pool)
	if type == "Joker" and G.GAME.starting_params.ecattos_deck then
		return elementcattos.fallbacks[math.random(#elementcattos.fallbacks)]
	end
	return meme(type, pool)
end

local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	
	elementcattos.title_cardarea = CardArea(
        0, 0,
        G.CARD_W * 7,G.CARD_H,
        {card_limit = 4, type = 'title', lr_padding = 1})
	elementcattos.title_cardarea:set_alignment({
		major = G.title_top,
		bond = "Strong",
		type = "cm",
		offset = {x=0, y=3.5}
	})
	local candidates = {}
	while #candidates < 118 do
		candidates[#candidates+1] = #candidates+1
	end
	-- adds a Cryptid spectral to the main menu
	while #elementcattos.title_cardarea.cards < 5 do
		local n = table.remove(candidates, math.random(#candidates))
		local newcard = Card(
			G.title_top.T.x,
			G.title_top.T.y,
			G.CARD_W,
			G.CARD_H,
			G.P_CARDS.empty,
			G.P_CENTERS["j_ecattos_element"..n],
			{ bypass_discovery_center = true }
		)
		-- recenter the title
		elementcattos.title_cardarea:emplace(newcard)
		-- make the card look the same way as the title screen Ace of Spades
		--newcard.T.w = newcard.T.w * 1.1 * 1.2
		--newcard.T.h = newcard.T.h * 1.1 * 1.2
		newcard.no_ui = true
		newcard.states.visible = false
		local delay = 3 - (#elementcattos.title_cardarea.cards * 0.3)

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = delay,
			blockable = false,
			blocking = false,
			func = function()
				newcard.states.visible = true
				newcard:start_materialize({ G.C.WHITE, G.C.WHITE }, false, 2)
				return true
			end,
		}))
	end
	
    elementcattos.title_cardarea:sort('order')
    elementcattos.title_cardarea:set_ranks()
    elementcattos.title_cardarea:align_cards()
    elementcattos.title_cardarea:hard_set_cards()
	elementcattos.title_cardarea:hard_set_VT()

	return ret
end

SMODS.Sound {
	--This song is a WIP
	key = "music_ecattos",
	path = "balatro-elementcatto.ogg",
	pitch = 1,
	select_music_track = function(self)
		return G.OVERLAY_MENU and topuplib.music == "ecattos"
	end
}

SMODS.Atlas({
	key = "modifiers",
	path = "modifiers.png",
	px = 71,
	py = 95
})

for i, v in ipairs(rq) do
	if v then
		local a = assert(SMODS.load_file("lua/"..v..".lua"))()
		if type(a) == "function" then
			a({
				legitimate = legitimate
			})
		end
	end
end

elementcattos.booster_pools = {
	[1] = {},
	[2] = {},
	[3] = {},
	[4] = {},
	tool = {}
}

for k,v in pairs(SMODS.Centers) do
	if v.original_mod and v.original_mod.id == SMODS.current_mod.id then
		if not v.not_in_booster then
			if v.set == "Joker" then
				table.insert(elementcattos.booster_pools[v.rarity], v.key)
			elseif v.set == "Tarot" then
				table.insert(elementcattos.booster_pools.tool, v.key)
			end
		end
	end
end