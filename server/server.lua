ESX = nil
TriggerEvent(Config.getESX, function(obj) ESX = obj end)

ESX.RegisterServerCallback("error:getUserCoins", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT coins FROM users WHERE identifier = ?", {xPlayer.identifier}, function(result)
    
        cb(result[1].coins)
    
    end)

end)

RegisterNetEvent("error:giveVeh", function(mod, plate)

    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`) VALUES (@a, @b, @c)", {

        ['@a'] = xPlayer.identifier,
        ['@b'] = plate,
        ['@c'] = json.encode(mod)

    })

end)

RegisterNetEvent("error:payWeapon", function(price, coins, weapon)

    local xPlayer = ESX.GetPlayerFromId(source)

    if coins >= price then 

        xPlayer.addWeapon(weapon, 200)

        xPlayer.showNotification("Vous avez reçus : ~b~"..ESX.GetWeaponLabel(weapon))

        MySQL.Async.execute("UPDATE users SET coins = ? WHERE identifier = ?", {coins-price, xPlayer.identifier})

        return

    end

    xPlayer.showNotification("Vous n'avez pas assez, vous avez ~r~"..coins.."~s~ coins")

end)

RegisterNetEvent("error:givePlayerMoney", function(money, coins, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if coins >= price then

        xPlayer.addAccountMoney('bank', money)

        xPlayer.showNotification("Vous avez reçus : ~g~"..money.."~s~$ en ~b~banque")

        MySQL.Async.execute("UPDATE users SET coins = ? WHERE identifier = ?", {coins-price, xPlayer.identifier})

        return

    end

    xPlayer.showNotification("Vous n'avez pas assez, vous avez ~r~"..coins.."~s~ coins")

end)

RegisterNetEvent("error:payVehicle", function(mod, plate, coins, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`) VALUES (@a, @b, @c)", {

        ['@a'] = xPlayer.identifier,
        ['@b'] = plate,
        ['@c'] = json.encode(mod)

    })

    MySQL.Async.execute("UPDATE users SET coins = ? WHERE identifier = ?", {coins-price, xPlayer.identifier})

    xPlayer.showNotification("Profite bien de ta ~b~voiture !")

end)

RegisterNetEvent("error:givePlayerCaisse1", function(loot, coins, price)

    local xPlayer = ESX.GetPlayerFromId(source)

    if loot.weapon then 

        xPlayer.addWeapon(loot.weapon, 200)

        xPlayer.showNotification("Vous avez reçus : ~b~"..ESX.GetWeaponLabel(loot.weapon))

        return

    end

    if loot.item then 

        xPlayer.addInventoryItem(loot.item, loot.nb)

        xPlayer.showNotification("Vous avez reçus : ~b~x"..loot.nb.." "..ESX.GetItemLabel(loot.item))

        return

    end

    if loot.model then

        TriggerClientEvent("error:giveVehC", -1, loot.model)


        xPlayer.showNotification("Vous avez reçus : ~b~"..loot.label)

    end

    MySQL.Async.execute("UPDATE users SET coins = ? WHERE identifier = ?", {coins-price, xPlayer.identifier})

end)

ESX.RegisterCommand('givecoins', 'admin', function(xPlayer, args, showError)

    local target = ESX.GetPlayerFromId(tonumber(args['Id']))

    if target == nil then xPlayer.showNotification("La personne n'est pas ~b~en ligne") return end
	
    MySQL.Async.execute("UPDATE users SET coins = coins + ? WHERE identifier = ?", {tonumber(args['Coins']), target.identifier})

    target.showNotification("Vous avez reçus : ~r~"..args['Coins'].."~s~ coins")

end, false, {help = "Donner Points Boutique", validate = true, arguments = {
	{name = 'Id', help = "Id", type = 'number'},
	{name = 'Coins', help = "Coins", type = 'number'}
}})