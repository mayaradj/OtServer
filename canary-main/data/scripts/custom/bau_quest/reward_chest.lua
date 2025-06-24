local REWARD_CHEST_UNIQUEID = 12345  -- Unique ID do baú no mapa
local STORAGE = 90001                -- Storage para controle de uso

local rewardChest = Action()

function rewardChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if player:getStorageValue(STORAGE) >= 1 then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce ja pegou essa recompensa.")
        return true
    end

    -- Criar a bag e colocar os itens dentro
    local bag = ItemType(10327) -- Bag ID
    local totalWeight = bag:getWeight() -- peso inicial da bag

    -- Itens da bag
    local bagItems = {
        {id = 3057, amount = 1},
        {id = 3549, amount = 1},
        {id = 22061, amount = 1}
    }

    for _, item in ipairs(bagItems) do
        totalWeight = totalWeight + ItemType(item.id):getWeight(item.amount or 1)
    end

    -- Recompensas fora da bag
    local otherRewards = {
        {id = 3043, amount = 3} -- por exemplo, crystal coins
    }

    for _, item in ipairs(otherRewards) do
        totalWeight = totalWeight + ItemType(item.id):getWeight(item.amount or 1)
    end

    -- Dar recompensas
    local bagItem = player:addItem(10327) -- cria a bag na mochila do player
    for _, item in ipairs(bagItems) do
        bagItem:addItem(item.id, item.amount)
    end

    for _, item in ipairs(otherRewards) do
        player:addItem(item.id, item.amount)
    end

    player:setStorageValue(STORAGE, 1)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce recebeu sua recompensa. Sera teleportado para o templo!")

    -- Efeito visual antes de teleportar
    local effectPos = player:getPosition()
    effectPos:sendMagicEffect(CONST_ME_TELEPORT)

    -- Teleportar para o templo do jogador
    player:teleportTo(player:getTown():getTemplePosition())
    player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)

    return true
end

rewardChest:uid(REWARD_CHEST_UNIQUEID)
rewardChest:register()
