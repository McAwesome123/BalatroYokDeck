
local atlas_key_legacy = "yokdeck_DeckSkinAtlasLegacy"
local atlas_key_legacy_lc = atlas_key_legacy.."_lc"
local atlas_key_legacy_hc = atlas_key_legacy.."_hc"

local atlas_path_legacy_lc = "YokCardsLegacyLC.png"
local atlas_path_legacy_hc = "YokCardsLegacyHCYellow.png"

local atlas_key_alt = "yokdeck_DeckSkinAtlasAlt"
local atlas_key_alt_lc = atlas_key_alt.."_lc"
local atlas_key_alt_hc = atlas_key_alt.."_hc"

local atlas_path_alt_lc = "YokCardsAltLC.png"
local atlas_path_alt_hc = "YokCardsAltHC.png"

local suits = {"hearts", "clubs", "diamonds", "spades"}
local ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace",}

local description_legacy = "Yockies (Legacy)"
local description_alt = "Yockies (Alternate)"

local skin_key_legacy = "_skin_legacy"
local skin_key_alt = "_skin_alt"

SMODS.Atlas {
	key = atlas_key_legacy_lc,
	px = 71,
	py = 95,
	path = atlas_path_legacy_lc,
	prefix_config = {key = false},
}

if atlas_path_legacy_hc then
	SMODS.Atlas {
		key = atlas_key_legacy_hc,
		px = 71,
		py = 95,
		path = atlas_path_legacy_hc,
		prefix_config = {key = false},
	}
end

for _, suit in ipairs(suits) do
	SMODS.DeckSkin {
		key = suit..skin_key_legacy,
		suit = suit:gsub("^%l", string.upper),
		ranks = ranks,
		lc_atlas = atlas_key_legacy_lc,
		hc_atlas = (atlas_path_legacy_hc and atlas_key_legacy_hc) or atlas_key_legacy_lc,
		loc_txt = {["en-us"] = description_legacy},
		posStyle = "deck"
	}
end

SMODS.Atlas {
	key = atlas_key_alt_lc,
	px = 71,
	py = 95,
	path = atlas_path_alt_lc,
	prefix_config = {key = false},
}

if atlas_path_alt_hc then
	SMODS.Atlas {
		key = atlas_key_alt_hc,
		px = 71,
		py = 95,
		path = atlas_path_alt_hc,
		prefix_config = {key = false},
	}
end

for _, suit in ipairs(suits) do
	SMODS.DeckSkin {
		key = suit..skin_key_alt,
		suit = suit:gsub("^%l", string.upper),
		ranks = ranks,
		lc_atlas = atlas_key_alt_lc,
		hc_atlas = (atlas_path_alt_hc and atlas_key_alt_hc) or atlas_key_alt_lc,
		loc_txt = {["en-us"] = description_alt},
		posStyle = "deck"
	}
end

function set_up_wild_card_override()
	local custom_enhancers_key = "yokdeck_enhancers"
	local custom_enhancers_path = "Enhancers.png"

	SMODS.Atlas {
		key = custom_enhancers_key,
		px = 71,
		py = 95,
		path = custom_enhancers_path,
		prefix_config = {key = false}
	}
	
	function using_alt_deck() 
		for _, suit in ipairs(suits) do
			local suit_key = suit:gsub("^%l", string.upper)
			
			if G.SETTINGS.CUSTOM_DECK.Collabs[suit_key] ~= "yokdeck_"..suit..skin_key_alt then
				return false
			end
		end	
		
		return true
	end

	local wild_card = SMODS.Enhancement:take_ownership("m_wild", {}, true)
	
	function enable_custom_wild_cards()
		wild_card.atlas = custom_enhancers_key
	end
	
	function disable_custom_wild_cards()
		wild_card.atlas = nil
	end
	
	local queue_wild_card_events = {
		wait_for_alt_deck_chosen = nil,
		wait_for_alt_deck_unchosen = nil
	}
	
	local wait_for_alt_deck_chosen_event = Event {
		func = function()
			if not using_alt_deck() then 
				return false 
			end
			
			enable_custom_wild_cards()
			queue_wild_card_events.wait_for_alt_deck_unchosen()
			
			return true
		end,
		blocking = false,
		no_delete = true
	}
	
	local wait_for_alt_deck_unchosen_event = Event {
		func = function()
			if using_alt_deck() then 
				return false 
			end
			
			disable_custom_wild_cards()
			queue_wild_card_events.wait_for_alt_deck_chosen()
			
			return true
		end,
		blocking = false,
		no_delete = true
	}
	
	queue_wild_card_events.wait_for_alt_deck_unchosen = function() 
		G.E_MANAGER:add_event(wait_for_alt_deck_unchosen_event)
	end
	
	queue_wild_card_events.wait_for_alt_deck_chosen = function()
		G.E_MANAGER:add_event(wait_for_alt_deck_chosen_event)
	end
	
	if using_alt_deck() then
		enable_custom_wild_cards()
		queue_wild_card_events.wait_for_alt_deck_unchosen()
	else 
		disable_custom_wild_cards()
		queue_wild_card_events.wait_for_alt_deck_chosen()
	end
end

set_up_wild_card_override()
