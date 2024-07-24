local QBCore = exports['qb-core']:GetCoreObject()
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
            ['Authorization'] = logapi,
            ['Content-Type'] = 'application/json',
    }

CreateThread(function()
if logs then 
    print'^2 Logs Enabled for md-stashes'
    if logapi == 'insert string here' then 
        print'^1 homie you gotta set your api on line 3'
    else
        print'^2 API Key Looks Good, Dont Trust Me Though, Im Not Smart'
    end
else
    print'^1 logs disabled for md-drugs'
end
end)
local function Log(message, type)
if logs == false then return end	
    local buffer = {
        level = "info",
        message = message,
        resource = GetCurrentResourceName(),
        metadata = {
            stash = type,
            playerid = source
        }
    }
     SetTimeout(500, function()
         PerformHttpRequest(endpoint, function(status, _, _, response)
             if status ~= 200 then 
                 if type(response) == 'string' then
                     response = json.decode(response) or response
                 end
             end
         end, 'POST', json.encode(buffer), headers)
         buffer = nil
     end)
end

CreateThread(function()
if Config.Inv == 'ox' then
    for k, v in pairs (Config.stash) do 
        if v.weight == nil then v.weight = Config.Defaultweight end
	if v.slots == nil then v.slots = Config.Defaultslot end
        local stash = {
        id = k,
        label = v.name,
        slots = v.slots,
        weight = v.weight,
        }
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    end
end    
end)

lib.addCommand('newstash', {
    help = "Make A New Stash",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    local info = Player.PlayerData.charinfo
    TriggerClientEvent('md-stashes:client:doray', src)
    Log('ID: ' .. source .. ' Name: ' .. info.firstname .. ' ' .. info.lastname .. ' Used Command newstash', 'command')
end)

RegisterServerEvent('md-stashes:server:OpenStash', function(name, weight, slot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local data = { label = name, maxweight = weight, slots = slot }
    if GetResourceState('qb-inventory') == 'started' then
    	exports['qb-inventory']:OpenInventory(source, name, data)
   elseif GetResourceState('ps-inventory') == 'started' then
	exports['ps-inventory']:OpenInventory(source, name, data)
   else
      print('follow the readme')
   end
end)
