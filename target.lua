local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
exports['qb-target']:AddBoxZone("stachename1",vector3location, 1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "stachename1",
	heading = 186.0,
	debugPoly = true,
	minZ = 37.77834,
	maxZ = 41.87834,
}, {
	options = {
		{
            type = "client",
            event = "md-stashes:client:AutoCare",
	    icon = "fas fa-sign-in-alt",
	    label = "open stash",
	    --job = "mechanic",
	    --gang = "ballas",
		--item = "metalscrap"
		},
	},
	distance = 2.5
 })

end)
