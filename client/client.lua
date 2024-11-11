local QBCore = exports['qb-core']:GetCoreObject()
local objectStash = {}

lib.callback.register('md-stashes:client:makeNew', function(key) 
    local keys = lib.callback.await('md-stashes:server:GetKeys', false) 
    if key == keys then 
        local stashmake, heading, object = StartRay()
        if stashmake then
            local input = lib.inputDialog('Stash Maker', {
                {type = 'input',  label = 'name', description = 'Name Of Stash', required = true},
                {type = 'input',  label = 'job', description = 'Job Or Blank'},
                {type = 'input',  label = 'gang', description = 'Gang Or Blank'},
                {type = 'number', label = 'rank', description = 'Rank Or Blank', default = 0, required = true},
                {type = 'input',  label = 'item', description = 'Item or Blank'},
                {type = 'number', label = 'Slot Size', description = 'Slot Size or Blank', default = Config.Defaultslot, required = true},
                {type = 'number', label = 'Weight', description = 'Weight Size or Blank', default = Config.Defaultweight, required = true},
                {type = 'input',  label = 'Password', description = 'Password Or Blank'},
                {type = 'input',  label = 'Citizen ID', description = 'Citizen ID or Blank'},
            })
            local loc = json.encode({x = math.ceil(stashmake.x * 100 + 0.1) / 100, y = math.ceil(stashmake.y * 100 + 0.1) / 100, z = math.ceil(stashmake.z * 100 + 0.1) / 100, h = heading or nil})
            for i = 1, #input do if input[i] == '' or input[i] == 'false' then input[i] = false end  end
            local data = {job = input[2],gang = input[3],rank = input[4],item = input[5],slots = input[6],weight = input[7],password = input[8],citizenid = input[9],object = object}
            TriggerServerEvent('md-stashes:server:makenew', loc, input[1], json.encode(data))
        end
    end
    return true
end)

local function CreateTargets()
	local prints = lib.callback.await('md-stashes:server:GetStashes')
	if type(prints) ~= 'table' then return end
	if #objectStash > 0 then
		for k, v in pairs (objectStash) do DeleteObject(v.object) end
		objectStash = {}
	end
	for i = 1, #prints do
		local v = prints[i]
		local name = v.name
		local loc, data = json.decode(v.loc), json.decode(v.data)
		local options = {name = name, label = 'Open Stash', action = function() OpenStash(name, data['weight'], data['slots'], data['password']) end,
			canInteract = function() return check(data) end}
		if data['object'] ~= false then 
			lib.requestModel(data['object'])
			local obj = CreateObject(data['object'], loc.x, loc.y, loc.z, false, false, false)
			table.insert(objectStash, {model = data['object'], object = obj, name = v.name, loc = loc,})
			SetEntityHeading(obj, loc.h)
			FreezeEntityPosition(obj, true)
			AddEntityTarg(obj, options)
		else
			AddBoxZone('mdstashes'..v.name, loc, options)
		end
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if GetCurrentResourceName() == resourceName then
	  for k, v in pairs (objectStash) do 
		 DeleteEntity(v.object)
	  end
	end
end)


RegisterNetEvent('md-stashes:client:makenew', function()
	CreateTargets()
end)

CreateThread(function()
	CreateTargets()
end)

lib.callback.register('md-stashes:client:edit', function(data)
	local info = {}
	local new = {}
	for k, v in pairs (data) do 
		info[#info + 1] = {
			title = v.name,
			description = 'Edit Stash:' .. v.name,
			onSelect = function()
				local data = json.decode(v.data)
				local input = lib.inputDialog('Update: ' ..  v.name, {
					{type = 'input',  label = 'job', 		description = 'Add Job Or Leave False',     required = true, placeholder = data['job'],       default = data['job']},
					{type = 'input',  label = 'gang', 		description = 'Add Gang Or Leave False',    required = true, placeholder = data['gang'],      default = data['gang']},
					{type = 'number', label = 'rank', 		description = 'Add Rank Or Leave 0',        required = true, placeholder = data['rank'],      default = data['rank']},
					{type = 'input',  label = 'item', 		description = 'Item or false', 		        required = true, placeholder = data['item'],      default = data['item']},
					{type = 'number', label = 'Slot Size',  description = 'Slot Size or Blank',         required = true, placeholder = data['slots'],     default = data['slots']},
					{type = 'number', label = 'Weight', 	description = 'Weight Size or Blank',       required = true, placeholder = data['weight'],    default = data['weight']},
					{type = 'input',  label = 'Password', 	description = 'Password Or Blank', 	        required = true, placeholder = data['password'],  default = data['password']},
					{type = 'input',  label = 'Citizen ID', description = 'Citizen ID or Blank',        required = true, placeholder = data['citizenid'], default = data['citizenid']},
				  })
				 for i = 1, #input do if input[i] == 'false' then input[i] = false end end
				 table.insert(new, {
					id = v.id,
					name = v.name,
					data = json.encode({
						job = input[1],
						gang = input[2],
						rank = input[3],
						item = input[4],
						weight = input[6],
						slots = input[5],
						targetlabel = 'Open Stash',
						password = input[7],
						citizenid = input[8],
						object = data['object']
					})
				 })
				 if input[1] == '' then return end
				 TriggerServerEvent('md-stashes:server:edit', new)
			end
		}
		lib.registerContext({id = 'md-stashes',	title = 'Edit Stash',	options = info})
	end
	lib.showContext('md-stashes')
end)

lib.callback.register('md-stashes:client:deleteSelectedStash', function(data)
	local stashOptions = {}
	local val = ''
    for _, stash in ipairs(data) do
        table.insert(stashOptions, {
            title = stash.name,
            description = "Location: (" .. stash.loc .. ")",
            onSelect = function()
				TriggerServerEvent('md-stashes:server:deleteStash', stash.name)
			end
        })
    end
    lib.registerContext({id = 'delete_stash_menu', title = 'Delete Stash', options = stashOptions })
	lib.showContext('delete_stash_menu')

end)