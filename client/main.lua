keyRegister("boutique", "Menu Boutique", "F10", function()

    CreateMenu(eBoutique)

end)

RegisterNetEvent("error:giveVehC", function(veh)

    local ped = PlayerPedId()

    local pos = GetEntityCoords(ped)

    print(veh)

    local veh = SpawnCar(veh)

    local mod = ESX.Game.GetVehicleProperties(veh)

    TriggerServerEvent("error:giveVeh", mod, mod.plate)

end)