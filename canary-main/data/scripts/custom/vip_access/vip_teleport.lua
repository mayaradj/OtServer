-- Deixar vipSystemEnabled = true no config.lua
-- Colocar em canary/data-otservbr-global/scripts/movements/teleport/teleport_vip.lua
-- Só entrar no remere's colocar um teleport, tirar as coords dele e colocar essa Action Id: 34534

local coords = {
    viplocation = { -- Lugar q vai teleportar se for vip
        x = 1906,
        y = 1258,
        z = 7
    },
    nonviplocation = { -- Lugar q vai teleportar se n for vip
        x = 32369,
        y = 32241,
        z = 7
    }
}

local tpvip = MoveEvent()

function tpvip.onStepIn(creature, item, position, fromPosition)
    local player = creature:getPlayer()
    if not player then
        return false
    end
    if player:isVip() then
        local msg = "Seja bem-vindo."
        player:sendTextMessage(MESSAGE_STATUS, msg)
        player:teleportTo(coords.viplocation)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    else
        local msg = "Voce nao eh vip, Be Gone!"
        player:sendCancelMessage(msg)
        player:teleportTo(coords.nonviplocation)
        player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    end
    return true
end

tpvip:type("stepin")
tpvip:aid(40001)
tpvip:register()
