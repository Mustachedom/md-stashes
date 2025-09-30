local create = {}

local function StartRay(data)
    local run = true
	if data.type == 'object' then
		local heading = 180.0
		local created = false
		local obj = data.object
		local coord = GetEntityCoords(PlayerPedId())
		ps.requestModel(obj)
		local entity = CreateObject(obj, coord.x, coord.y, coord.z, false, false)
		repeat
        	local hit, endCoords, surfaceNormal, matHash = ps.raycast()
        	if not created then
				created = true
				ps.drawText(ps.lang('Interact.drawTextobj'))
			else
				SetEntityCoords(entity, endCoords.x, endCoords.y, endCoords.z)
				SetEntityHeading(entity, heading)
				SetEntityCollision(entity, false, false)
				SetEntityAlpha(entity, 100)
			end
        	if IsControlPressed(0, 174) then
        	    heading = heading - 2
        	end
			if IsControlPressed(0, 175) then
        	    heading = heading + 2
        	end
        	if IsControlPressed(0, 38) then
        	    ps.hideText()
        	    run = false
        	    DeleteEntity(entity)
        	    return {coords = {x = ps.decimalRound(endCoords.x, 2), y = ps.decimalRound(endCoords.y, 2), z = ps.decimalRound(endCoords.z, 2), w = ps.decimalRound(heading, 2)}, object = obj}
        	end

        	if IsControlPressed(0, 178) then
        	    ps.hideText()
        	    run = false
        	    DeleteEntity(entity)
        	    return nil
        	end
            Wait(1)
		until run == false
	else
    	repeat
    	    local wait = 1
    	    local hit, endCoords, surfaceNormal, matHash = ps.raycast()
			ps.drawText(ps.lang('Interact.drawTextCoords', ps.decimalRound(endCoords.x, 2), ps.decimalRound(endCoords.y, 2), ps.decimalRound(endCoords.z, 2)))
    	    DrawMarker(28, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255,
    	    255, 255, false, true, 2, nil, nil, false, false)
    	    if IsControlPressed(0, 38) then
    	        ps.hideText()
    	        run = false
    	        return {coords = {x = ps.decimalRound(endCoords.x, 2), y = ps.decimalRound(endCoords.y, 2), z = ps.decimalRound(endCoords.z, 2)}, object = false}
    	    end

    	    if IsControlPressed(0, 178) then
    	        ps.hideText()
    	        run = false
    	        return nil
    	    end

    	    Wait(wait)
    	until run == false
	end
end

-- Create Stash
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

-- Delete and Goto Stash

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

-- edit 

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