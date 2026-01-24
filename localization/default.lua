return {
	misc = {
		dictionary = {
			ecattos_compoundcreator_tocreate = "Compound to create",
			ecattos_compoundcreator_confirm = "Confirm",
			
			ecattos_endedworld = {
				"The element was so dense,",
				"that the world was destroyed..."
			},
			ecattos_endedworld_confirm = "Oh :(",
			
			k_booster_group_p_ecattos_element_common = "Elements Pack",
			k_booster_group_p_ecattos_element_uncommon = "Elements Pack",
			k_booster_group_p_ecattos_element_rare = "Elements Pack",
			k_booster_group_p_ecattos_element_tools = "Tools Pack",
			
			ecattos_fusion_negative = "Negative Edition",
			ecattos_fusion_none = "None",
			ecattos_fission_none = "None",
			ecattos_recipe_name_stone_cards = "6 Stone Cards",
			ecattos_unlock_compound = {
				"Form this using",
				"Compound Creator"
			},
			
			ecattos_neil = "Neil",
			
			ecattos_ds_screen_train = "ZÜGE",
			ecattos_ds_screen_hi = "HI #1#",
			ecattos_ds_screen_dragged = "HAI :3",
			ecattos_ds_screen_explode = "!?!?!",
			ecattos_ds_screen_bye = "BYE :3",
			
			ecattos_planet_star_of = "Star of #1#",
			ecattos_planet_moon_of = "Moon of #1#",
			ecattos_planet_planet_of = "Planet of #1#",
			ecattos_planet_satellite_of = "Satellite of #1#",
			ecattos_planet_solarsystem = "the Solar System",
			
			ecattos_planet_category_inner_solar = "Inner Solar System",
			ecattos_planet_category_hoax = "Hoax Object",
			ecattos_planet_category_outer_solar = "Outer Solar System"
		},
		ecattos_extended_element = {
			name = function(num, isSymbol) --this is a function, hopefully the game takes this well
				local dgt = {
					["0"] = "Nil",
					["1"] = "Un",
					["2"] = "Bi",
					["3"] = "Tri",
					["4"] = "Quad",
					["5"] = "Pent",
					["6"] = "Hex",
					["7"] = "Sept",
					["8"] = "Oct",
					["9"] = "Enn"
				}
				local result = ""
				for v in string.gmatch(num, "%d") do
					local t = result == "" and dgt[v] or string.lower(dgt[v])
					result = result .. (isSymbol and string.sub(t, 1, 1) or t)
				end
				if isSymbol then
					return result
				end
				if string.sub(result, string.len(result)) == "i" then
					return result .. "um"
				end
				return result .. "ium"
			end,
			effect_chips = {
				"{C:chips}+#1#{} Chips"
			},
			effect_mult = {
				"{C:mult}+#1#{} Mult"
			},
			effect_tarot = {
				"Create a {C:tarot}Tarot{} card"
			},
			effect_spectral = {
				"Create a {C:spectral}Spectral{} card"
			},
			trigger_scored_card = {
				"#1# per scored card"
			},
			trigger_scored_card_suit = {
				"#1# per scored card of #2# suit"
			},
			trigger_held_card = {
				"#1# per card held in hand"
			},
			trigger_held_card_suit = {
				"#1# per",
				"card of #2# suit held in hand"
			},
			condition_hand = {
				"#1# if played hand is #2#"
			},
			condition_contains_hand = {
				"#1# if scored hand contains #2#"
			},
			break_stabilizer = {
				"#1# in #2# chance to break",
				"equipped Stabilizer"
			},
			break_stabilizer_eternal = {
				"#1# in #2# chance to break",
				"equipped Stabilizer",
				"and become Eternal"
			}
		}
	},
	descriptions = {
		Joker = {
			--Elements
			j_ecattos_element0 = elementcattos.loc_txt {
				name = "Muonium",
				text = {
					"{_A:dark_edition:+?} ???"
				},
				anum = 0,
				sym = "Mu"
			},
			j_ecattos_element1 = elementcattos.loc_txt {
				name = "Hydrogen",
				text = {
					"{_A:chips:+#1#}"
				},
				anum = 1,
				sym = "H"
			},
			j_ecattos_element2 = elementcattos.loc_txt {
				name = "Helium",
				text = {
					"{_A:mult:+#1#}"
				},
				anum = 2,
				sym = "He"
			},
			j_ecattos_element3 = elementcattos.loc_txt {
				name = "Lithium",
				--i wanna change this as i dont rly want elements to have "This Joker gains" effects
				text = {
					"Gains {C:chips}Chips{} equal to",
					"{_A:attention:1/12th} of scored {C:mult}Mult{}",
					"{_A:currentchips:+#1#}"
				},
				anum = 3,
				sym = "Li"
			},
			j_ecattos_element4 = elementcattos.loc_txt {
				name = "Beryllium",
				text = {
					"{_A:mult:+#1#} per scored",
					"card with an {C:dark_edition}edition{}"
				},
				anum = 4,
				sym = "Be"
			},
			j_ecattos_element5 = elementcattos.loc_txt {
				name = "Boron",
				text = {
					"Levels up last played poker hand",
					"when Compound Creator is used",
					"{_A:currentattention:#1#}"
				},
				anum = 5,
				sym = "B"
			},
			j_ecattos_element6 = elementcattos.loc_txt {
				name = "Carbon",
				text = {
					"{_A:xchips:#1#} per scored",
					"{_A:spades:Spade} or {_A:clubs:Club}"
				},
				anum = 6,
				sym = "C"
			},
			j_ecattos_element7 = elementcattos.loc_txt {
				name = "Nitrogen",
				text = {
					"{_A:chips:+15} per unique",
					"suit in scoring hand",
					"{C:attention}Wild Cards{} always count",
					"as an unique suit"
				},
				anum = 7,
				sym = "N"
			},
			j_ecattos_element8 = elementcattos.loc_txt {
				name = "Oxygen",
				text = {
					"{_A:chips:+#1#} or {_A:mult:+#2#}",
					"per scored card"
				},
				anum = 8,
				sym = "O"
			},
			j_ecattos_element10 = elementcattos.loc_txt {
				name = "Neon",
				text = {
					"{_A:basexmult:#1#}"
				},
				anum = 10,
				sym = "Ne"
			},
			j_ecattos_element14 = elementcattos.loc_txt {
				name = "Silicon",
				text = {
					"Booster Packs have",
					"{_A:attention:#1#} more card"
				},
				anum = 14,
				sym = "Si"
			},
			j_ecattos_element15 = elementcattos.loc_txt {
				name = "Phosphorus",
				text = {
					"When sold, all cards held",
					"in hand permenantly gain {_A:mult:+0.2}",
					"for each round played this run",
					"{_A:currentmult:+0}"
				},
				anum = 15,
				sym = "P"
			},
			j_ecattos_element16 = elementcattos.loc_txt {
				name = "Sulfur",
				text = {
					"{_A:mult:+24} after an explosion",
					"{C:inactive}(Inactive)",
					"Resets when Boss Blind is defeated"
				},
				anum = 16,
				sym = "S"
			},
			j_ecattos_element27 = elementcattos.loc_txt {
				name = "Cobalt",
				text = {
					"Every played {C:attention}card{} permenantly",
					"gains {_A:chips:+3} when scored"
				},
				anum = 27,
				sym = "Co"
			},
			j_ecattos_element28 = elementcattos.loc_txt {
				name = "Nickel",
				text = {
					"Earn {_A:money:2} at end of round,",
					"plus {_A:money:1} for each Ante",
					"{_A:currentmoney:2}"
				},
				anum = 28,
				sym = "Ni"
			},
			j_ecattos_element33 = elementcattos.loc_txt {
				name = "Arsenic",
				--maybe i dont actually want arsenic to be meta
				--[[text = {
					"Retrigger all scored cards, but",
					"X3 Blind score requirement",
				},]]
				anum = 33,
				sym = "As"
			},
			j_ecattos_element34 = elementcattos.loc_txt {
				name = "Selenium",
				text = {
					"{C:tarot}The Moon{} additionally enhances",
					"selected cards to {C:attention}Mult Cards",
				},
				anum = 34,
				sym = "Se"
			},
			j_ecattos_element34_alt = elementcattos.loc_txt {
				name = "Neil",
				text = {
					"{C:tarot}The Moon{} additionally enhances",
					"selected cards to {C:attention}Mult Cards",
				},
				anum = 34,
				sym = "Neil"
			},
			j_ecattos_element56 = elementcattos.loc_txt {
				name = "Barium",
				--idk -Jacob
				--[[text = {
					"{_A:basexmult:#1#}",
					"After playing a hand,",
					"discard {C:attention}#1#{} cards from your deck.",
				},]]
				anum = 56,
				sym = "Ba"
			},
			j_ecattos_element60 = elementcattos.loc_txt {
				name = "Neodymium",
				text = {
					"{C:green}1 in 2{} chance to retrigger",
					"{C:attention}Steel Cards{} held in hand"
				},
				anum = 60,
				sym = "Nd"
			},
			j_ecattos_element63 = elementcattos.loc_txt {
				name = "Europium",
				text = {
					"{_A:mult:+6} per scored",
					"card of {_A:hearts} suit",
					"Wild Cards also give",
					"{_A:chips:+10}"
				},
				anum = 63,
				sym = "Eu"
			},
			j_ecattos_element79 = elementcattos.loc_txt {
				name = "Gold",
				text = {
					"Raise the cap on interest",
					"earned in each round by {_A:money:10}"
				},
				anum = 79,
				sym = "Au"
			},
			j_ecattos_element94 = elementcattos.loc_txt {
				name = "Plutonium",
				text = {
					"If {C:attention}played hand{} has only {C:attention}1{} card,",
					"cards {C:attention}held in hand{} give {_A:xmult:1.21}"
				},
				anum = 94,
				sym = "Pu"
			},
			j_ecattos_element95 = elementcattos.loc_txt {
				name = "Americium",
				text = {
					"{_A:xmult:#1#} if {C:attention}scored hand{} contains",
					"{_A:clubs:Clubs}, {_A:hearts:Hearts}, and no other suits"
				},
				anum = 95,
				sym = "Am"
			},
			j_ecattos_element118 = elementcattos.loc_txt {
				name = "Oganesson",
				text = {
					"Balances {C:chips}Chips{} and {C:mult}Mult{}",
					"before scoring"
				},
				anum = 118,
				sym = "Og"
			},
			j_ecattos_element119 = elementcattos.loc_txt {
				name = "Ununennium",
				text = {
					"{_A:echips:1.025} per scored",
					"unique rank in hand"
				},
				anum = 119,
				sym = "Uue"
			},
			j_ecattos_element120 = elementcattos.loc_txt {
				name = "Unbinilium",
				text = {
					"When Boss Blind is defeated, upgrades",
					"played poker hand with {_A:basexmult:1.25}"
				},
				anum = 120,
				sym = "Ubn"
			},
			j_ecattos_element_extended = elementcattos.loc_txt {
				name = "Extended Element",
				text = {
					"Unfinished.",
					"This description should be",
					"replaced via code.",
					"Intended for atomic numbers",
					"exceeding 120."
				}
			},
			--Specials
			j_ecattos_purrcent = elementcattos.loc_txt {
				name = "Purrcent",
				text = {
					"{_A:legendary} Jokers can",
					"be found in the shop"
				},
				anum = ":3",
				sym = "cta"
			},
			j_ecattos_codecatto = elementcattos.loc_txt {
				name = "Sysop",
				text = {
					"{_A:chance:#1# in #2#} chance to create a",
					"{_A:code} Card when a Tool is used"
				},
				sym = "C:\\"
			},
			j_ecattos_bungy = elementcattos.loc_txt {
				name = "Bungy",
				text = {
					"Can be used as a substitute for any",
					"element when creating compounds",
				},
				sym = "Bu"
			},
			j_ecattos_naium = elementcattos.loc_txt {
				name = "N/Aium",
				text = {
					"Fuse with up to {_A:attention:3} other Cattos",
					"to add {_A:dark_edition:Negative} edition to them"
				},
				anum = "Omega",
				sym = "N/A"
			},
			j_ecattos_garbage = {
				name = "Garbage",
				text = {
					"{C:inactive}Oops...{}"
				}
			},
			j_ecattos_yomium = elementcattos.loc_txt {
				name = "Yomium",
				text = {
					"Copies ability of first",
					"{C:attention}Element Catto{} to the right",
				},
				--anum = "{5}",
				sym = "Ym"
			},
			j_ecattos_joker = elementcattos.loc_txt {
				name = "Jimbonium",
				text = {
					"+4 {C:mult}Mult{}",
				},
				anum = "139", --https://commons.wikimedia.org/wiki/File:Wales_Chem.png lol
				sym = "JOKER"
			},
			j_ecattos_element118fake = elementcattos.loc_txt {
				name = "Ninovium",
				text = {
					"x2 {C:mult}Mult{}",
					"x0.5 {C:chips}Chips{}",
					"{C:inactive}Explodes when balancing Chips and Mult{}"
				},
				anum = "118",
				sym = "Nv"
			},
			--Subatomic particles
			j_ecattos_neutron = elementcattos.loc_txt {
				name = "Neutron",
				text = {
					"{C:attention}Use{} to add to {C:attention}1{}",
					"selected Element Catto",
					"{C:inactive}+1 Joker slot",
					"{C:inactive}(Vanishes after {C:attention}#1#{C:inactive} rounds)"
				},
				extra = "Subatomic particle"
			},
			j_ecattos_electron = elementcattos.loc_txt {
				name = "Electron",
				text = {
					"{C:attention}Use{} to add to {C:attention}1{}",
					"selected Element Catto",
					"{C:inactive}+1 Joker slot",
					"{C:inactive}(Vanishes after {C:attention}#1#{C:inactive} rounds)"
				},
				extra = "Subatomic particle"
			},
			j_ecattos_photon = elementcattos.loc_txt {
				name = "Photon",
				text = {
					"Has specific interactions",
					"with certain Element Cattos",
					"(Check tooltips of valid targets)",
					"{C:inactive}+1 Joker slot",
					"{C:inactive}(Vanishes after {C:attention}#1#{C:inactive} rounds)"
				},
				extra = "Subatomic particle"
			},
			--Compounds
			j_ecattos_compound_water = elementcattos.loc_txt {
				name = "Water",
				text = {
					"All played cards","count in scoring"
				},
				compound = "water"
			},
			j_ecattos_compound_starch = elementcattos.loc_txt {
				name = "Starch",
				compound = "starch"
			},
			j_ecattos_compound_oobleck = elementcattos.loc_txt {
				name = "Oobleck",
				text = {
					"{_A:xmult:#1#} if played hand",
					"has at most {_A:basemult:#3#},",
					"otherwise {_A:xmult:#2#}"
				},
				compound = "oobleck"
			},
			j_ecattos_compound_silica = elementcattos.loc_txt {
				name = "Silica",
				text = {
					"{_A:mult:+#1#} per",
					"scored Stone Card"
				},
				compound = "silica"
			},
			j_ecattos_compound_magnetite = elementcattos.loc_txt {
				name = "Magnetite",
				text = {
					"{C:attention}Steel Cards{} are",
					"always drawn first"
				},
				compound = "magnetite"
			},
			j_ecattos_compound_neodymium_magnet = elementcattos.loc_txt {
				name = "Neodymium Magnet",
				text = {
					"{C:green}1 in 4{} chance for each base",
					"edition {C:attention}Steel Card{} held",
					"in hand to become {C:dark_edition}Negative{}"
				},
				compound = "neodymium_magnet"
			},
			j_ecattos_compound_titin = elementcattos.loc_txt {
				name = "Titin",
				text = {
					"If {C:important}played hand{} contains at least",
					"{C:important}5{} cards, {_A:emult:#1#} per scored card"
				},
				compound = "titin"
			},
			j_ecattos_compound_titin_cheated = {
				name = "''Titin''",
				text = {
					"There are other ways you",
					"could've have cheated.",
					"This one... nah.",
					"{C:inactive,s:0.75}Create a GitHub issue if",
					"{C:inactive,s:0.75}verdict is incorrect."
				}
			},
			--Blindside
			j_ecattos_planet_sun = elementcattos.loc_txt_planet {
				name = "The Sun",
				text = {
					"{C:attention}Retrigger{} the first",
					"Blind of each Hue"
				}
			},
			j_ecattos_planet_earth = elementcattos.loc_txt_planet {
				name = "Earth",
				text = {
					"Create a {_A:bs_mineral} Card",
					"if played hand contains",
					"a {_A:bs_green} or {_A:bs_blue} Blind",
					"with multiple Hues"
				}
			},
			j_ecattos_planet_mercury = elementcattos.loc_txt_planet {
				name = "Mercury",
				text = {
					"text format test",
					"{_A:bs_red} {_A:bs_green} {_A:bs_blue} {_A:bs_yellow} {_A:bs_purple} {_A:bs_faded}",
					"{_A:bs_channel} {_A:bs_mineral} {_A:bs_rune} {_A:bs_ritual}"
				}
			},
			j_ecattos_planet_jupiter = elementcattos.loc_txt_planet {
				name = "Jupiter",
				text = {
					""
				}
			},
			j_ecattos_planet_planetx = elementcattos.loc_txt_planet {
				name = "Planet X",
				text = {
					""
				}
			}
		},
		Tarot = {
			c_ecattos_fusion = {
				name = "Fusion Reactor",
				text = topuplib.asub {
					"Combine {_A:attention:2} selected Element Cattos",
					"into one with an atomic number",
					"equal to the sum of the inputs",
					"{C:inactive}(First Edition is kept)",
					"{C:inactive}(Will create: #1#)"
				}
			},
			c_ecattos_fission = {
				name = "Fission Hammer",
				text = topuplib.asub {
					"Split {_A:attention:1} selected Element Catto",
					"into two based on it's atomic number",
					"{_A:musthaveroom}",
					"{C:inactive}(Edition is given to the first output)",
					"{C:inactive}(Will create: #1# and #2#)"
				}
			},
			c_ecattos_weakray = {
				name = "Weak Ray",
				text = topuplib.asub {
					topuplib.txnyi,
					"Accelerates {_A:attention:1} selected",
					"radioactive Element Catto's decay"
				}
			},
			c_ecattos_duplicator = {
				name = "Matter Duplicator",
				text = topuplib.asub {
					"Creates a copy of {_A:attention:1}",
					"selected Element Catto",
					"Common Elements are",
					"copied twice",
					"{_A:musthaveroom}"
				}
			},
			c_ecattos_eraser = {
				name = "Matter Eraser",
				text = topuplib.asub {
					"Destroys {_A:attention:1} selected",
					"Element Catto",
					"{C:inactive}(Bypasses Eternal)"
				}
			},
			c_ecattos_compoundcreator = {
				name = "Compound Creator",
				text = topuplib.asub {
					"Select {_A:attention:1} Compound to form",
					"using Elements you have",
					"{C:inactive}(First Edition is kept)"
				}
			},
			c_ecattos_tweezers = {
				name = "Neutron Tweezers",
				text = topuplib.asub {
					topuplib.txnyi,
					"Removes a Neutron from",
					"{_A:attention:1} selected Element Catto",
					"{_A:musthaveroom}"
				}
			},
			c_ecattos_electromagnet = {
				name = "Electromagnet",
				text = topuplib.asub {
					topuplib.txnyi,
					"Removes an Electron from",
					"{_A:attention:1} selected Element Catto",
					"{_A:musthaveroom}"
				}
			},
			c_ecattos_stabilizer = {
				name = "Stabilizer",
				text = topuplib.asub {
					"Pauses {_A:attention:1} selected Element Catto's",
					"radioactive decay for {C:attention}+2{} rounds"
				}
			},
			c_ecattos_lightbulb = {
				name = "Lightbulb",
				text = {
					"i dont know"
				}
			},
			c_ecattos_recipe_titin = {
				name = "Titin Blueprint",
				text = topuplib.asub {
					topuplib.txnyi,
					"{C:important}Use to consume ingredients",
					"Creates {_A:exotic:Titin} when completed",
					"{C:inactive}Carbon: #1#/169719",
					"{C:inactive}Hydrogen: #2#/270466",
					"{C:inactive}Nitrogen: #3#/45688",
					"{C:inactive}Oxygen: #4#/52238",
					"{C:inactive}Sulfur: #5#/911"
				}
			}
		},
		Other = {
			p_ecattos_element_common = {
				name = "Common Elements Pack",
				text = topuplib.asub {
					"Select {C:attention}2{} of {C:attention}5{} {_A:common}",
					"Element Cattos"
				}
			},
			p_ecattos_element_uncommon = {
				name = "Uncommon Elements Pack",
				text = topuplib.asub {
					"Select {C:attention}2{} of {C:attention}5{} {_A:uncommon}",
					"Element Cattos"
				}
			},
			p_ecattos_element_rare = {
				name = "Common Elements Pack",
				text = topuplib.asub {
					"Select {C:attention}1{} of {C:attention}3{} {_A:rare}",
					"Element Cattos"
				}
			},
			p_ecattos_element_tools = {
				name = "Tools Pack",
				text = {
					"Select {C:attention}1{} of {C:attention}4{} {C:tarot}Tools{}",
					"to use immediately"
				}
			},
			ecattos_radioactive = {
				name = "Radioactive",
				text = {
					"Decays in {C:attention}#1#{} hands"
				}
			},
			ecattos_radioactive_explodes = {
				name = "Radioactive",
				text = {
					"Decays in {C:attention}#1#{} hands",
					"{C:red}Explodes{} upon decay"
				}
			},
            ecattos_stabilized={
                name="Stabilized",
                text={
                    "Radioactive decay is",
                    "paused for {C:attention}#1#{} rounds",
                },
            },
            ecattos_photon_light_fuse={
                name="Interaction with Photon",
                text={
                    "Lights fuse"
                },
            }
		},
		Back = {
			b_ecattos_elements = {
				name = "Element Cattos Deck",
				text = topuplib.asub {
					"Only Jokers from {C:attention}Element",
					"{C:attention}Catlatro{} may appear",
					"{C:attention}+24{} Joker slots",
					"Start with additional {_A:money:8}",
					"and {C:attention}Overstock Plus{}"
				}
			}
		},
        Sleeve = {
            sleeve_ecattos_elements = {
                name = "Element Cattos Sleeve",
				text = topuplib.asub {
					"Only Jokers from {C:attention}Element",
					"{C:attention}Catlatro{} may appear",
					"{C:attention}+24{} Joker slots",
					"Start with additional {_A:money:8}",
					"and {C:attention}Overstock Plus{}"
				}
            },
            sleeve_ecattos_elements_alt = {
                name = "Element Cattos Sleeve",
				text = topuplib.asub {
					"{C:tarot}Tool{} and {C:attention}Element{} Packs both have",
                    "{C:attention}2{} extra options to choose from",
				}
            },
        }
    }
}