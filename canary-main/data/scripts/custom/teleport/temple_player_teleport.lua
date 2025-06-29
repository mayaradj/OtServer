
local portal = MoveEvent()

function portal.onStepIn(player)
    local inPz = player:getTile():hasFlag(TILESTATE_PROTECTIONZONE)

--     	local inFight = player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)
--     	if not inPz and inFight then
--     		return error({ code = 0, message = "You can't use temple teleport in fight!" })
--     	end

    	player:teleportTo(player:getTown():getTemplePosition())
    	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
    	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been teleported to your hometown.")

end

portal:type("stepin")
portal:aid(40005)
portal:register()
