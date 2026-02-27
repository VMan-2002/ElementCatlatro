SMODS.Challenge {
	key = "peakdeckfixing",
	rules = {
		modifiers = {
			{id="joker_slots", value = 3},
			{id="dollars", value = 2},
			{id="discards", value = 2}
		},
		custom = {
			{id="scaling", value = 1300000},
			{id="enable_perishables_in_shop"}
		}
	},
	restrictions = {
		banned_cards = {
			{id = 'p_standard_normal_1', ids = {
				'p_standard_normal_1','p_standard_normal_2','p_standard_normal_3','p_standard_normal_4','p_standard_jumbo_1','p_standard_jumbo_2','p_standard_mega_1','p_standard_mega_2',
			}},
			{id = 'p_celestial_normal_1', ids = {
				'p_celestial_normal_1','p_celestial_normal_2','p_celestial_normal_3','p_celestial_normal_4','p_celestial_jumbo_1','p_celestial_jumbo_2','p_celestial_mega_1','p_celestial_mega_2',
			}},
			{id = "c_trance"},
			{id = "p_ecattos_element_tools"},
			{id = "j_ecattos_element10"},
			{id = "v_magic_trick"},
			{id = "v_planet_merchant"},
			{id = "j_certificate"},
			{id = "c_ankh"},
			{id = "c_ecattos_duplicator"},
			{id = "c_ecattos_stabilizer"},
			{id = "c_ecattos_weakray"},
			{id = "j_brainstorm"}
		}
	},
	jokers = {
		{id = "j_ecattos_compound_pkzilla1", eternal = true, pinned = true, stickers={"ecattos_placeholder"}}
	}
}

local carbongaming_allows = {
	[1]=true,[2]=true,[4]=true,[6]=true,[7]=true,[8]=true,[10]=true,[27]=true,[34]=true,[60]=true,[118]=true
}
local carbongaming_bans = {}
for i = 1, 120 do
	if not carbongaming_allows[i] then
		table.insert(carbongaming_bans, {id="j_ecattos_element"..tostring(i)})
	end
end

SMODS.Challenge {
	key = "carbongaming",
	rules = {
		modifiers = {
			{id="joker_slots", value = 29},
			{id="dollars", value = 12}
		},
		custom = {
			{id="ecattos_challenge_banlist"},
			{id="topuplib_debuff_joker_except", value = {"j_ecattos_element6", "j_ecattos_yomium", "j_blueprint", "j_brainstorm", "j_poke_zorua", "j_poke_zoroark", "j_poke_ditto", "j_invisible"}},
		}
	},
	restrictions = {
		banned_cards = carbongaming_bans
	},
	vouchers = {
		{id="v_overstock_norm"},
		{id="v_overstock_plus"}
	}
}