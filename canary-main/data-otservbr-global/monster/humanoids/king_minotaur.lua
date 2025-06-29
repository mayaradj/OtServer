local mType = Game.createMonsterType("King Minotaur")
local monster = {}

monster.description = "King Minotaur"
monster.experience = 5000
monster.outfit = {
	lookType = 607,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.health = 5500
monster.maxHealth = 5500
monster.race = "blood"
monster.corpse = 20996
monster.speed = 100
monster.manaCost = 0

monster.changeTarget = {
	interval = 60000,
	chance = 0,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 50,
	targetDistance = 3,
	runHealth = 150,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = false,
	canWalkOnPoison = false,
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 40,
	{ text = "Eles te enviaram...", yell = false },
	{ text = "Arrrgh!", yell = false },
	{ text = "Matarei todos!", yell = false },
	{ text = "§%§&§! #*$§$!!", yell = false },
	{ text = "Covardes!", yell = false },
}

monster.loot = {
	{ id = 3031, chance = 100000, maxCount = 195 }, -- gold coin
  { id = 3035, chance = 58160, maxCount = 2 }, -- platinum coin
  { id = 21200, chance = 2740, maxCount = 2 }, -- moohtant horn
  { id = 3030, chance = 4680, maxCount = 5 }, -- small ruby
	{ id = 3357, chance = 78000 }, -- plate armor
	{ id = 3370, chance = 28000 }, -- knight armor
	{ id = 3028, chance = 14000 }, -- small diamond
	{ id = 3275, chance = 7000 }, -- double axe
	{ id = 5926, chance = 1400 }, -- minotaur backpack
	{ id = 7452, chance = 830 }, -- spiked squelcher
  { id = 7427, chance = 480 }, -- chaos mace
  { id = 9058, chance = 480 }, -- gold ingot
  { id = 7401, chance = 480 }, -- minotaur trophy
}

monster.attacks = {
	{ name = "melee", interval = 2000, chance = 100, minDamage = -50, maxDamage = -300 },
	{ name = "combat", interval = 4000, chance = 60, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -220, shootEffect = CONST_ANI_THROWINGKNIFE, target = false },
	{ name = "combat", interval = 6000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = -50, maxDamage = -210, radius = 3, effect = CONST_ME_GROUNDSHAKER, target = false },

}

monster.defenses = {
	defense = 50,
	armor = 35,
	mitigation = 1.24,
	{ name = "combat", interval = 5000, chance = 35, type = COMBAT_HEALING, minDamage = 100, maxDamage = 350, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 0 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 0 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 0 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)


local kingMinotaurDeath = CreatureEvent("KingMinotaurDeath")

function kingMinotaurDeath.onDeath(creature, corpse, killer, mostDamageKiller, unjustified, mostDamageUnjustified)
    -- Verifica se a criatura morta é o King Minotaur (comparação case-insensitive)
    if creature:getName():lower() == "king minotaur" then
        local position = creature:getPosition()

        -- Cria o teleport próximo ao local da morte (1 tile acima)
        local teleportPosition = Position(position.x, position.y, position.z)
        local teleport = Game.createItem(34111, 1, teleportPosition) -- ID 34111 é o teleport

        if teleport then
            -- Configura o destino do teleport
            teleport:setDestination(Position(786, 1179, 8))

            -- Adiciona um efeito visual
            position:sendMagicEffect(CONST_ME_TELEPORT)

            -- Faz o teleport desaparecer após 60 segundos (opcional)
            addEvent(function()
                local tile = Tile(teleportPosition)
                if tile then
                    local teleportItem = tile:getItemById(34111)
                    if teleportItem then
                        teleportItem:remove()
                        teleportPosition:sendMagicEffect(CONST_ME_POFF)
                    end
                end
            end, 60 * 1000)
        end
    end
    return true
end

kingMinotaurDeath:register()

-- Registrar o evento para o King Minotaur usando o nome exato do arquivo
local monsterType = MonsterType("King Minotaur")
if monsterType then
    monsterType:registerEvent("KingMinotaurDeath")
end

