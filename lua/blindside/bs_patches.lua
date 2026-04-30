elementcattos.Bs_Planets_Owned_Check = function(card)
	if card.area ~= G.jokers or not (card.config.center.ecattos_conf and card.config.center.ecattos_conf.t_planet) then return end
	G.GAME.ecattos_iss = G.GAME.ecattos_iss or {unique_count = 0, unique = {}}
	G.GAME.ecattos_iss.unique[card.config.center.key] = true
	G.GAME.ecattos_iss.unique_count = topuplib.countKeys(G.GAME.ecattos_iss.unique)
end

local card_set_ability_ref = Card.set_ability
local cardarea_emplace_ref = CardArea.emplace

function Card:set_ability(center, ...)
	local a = card_set_ability_ref(self, center, ...)
	elementcattos.Bs_Planets_Owned_Check(self)
	return a
end

function CardArea:emplace(card, ...)
	local a = cardarea_emplace_ref(self, card, ...)
	elementcattos.Bs_Planets_Owned_Check(card)
	return a
end