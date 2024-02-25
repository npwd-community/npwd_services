local supportedFrameworks = {"es_extended", "qb-core", "ND_Core"}

local frameworks = {
    ["es_extended"] = function()
        local ESX = exports["es_extended"]:getSharedObject()

        RegisterNUICallback("npwd:services:getPlayers", function(_, cb)
            ESX.TriggerServerCallback("npwd:services:getPlayers", function(PlayerList)
                cb({ status = "ok", data = PlayerList })
            end)
        end)
        
        RegisterNUICallback("npwd:services:callPlayer", function(data, cb)
            -- print(data.job) job of player being called
            exports.npwd:startPhoneCall(tostring(data.number))
            cb({})
        end)
    end,
    ["qb-core"] = function()
        RegisterNUICallback("npwd:services:getPlayers", function(_, cb)
            TriggerServerEvent("npwd:services:getPlayers")
            RegisterNetEvent("npwd:services:sendPlayers", function(players)
                cb({ status = "ok", data = players })
            end)
        end)
        
        RegisterNUICallback("npwd:services:callPlayer", function(data, cb)
            -- print(data.job) job of player being called
            exports.npwd:startPhoneCall(tostring(data.number))
            cb({})
        end)
    end,
    ["ND_Core"] = function()
        RegisterNUICallback("npwd:services:getPlayers", function(_, cb)
            TriggerServerEvent("npwd:services:getPlayers")
            RegisterNetEvent("npwd:services:sendPlayers", function(players)
                cb({ status = "ok", data = players })
            end)
        end)
        
        RegisterNUICallback("npwd:services:callPlayer", function(data, cb)
            -- print(data.job) job of player being called
            exports.npwd:startPhoneCall(tostring(data.number))
            cb({})
        end)
    end
}

for i=1, #supportedFrameworks do
    local fw = supportedFrameworks[i]
    if GetResourceState(fw) ~= "missing" then
        frameworks[fw]()
        break
    end
end
