if not Config.UseBackpacks then return end

local function initVendor()
    local vendors = Bridge.Callback.Trigger('md-stashes:server:getVendors')
    for k, v in pairs(vendors) do
        requestModel(v.ped)
        local ped = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        Bridge.Target.AddLocalEntity(ped, {
            {
                label = Bridge.Language.Locale('Vendor.targetLabel'),
                icon = Bridge.Language.Locale('Vendor.targetIcon'),
                action = function()
                    local items = Bridge.Callback.Trigger('md-stashes:server:getBackpacks', k)
                    local elements = {}
                    for itemName, itemData in pairs(items) do
                        local itemInfo = Bridge.Inventory.GetItemInfo(itemName)
                        elements[#elements + 1] = {
                            title = itemInfo.label,
                            description = Bridge.Language.Locale('Vendor.price', itemData.price),
                            icon = itemInfo.image,
                            action = function()
                                local input = Bridge.Input.Open(Bridge.Language.Locale('Vendor.inputTitle'), {
                                        {type = 'select', title = Bridge.Language.Locale('Vendor.inputDesc'), options = {
                                            {value = 'cash', label = Bridge.Language.Locale('Vendor.inputOption1')},
                                            {value = 'bank', label = Bridge.Language.Locale('Vendor.inputOption2')},
                                    }}
                                })
                                if not input then return end
                                if not input[1] then return end
                                TriggerServerEvent('md-stashes:server:buyBackpack', k, itemName, input[1])
                            end
                        }
                    end
                    Bridge.Menu.Open({
                        id = Bridge.Language.Locale('Vendor.menuTitle'),
                        title = Bridge.Language.Locale('Vendor.menuTitle'),
                        options = elements
                    })
                end,
            }
        })
    end
end

initVendor()