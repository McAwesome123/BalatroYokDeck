
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
