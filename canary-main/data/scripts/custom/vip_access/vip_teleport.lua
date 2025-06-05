local failPosition = Position(32369, 32241, 7)

local vipPortal = MoveEvent()

function vipPortal.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()

    if not player then
        return true
    end

    if player:isVip() then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Bem-vindo a area VIP!")
        return true
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Voce nao possui acesso VIP.")
        player:teleportTo(failPosition)
        return true
    end
end

vipPortal:type("stepin")
vipPortal:aid(40001)
vipPortal:register()
