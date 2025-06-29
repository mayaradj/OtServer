local livroMestre = Action()

function livroMestre.onUse(player, item, fromPosition, target, toPosition, isHotkey)

    player:say("Acho que deixaram o livro colado no piso, talvez isso explique como vim parar aqui.", TALKTYPE_MONSTER_SAY)

    return false
end

livroMestre:aid(26625)  -- Registra para o ActionID 26625
livroMestre:register()
