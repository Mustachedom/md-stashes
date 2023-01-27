local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('md-stashes:client:stashname1', function ()
    TriggerEvent("inventory:client:SetCurrentStash", "stashname1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "stashname1", {
        maxweight = 4000000,
        slots = 500,
    })
end)
