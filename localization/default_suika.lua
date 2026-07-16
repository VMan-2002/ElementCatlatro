return {
	misc = {
		dictionary = {
			ecattos_multiplepokercombos = "Multiple Combos"
		}
	},
	descriptions = {
		Joker = {
			--Elements
			j_ecattos_element5 = elementcattos.loc_txt {
				name = "Boron",
				text = {
					"{C:green}1 in 5{} chance for {_A:handsize:+1}",
					"when dropping a ball",
					"{C:attention}Resets{} at end of round",
					"{_A:currenthandsize:+0}"
				},
				anum = 5,
				sym = "B"
			},
			j_ecattos_element10 = elementcattos.loc_txt {
				name = "Neon",
				text = {
					"{C:green}1 in 2{} chance to {C:attention}retrigger",
					"ball {C:attention}remaining in box{} effects"
				},
				anum = 10,
				sym = "Ne"
			},
			j_ecattos_element15 = elementcattos.loc_txt {
				name = "Phosphorus",
				text = {
					"Gains {_A:xmult:0.1} per dropped",
					"ball of {_A:hearts} suit this round",
					"{_A:currentxmult:1}"
				},
				anum = 15,
				sym = "P"
			},
			j_ecattos_element60 = elementcattos.loc_txt {
				name = "Neodymium",
				text = {
					"{C:attention}Steel{} balls can always",
					"merge with each other"
				},
				anum = 60,
				sym = "Nd"
			},
			j_ecattos_element63 = elementcattos.loc_txt {
				name = "Europium",
				text = {
					"{C:green}1 in 4{} chance for",
					"unenhanced {_A:hearts} cards",
					"to drop as {C:attention}Wild{} balls"
				},
				anum = 63,
				sym = "Eu"
			},
			j_ecattos_element75 = elementcattos.loc_txt {
				name = "Rhenium",
				text = {
					"{C:attention}-30%{} explosion force"
				},
				anum = 75,
				sym = "Re"
			},
			j_ecattos_element119 = elementcattos.loc_txt {
				name = "Ununennium",
				text = {
					"{_A:echips:1.02} when a ball",
					"merges with a ball of",
					"another suit"
				},
				anum = 119,
				sym = "Uue"
			},
			j_ecattos_element120 = elementcattos.loc_txt {
				name = "Unbinilium",
				text = {
					"{C:green}1 in 2{} chance to {C:attention}level up",
					"each played poker combo"
				},
				anum = 120,
				sym = "Ubn"
			},
			--Compounds
			j_ecattos_compound_oobleck = elementcattos.loc_txt {
				name = "Oobleck",
				text = {
					"Per hand, the {C:attention}first 4{} ball merges",
					"give {_A:xmult:1.5}, future ball merges",
					"give {_A:xmult:0.75}"
				},
				compound = "oobleck"
			},
			j_ecattos_compound_neodymium_magnet = elementcattos.loc_txt {
				name = "Neodymium Magnet",
				text = {
					"{C:green}1 in 5{} chance for each",
					"base edition {C:attention}Steel Card",
					"held in hand to become {C:dark_edition}Negative",
					"when a ball is dropped"
				},
				compound = "neodymium_magnet"
			},
			j_ecattos_compound_titin = elementcattos.loc_txt {
				name = "Titin",
				text = {
					"If {C:important}played hand{} contains a",
					"{C:attention}5-Flush{}, {_A:emult:#1#} when a ball merges"
				},
				compound = "titin"
			},
			--Special
			j_ecattos_suika_exploding = elementcattos.loc_txt {
				name = "Exploding Catto",
				text = {
					"Causes an {C:red}explosion{} on the",
					"next ball merge, {C:red}self-destructs",
					"Explosion force: {C:attention}#1#"
				}
			}
		}
    }
}