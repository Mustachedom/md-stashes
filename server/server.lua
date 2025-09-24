
local stashes = MySQL.query.await('SELECT * FROM mdstashes',{})


-- Callbacks
ps.registerCallback('md-stashes:server:verifyKey', function(source)
    if not IsPlayerAceAllowed(source, 'command') then return false end
    return true
end)

ps.registerCallback('md-stashes:server:getStashes', function(source)
    return stashes
end)

ps.registerCallback('md-stashes:server:passwordCheck', function(source, pass, id)
    local src = source
    local passWord = MySQL.query.await('SELECT * FROM mdstashes WHERE id = ?', {id})
    if passWord and not passWord[1] then return false end
    passWord = passWord[1]
    local loc = json.decode(passWord.loc)
    local location = vector3(loc.x, loc.y, loc.z)
    if not ps.checkDistance(src, location, 3) then
        ps.warn(ps.lang('Fail.tooFar', ps.getPlayerName(src), 'md-stashes:server:passwordCheck'))
        return
    end
    local data = json.decode(passWord.data)
    return data.password == pass
end)


ps.registerCallback('md-stashes:server:gotoLoc', function(source, data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local loc = json.decode(data.loc)
    local location = vector3(loc.x, loc.y, loc.z)

    SetEntityCoords(GetPlayerPed(src), location.x, location.y, location.z, false, false, false, false)
    return true
end)

-- Events
RegisterNetEvent('md-stashes:server:createStash', function(data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end

    MySQL.insert('INSERT INTO mdstashes SET loc = ?, name = ?, data = ?', {json.encode(data.coords), data.data.name, json.encode(data.data)})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

RegisterNetEvent('md-stashes:server:saveEdit', function(data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local formData = data.form

    local oldData = data.id
    oldData.data = json.decode(oldData.data)
    if oldData.data.object then
        formData.object = oldData.data.object
    end

    MySQL.update('UPDATE mdstashes SET name = ?, data = ? WHERE id = ?', {formData.name, json.encode(formData), oldData.id})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

ps.versionCheck('md-stashes', 'https://raw.githubusercontent.com/Mustachedom/md-stashes/refs/heads/ps_lib/changelog.txt','https://github.com/Mustachedom/md-stashes/tree/ps_lib')

RegisterNetEvent('md-stashes:server:changeLocation', function(data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local id = data.id.id
    local loc = data.loc.coords
    MySQL.update('UPDATE mdstashes SET loc = ? WHERE id = ?', {json.encode(loc), id})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

RegisterNetEvent('md-stashes:server:deleteStash', function(data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    local id = data.id
    MySQL.update('DELETE FROM mdstashes WHERE id = ?', {id})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

local function handleRCOREGangs(gangName, gangRank)
    local gangs = exports['rcore_gang']:GetPlayerGang()
    if not gangs then return false end
    if gangs.name ~= gangName then return false end
    for k, v in pairs(gangs.members) do
        if v.identifier == ps.getIdentifier() then
            if v.rankIndex >= gangRank then
                return true
            end
        end
    end
    return false
end

local function checkAllowance(src, data)
    local checks, has = 0, 0
    if not data.gang then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        if GetResourceState('rcore_gangs') == 'started' then
            if handleRCOREGangs(data.gang, data.gangRank) then
                has = has + 1
            end
        else
            if ps.tableContains(data.gang, ps.getGangName(src)) and ps.getGangData(src, 'grade').level >= data.gangRank then
                has = has + 1
            end
        end
    end
    if not data.job then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        if ps.tableContains(data.job, ps.getJobName(src)) and ps.getJobData(src, 'grade').level >= data.jobRank then
            has = has + 1
        end
    end
    if not data.item then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        local need, have = 0, 0
        for k, v in pairs(data.item) do
            need = need + 1
            if ps.hasItem(src, v, 1) then
                have = have + 1
            end
        end
        if need == have then
            has = has + 1
        end
    end
    if not data.identifier then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        if ps.tableContains(data.identifier, ps.getIdentifier(src)) then
            has = has + 1
        end
    end
    return checks == has
end

RegisterNetEvent('md-stashes:server:openStash', function(id)
    local src = source
    local stashData = stashes[id]
    if not stashData then return end

    local loc = json.decode(stashData.loc)
    local location = vector3(loc.x, loc.y, loc.z)
    if not ps.checkDistance(src, location, 3) then
        ps.warn(ps.lang('Fail.tooFar', ps.getPlayerName(src), 'md-stashes:server:openStash'))
        return
    end

    if not checkAllowance(src, stashData.data) then
        ps.notify(src, ps.lang('Notify.noAccess'), 'error')
        return
    end

    local data = json.decode(stashData.data)
    ps.openStash(src, stashData.name, {
        label = stashData.name,
        slots = data.slots,
        maxweight = data.maxWeight,
    })
end)

-- Commands
if Config.OldData then
    ps.registerCommand('ADjustStashes', {admin = true}, function(source, args, raw)
        local src = source
        if not IsPlayerAceAllowed(src, 'command') then return false end
        local originalData = MySQL.query.await('SELECT * FROM mdstashes',{})
        for i = 1, #originalData do
            local data = json.decode(originalData[i].data)
            local slots = tonumber(data.slots) or Config.Defaults.slots
            local weight = tonumber(data.weight) or Config.Defaults.maxWeight
            local job, gang, citizenid, item = {}, {}, {}, {}
            data.slots = slots
            data.maxWeight = weight
            if data.password == 0 or data.password == '0' or not data.password then
                data.password = false
            end
            if data.citizenid then
                if type(data.citizenid) == 'string' then
                    table.insert(citizenid, data.citizenid)
                    data.identifier = citizenid
                    data.citizenid = nil
                end
            end
            if data.job then
                if type(data.job) == 'string' then
                    table.insert(job, data.job)
                    data.job = job
                    if data.rank then
                        data.jobRank = data.rank
                    else
                        data.jobRank = 0
                    end
                end
            end
            if data.gang then
                if type(data.gang) == 'string' then
                    table.insert(gang, data.gang)
                    data.gang = gang
                    if data.rank then
                        data.gangRank = data.rank
                    else
                        data.gangRank = 0
                    end
                end
            end
            if data.item then
                if type(data.item) == 'string' then
                    table.insert(item, data.item)
                    data.item = item
                end
            end
            data.targetlabel = nil
            data.rank = nil
            data.name = originalData[i].name
            MySQL.update('UPDATE mdstashes SET data = ? WHERE id = ?', {json.encode(data), originalData[i].id})
            Wait(10)
        end
    end)
end

ps.registerCommand('newStash',{admin = true}, function(source, args, raw)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    TriggerClientEvent('md-stashes:client:startNew', src)
end)

ps.registerCommand('editStash', {admin = true}, function(source, args, raw)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    TriggerClientEvent('md-stashes:client:editStash', src)
end)

if not Config.useBackpacks then return end

local vendorLocation = {
    {loc = vector4(2557.458, 382.282, 108.622, 356.09), ped = 'ig_priest'},
}

local itemList = { -- itemname | slots: number | maxweight: number | allowStashInside: boolean or nil
    small_backpack = {
        price = 1000,
        slots = 15,
        maxweight = 25000,
        allowStashInside = false,
    },
    medium_backpack = {
        price = 2500,
        slots = 30,
        maxweight = 50000,
        allowStashInside = false,
    },
    large_backpack = {
        price = 5000,
        slots = 55,
        maxweight = 120000,
        allowStashInside = false,
    },
}

ps.registerCallback('md-stashes:server:getVendors', function(source)
    return vendorLocation
end)

ps.registerCallback('md-stashes:server:getBackpacks', function(source, loc)
    local src = source
    if not ps.checkDistance(src, vendorLocation[loc].loc, 3) then
        ps.warn(ps.lang('Fail.tooFar', ps.getPlayerName(src), 'md-stashes:server:getBackpacks'))
        return {}
    end
    return itemList
end)

local function generateUniqueId()
    local allowedChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    local idLength = 16
    local uniqueId = ''
    math.randomseed(os.time())
    for i = 1, idLength do
        local randomIndex = math.random(1, #allowedChars)
        uniqueId = uniqueId .. allowedChars:sub(randomIndex, randomIndex)
    end
    return uniqueId
end


for k, v in pairs(itemList) do
    ps.createUseable(k, function(source, item)
        local src = source
        if not item then return end
        if GetResourceState('ox_inventory') == 'started' then
            ps.openStash(src, item.metadata.stashName, {
                label = item.metadata.stashName,
                slots = v.slots,
                maxweight = v.maxweight,
            })
            return
        end
        ps.openStash(src, item.info.stashName, {
            label = item.info.stashName,
            slots = v.slots,
            maxweight = v.maxweight,
        })
    end)
end

local function refuse()
    local itemToRefuse = {}
    for k, v in pairs(itemList) do
        if not v.allowStashInside then
            itemToRefuse[k] = true
        end
    end
    return itemToRefuse
end

local function filterInv()
    local refuseString = {}
    for k, v in pairs(itemList) do
        if not v.allowStashInside then
            table.insert(refuseString, '^' .. k .. '[%w]+')
        end
    end
    return refuseString
end

if GetResourceState('ox_inventory') == 'started' then
    local hookId = exports.ox_inventory:registerHook('swapItems', function(payload)
        return false
    end, {
        print = true,
        itemFilter = refuse(),
        inventoryFilter = filterInv()
    })
end


RegisterNetEvent('md-stashes:server:buyBackpack', function(loc, itemName, type)
    local src = source
    if not itemList[itemName] then return end
    if not ps.checkDistance(src, vendorLocation[loc].loc, 3) then
        ps.warn(ps.lang('Fail.tooFar', ps.getPlayerName(src), 'md-stashes:server:buyBackpack'))
        return
    end
    local price = itemList[itemName].price
    if ps.removeMoney(src, type, price) then
        local uniqueId = generateUniqueId()
        ps.addItem(src, itemName, 1, {stashName = itemName .. uniqueId})
        return
    end
end)