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

RegisterServerEvent('md-stashes:server:makenew', function(loc, name, job, gang, rank, item, slots, weight, password, cid)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local location = json.decode(loc)
    if job == "" then job = nil end
    if gang == "" then gang = nil end
    if rank == "" then rank = 0 end
    if item == "" then item = nil end
    if slots == "" then slots = Config.Defaultslot end
    if weight == "" then weight = Config.Defaultweight end
    if password == "" then password = 0 end
    if cid == "" then cid = '0' end
    MySQL.insert('INSERT INTO mdstashes SET loc = ?, name = ?, job = ?, gang = ?, rank = ?, weight = ?, slots = ?, item = ?, targetlabel = ?, password = ?, citizenid = ?',
    {loc, name,job,gang, rank ,weight,slots,item, 'Open Stash', password, cid})
    TriggerClientEvent('md-stashes:client:makenew', -1)
end)

lib.callback.register('md-stashes:server:GetStashes', function(source)
   local result = MySQL.query.await('SELECT * FROM mdstashes',{})
   local stashes = {}
   for i = 1, #result do 
    local a = result[i]
    table.insert(stashes, {
        id = a.id,
        loc = a.loc, 
        name = a.name,
        job = a.job,
        gang = a.gang,
        rank = a.rank,
        weight = a.weight,
        slots = a.slots,
        item = a.item,
        targetlabel = a.targetlabel,
        password = a.password,
        citizenid = a.citizenid,
    })
        if GetResourceState('ox_inventory') == 'started' then
            exports.ox_inventory:RegisterStash(a.name, a.name, a.slots, a.weight)
        end
   end
   return stashes
end)

lib.addCommand('ImportConfigStashes', {
    help = "YOU ONLY NEED TO DO THIS ONCE, LITERALLY ONE TIME EVER",
    restricted = 'group.admin',
}, function(source, args, raw)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src) 
    local info = Player.PlayerData.charinfo
    for k, v in pairs (Config.stash) do 
        local loc = json.encode({
            x = v.loc.x,
            y = v.loc.y,
            z = v.loc.z
        })
        if v.loc == nil then return end
        if v.cid == nil then v.cid = '0' end
        if v.rank == nil then v.rank = 0 end
        if v.password == nil then v.password = 0 end
        MySQL.insert('INSERT INTO mdstashes SET loc = ?, name = ?, job = ?, gang = ?, rank = ?, weight = ?, slots = ?, item = ?, targetlabel = ?, password = ?, citizenid = ?',
        {loc, k,v.job,v.gang, v.rank ,v.weight,v.slots,v.item, 'Open Stash', v.password, v.cid})
    end
    Log('ID: ' .. source .. ' Name: ' .. info.firstname .. ' ' .. info.lastname .. ' Used Command IMPORT CONFIG STASHES', 'command')

end)

