--[[
	may be changed if needed
	
	rarity 1:
		15000 atomic fraction in earth or above
		100 atomic fraction in solar system or above
		(source: https://en.wikipedia.org/wiki/Abundance_of_the_chemical_elements)
	rarity 2: 
		3000 atomic fraction in earth or above
		5 atomic fraction in solar system or above
			(isotopes: Neon-22, Hydrogen-2, Helium-3)
	rarity 3: 
		150 atomic fraction in earth or above
		1 atomic fraction in solar system or above
			(isotopes: Magnesium-26, Carbon-12, Magnesium-25, Argon-36, Iron-54, Silicon-29, Silicon-30, Iron-57)
	
	
	idk what do for further rarity stuff aaaaa
]]

local elements = {
	--Atomic number, Symbol, Name, Pronouns, Base Mass, Calculate
	{0, "Mu", "Muonium", "hse_ehr", 0, rarity = 3},
	
	{1, "H", "Hydrogen", "she_her", 1, rarity = 1, config = { extra = {chips = 25} }, loc_vars = {"chips"}},
	
	{2, "He", "Helium", "he_him", 4, rarity = 1, config = { extra = {mult = 2.5} }, loc_vars = {"mult"}},
	
	{3, "Li", "Lithium", "he_him", 7, rarity = 2, config = { extra = {chips = 0} }, loc_vars = {"chips"}},
	
	{4, "Be", "Beryllium", "she_her", 9, function(self, card, context)
		if context.individual and context.cardarea == G.play and context.other_card.edition then
            return {
                mult = card.ability.extra.mult, --attempt to index field 'extra' (a nil value)
                colour = G.C.MULT,
                card = card,
            }
        end
    end, config = { extra = {mult = 1.5} }, loc_vars = {"mult"}},
	
	{5, "B", "Boron", "he_him", 11, rarity = 3},
	
	{6, "C", "Carbon", "he_him", 12, function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:is_suit(card.ability.extra.suits[1]) or context.other_card:is_suit(card.ability.extra.suits[2])) then
            return {
                x_chips = card.ability.extra.s_xchips
            }
        end
    end, rarity = 1, config = { extra = {s_xchips = 1.15, suits = {'Spades', 'Clubs'}} }, loc_vars = {"s_xchips"}},
	
	{7, "N", "Nitrogen", "she_her", 14, function(self, card, context)
        if context.before then
            local suits = {}
            local wilds = 0
            for _, playing_card in ipairs(context.scoring_hand) do
				if playing_card == G.P_CENTERS.m_wild then
                    wilds = wilds + 1
                elseif playing_card.base.suit then 
					suits[playing_card.base.suit] = true 
				end
			end
			card.ability.extra.suit_count = wilds
			for _,_ in pairs(suits) do
				card.ability.extra.suit_count = card.ability.extra.suit_count + 1
			end
        end
        if context.joker_main then
			return {
				chips = card.ability.extra.s_chips * card.ability.extra.suit_count
            }
        end
    end, config = { extra = {s_chips = 15, suit_count = 0} }, loc_vars = {"s_chips", "suit_count"}, rarity = 1},
	
	{8, "O", "Oxygen", "she_her", 16, rarity = 1, config = { extra = {chips = 10, mult = 0.5} }, loc_vars = {"chips", "mult"}},
	
	{9, "F", "Fluorine", "she_her", 19, rarity = 2},
	
	{10, "Ne", "Neon", "she_her", 20, rarity = 1, config = { extra = {xmult = 1.5} }, loc_vars = {"xmult"}},
	
	{11, "Na", "Sodium", "he_him", 23, rarity = 1},
	
	{12, "Mg", "Magnesium", "she_her", 24, rarity = 1},
	
	{13, "Al", "Aluminium", "he_him", 27, rarity = 1},
	
	{14, "Si", "Silicon", "he_him", 28, rarity = 1, config = { extra = {more = 1} }, loc_vars = {"more"}},
	
	{15, "P", "Phosphorus", "he_him", 31, rarity = 1},
	
	{16, "S", "Sulfur", "she_her", 32, rarity = 1},
	
	{17, "Cl", "Chlorine", "she_her", 35, rarity = 1},
	
	{18, "Ar", "Argon", "they_them", 40},
	
	{19, "K", "Potassium", "she_her", 39, rarity = 1},
	
	{20, "Ca", "Calcium", "they_them", 40, rarity = 1},
	
	{21, "Sc", "Scandium", "he_him", 45, rarity = 2},
	
	{22, "Ti", "Titanium", "she_her", 48, rarity = 1},
	
	{23, "V", "Vanadium", "he_him", 51, rarity = 1},
	
	{24, "Cr", "Chromium", "she_her", 52, rarity = 1},
	
	{25, "Mn", "Manganese", "he_him", 55, rarity = 1},
	
	{26, "Fe", "Iron", "he_him", 56, rarity = 1},
	
	{27, "Co", "Cobalt", "he_him", 59, function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.CHIPS },
                card = card
            }
        end
    end, rarity = 1, config = { extra = {chips = 3} }, loc_vars = {"chips"}},
	
	{28, "Ni", "Nickel", "he_him", 58, rarity = 1},
	
	{29, "Cu", "Copper", "she_her", 63, rarity = 1},
	
	{30, "Zn", "Zinc", "he_him", 64, rarity = 1},
	
	{31, "Ga", "Gallium", "he_him", 69, rarity = 3},
	
	{32, "Ge", "Germanium", "he_him", 74, rarity = 3},
	
	{33, "As", "Arsenic", "he_him", 75, rarity = 3},
	
	{34, "Se", "Selenium", "he_him", 80, function(self, card, context)
        if context.using_consumeable then
			if context.consumeable.ability.name == 'The Moon' and G.hand.highlighted then
				for i = 1, #G.hand.highlighted do
					if not SMODS.has_enhancement(G.hand.highlighted[i], card.ability.extra.mod_conv) then
						G.hand.highlighted[i]:set_ability(card.ability.extra.mod_conv)
					end
				end
			end
		end
	end,
		loc_vars = function(self, card)
			local key, vars
			if SMODS.pseudorandom_probability(card, 'ecattos_element34', 1, 50) then 
				keys = self.key .. "_alt"
			else 
				keys = self.key
			end
			return { key = keys }
		end, config = { extra = { mod_conv = "m_mult" } }, rarity = 3
	},
	
	{35, "Br", "Bromine", "he_she", 79},
	
	{36, "Kr", "Krypton", "she_her", 84},
	
	{37, "Rb", "Rubidium", "they_them", 85},
	
	{38, "Sr", "Strontium", "she_her", 88, rarity = 2},
	
	{39, "Y", "Yttrium", "he_him", 89, rarity = 3},
	
	{40, "Zr", "Zirconium", "they_it_xe", 90, rarity = 3},
	
	{41, "Nb", "Niobium", "they_them", 93},
	
	{42, "Mo", "Molybdenum", "he_him", 98, rarity = 3},
	
	{43, "Tc", "Technetium", "she_her", 99},
	
	{44, "Ru", "Ruthenium", "she_her", 102},
	
	{45, "Rh", "Rhodium", "they_them", 103},
	
	{46, "Pd", "Palladium", "she_her", 106, rarity = 3},
	
	{47, "Ag", "Silver", "she_her", 107},
	
	{48, "Cd", "Cadmium", "she_her", 114},
	
	{49, "In", "Indium", "he_him", 115},
	
	{50, "Sn", "Tin", "he_him", 120},
	
	{51, "Sb", "Antimony", "she_her", 121},
	
	{52, "Te", "Tellurium", "he_him", 130},
	
	{53, "I", "Iodine", "they_them", 127},
	
	{54, "Xe", "Xenon", "xe_xem", 132},
	
	{55, "Cs", "Caesium", "he_him", 133},
	
	{56, "Ba", "Barium", "he_him", 138, rarity = 3},
	
	{57, "La", "Lanthanum", "he_him", 139},
	
	{58, "Ce", "Cerium", "she_her", 140, rarity = 3},
	
	{59, "Pr", "Praseodymium", "she_her", 141},
	
	{60, "Nd", "Neodymium", "they_them", 142, function(self, card, context)
        if (context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1)) then
            if (SMODS.has_enhancement(context.other_card, 'm_steel') and SMODS.pseudorandom_probability(card, 'ecattos_element60', 1, card.ability.extra.odds)) then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
        end
    end, config = { extra = { repetitions = 1, odds = 2 } }, rarity = 3
	},
	
	{61, "Pm", "Promethium", "she_her", 147},
	
	{62, "Sm", "Samarium", "he_him", 152},
	
	{63, "Eu", "Europium", "any_all", 153},
	
	{64, "Gd", "Gadolinium", "they_them", 158},
	
	{65, "Tb", "Terbium", "she_her", 159},
	
	{66, "Dy", "Dysprosium", "she_her", 164},
	
	{67, "Ho", "Holmium", "she_her", 165},
	
	{68, "Er", "Erbium", "they_them", 166},
	
	{69, "Tm", "Thulium", "he_him", 169},
	
	{70, "Yb", "Ytterbium", "they_them", 174},
	
	{71, "Lu", "Lutetium", "she_her", 175},
	
	{72, "Hf", "Hafnium", "they_them", 180},
	
	{73, "Ta", "Tantalum", "she_her", 181},
	
	{74, "W", "Tungsten", "he_him", 184},
	
	{75, "Re", "Rhenium", "he_him", 187},
	
	{76, "Os", "Osmium", "he_him", 192},
	
	{77, "Ir", "Iridium", "she_her", 193},
	
	{78, "Pt", "Platinum", "she_her", 195, rarity = 3},
	
	{79, "Au", "Gold", "she_her", 197, function(self, card, context) end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.interest_cap = G.GAME.interest_cap + card.ability.extra.interest
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.interest_cap = G.GAME.interest_cap - card.ability.extra.interest
	end, config = { extra = { interest = 10 } }
	},
	
	{80, "Hg", "Mercury", "she_he", 202},
	
	{81, "Tl", "Thallium", "he_him", 205},
	
	{82, "Pb", "Lead", "she_her", 208},
	
	{83, "Bi", "Bismuth", "she_he", 209},
	
	{84, "Po", "Polonium", "she_her", 210},
	
	{85, "At", "Astatine", "unknown", 219},
	
	{86, "Rn", "Radon", "she_her", 222},
	
	{87, "Fr", "Francium", "she_her", 223},
	
	{88, "Ra", "Radium", "they_them", 226},
	
	{89, "Ac", "Actinium", "he_him", 227},
	
	{90, "Th", "Thorium", "he_him", 232},
	
	{91, "Pa", "Protactinium", "any_all", 231},
	
	{92, "U", "Uranium", "he_any", 238},
	
	{93, "Np", "Neptunium", "he_any", 237},
	
	{94, "Pu", "Plutonium", "he_any", 244},
	
	{95, "Am", "Americium", "ecatto_eaglenoise_any", 243, config = { extra = {xmult = 3} }, loc_vars = {"xmult"}},
	
	{96, "Cm", "Curium", "she_her", 250},
	
	{97, "Bk", "Berkelium", "he_him", 247},
	
	{98, "Cf", "Californium", "she_her", 251},
	
	{99, "Es", "Einsteinium", "he_him", 252},
	
	{100, "Fm", "Fermium", "they_them", 257},
	
	{101, "Md", "Mendelevium", "he_him", 258},
	
	{102, "No", "Nobelium", "they_them", 259},
	
	{103, "Lr", "Lawrencium", "he_they", 266},
	
	{104, "Rf", "Rutherfordium", "they_any", 267},
	
	{105, "Db", "Dubnium", "tree_trim", 268},
	
	{106, "Sg", "Seaborgium", "she_her", 267},
	
	{107, "Bh", "Bohrium", "they_any", 270},
	
	{108, "Hs", "Hassium", "they_them", 277},
	
	{109, "Mt", "Meitnerium", "she_they", 278},
	
	{110, "Ds", "Darmstadtium", "he_him", 281},
	
	{111, "Rg", "Roentgenium", "they_them", 282},
	
	{112, "Cn", "Copernicium", "he_she", 285},
	
	{113, "Nh", "Nihonium", "she_her", 286},
	
	{114, "Fl", "Flerovium", "he_she", 289},
	
	{115, "Mc", "Moscovium", "he_they", 290},
	
	{116, "Lv", "Livermorium", "she_he", 293},
	
	{117, "Ts", "Tennessine", "she_her", 294},
	
	{118, "Og", "Oganesson", "he_him", 294, 
	function(self, card, context)
		if (context.joker_main and not context.debuffed_hand) or context.forcetrigger then
			return { balance = true }
		end
	end}, 
	
	{119, "Uue", "Ununennium", "unknown", 297, rarity = 4}, --Idk actually the base mass of Uue and Ubn (but they're theoretical so how much does it matter?)
	
	{120, "Ubn", "Unbinilium", "unknown", 300, rarity = 4}
}

SMODS.Atlas({
	key = "elements",
	path = "elements.png",
	px = 71,
	py = 95
})

SMODS.Atlas({ --https://github.com/InertSteak/Pokermon/wiki/Creating-Pokermon-Content#create-shiny-sprites-for-your-cards
	key = "elementsShiny",
	path = "elementsShiny.png",
	px = 71,
	py = 95
})

local inpool = function(self)
	local count = 0
	local percent = 0
	if G.jokers then
		for k,v in pairs(G.jokers.cards) do
			if v.config.center_key == self.key then count = count + 1 end
		end
		percent = count / G.jokers.config.card_limit
	end
	local dups = true
	if self.rarity >= 4 then
		local purrcentcount = elementcattos.countJokers("j_ecattos_purrcent")
		dups = purrcentcount >= 1 + (percent * 4)
		if pseudorandom("ecatto_spawnrate") > 0.75 then return purrcentcount >= 2 end
	else
		if self.rarity <= 1 then
			dups = count <= 2 or percent <= 0.38
		elseif self.rarity == 2 then
			dups = count <= 2 or percent <= 0.2
		elseif self.rarity == 3 then
			dups = (count <= 1 or percent <= 0.1) and pseudorandom("ecatto_spawnrate") > 0.3
		end
	end
	return self.atomic_number ~= 0, {allow_duplicates = dups}
end

local pools = {"ElementCattosCommon", "ElementCattosUncommon", "ElementCattosRare", "ElementCattosLegendary"}

for k,v in pairs(elements) do
	local n = v[1] + 1
	if v[4] and CardPronouns and not CardPronouns.badge_types[v[4]] then
		v[4] = "ecatto_" .. v[4]
		if not CardPronouns.badge_types[v[4]] then
			print("ElementCatlatro | Not found pronouns for key "..v[4])
		end
	end
	if type(v.loc_vars) == "table" then
		v.loc_vars = elementcattos.simpleLocVars(v.loc_vars)
	end
	--[[if not v.rarity then
		print("ElementCatlatro | Not defined rarity for "..v[1].." "..v[3])
	end]]
	local j = SMODS.Joker({
		key = "element" .. tostring(v[1]),
		loc_txt = {
			name = v[3],
			text = {"{C:inactive}Symbol: "..v[2]..", Atomic number: "..tostring(v[1])}
		},
		atlas = "elements",
		pos = {
			x = n % 8,
			y = math.floor(n / 8)
		},
		pronouns = v[4] or "she_her",
		cost = v.cost or 1,
		atomic_number = v[1] or v.atomic_number,
		element_symbol = v[2] or v.element_symbol,
		in_pool = inpool,
		pools = {
			ElementCattosCommon = true,
			ElementCattosUncommon = true,
			ElementCattosRare = true
		},
		rarity = v.rarity or 3,
		config = v.config,
		loc_vars = v.loc_vars,
		calculate = v[6] or elementcattos.defaultJokerCalculate,
		element_base_mass = v[5] or v.element_base_mass
	})
	
	--[[if v[6] then
		topuplib.ezcalc(j, v[6])
	end]]
	if not elementcattos.atomicnumber[v[1]] and v[1] > 0 then
		elementcattos.atomicnumber[v[1]] = j.key
	end
end