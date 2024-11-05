Config = {}
Config.Inv = 'qb'
Config.Target = 'qb' -- qb, ox or interact
Config.Defaultslot = 50
Config.Defaultweight = 1000000

Config.Objects = {
    {value = 'tr_prop_tr_chest_01a', label = 'Chest 1'},
    {value = 'prop_champ_box_01', label = 'Chest 2'},
    {value = 'prop_box_wood05a', label = 'Chest 3'}
}
--[[
    OPTIONALS
    job = "jobname"
    gang = "gangname"
    rank = 0 ( if no rank in code, defaults to 0 for job/gang)
    weight = 100000
    slots = 50
    item = 'item'
    cid = 'citizenID'
    password = 1234 ( must be number between 1 and 99999)
    REQUIRED
    loc = vector3

]]
-- seriously this table below is not needed anymore just for backwards compatability and wont work with the new system
Config.stash = { ------ outdated dont use if you are downloading new, this is meant for previous users that can use a command to inject this data to the SQL
    ['test'] = { loc = vector3(520.29736328125, -3108.0920410156, 33.285308837891), password = 1234},
    ['test2'] = { loc = vector3(2746.3481445312, 2787.6713867188, -35.787368774414), item = 'lockpick', slots = 12, weight = 10000},

}