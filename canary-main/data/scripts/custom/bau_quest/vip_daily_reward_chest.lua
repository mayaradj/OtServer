local config = {
	storage = 123123, -- Storage para verificar se o jogador pode pegar novamente.
	actionId = 12331, -- action id do baú.
	timeToReward = 24, -- Tempo em horas pra pegar o bau novamente.
	itemsList = {

		{id = 3043, count = 30, chance = 75},
		{id = 3043, count = 100, chance = 90},
		{id = 3043, count = 50, chance = 90},
		{id = 3043, count = 100, chance = 50},
		{id = 3043, count = 50, chance = 50},
		{id = 3043, count = 100, chance = 45},
		{id = 3043, count = 50, chance = 55},
		{id = 3043, count = 100, chance = 89},
		{id = 16106, count = 100, chance = 50},
		{id = 16105, count = 100, chance = 50},
		{id = 16104, count = 100, chance = 50},
		{id = 16111, count = 100, chance = 50},
		{id = 16110, count = 100, chance = 50},
		{id = 16109, count = 100, chance = 50},
		{id = 3079, count = 100, chance = 50},
		{id = 6529, count = 100, chance = 45},
		{id = 16116, count = 100, chance = 50},
		{id = 16096, count = 100, chance = 50},
		{id = 16118, count = 100, chance = 50},
		{id = 7405, count = 100, chance = 50},
		{id = 6529, count = 100, chance = 45},
		{id = 16118, count = 100, chance = 50},
		{id = 6432, count = 100, chance = 25},
	},
}

local function generateItemList()
	local finalList = {}
	for _, item in ipairs(config.itemsList) do
		local itemRand = math.random(100) -- random chance for each individual item listed in the list
		if itemRand <= item.chance then
			finalList[#finalList + 1] = item -- insert item into a new index of finalList
		end
	end
	return finalList
end

local function getMinutes(seconds)
	return math.floor(seconds/60)
end

local rewardChest = Action()

function rewardChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local generateList = generateItemList()
	while #generateList == 0 do
		generateList = generateItemList()
	end

	if player:getStorageValue(config.storage) > os.time() then
		--print(player:getStorageValue(config.storage))
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("You need wait more %d minutes to take this again!", getMinutes(player:getStorageValue(config.storage) - os.time())))
		return false
	end

	for _, item in ipairs(generateList) do
		if player:addItem(item.id, item.count) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format('Congratulations, you won %d %s(s).', item.count, ItemType(item.id):getName()))
			player:setStorageValue(config.storage, os.time() + config.timeToReward * 60 * 60)
			return true
		end
	end

	return true
end

rewardChest:aid(config.actionId)
rewardChest:register()
