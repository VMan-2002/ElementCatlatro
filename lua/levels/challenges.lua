SMODS.Challenge {
	key = "peakdeckfixing",
	rules = {
		modifiers = {
			{id="joker_slots", value = 3},
			{id="dollars", value = 2},
			{id="discards", value = 2}
		},
		custom = {
			{id="scaling", value = 600000},
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
		}
	},
	jokers = {
		{id = "j_ecattos_compound_pkzilla1", eternal = true, pinned = true, stickers={"ecattos_placeholder"}}
	}
}