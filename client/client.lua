
local props = {}

function requestModel(model)
    if not HasModelLoaded(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(10)
        end
    end
end

local function getGang()
    if GetResourceState('es_extended') == 'started' then
        return true
    end
    local Player = Bridge.Framework.GetPlayerData()
    if Player.gang then
        return Player.gang.name
    end
end

local function getGangRank()
    if GetResourceState('es_extended') == 'started' then
        return true
    end
    local Player = Bridge.Framework.GetPlayerData()
    if Player.gang then
        return Player.gang.grade.level
    end
end
local function handleRCOREGangs(gangName, gangRank)
    local gangs = exports['rcore_gang']:GetPlayerGang()
    if not gangs then return false end
    if gangs.name ~= gangName then return false end
    for k, v in pairs(gangs.members) do
        if v.identifier == Bridge.Framework.GetPlayerIdentifier() then
            if v.rankIndex >= gangRank then
                return true
            end
        end
    end
    return false
end

local function check(data)
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
            if Bridge.Tables.TableContains(data.gang, getGang()) and getGangRank() >= data.gangRank then
                has = has + 1
            end
        end
    end
    if not data.job then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        local jobData = Bridge.Framework.GetPlayerJobData()
        if Bridge.Tables.TableContains(data.job, jobData.jobName) and jobData.gradeRank >= data.jobRank then
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
            if Bridge.Inventory.HasItem(v) then
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
        if Bridge.Tables.TableContains(data.identifier, Bridge.Framework.GetPlayerIdentifier()) then
            has = has + 1
        end
    end
    return checks == has
end

local targets = {}

local function checkPassword(pass, id)
    if not pass or pass == '' then return true end

    local submitPassword = Bridge.Input.Open(Bridge.Language.Locale('Interact.inputTitle'), {
        {type = 'input', title = Bridge.Language.Locale('Interact.inputHeader'), description = Bridge.Language.Locale('Interact.inputDesc'), required = true}
    })

    if not submitPassword then return false end
    if submitPassword[1] == pass then
        return Bridge.Callback.Trigger('md-stashes:server:passwordCheck', submitPassword[1], id)
    else
        Bridge.Notify.SendNotify(Bridge.Language.Locale('Notify.wrongPass'), 'error')
        return false
    end
end

local function initTargets()
    local cb = Bridge.Callback.Trigger('md-stashes:server:getStashes')
    for k, v in pairs(cb) do
        v.loc = json.decode(v.loc)
        v.data = json.decode(v.data)
        if v.data.object then
            requestModel(v.data.object)
            props[#props + 1] = CreateObject(v.data.object, v.loc.x, v.loc.y, v.loc.z, false, false, false)
            SetEntityHeading(props[#props], v.loc.w or 180.0)
            FreezeEntityPosition(props[#props], true)
            Bridge.Target.AddLocalEntity(props[#props], {
                {
                    label = Bridge.Language.Locale('Interact.targetLabel'),
                    icon = Bridge.Language.Locale('Interact.targetIcon'),
                    action = function()
                        if not checkPassword(v.data.password, v.id) then return end
                        TriggerServerEvent('md-stashes:server:openStash', k)
                    end,
                    canInteract = function()
                        return check(v.data)
                    end
                }
            })
        else
            Bridge.Target.AddBoxZone('md_stashes'..k, vector3(v.loc.x, v.loc.y, v.loc.z), vector3(1.0, 1.0, 2.0),v.loc.w or 0.0, {
                {
                    label = Bridge.Language.Locale('Interact.targetLabel'),
                    icon = Bridge.Language.Locale('Interact.targetIcon'),
                    action = function()
                        if not checkPassword(v.data.password) then return end
                        TriggerServerEvent('md-stashes:server:openStash', k)
                    end,
                    canInteract = function()
                        return check(v.data)
                    end
                }
            })
            targets[#targets+1] = 'md_stashes'..k
        end
    end
end

initTargets()

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end
    for k, v in pairs(props) do
        DeleteEntity(v)
    end
end)

RegisterNetEvent('md-stashes:client:newstash', function()
    for k, v in pairs (props) do
        Bridge.Target.RemoveLocalEntity(v)
        DeleteEntity(v)
    end
    for k, v in pairs(targets) do
        Bridge.Target.RemoveZone(v)
    end
    initTargets()
end)