local QBCore = exports['qb-core']:GetCoreObject()
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
local function OpenStash(name, weight, slot, password)
	if password ~= 0 then
		local input = lib.inputDialog('Password', {
			 {type = 'number', label = 'Password', description = 'What Is The Password', required = true},
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
    while run do
        local Wait = 1
        local hit, entityHit, endCoords, surfaceNormal, matHash = lib.raycast.cam(511, 4, 10)
        lib.showTextUI('Raycast Coords:  \n X:  ' ..
        endCoords.x .. ',  \n Y:  ' .. endCoords.y .. ',  \n Z:  ' .. endCoords.z .. '  \n[E] to copy  \n[DEL] to cancel')
        DrawMarker(21, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255,
        255, 255, false, true, 2, nil, nil, false, false)
        if IsControlJustReleased(0, 38) then
            lib.hideTextUI()
            run = false
            return endCoords
        end

        if IsControlJustReleased(0, 178) then
            lib.hideTextUI()
            run = false
            return nil
        end

        Citizen.Wait(Wait)
    end
end

RegisterNetEvent('md-stashes:client:doray', function()
	local stashmake = StartRay()
	if stashmake then
		local input = lib.inputDialog('Stash Maker', {
			{type = 'input', label = 'name', description = 'Name Of Stash', required = true},
			{type = 'input', label = 'job', description = 'Job Or Blank'},
			{type = 'input', label = 'gang', description = 'Gang Or Blank'},
			{type = 'input', label = 'rank', description = 'Rank Or Blank'},
			{type = 'input', label = 'item', description = 'Item or Blank'},
			{type = 'input', label = 'Slot Size', description = 'Slot Size or Blank'},
			{type = 'input', label = 'Weight', description = 'Weight Size or Blank'},
			{type = 'input',label = 'Password', description = 'Password Or Blank'},
			{type = 'input', label = 'Citizen ID', description = 'Citizen ID or Blank'},
		  })
		  local loc = json.encode({
			x = math.ceil(stashmake.x * 100 + 0.1) / 100,
			y = math.ceil(stashmake.y * 100 + 0.1) / 100,
			z = math.ceil(stashmake.z * 100 + 0.1) / 100
		  })
		  if not input[2] then input[2] = 'none' end
		  for i = 1, #input do 
			print(input[i])
		  end
		 TriggerServerEvent('md-stashes:server:makenew', loc, input[1], input[2], input[3], input[4],input[5], input[6], input[7], input[8], input[9] )
	end
end)

local function CreateTargets()
	local prints = lib.callback.await('md-stashes:server:GetStashes')
	for i = 1, #prints do
	local v = prints[i]
	local loc = json.decode(v.loc)
	if v.job == nil then v.job = 1 end
	if v.gang == nil then v.gang = 1 end
	if v.targetlabel == nil then v.targetlabel = "Open Stash" end
	if v.weight == nil then v.weight = Config.Defaultweight end
	if v.slots == nil then v.slots = Config.Defaultslot end
	if v.item == nil then v.item = 1 end
	if v.citizenid == '0' then v.citizenid = 2 end
	if v.rank == 0 then v.rank = 0 end
	if v.password == 0 then v.password = 0 end 
	local optionsox = {
		{ label = v.targetlabel, onSelect = function() 	OpenStash(v.name, v.weight, v.slot, v.password) end,
			 canInteract = function()
				if QBCore.Functions.GetPlayerData().job.name == v.job and QBCore.Functions.GetPlayerData().job.grade.level >= v.rank or v.job == 1 then
					if QBCore.Functions.GetPlayerData().gang.name == v.gang and QBCore.Functions.GetPlayerData().gang.grade.level >= v.rank or v.gang == 1 then
						if v.item == 1 or QBCore.Functions.HasItem(v.item) then
							if QBCore.Functions.GetPlayerData().citizenid == v.citizenid or v.citizenid == 2 then
							return true end
						end	
					end	
				end	
			end

		}
	}
	local options = {
		{ label = v.targetlabel, action = function() 	OpenStash(v.name, v.weight, v.slot, v.password) end,
			 canInteract = function()
				if QBCore.Functions.GetPlayerData().job.name == v.job and QBCore.Functions.GetPlayerData().job.grade.level >= v.rank or v.job == 1 then
					if QBCore.Functions.GetPlayerData().gang.name == v.gang and QBCore.Functions.GetPlayerData().gang.grade.level >= v.rank or v.gang == 1 then
						if v.item == 1 or QBCore.Functions.HasItem(v.item) then
							if QBCore.Functions.GetPlayerData().citizenid == v.citizenid or v.citizenid == 2 then
							return true end
						end	
					end	
				end	
			end
		},
	}
	if Config.OxTarget then		
		stashes = exports.ox_target:addBoxZone({name = 'mdstashes' .. v.id, coords = vector3(loc.x, loc.y,loc.z), size = vec(1,1,2), rotation = 0, debug = false, options = optionsox})
	elseif Config.interact then
		exports.interact:AddInteraction({ coords = vector3(loc.x, loc.y,loc.z), distance = 8.0, interactDst = 2.0, id = 'mdstashes'..v.id, name = 'mdstashes'..v.id}, {options = options})
	else
		exports['qb-target']:AddBoxZone('mdstashes'..v.id, vector3(loc.x, loc.y,loc.z), 1.5, 1.75, {name = 'mdstashes'..v.id, minZ = loc.z-2,maxZ = loc.z+2,}, {options = options, distance = 2.0})
	end	
end		
end


local function DestroyTargets()
	local prints = lib.callback.await('md-stashes:server:GetStashes')

	for i = 1, #prints do
		local v = prints[i]
		print(v.id, 'md-stashes'..v.id)
		if v.job == nil then v.job = 1 end
		if v.gang == nil then v.gang = 1 end
		if v.targetlabel == nil then v.targetlabel = "Open Stash" end
		if v.weight == nil then v.weight = Config.Defaultweight end
		if v.slots == nil then v.slots = Config.Defaultslot end
		if v.item == nil then v.item = 1 end
		if v.cid == 0 then v.cid = 2 end
		if v.rank == 0 then v.rank = 0 end
		if v.password == 0 then v.password = 0 end 
		if Config.OxTarget then
			exports.ox_target:removeZone('mdstashes' .. v.id)
		elseif Config.Interact then
			exports.interact:RemoveInteraction('mdstashes'..v.id)
		else
			 exports['qb-target']:RemoveZone('md-stashes'..v.id)  
		end
	end
end

RegisterNetEvent('md-stashes:client:makenew', function()
DestroyTargets()
Wait(1000)
CreateTargets()
end)

CreateThread(function()

	CreateTargets()
end)