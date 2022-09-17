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
	RegisterNUICallback("npwd:services:getPlayers", function(_, cb)
		FrameworkObj.TriggerServerCallback("npwd:services:getPlayers", function(PlayerList)
			cb({ status = "ok", data = PlayerList })
		end)
	end)
	
	
	RegisterNUICallback("npwd:services:callPlayer", function(data, cb)
		-- print(data.job) job of player being called
		exports.npwd:startPhoneCall(tostring(data.number))
		cb({})
	end)
end

if isQB then 
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

