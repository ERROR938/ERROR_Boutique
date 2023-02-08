function keyRegister(openname, name, key, action)
    RegisterKeyMapping(openname, name, 'keyboard', key)
    RegisterCommand(openname, function()
        if (action ~= nil) then
            action();
        end
    end, false)
end

function SpawnCar(model)

    
    local hash = GetHashKey(model)
    
    RequestModel(hash)
    
    while not HasModelLoaded(hash) do Wait(0) end

    local pos = GetEntityCoords(PlayerPedId())

    local veh = CreateVehicle(hash, pos.x, pos.y, pos.z, GetEntityHeading(PlayerPedId()), true, false)

    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)

    return veh

end