if not Config.UseBackpacks then return end
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

ps.registerCommand('giveBag', {
    admin = true,
    help = ps.lang('giveBag.help'),
    description = {
        {
            name = ps.lang('giveBag.pid'),
            help = ps.lang('giveBag.pidHelp'),
        },
        {
            name = ps.lang('giveBag.item'),
            help = ps.lang('giveBag.itemHelp'),
        }
    }
}, function(source, args, rawCommand)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then return false end
    local targetId = tonumber(args[1])
    local itemName = args[2]
    if not ps.getPlayer(targetId) then
        ps.notify(src, ps.lang('giveBag.invalidPlayer'), 'error')
        return
    end
    if not itemList[args[2]] then
        ps.notify(src, ps.lang('giveBag.invalidItem'), 'error')
        return
    end
    local uniqueId = generateUniqueId()
    ps.addItem(targetId, itemName, 1, {stashName = itemName .. uniqueId})
    ps.notify(src, ps.lang('giveBag.given',  ps.getPlayerName(targetId), itemName), 'success')
    ps.notify(targetId, ps.lang('giveBag.received', itemName, ps.getPlayerName(src)), 'success')
end)