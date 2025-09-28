if not Config.UseBackpacks then return end

local function initVendor()
    local vendors = ps.callback('md-stashes:server:getVendors')
    for k, v in pairs(vendors) do
        ps.requestModel(v.ped)
        local ped = CreatePed(0, v.ped, v.loc.x, v.loc.y, v.loc.z, v.loc.w, false, false)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        ps.entityTarget(ped, {
            {
                label = ps.lang('Vendor.targetLabel'),
                icon = ps.lang('Vendor.targetIcon'),
                action = function()
                    local items = ps.callback('md-stashes:server:getBackpacks', k)
                    local elements = {}
                    for itemName, itemData in pairs(items) do
                        elements[#elements + 1] = {
                            title = ps.getLabel(itemName),
                            description = ps.lang('Vendor.price', itemData.price),
                            icon = ps.getImage(itemName),
                            action = function()
                                local input = ps.input(ps.lang('Vendor.inputTitle'), {
                                    {type = 'select', title = ps.lang('Vendor.inputDesc'), options = {
                                        {value = 'cash', label = ps.lang('Vendor.inputOption1')},
                                        {value = 'bank', label = ps.lang('Vendor.inputOption2')},
                                    }}
                                })
                                if not input then return end
                                if not input[1] then return end
                                TriggerServerEvent('md-stashes:server:buyBackpack', k, itemName, input[1])
                            end
                        }
                    end
                    ps.menu(ps.lang('Vendor.menuTitle'),ps.lang('Vendor.menuTitle'),elements)
                end,
            }
        })
    end
end

initVendor()