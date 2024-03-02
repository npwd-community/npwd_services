local supportedFrameworks = {"es_extended", "qb-core", "ND_Core"}

local frameworks = {
    ["es_extended"] = function()
        local ESX = exports["es_extended"]:getSharedObject()
        ESX.RegisterServerCallback("npwd:services:getPlayers", function(src, cb)
            local PlayerList = {}
    
            for jobIndex =1, #Config.Jobs do
                local PlayersWithJob = ESX.GetExtendedPlayers("job", Config.Jobs[jobIndex])
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
    end,
    ["qb-core"] = function()
        local QBCore = exports["qb-core"]:GetCoreObject()
        RegisterNetEvent("npwd:services:getPlayers", function()
            local src = source
            local players = QBCore.Functions.GetQBPlayers()
            local playerList = {}
        
            
            for i = 1, #players do
                if not Config.ShowOffDuty and players[i].PlayerData.job.onduty then
                    for _, job in pairs(Config.Jobs) do
                        if job == players[i].PlayerData.job.name then
                            table.insert(playerList, {
                                name = players[i].PlayerData.charinfo.firstname .. " " .. players[i].PlayerData.charinfo.lastname,
                                job = players[i].PlayerData.job.name,
                                phoneNumber = players[i].PlayerData.charinfo.phone,
                            })
                        end
                    end
                end
            end
        
            TriggerClientEvent("npwd:services:sendPlayers", src, playerList)
        end)
    end,
    ["ND_Core"] = function()
        local NDCore = exports["ND_Core"]
        local NDCoreGroups = NDCore:getConfig("groups") or {}

        local function hasServiceJob(job)
            local services = Config.Jobs
            for i=1, #services do
                if job == services[i] then
                    local groupFound = NDCoreGroups[player.job]
                    return groupFound and groupFound.label or job
                end
            end
        end

        RegisterNetEvent("npwd:services:getPlayers", function()
            local src = source
            local players = NDCore:getPlayers()
            local playerList = {}
        
            for src, player in pairs(players) do
                local serviceJob = hasServiceJob(player.job)
                if not serviceJob then goto next end

                table.insert(playerList, {
                    name = player.firstname .. " " .. player.lastname,
                    job = serviceJob,
                    phoneNumber = player.phonenumber
                })
                
                ::next::
            end
    
            TriggerClientEvent("npwd:services:sendPlayers", src, playerList)
        end)
    end
}

for i=1, #supportedFrameworks do
    local fw = supportedFrameworks[i]
    if GetResourceState(fw) ~= "missing" then
        frameworks[fw]()
        print(("Using %s framework for npwd_services"):format(fw))
        break
    end
end
