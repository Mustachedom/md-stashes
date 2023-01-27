This is a basic and configurable staches for a third eye.

example on client


RegisterNetEvent('md-stashes:client:stashname1', function ()
    TriggerEvent("inventory:client:SetCurrentStash", "stashname1")
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "stashname1", {
        maxweight = 4000000,
        slots = 500,
    })
end)

example for QB-Target


CreateThread(function()
exports['qb-target']:AddBoxZone("stashname1",vector3location, 1.5, 1.75, { -- 963.37, -2122.95, 31.47
	name = "stashname1",
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
			--item = "metalscrap",
		},
	},
	distance = 2.5
 })

end)

just add location, the stash name, and if you want it to be hidden unless you are in a job, gang, or have an item in your inventory just write it there
