local QBCore = exports['qb-core']:GetCoreObject()
local logs = false 
local logapi = GetConvar("fivemerrLogs", "")
local endpoint = 'https://api.fivemerr.com/v1/logs'
local headers = {
            ['Authorization'] = logapi,
            ['Content-Type'] = 'application/json',
    }
local key = 'adsjhaskd' .. math.random(1, 1000000) .. 'asdasd' .. math.random(1,5) .. math.random(1,5) .. 'asdasd' .. 'ertyhzxcdjSA'

CreateThread(function()
if logs then 
    print'^2 Logs Enabled for md-stashes'
    if logapi == nil then 
        print'^1 TURN LINE 2 TO FALSE OR ADD fivemerrLogs TO YOUR CFG LIKE THE README SAYS'
    else
        print'^2 API Key Looks Good, Dont Trust Me Though, Im Not Smart'
    end
else
    print'^1 logs disabled for md-stashes'
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
                if not response then 
                    print('^1[ERROR] ^7Failed to send logs to fivemerr')
                    return end
                 if type(response) == 'string' then
                     response = json.decode(response) or response
                 end
             end
         end, 'POST', json.encode(buffer), headers)
         buffer = nil
     end)
end

lib.addCommand('newstash', {
    help = "Make A New Stash",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    local info = Player.PlayerData.charinfo
    local send =  lib.callback.await('md-stashes:client:makeNew', src, key)
    if not send then return end
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
      print('^1 You Wouldnt See This If You Had Read The ReadMe.md')
   end
end)

RegisterServerEvent('md-stashes:server:makenew', function(loc, name, data)
    if not IsPlayerAceAllowed(source, 'command') then return false end
    MySQL.insert('INSERT INTO mdstashes SET loc = ?, name = ?, data = ?',
    {loc, name, data})
    TriggerClientEvent('md-stashes:client:makenew', -1)
end)

lib.callback.register('md-stashes:server:GetStashes', function(source)
   local result = MySQL.query.await('SELECT * FROM mdstashes',{})
   if not result[1] then print('^1 You Either Didnt Run The SQL Or You Have No Stashes') return false end
   for i = 1, #result do
        local data = json.decode(result[i].data)
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:RegisterStash(result[i].name, result[i].name, data['slots'],data['weight'])
        end
   end
   return result
end)

lib.callback.register('md-stashes:server:GetKeys', function(source)
    if not IsPlayerAceAllowed(source, 'command') then return false end
    return key
 end)

lib.addCommand('editStashes', {
    help = "Edit Stash Data",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local Data = MySQL.query.await('SELECT * FROM mdstashes')
    local options = lib.callback.await('md-stashes:client:edit', src, Data)
    if not options then return end
end)

lib.addCommand('DeleteStashes', {
    help = "Delete A Stash",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local Data = MySQL.query.await('SELECT * FROM mdstashes')
    local options = lib.callback.await('md-stashes:client:deleteSelectedStash', src, Data)
    if not options then return end
end)


RegisterServerEvent('md-stashes:server:edit', function(new)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then return false end
    MySQL.query.await('UPDATE mdstashes SET data = ? WHERE name = ?', {new[1].data, new[1].name})
    TriggerClientEvent('md-stashes:client:makenew', -1)
end)

RegisterServerEvent('md-stashes:server:deleteStash', function(name)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then return false end
    MySQL.query.await('DELETE FROM mdstashes WHERE name = ?', {name})
    TriggerClientEvent('md-stashes:client:makenew', -1)
end)

lib.addCommand('ConvertStashSQL', {
    help = "YOU ONLY NEED TO DO THIS ONCE, LITERALLY ONE TIME EVER",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local Data = MySQL.query.await('SELECT * FROM mdstashes')
    if not Data[1].data then
        MySQL.Async.execute('ALTER TABLE mdstashes ADD COLUMN data VARCHAR(255);', {})
    end
    local hold = {}
    Wait(5000)
    for i = 1, #Data do 
        local v = Data[i]
        if v.item == nil then v.item = false end
        if v.password == 0 then v.password = false end
        if v.citizenid == '0' then v.citizenid = false end
        local new = json.encode({
            job = v.job or false,
            gang = v.gang or false,
            rank = v.rank or 0,
            weight = v.weight,
            slots = v.slots,
            item = v.item or false, 
            targetlabel = 'Open Stash',
            password = v.password or false,
            citizenid = v.citizenid or false,
            object = false,
        })
        MySQL.update('UPDATE mdstashes SET loc = ?, name = ?, data = ? WHERE id = ?', {v.loc, v.name, new, i})
    end
    Wait(5000)
    local query = [[
        ALTER TABLE mdstashes 
        DROP COLUMN job, 
        DROP COLUMN gang, 
        DROP COLUMN rank, 
        DROP COLUMN weight, 
        DROP COLUMN slots, 
        DROP COLUMN item, 
        DROP COLUMN targetlabel, 
        DROP COLUMN password, 
        DROP COLUMN citizenid;
    ]]
    MySQL.Async.execute(query, {})
end)

