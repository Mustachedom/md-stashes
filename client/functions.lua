
function StartRay(data)
    local run = true
	if data.type == 'object' then
		local heading = 180.0
		local created = false
		local obj = data.object
		local coord = GetEntityCoords(PlayerPedId())
		ps.requestModel(obj)
		local entity = CreateObject(obj, coord.x, coord.y, coord.z, false, false)
		repeat
        	local hit, endCoords, surfaceNormal, matHash = ps.raycast()
        	if not created then
				created = true
				ps.drawText(ps.lang('Interact.drawTextobj'))
			else
				SetEntityCoords(entity, endCoords.x, endCoords.y, endCoords.z)
				SetEntityHeading(entity, heading)
				SetEntityCollision(entity, false, false)
				SetEntityAlpha(entity, 100)
			end
        	if IsControlPressed(0, 174) then
        	    heading = heading - 2
        	end
			if IsControlPressed(0, 175) then
        	    heading = heading + 2
        	end
        	if IsControlPressed(0, 38) then
        	    ps.hideText()
        	    run = false
        	    DeleteEntity(entity)
        	    return {coords = {x = ps.decimalRound(endCoords.x, 2), y = ps.decimalRound(endCoords.y, 2), z = ps.decimalRound(endCoords.z, 2), w = ps.decimalRound(heading, 2)}, object = obj}
        	end

        	if IsControlPressed(0, 178) then
        	    ps.hideText()
        	    run = false
        	    DeleteEntity(entity)
        	    return nil
        	end
            Wait(1)
		until run == false
	else
    	repeat
    	    local wait = 1
    	    local hit, endCoords, surfaceNormal, matHash = ps.raycast()
			ps.drawText(ps.lang('Interact.drawTextCoords', ps.decimalRound(endCoords.x, 2), ps.decimalRound(endCoords.y, 2), ps.decimalRound(endCoords.z, 2)))
    	    DrawMarker(28, endCoords.x, endCoords.y, endCoords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, 255, 255,
    	    255, 255, false, true, 2, nil, nil, false, false)
    	    if IsControlPressed(0, 38) then
    	        ps.hideText()
    	        run = false
    	        return {coords = {x = ps.decimalRound(endCoords.x, 2), y = ps.decimalRound(endCoords.y, 2), z = ps.decimalRound(endCoords.z, 2)}, object = false}
    	    end

    	    if IsControlPressed(0, 178) then
    	        ps.hideText()
    	        run = false
    	        return nil
    	    end

    	    Wait(wait)
    	until run == false
	end
end