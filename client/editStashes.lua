
RegisterNUICallback('editStash', function(data, cb)
    SendNUIMessage({
        action = 'setEditable',
        data = data
    })
    cb('ok')
end)

RegisterNUICallback('changeLocation', function(data, cb)
    cb('ok')
    SetNuiFocus(false, false)
    local handle = {}
    local objCheck = json.decode(data.data)
    if not objCheck.object then
        handle = {type = 'coords'}
    else
        handle = {type = 'object', object = objCheck.object}
    end
    local coords = StartRay(handle)
    if not coords then
        return
    end
    TriggerServerEvent('md-stashes:server:changeLocation', {id = data, loc = coords})
end)

RegisterNUICallback('saveEdit', function(data, cb)
    TriggerServerEvent('md-stashes:server:saveEdit', data)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNetEvent('md-stashes:client:editStash', function()
    local check = ps.callback('md-stashes:server:verifyKey')
    if not check then return end
    local stashData = ps.callback('md-stashes:server:getStashes')
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'editMenu',
        data = stashData
    })
end)

