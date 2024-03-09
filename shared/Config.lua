Config = {}
Config.OxInv = false
Config.OxTarget = true
Config.interact = false
Config.Defaultslot = 50
Config.Defaultweight = 1000000
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
Config.stash = {
    ['test'] = { loc = vector3(520.29736328125, -3108.0920410156, 33.285308837891)},
    ['test2'] = { loc = vector3(2746.3481445312, 2787.6713867188, -35.787368774414), item = 'lockpick', slots = 12, weight = 10000},
   
    
}

