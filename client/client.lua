RegisterNetEvent('pyrp_floods:client:SyncWaterLevel', function(waterLevel)
	Wait(5000) -- Add wait before proceeding to load the water from path hehe.
	if waterLevel == 'default' then
		ResetWater()
	else
		LoadWaterFromPath(GetCurrentResourceName(), "files/"..waterLevel..".xml")
	end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
		ResetWater()
    end
end)
