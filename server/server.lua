
local stashes = MySQL.query.await('SELECT * FROM mdstashes',{})

function checkDistance(src, loc, dist)
    local playerCoords = GetEntityCoords(GetPlayerPed(src))
    local distance = #(playerCoords - loc)
    if distance > dist then
        Bridge.Prints.Warn(Bridge.Language.Locale('Fail.tooFar', Bridge.Framework.GetPlayerIdentifier(src), 'md-stashes:server:passwordCheck'))
        return false
    end
    return true
end
-- Callbacks
Bridge.Callback.Register('md-stashes:server:verifyKey', function(source)
    if not IsPlayerAceAllowed(source, 'command') then return false end
    return true
end)

Bridge.Callback.Register('md-stashes:server:getStashes', function(source)
    return stashes
end)

Bridge.Callback.Register('md-stashes:server:passwordCheck', function(source, pass, id)
    local src = source
    local passWord = MySQL.query.await('SELECT * FROM mdstashes WHERE id = ?', {id})
    if passWord and not passWord[1] then return false end
    passWord = passWord[1]
    local loc = json.decode(passWord.loc)
    local location = vector3(loc.x, loc.y, loc.z)

    if not checkDistance(src, location, 3) then
        return
    end
    local data = json.decode(passWord.data)
    return data.password == pass
end)


Bridge.Callback.Register('md-stashes:server:gotoLoc', function(source, data)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then
        return false
    end
    local loc = json.decode(data.loc)
    local location = vector3(loc.x, loc.y, loc.z)

    SetEntityCoords(GetPlayerPed(src), location.x, location.y, location.z, false, false, false, false)
    return true
end)

-- Events
RegisterNetEvent('md-stashes:server:createStash', function(data)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then
        return false
    end

    MySQL.insert('INSERT INTO mdstashes SET loc = ?, name = ?, data = ?', {json.encode(data.coords), data.data.name, json.encode(data.data)})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

RegisterNetEvent('md-stashes:server:saveEdit', function(data)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then
        return false
    end
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


RegisterNetEvent('md-stashes:server:changeLocation', function(data)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then
         return false
    end
    local id = data.id.id
    local loc = data.loc.coords
    MySQL.update('UPDATE mdstashes SET loc = ? WHERE id = ?', {json.encode(loc), id})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

RegisterNetEvent('md-stashes:server:deleteStash', function(data)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then
         return false
    end
    local id = data.id
    MySQL.update('DELETE FROM mdstashes WHERE id = ?', {id})
    Wait(100)
    stashes = MySQL.query.await('SELECT * FROM mdstashes',{})
    TriggerClientEvent('md-stashes:client:newstash', -1)
end)

local function handleRCOREGangs(gangName, gangRank, src)
    local gangs = exports['rcore_gang']:GetPlayerGang()
    if not gangs then return false end
    if gangs.name ~= gangName then return false end
    for k, v in pairs(gangs.members) do
        if v.identifier == Bridge.Framework.GetPlayerIdentifier(src) then
            if v.rankIndex >= gangRank then
                return true
            end
        end
    end
    return false
end

local function getGang(src)
    if GetResourceState('es_extended') == 'started' then
        return true
    end
    local Player = Bridge.Framework.GetPlayerData(src)
    if Player.gang then
        return Player.gang.name, Player.gang.grade.level
    end
end

local function checkAllowance(src, data)
    local checks, has = 0, 0
    if not data.gang then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        if GetResourceState('rcore_gangs') == 'started' then
            if handleRCOREGangs(data.gang, data.gangRank, src) then
                has = has + 1
            end
        else
            local gangName, gangRank = getGang(src)
            if Bridge.Tables.TableContains(data.gang, gangName) and gangRank >= data.gangRank then
                has = has + 1
            end
        end
    end
    if not data.job then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        local jobInfo = Bridge.Framework.GetPlayerJobData(src)
        if Bridge.Tables.TableContains(data.job, jobInfo.jobName) and jobInfo.gradeRank >= data.jobRank then
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
            if Bridge.Framework.HasItem(src, v) then
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
        if Bridge.Tables.TableContains(data.identifier, Bridge.Framework.GetPlayerIdentifier(src)) then
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
    if not checkDistance(src, location, 3) then
        return
    end

    if not checkAllowance(src, stashData.data) then
        Bridge.Notify.SendNotify(src, Bridge.Framework.Lang('Notify.noAccess'), 'error')
        return
    end

    local data = json.decode(stashData.data)
    local stashInfo = {
        name = stashData.name,
        slots = data.slots,
        maxweight = data.maxWeight
    }
    Bridge.Inventory.RegisterStash(stashInfo.name, stashInfo.name, stashInfo.slots, stashInfo.maxweight)
    Bridge.Inventory.OpenStash(src, 'stash', stashInfo.name)
end)

-- Commands
if Config.OldData then
    RegisterCommand('ADjustStashes',function(source, args, raw)
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
    end, false)
end

RegisterCommand('newStash',function(source, args, raw)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    TriggerClientEvent('md-stashes:client:startNew', src)
end, false)

RegisterCommand('editStash',function(source, args, raw)
    local src = source
    if not IsPlayerAceAllowed(source, 'command') then return false end
    TriggerClientEvent('md-stashes:client:editStash', src)
end, false)
