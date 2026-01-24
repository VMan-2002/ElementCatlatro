

-- 1 in whatever chance for shop Jokers to be Legendary
-- uhm m modified from ellejokers
local gcp_hook = get_current_pool
function get_current_pool(_type, _rarity, _legendary, _append)
	local purrcentcount = math.min(elementcattos.countJokers("j_ecattos_purrcent"), 6)
	
    if purrcentcount>0 and _type == 'Joker' and _append == 'sho' and pseudorandom('ECattosPurrcent'..G.GAME.round_resets.ante.._append, 1, 3+math.ceil(14 / purrcentcount))==1 then _legendary = true end
    return gcp_hook(_type, _rarity, _legendary, _append)
end

-- Description for extended element
local localize_ref = topuplib.localizeHook
local ex
topuplib.localizeHook = function(args, loc_target, misc_cat, ...)
	if args.key == "j_ecattos_element_extended" then
		ex = G.localization.misc.ecattos_extended_element
		print("Did replace for TBA catto")
		print(loc_target)
		G_tba_loc_target = loc_target
		return {name = ex.name(args.vars.atomic_number or 999)}
	end
	--print("Dont replace, not TBA catto")
	return localize_ref(args, loc_target, misc_cat, ...)
end