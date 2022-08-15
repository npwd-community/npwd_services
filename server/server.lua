local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("npwd:qb-services:getPlayers", function()
	local src = source
	local players = QBCore.Functions.GetQBPlayers()
	local playerList = {}

	
	for i = 1, #players do
		if not Config.ShowOffDuty and players[i].PlayerData.job.onduty then
			for _, job in pairs(Config.Jobs) do
				if job == players[i].PlayerData.job.label then
					table.insert(playerList, {
						name = players[i].PlayerData.charinfo.firstname .. " " .. players[i].PlayerData.charinfo.lastname,
						job = players[i].PlayerData.job.label,
						phoneNumber = players[i].PlayerData.charinfo.phone,
					})
				end
			end
		end
	end

	TriggerClientEvent('npwd:qb-services:sendPlayers', src, playerList)
end)


