local QBCore = exports['qb-core']:GetCoreObject()
local invcall = ''
local storages = {}
local spawned = {}

RegisterNetEvent('md-stashes:client:doray', function()
	local stashmake, heading, object = StartRay()
	if object then 
		local input = lib.inputDialog('Stash Maker', {
			{type = 'input', label = 'name', description = 'Name Of Stash', required = true},
			{type = 'input', label = 'job', description = 'Job Or Blank'},
			{type = 'input', label = 'gang', description = 'Gang Or Blank'},
			{type = 'number', label = 'rank', description = 'Rank Or Blank'},
			{type = 'input', label = 'item', description = 'Item or Blank'},
			{type = 'number', label = 'Slot Size', description = 'Slot Size or Blank'},
			{type = 'number', label = 'Weight', description = 'Weight Size or Blank'},
			{type = 'input',label = 'Password', description = 'Password Or Blank'},
			{type = 'input', label = 'Citizen ID', description = 'Citizen ID or Blank'},
		  })
		  local loc = json.encode({
			x = math.ceil(stashmake.x * 100 + 0.1) / 100,
			y = math.ceil(stashmake.y * 100 + 0.1) / 100,
			z = math.ceil(stashmake.z * 100 + 0.1) / 100,
			h = heading
		  })
		  if not input[2] then input[2] = 'none' end
		  if not input[4] then input[4] = 0 end
		 TriggerServerEvent('md-stashes:server:makenew', loc, input[1], input[2], input[3], input[4],input[5], input[6], input[7], input[8], input[9], object )
	else	 
		if stashmake then
			local input = lib.inputDialog('Stash Maker', {
				{type = 'input', label = 'name', description = 'Name Of Stash', required = true},
				{type = 'input', label = 'job', description = 'Job Or Blank'},
				{type = 'input', label = 'gang', description = 'Gang Or Blank'},
				{type = 'number', label = 'rank', description = 'Rank Or Blank'},
				{type = 'input', label = 'item', description = 'Item or Blank'},
				{type = 'number', label = 'Slot Size', description = 'Slot Size or Blank'},
				{type = 'number', label = 'Weight', description = 'Weight Size or Blank'},
				{type = 'input',label = 'Password', description = 'Password Or Blank'},
				{type = 'input', label = 'Citizen ID', description = 'Citizen ID or Blank'},
			  })
			  local loc = json.encode({
				x = math.ceil(stashmake.x * 100 + 0.1) / 100,
				y = math.ceil(stashmake.y * 100 + 0.1) / 100,
				z = math.ceil(stashmake.z * 100 + 0.1) / 100
			  })
			  if not input[2] then input[2] = 'none' end
			  if not input[4] then input[4] = 0 end
			 TriggerServerEvent('md-stashes:server:makenew', loc, input[1], input[2], input[3], input[4],input[5], input[6], input[7], input[8], input[9], nil )
		end
	end
end)

local function CreateTargets()
	local prints = lib.callback.await('md-stashes:server:GetStashes')

	for i = 1, #prints do
		if not spawned[i] then 
			spawned[i] = true
			local v = prints[i]
			local name = v.name
			local loc = json.decode(v.loc)
			local data = json.decode(v.data)
			local p = QBCore.Functions.GetPlayerData()
			local rank = data['rank']
			if not data['object']  then 
				AddBoxZone('md-stashes' .. v.id, vector3(loc.x, loc.y, loc.z),
					{ label = data['targetlabel'], action = function() 	OpenStash(v.name, data['weight'], data['slots'], data['password']) end,
						canInteract = function()
							if QBCore.Functions.GetPlayerData().job.name == data['job'] and QBCore.Functions.GetPlayerData().job.grade.level >= rank or data['job'] == false then 
								if QBCore.Functions.GetPlayerData().gang.name == data['gang'] and QBCore.Functions.GetPlayerData().gang.grade.level >= rank or data['gang'] == false then 
									if data['item'] == false or QBCore.Functions.HasItem(''..data['item']..'') == true then 
										if QBCore.Functions.GetPlayerData().citizenid == data['citizenid'] or data['citizenid'] == false then
										return true end
									end	
								end	
							end	
						end
					})
			else
				lib.requestModel(data['object'])
				storages[i] = CreateObject(data['object'], loc.x, loc.y, loc.z, loc.h, false, false, false)
				SetEntityHeading(storages[i], loc.h or 70.0)
				spawned[i] = true
				FreezeEntityPosition(storages[i], true)
				AddEntityTarg(storages[i],
					{ label = data['targetlabel'], action = function() 	OpenStash(v.name, data['weight'], data['slots'], data['password']) end,
						 canInteract = function()
							if QBCore.Functions.GetPlayerData().job.name == data['job'] and QBCore.Functions.GetPlayerData().job.grade.level >= rank or data['job'] == false then 
								if QBCore.Functions.GetPlayerData().gang.name == data['gang'] and QBCore.Functions.GetPlayerData().gang.grade.level >= rank or data['gang'] == false then 
									if data['item'] == false or QBCore.Functions.HasItem(''..data['item']..'') == true then 
										if QBCore.Functions.GetPlayerData().citizenid == data['citizenid'] or data['citizenid'] == false then
										return true end
									end	
								end	
							end	
						end
					})
			end
		end
	end
end		


RegisterNetEvent('md-stashes:client:makenew', function()
CreateTargets()
end)

CreateThread(function()
	CreateTargets()
end)
