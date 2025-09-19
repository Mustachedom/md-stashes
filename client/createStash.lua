local create = {}

RegisterNUICallback('hideUI', function(_, cb)
    cb({})
    SetNuiFocus(false, false)
end)

RegisterNUICallback('createStash', function(data, cb)
    cb('ok')
    if not create.coords then
        return
    end
    for k, v in pairs(data) do
        create.data[k] = v
    end
    TriggerServerEvent('md-stashes:server:createStash', { data = create.data, coords = create.coords })
    SetNuiFocus(false, false)
    create = {}
end)

RegisterNUICallback('submitSelection', function(data, cb)
    cb('ok')
    SetNuiFocus(false, false)
    local coords = StartRay(data)
    if not coords then
        return
    end
    create.coords = coords.coords
    create.data = {}
    create.data.object = coords.object
    SendNUIMessage({
        action = 'setVisible',
        data = true
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('initUi', function(_, cb)
    cb({
        Config = Config.Objects,
        lang = ps.getLang(),
        defaults = Config.Defaults
    })
end)

RegisterNetEvent('md-stashes:client:startNew', function()
    local check = ps.callback('md-stashes:server:verifyKey')
    if not check then return end
    SendNUIMessage({ action = 'firstMenu' })
    SetNuiFocus(true, true)
end)

