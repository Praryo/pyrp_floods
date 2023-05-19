local currentWaterLevel = "default"

local function SyncWaterLevel(all, src)
	if all then
		TriggerClientEvent("pyrp_floods:client:SyncWaterLevel", -1, currentWaterLevel)
	else
		TriggerClientEvent("pyrp_floods:client:SyncWaterLevel", src, currentWaterLevel)
	end
end

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == Config.FloodStamps[1] * 60 then -- Level 1
		currentWaterLevel = "water1"
		SyncWaterLevel(true)
    end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == Config.FloodStamps[2] * 60 then -- Level 2
		currentWaterLevel = "water2"
		SyncWaterLevel(true)
    end
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == Config.FloodStamps[3] * 60 then -- Level 3
		currentWaterLevel = "water3"
		SyncWaterLevel(true)
    end
end)

-- Frameworks initializer
local function hasResource(name)
	return GetResourceState(name):find('start') ~= nil
end

local core = (hasResource('es_extended') and 'esx') or (hasResource('qb-core') and 'qb') or ''
if core ~= 'esx' and core ~= 'qb' then
	print("[^5PYRP] ^0Framework like qb-core / es_extended not found, syncing with newly joined players will not be available.")
	return 
end

if core == "esx" then
	AddEventHandler('esx:playerLoaded', function(playerId)
		SyncWaterLevel(false, playerId)
	end)
elseif core == "qb" then
	AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
		SyncWaterLevel(false, Player.PlayerData.source)
	end)
end
