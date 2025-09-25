
local props = {}

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
            if ps.tableContains(data.gang, ps.getGangName()) and ps.getGangData('grade').level >= data.gangRank then
                has = has + 1
            end
        end
    end
    if not data.job then
        checks = checks + 1
        has = has + 1
    else
        checks = checks + 1
        if GetResourceState('es_extended') == 'started' then
            if ps.tableContains(data.job, ps.getJobName()) and ps.getJobData('grade') >= data.jobRank then
                has = has + 1
            end
        else
            if ps.tableContains(data.job, ps.getJobName()) and ps.getJobData('grade').level >= data.jobRank then
                has = has + 1
            end
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
            if ps.hasItem(v) then
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
        if ps.tableContains(data.identifier, ps.getIdentifier()) then
            has = has + 1
        end
    end
    return checks == has
end

local targets = {}

local function checkPassword(pass, id)
    if not pass or pass == '' then return true end
    local submitPass = ps.input(ps.lang('Interact.inputTitle'), {
        {type = 'input', title = ps.lang('Interact.inputHeader'), description = ps.lang('Interact.inputDesc'), required = true}
    })
    if not submitPass then return false end
    if submitPass[1] == pass then
        return ps.callback('md-stashes:server:passwordCheck', submitPass[1], id)
    else
        ps.notify(ps.lang('Notify.wrongPass'), 'error')
        return false
    end
end

local function initTargets()
    local cb = ps.callback('md-stashes:server:getStashes')
    for k, v in pairs(cb) do
        v.loc = json.decode(v.loc)
        v.data = json.decode(v.data)
        if v.data.object then
            ps.requestModel(v.data.object)
            props[#props + 1] = CreateObject(v.data.object, v.loc.x, v.loc.y, v.loc.z, false, false, false)
            SetEntityHeading(props[#props], v.loc.w or 180.0)
            FreezeEntityPosition(props[#props], true)
            ps.entityTarget(props[#props], {
                {
                    label = ps.lang('Interact.targetLabel'),
                    icon = ps.lang('Interact.targetIcon'),
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
            ps.boxTarget('md_stashes'..k, vector3(v.loc.x, v.loc.y, v.loc.z), {length = 1.0, width = 1.0, height = 1.0}, {
                {
                    label = ps.lang('Interact.targetLabel'),
                    icon = ps.lang('Interact.targetIcon'),
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
        DeleteEntity(v)
    end
    for k, v in pairs(targets) do
        ps.destroyTarget(v)
    end
    initTargets()
end)