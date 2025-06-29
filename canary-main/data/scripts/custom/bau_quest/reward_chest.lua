-- CONFIGURAÇÕES GLOBAIS
local CHESTS_CONFIG = {
    -- Baú de Recompensa Principal
    REWARD_CHEST = {
        uniqueId = 23625,
        storage = 90001,
        messageAlreadyUsed = "Pegou essa recompensa.",
        messageSuccess = "Recebeu sua recompensa. Vai ser teleportado para o templo!",
        bag = {
            id = 10327,
            items = {
                {id = 3057, amount = 1},  -- Item 1
                {id = 3549, amount = 1},  -- Item 2
                {id = 22061, amount = 1}  -- Item 3
            }
        },
        otherRewards = {
            {id = 3043, amount = 3}  -- Crystal coins
        },
        teleportAfter = true,
        effects = true
    },

    -- Baú Aleatório
    RANDOM_CHEST = {
        uniqueId = 22625,
        storage = 90002,
        messageAlreadyUsed = "Peguou os itens daqui.",
        messageSuccess = "Coletou esse bau!",
        otherRewards = {
            {id = 237, amount = 50},  -- Mana potion
            {id = 3048, amount = 1}   -- Might ring
        },
        teleportAfter = false,
        effects = false
    }
}

-- FUNÇÃO PARA DAR RECOMPENSAS
local function giveRewards(player, config)
    -- Adiciona itens da bag se existir na configuração
    if config.bag then
        local bagItem = player:addItem(config.bag.id)
        for _, item in ipairs(config.bag.items) do
            bagItem:addItem(item.id, item.amount or 1)
        end
    end

    -- Adiciona outros itens
    if config.otherRewards then
        for _, item in ipairs(config.otherRewards) do
            player:addItem(item.id, item.amount or 1)
        end
    end

    -- Efeitos e teleporte se configurado
    if config.effects then
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end

    if config.teleportAfter then
        player:teleportTo(player:getTown():getTemplePosition())
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end

    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.messageSuccess)
    player:setStorageValue(config.storage, 1)
end

-- REGISTRO DOS BAÚS
for chestName, config in pairs(CHESTS_CONFIG) do
    local action = Action()

    function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
        if player:getStorageValue(config.storage) >= 1 then
            player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.messageAlreadyUsed)
            return true
        end

        giveRewards(player, config)
        return true
    end

    action:uid(config.uniqueId)
    action:register()
end
