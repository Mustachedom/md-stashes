local create = {}

local function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

local function RayCastGamePlayCamera(distance)
    local currentRenderingCam = false
    if not IsGameplayCamRendering() then
        currentRenderingCam = GetRenderingCam()
    end

    local cameraRotation = not currentRenderingCam and GetGameplayCamRot() or GetCamRot(currentRenderingCam, 2)
    local cameraCoord = not currentRenderingCam and GetGameplayCamCoord() or GetCamCoord(currentRenderingCam)
    local direction = RotationToDirection(cameraRotation)
    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }
    local _, hit, endCoords, surfaceNormal, entityHit  = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
    return _, hit, endCoords, surfaceNormal, entityHit
end

local function ray()
   local _, hit, endCoords, surfaceNormal, entityHit  = RayCastGamePlayCamera(1000.0)
    return hit, endCoords, surfaceNormal, entityHit
end

local function decimalRound(num)
    local num = math.floor(num * 100) / 100
    return num
end

local function StartRay(data)
    local run = true
	if data.type == 'object' then
		local heading = 180.0
		local created = false
		local obj = data.object
		local coord = GetEntityCoords(PlayerPedId())
		requestModel(obj)
		local entity = CreateObject(obj, coord.x, coord.y, coord.z, false, false)
		repeat
        	local hit, endCoords, surfaceNormal, entityHit = ray()
        	if not created then
				created = true
				Bridge.HelpText.ShowHelpText(Bridge.Language.Locale('Interact.drawTextobj'))
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
        	    Bridge.HelpText.HideHelpText()
        	    run = false
        	    DeleteEntity(entity)
        	    return {coords = {x = decimalRound(endCoords.x), y = decimalRound(endCoords.y), z = decimalRound(endCoords.z), w = decimalRound(heading)}, object = obj}
        	end

        	if IsControlPressed(0, 178) then
        	    Bridge.HelpText.HideHelpText()
        	    run = false
        	    DeleteEntity(entity)
        	    return nil
        	end
            Wait(1)
		until run == false
	else
    	repeat
    	    local wait = 1
    	    local hit, endCoords, surfaceNormal, entityHit = ray()
			Bridge.HelpText.ShowHelpText(Bridge.Language.Locale('Interact.drawTextCoords', decimalRound(endCoords.x), decimalRound(endCoords.y), decimalRound(endCoords.z)))
    	    DrawMarker(28, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255,
    	    255, 255, false, true, 2, nil, nil, false, false)
    	    if IsControlPressed(0, 38) then
    	        Bridge.HelpText.HideHelpText()
    	        run = false
    	        return {coords = {x = decimalRound(endCoords.x), y = decimalRound(endCoords.y), z = decimalRound(endCoords.z)}, object = false}
    	    end

    	    if IsControlPressed(0, 178) then
    	        Bridge.HelpText.HideHelpText()
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

local function loadLocale()
    local language = Config.Lang or 'en'
    local file = LoadResourceFile(GetCurrentResourceName(), 'locales/'..language..'.json')
    if not file then
        file = LoadResourceFile(GetCurrentResourceName(), 'locales/en.json')
    end
    return file
end

RegisterNUICallback('initUi', function(_, cb)
    cb({
        Config = Config.Objects,
        lang = json.decode(loadLocale()),
        defaults = Config.Defaults
    })
end)

RegisterNetEvent('md-stashes:client:startNew', function()
    local check = Bridge.Callback.Trigger('md-stashes:server:verifyKey')
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
    local check = Bridge.Callback.Trigger('md-stashes:server:gotoLoc', data)
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
    local check = Bridge.Callback.Trigger('md-stashes:server:verifyKey')
    if not check then return end
    local stashData = Bridge.Callback.Trigger('md-stashes:server:getStashes')
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'editMenu',
        data = stashData
    })
end)