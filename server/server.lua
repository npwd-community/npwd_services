local isESX = GetResourceState("es_extended") ~= "missing"
local isQB = GetResourceState("qb-core") ~= "missing"
local FrameworkObj = {}
if isESX and isQB then
	print("[ERROR] You are using both ESX and QB-Core, please remove one of them.")
elseif isESX then
	FrameworkObj = exports["es_extended"]:getSharedObject()
elseif isQB then
	FrameworkObj = exports["qb-core"]:GetCoreObject()
end

if isESX then 
	FrameworkObj.RegisterServerCallback('npwd:services:getPlayers', function(src, cb)
		local PlayerList = {}

		for jobIndex = 1, #Config.Jobs do
			local PlayersWithJob = FrameworkObj.GetExtendedPlayers("job", Config.Jobs[jobIndex])
			for playerIndex = 1, #PlayersWithJob do
				local xPlayer = PlayersWithJob[playerIndex]
				local PlayerData = exports.npwd:getPlayerData({source = src})
				PlayerList[#PlayerList + 1] = {
						name = xPlayer.getName(),
						job = xPlayer.job.name,
						phoneNumber = PlayerData.phoneNumber,
					}
			end
		end
		cb(PlayerList)
	end)
end

if isQB then 
	RegisterNetEvent("npwd:services:getPlayers", function()
		local src = source
		local players = FrameworkObj.Functions.GetQBPlayers()
		local playerList = {}
	
		for _, Player in pairs(players) do
			if not Config.ShowOffDuty and Player.PlayerData.job.onduty then
				for _, job in pairs(Config.Jobs) do
					if job == Player.PlayerData.job.name then
						table.insert(
							playerList,
							{
								name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname,
								job = Player.PlayerData.job.name,
								phoneNumber = Player.PlayerData.charinfo.phone
							}
						)
					end
				end
			end
		end
	
		TriggerClientEvent('npwd:services:sendPlayers', src, playerList)
	end)
end