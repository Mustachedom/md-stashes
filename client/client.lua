local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    for k, v in pairs (Config.stash) do 
		if v.job == nil then v.job = 1 end
		if v.gang == nil then v.gang = 1 end
		if v.targetlabel == nil then v.targetlabel = "Open Stash" end
		if v.weight == nil then v.weight = Config.Defaultweight end
		if v.slots == nil then v.slots = Config.Defaultslot end
		if v.item == nil then v.item = 1 end
		if v.cid == nil then v.cid = 2 end
		if v.rank == nil then v.rank = 0 end
		if v.password == nil then v.password = 0 end
		if Config.OxTarget then
			stashes = exports.ox_target:addBoxZone({
				coords = v.loc,
				size = vec(1,1,2),
				rotation = 0,
				debug = false,
				options = {
					{
						name = 'openstashes',
						icon = "fas fa-sign-in-alt",
						label = v.targetlabel,
						distance = 2.5,
						onSelect = function()
							if v.password ~= 0 then
								local input = lib.inputDialog('Password', {
									 {type = 'input', label = 'Password', description = 'What Is The Password', required = true},
								})
								local combo = input[1]
								if v.password == combo then
									if Config.OxInv then
										exports.ox_inventory:openInventory('stash', {id = k})
									else	
										Wait(100)
										TriggerEvent("inventory:client:SetCurrentStash", k)
										TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
											maxweight = v.weight,
											slots = v.slots,
										})
									end	
								end	
							else
								if Config.OxInv then
									exports.ox_inventory:openInventory('stash', {id = k})
								else	
									Wait(100)
									TriggerEvent("inventory:client:SetCurrentStash", k)
									TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
										maxweight = v.weight,
										slots = v.slots,
									})
								end	
							end
						end,
						 canInteract = function()
							if QBCore.Functions.GetPlayerData().job.name == v.job and QBCore.Functions.GetPlayerData().job.grade.level >= v.rank or v.job == 1 then
								if QBCore.Functions.GetPlayerData().gang.name == v.gang and QBCore.Functions.GetPlayerData().gang.grade.level >= v.rank or v.gang == 1 then
									if v.item == 1 or QBCore.Functions.HasItem(v.item) then
										if QBCore.Functions.GetPlayerData().citizenid == v.cid or v.cid == 2 then
										return true end
									end	
								end	
							end	
						end
			
					},
				},
			})
		elseif Config.interact then
			exports.interact:AddInteraction({
				coords = v.loc,
				distance = 8.0, -- optional
				interactDst = 2.0, -- optional
				id = 'mdstashes'..k, -- needed for removing interactions
				name = 'mdstashes'..k, -- optional
				options = {
					{
						label = v.targetlabel,
						action = function()
							if v.password ~= 0 then
								local input = lib.inputDialog('Password', {
									 {type = 'input', label = 'Password', description = 'What Is The Password', required = true},
								})
								local combo = input[1]
								if v.password == combo then
									if Config.OxInv then
										exports.ox_inventory:openInventory('stash', {id = k})
									else	
										Wait(100)
										TriggerEvent("inventory:client:SetCurrentStash", k)
										TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
											maxweight = v.weight,
											slots = v.slots,
										})
									end	
								end	
							else
								if Config.OxInv then
									exports.ox_inventory:openInventory('stash', {id = k})
								else	
									Wait(100)
									TriggerEvent("inventory:client:SetCurrentStash", k)
									TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
										maxweight = v.weight,
										slots = v.slots,
									})
								end	
							end
						end,
						 canInteract = function()
							if QBCore.Functions.GetPlayerData().job.name == v.job and QBCore.Functions.GetPlayerData().job.grade.level >= v.rank or v.job == 1 then
								if QBCore.Functions.GetPlayerData().gang.name == v.gang and QBCore.Functions.GetPlayerData().gang.grade.level >= v.rank or v.gang == 1 then
									if v.item == 1 or QBCore.Functions.HasItem(v.item) then
										if QBCore.Functions.GetPlayerData().citizenid == v.cid or v.cid == 2 then
										return true end
									end	
								end	
							end	
						end
					},
				}
			})
		else
    	    exports['qb-target']:AddBoxZone('mdstashes'..k, v.loc, 1.5, 1.75, { -- 963.37, -2122.95, 31.47
			name = 'mdstashes'..k,
			minZ = v.loc.z-2,
			maxZ = v.loc.z+2,
			}, {
			options = {
				{
					icon = "fas fa-sign-in-alt",
					label = v.targetlabel,
					action = function()
						if v.password ~= 0 then
							local input = lib.inputDialog('Password', {
								 {type = 'input', label = 'Password', description = 'What Is The Password', required = true},
							})
							local combo = input[1]
							if v.password == combo then
								if Config.OxInv then
									exports.ox_inventory:openInventory('stash', {id = k})
								else	
									Wait(100)
									TriggerEvent("inventory:client:SetCurrentStash", k)
									TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
										maxweight = v.weight,
										slots = v.slots,
									})
								end	
							end	
						else
							if Config.OxInv then
								exports.ox_inventory:openInventory('stash', {id = k})
							else	
								Wait(100)
								TriggerEvent("inventory:client:SetCurrentStash", k)
								TriggerServerEvent("inventory:server:OpenInventory", "stash", k, {
									maxweight = v.weight,
									slots = v.slots,
								})
							end	
						end
					end,
					 canInteract = function()
						if QBCore.Functions.GetPlayerData().job.name == v.job and QBCore.Functions.GetPlayerData().job.grade.level >= v.rank or v.job == 1 then
							if QBCore.Functions.GetPlayerData().gang.name == v.gang and QBCore.Functions.GetPlayerData().gang.grade.level >= v.rank or v.gang == 1 then
								if v.item == 1 or QBCore.Functions.HasItem(v.item) then
									if QBCore.Functions.GetPlayerData().citizenid == v.cid or v.cid == 2 then
									return true end
								end	
							end	
						end	
					end
				},
			},
			distance = 2.5
		})
	end	
end
end)

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
	local nameloc = "['"..input[1] .. "'] = { loc = vector3(" .. stashmake.x ..", " .. stashmake.y .. ", " .. stashmake.z .. ")"
	if input[2] == ''then else input[2] = ", job = '" .. input[2] .. "'" end
	if input[3] == ''then else input[3] = ", gang = '" .. input[3] .. "'" end
	if input[4] == ''then else input[4] = ", rank = " .. input[4] .. "" end
	if input[5] == ''then else input[5] = ", item = '" .. input[5] .. "'" end
	if input[6] == ''then else input[6] = ", slots = " .. input[6] .. "" end
	if input[7] == ''then else input[7] = ", weight = " .. input[7] .. "" end
	if input[8] == ''then else input[8] = ", password = '" .. input[8] .. "'" end
	if input[9] == ''then else input[9] = ", cid = '" .. input[9] .. "'" end
	local copy = nameloc .. input[2] .. "" .. input[3] .. "" .. input[4] .. "" .. input[5] .. "" .. input[6].. "" .. input[7] .. "" .. input[8] .. "" .. input[9].. "},"
	lib.setClipboard(copy)
	QBCore.Functions.Notify("Info Copied To Your Clip Board, Paste Into Config.stash")
	end
end)
