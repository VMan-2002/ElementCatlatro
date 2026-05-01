--Returns all blind centers
function elementcattos.bs_blind_centers()
	return elementcattos.bs_blind_filter(SMODS.Centers, function(bl)
		return getmetatable(bl) == BLINDSIDE.Blind
	end)
end

--Filter blinds according to the given function
--(Keys are retained)
function elementcattos.bs_blind_filter(blinds, filter)
	local ret = {}
	for k,v in ipairs(blinds) do
		if filter(v, v.config and v.config.center) then
			ret[k] = v
		end
	end
	return ret
end

--Amount of blinds that satisfy the filter
function elementcattos.bs_blind_filter_count(blinds, filter)
	return topuplib.countKeys(elementcattos.bs_blind_filter(blinds, filter))
end

--Filter blinds according to the rarity
--rarity:
--"basic": Starter
--"common": Simple
--"rare": Premium
--"curse": Crude
--"legendary": Legendary
function elementcattos.bs_blind_filter_rarity(blinds, rarity, not_matching)
	return elementcattos.bs_blind_filter(blinds, function(bl, cen)
		bl = cen or bl
		if rarity == "common" then
			return (bl.rare or bl.basic or bl.curse or bl.legendary) ~= not_matching
		end
		return bl[rarity] ~= not_matching
	end)
end

--Alert debuff if cond function succeeds
--function-type cond is called with context.scoring_hand
--Also handles some other alert_debuff cases
--not_clearing: Doesn't remove the debuff alert if the condition fails
function elementcattos.bs_alert_debuff(self, context, cond, loc, not_clearing)
	if context.scoring_hand and context.poker_hands and G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.disabled then
		local t = cond(context.scoring_hand)
		if not_clearing and not t then return end
		BLINDSIDE.alert_debuff(self, cond, cond and loc)
	elseif (context.pre_discard or context.before) and not not_clearing then
		BLINDSIDE.alert_debuff(self, false)
	end
end

--Common calculate function
function elementcattos.bs_calculate_common(self, blind, context)
	if context.after then
		if blind.playingfire_adds then
			G.GAME.playing_with_fire_num = G.GAME.playing_with_fire_num + blind.playingfire_adds
			local each = (self.playingfire_more and 1 or 2) + (G.GAME.used_vouchers.v_bld_swearjar and 1 or 0)
			G.GAME.playing_with_fire = G.GAME.playing_with_fire + each * blind.playingfire_adds
			G.GAME.playing_with_fire_each = "bld_playing_with_fire_each_"..each
			blind.playingfire_adds = 0
		end
	end
end

--Modify enemy joker's chips/mult.
--tbl accepts (in this order): chips, mult, xmult, xchips, emult, echips, balance
--immediate: Do this immediately, otherwise return this as a function
function elementcattos.bs_chipsmodify(tbl, immediate)
	local mult, chips, snd = G.GAME.blind.mult, G.GAME.blind.basechips
	if tbl.chips then
		chips = chips + tbl.chips
		snd = "chips1"
	end
	if tbl.mult then
		mult = mult + tbl.mult
		snd = "multhit1"
	end
	if tbl.xchips then
		chips = chips * tbl.chips
		snd = "xchips"
	end
	if tbl.xmult then
		mult = mult * tbl.mult
		snd = "multhit2"
	end
	if tbl.echips then
		chips = math.pow(chips, tbl.echips)
		snd = SMODS.Sounds.talisman_echip and "talisman_echip" or "xchips"
	end
	if tbl.emult then
		mult = math.pow(mult, tbl.emult)
		snd = SMODS.Sounds.talisman_emult and "talisman_emult" or "multhit2"
	end
	if tbl.balance then
		chips = (chips + mult) * 0.5
		mult = math.floor(chips)
		chips = math.ceil(chips)
		snd = "balance"
	end
	if not immediate then
		return {
			func = function() elementcattos.bs_chipsmodify(tbl, true) end,
			message = "!!",
			sound = snd
		}
	end
	BLINDSIDE.chipsmodify(mult - G.GAME.blind.mult, chips - G.GAME.blind.basechips, 0, 0, true)
end