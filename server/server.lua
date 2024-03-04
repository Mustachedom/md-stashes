local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
if Config.OxInv then
    for k, v in pairs (Config.stash) do 
        if v.weight == nil then v.weight = Config.Defaultweight end
		if v.slot == nil then v.slot = Config.Defaultslot end
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

QBCore.Commands.Add('newstash',"Make A New Stash", {},false, function(source)
local src = source
local Player = QBCore.Functions.GetPlayer(src)    
    TriggerClientEvent('md-stashes:client:doray', src)         
end,'admin')