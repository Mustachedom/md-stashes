
RegisterNUICallback('deleteStash', function(data, cb)
    TriggerServerEvent('md-stashes:server:deleteStash', data)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('gotoLoc', function(data, cb)
    SetNuiFocus(false, false)
    local check = ps.callback('md-stashes:server:gotoLoc', data)
    if not check then return end
    cb('ok')
end)