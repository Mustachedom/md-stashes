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

Bridge.Callback.Register('md-stashes:server:getVendors', function(source)
    return vendorLocation
end)

Bridge.Callback.Register('md-stashes:server:getBackpacks', function(source, loc)
    local src = source
    if not checkDistance(src, vendorLocation[loc].loc, 3) then
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
    Bridge.Framework.RegisterUsableItem(k, function(source, item)
        local src = source
        if not item then return end
        if not item.info or not item.info.stashName then
            return
        end
        Bridge.Inventory.OpenStash(src, 'stash', item.info.stashName)
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

if GetResourceState('tgiann-inventory') == 'started' then
    exports["tgiann-inventory"]:RegisterHook('swapItems', function(payload)
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
    if not checkDistance(src, vendorLocation[loc].loc, 3) then
        return
    end
    local price = itemList[itemName].price
    if Bridge.Framework.RemoveAccountBalance(src, type, price) then
        local uniqueId = generateUniqueId()
        Bridge.Inventory.AddItem(src, itemName, 1, {stashName = itemName .. uniqueId})
        return
    end
end)


RegisterCommand('giveBag',function(source, args, rawCommand)
    local src = source
    if not IsPlayerAceAllowed(src, 'command') then return false end
    local targetId = tonumber(args[1])
    local itemName = args[2]
    if not Bridge.Framework.GetPlayer(targetId) then
        return
    end
    if not itemList[args[2]] then
        Bridge.Notify.SendNotify(src, Bridge.Language.Locale('giveBag.invalidItem'), 'error')
        return
    end
    local uniqueId = generateUniqueId()
    Bridge.Inventory.AddItem(targetId, itemName, 1, {stashName = itemName .. uniqueId})
    Bridge.Notify.SendNotify(src, Bridge.Language.Locale('giveBag.given',  Bridge.Framework.GetPlayerName(targetId), itemName), 'success')
    Bridge.Notify.SendNotify(targetId, Bridge.Language.Locale('giveBag.received', itemName, Bridge.Framework.GetPlayerName(src)), 'success')
end, false)

TriggerClientEvent('chat:addSuggestion', -1, '/giveBag', Bridge.Language.Locale('giveBag.help'), {
    { name = Bridge.Language.Locale('giveBag.pid'), help = Bridge.Language.Locale('giveBag.pidHelp') },
    { name = Bridge.Language.Locale('giveBag.item'), help = Bridge.Language.Locale('giveBag.itemHelp') }
})