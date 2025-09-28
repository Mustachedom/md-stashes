Config = {}
ps = exports.ps_lib:init()
ps.loadLangs('en')

Config.OldData = false -- Enable this if you are using old data from before version 3.0.0 | this loads command ADjustStashes to adjust old data to new data format
                      -- Turn to false after you run the command IF you need to use it
Config.Defaults = {
    slots = 50,
    maxWeight = 1000000
}

Config.Objects = {
    {value = 'tr_prop_tr_chest_01a', label = 'Small Chest'},
    {value = 'prop_champ_box_01',    label = 'Medium Crate'},
    {value = 'prop_box_wood05a',     label = 'Large Crate'},
    {value = 'prop_lev_crate_01',    label = 'Large Wooden Crate'},
    {value = 'prop_container_03mb', label = 'Shipping Container'},
}

Config.UseBackpacks = true -- Set to false if you do not want to use backpacks
