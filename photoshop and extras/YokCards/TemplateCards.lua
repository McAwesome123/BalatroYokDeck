------ STEAMODDED HEADER
--- MOD_NAME: Doughbyte Cards
--- MOD_ID: TemplateCards
--- MOD_AUTHOR: [prrrki]
--- MOD_DESCRIPTION: Doughbyte Pack

----------------------------------------------
------------MOD CODE -------------------------

function SMODS.INIT.DecColors()

    local dec_mod = SMODS.findModByID("TemplateCards")
    local sprite_card = SMODS.Sprite:new("cards_1", dec_mod.path, "YokCards.png", 71, 95, "asset_atli")
    
    sprite_card:register()
end

----------------------------------------------
------------MOD CODE END----------------------
