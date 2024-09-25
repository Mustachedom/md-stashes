local invcall = ''
CreateThread(function()
	if GetResourceState('ps-inventory') == 'started' then
		invcall = 'ps-inventory'
	elseif GetResourceState('qb-inventory') == 'started' then 
		invcall = 'qb-inventory'
	elseif GetResourceState('lj-inventory') == 'started' then
		invcall = 'inventory'
	end
end)
		

function OpenStash(name, weight, slot, password)
	if password ~= 0 then
		local input = lib.inputDialog('Password', {
			 {type = 'input', label = 'Password', description = 'What Is The Password', required = true},
		})
		local combo = input[1]
		if password == combo then
			if Config.Inv == 'ox' then
				exports.ox_inventory:openInventory('stash', {id = name})
			elseif Config.Inv == 'oldqb' then 
				Wait(100)
				TriggerEvent(invcall..":client:SetCurrentStash", name)
				TriggerServerEvent(invcall..":server:OpenInventory", "stash", name, {
					maxweight = weight,
					slots = slot,
				})
			elseif Config.Inv == 'qs' then
				local other = {}
				other.maxweight = weight -- Custom weight statsh
				other.slots = slot -- Custom slots spaces
				TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..name, other)
				TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..name)
			elseif Config.Inv == 'qb' then
				TriggerServerEvent('md-stashes:server:OpenStash', name, weight, slot)
			end
		end	
	else
		if Config.Inv == 'ox' then
			exports.ox_inventory:openInventory('stash', {id = name})
		elseif Config.Inv == 'oldqb' then 
			Wait(100)
			TriggerEvent(invcall..":client:SetCurrentStash", name)
			TriggerServerEvent(invcall..":server:OpenInventory", "stash", name, {
				maxweight = weight,
				slots = slot,
			})
		elseif Config.Inv == 'qs' then
			local other = {}
			other.maxweight = weight -- Custom weight statsh
			other.slots = slot -- Custom slots spaces
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "Stash_"..name, other)
			TriggerEvent("inventory:client:SetCurrentStash", "Stash_"..name)
		elseif Config.Inv == 'qb' then
			TriggerServerEvent('md-stashes:server:OpenStash', name, weight, slot)
		end
	end
end

function StartRay()
    local run = true
	local input = lib.inputDialog('Object Or Location', {
        {type = 'select', label = 'Type Of Stash', options = {{value = true, label = 'Object'}, {value = false, label = 'Location'}}},
       })
	if input[1] then
		local objects = {}
		for k, v in pairs (Config.Objects) do
			table.insert(objects,{
				value = v.value,
				label = v.label
			})
		end
		local objectchoice = lib.inputDialog('Object Or Location', {
			{type = 'select', label = 'What Object', options = objects,searchable = true, }
		   })

		local heading = 180.0
		local created = false
		local obj = objectchoice[1]
		local coord = GetEntityCoords(PlayerPedId())
		lib.requestModel(obj, 30000)
		local entity = CreateObject(obj, coord.x, coord.y, coord.z, false, false)
		repeat
        	local hit, entityHit, endCoords, surfaceNormal, matHash = lib.raycast.cam(511, 4, 10)
        	if not created then 
				created = true
				lib.showTextUI('[E] To Place  \n  [DEL] To Cancel  \n  [<-] To Move Left  \n  [->] To Move Right')
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
        	    lib.hideTextUI()
        	    run = false
        	    DeleteEntity(entity)
        	    return endCoords, heading, obj
        	end

        	if IsControlPressed(0, 178) then
        	    lib.hideTextUI()
        	    run = false
        	    DeleteEntity(entity)
        	    return nil
        	end
		until run == false
	else
    	repeat
    	    local Wait = 1
    	    local hit, entityHit, endCoords, surfaceNormal, matHash = lib.raycast.cam(511, 4, 10)
    	    lib.showTextUI('Raycast Coords:  \n X:  ' ..
    	    math.floor(endCoords.x * 100) / 100 .. ',  \n Y:  ' .. math.floor(endCoords.y * 100) / 100 .. ',  \n Z:  ' .. math.floor(endCoords.z * 100) / 100 .. '  \n[E] to copy  \n[DEL] to cancel')
    	    DrawMarker(28, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255,
    	    255, 255, false, true, 2, nil, nil, false, false)
    	    if IsControlPressed(0, 38) then
    	        lib.hideTextUI()
    	        run = false
    	        return endCoords, nil, false
    	    end

    	    if IsControlPressed(0, 178) then
    	        lib.hideTextUI()
    	        run = false
    	        return nil
    	    end

    	    Citizen.Wait(Wait)
    	until run == false
	end
end

function AddBoxZone(name, coords, options)
    if Config.Target == 'ox' then 
       name = exports.ox_target:addBoxZone({coords = coords, size = vec3(1,1,1), options = {
            {label = options.label, event = options.event or nil,onSelect = options.action or nil, canInteract = options.canInteract,}
       }} )
    elseif Config.Target == 'qb' then
        exports['qb-target']:AddBoxZone(name,coords, 1.0, 1.0, {name = name, heading = 156.0,minZ = coords.z-1, maxZ = coords.z+1, }, { 
            options = {
                {    label = options.label,     event = options.event or nil,    action = options.action or nil,     canInteract = options.canInteract,}
            }, distance = 1.5})	
    elseif Config.Target == 'interaction' then
        exports.interact:AddInteraction({ coords = vector3(coords.x, coords.y,coords.z), distance = 8.0, interactDst = 2.0, id = name, name = name}, {options = {
            { label = options.label,  event = options.event or nil, action = options.action or nil,  canInteract = options.canInteract, }
       }})
    end
end

function AddEntityTarg(entity, options)
    if Config.Target == 'ox' then 
        exports.ox_target:addLocalEntity(entity, {options = { label = options.label,  event = options.event or nil, onSelect = options.action or nil,  canInteract = options.canInteract, } })
    elseif Config.Target == 'qb' then
        exports['qb-target']:AddTargetEntity(entity, {options = {
			{icon = options.icon, label = options.label, event = options.event or nil, action = options.action or nil }
		}, distance = 2.5})
    elseif Config.Target == 'interaction' then
        exports.interact:AddLocalEntityInteraction({entity = entity, name = entity, id = entity, distance = 8.0, interactDst = 2.0, options = {
            {icon = options.icon, label = options.label, event = options.event or nil, action = options.action or nil }
        }})
    end
end
