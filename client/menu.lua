ESX = nil
playerData = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.getESX, function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	playerData = ESX.GetPlayerData()
end)

local player_coins = ""

local function refreshCoins()

    ESX.TriggerServerCallback("error:getUserCoins", function(coins)

        player_coins = coins
        
    end)

    Wait(150)

    return player_coins

end

eBoutique = {}

eBoutique.Base = {

    Header = {"commonmenu", "interaction_bgd"},
    Color = {color_Green},
    HeaderColor = Config.colors,
    Title = 'Boutique '..Config.serverName

}

eBoutique.Data = {currentMenu = "liste des ~b~articles"}

eBoutique.Events = {

    onSelected = function(self, _, btn, PMenu, menuData, currentButton, currentBtn, currentSlt, result, slide)
        
        if btn.weaponn then

            TriggerServerEvent("error:payWeapon", btn.pricee, player_coins, btn.weaponn)

            eBoutique.Menu['liste des ~b~articles'].b()
            Wait(500)

            return

        end

        if btn.sommee then

            
            TriggerServerEvent("error:givePlayerMoney", btn.sommee, player_coins, btn.pricee)
            
            eBoutique.Menu['liste des ~b~articles'].b()

            Wait(500)

        end

        if btn.model then

            
            if player_coins >= btn.pricee then
                
                local veh = SpawnCar(btn.model)
                
                TriggerServerEvent("error:payVehicle", ESX.Game.GetVehicleProperties(veh), GetVehicleNumberPlateText(veh), player_coins, btn.pricee)
                
                eBoutique.Menu['liste des ~b~articles'].b()
                    
                Wait(500)

                return

            end

            ESX.ShowNotification("Vous n'avez pas assez, vous avez ~r~"..player_coins.."~s~ coins")

        end

        if btn.loot then

            if player_coins < btn.pricee then ESX.ShowNotification("Vous n'avez pas assez, vous avez ~r~"..player_coins.."~s~ coins") return end
            
            local index = math.random(1, #btn.loot)
            
            TriggerServerEvent("error:givePlayerCaisse1", btn.loot[index], player_coins, btn.pricee)

            eBoutique.Menu['liste des ~b~articles'].b()

            Wait(500)

            return

        end

    end

}

eBoutique.Menu = {

    ['liste des ~b~articles'] = {

        b = function()

            local all_btn = {}

                player_coins = refreshCoins()

                all_btn[#all_btn+1] = {

                    name = "Vos coins : ~r~"..player_coins,
                    ask = "",
                    askX = true

                }

                all_btn[#all_btn+1] = {

                    name = "\t\t\t     ---------------------",
                    ask = "",
                    askX = true

                }

            if Config.weapons then 

                all_btn[#all_btn+1] = {

                    name = "Liste des ~b~armes",
                    ask = "→",
                    askX = true

                }

            end

            all_btn[#all_btn+1] = {

                name = "Liste des ~b~voitures",
                ask = "→",
                askX = true

            }

            all_btn[#all_btn+1] = {

                name = "Liste des ~b~caisses",
                ask = "→",
                askX = true

            }

            if Config.money then

                all_btn[#all_btn+1] = {

                    name = "Liste des sommes ~g~d'argent",
                    ask = "→",
                    askX = true

                }

            end

            return all_btn

        end

    },

    ['liste des ~b~caisses'] = {

        b = function()

            local all_box = {}

            for _,v in pairs(Config.caisses) do

                all_box[#all_box+1] = {

                    name = v.label,
                    ask = "~r~"..v.price.."~s~ coins",
                    askX = true,
                    level = v.level,
                    loot = v.loot,
                    pricee = v.price

                }

            end

            return all_box

        end

    },

    ['liste des sommes ~g~d\'argent'] = {

        b = function()

            local all_cash = {}

            for _,v in pairs(Config.cashList) do 

                all_cash[#all_cash+1] = {

                    name = v.label,
                    ask = "~r~"..v.price.."~s~ coins",
                    askX = true,
                    pricee = v.price,
                    sommee = v.somme,
                    typee == "money"

                }

            end

            return all_cash

        end

    },

    ['liste des ~b~armes'] = {

        b = function()

            local all_weapons = {}

            for _,v in pairs(Config.weaponList) do 

                all_weapons[#all_weapons+1] = {

                    name = v.label,
                    ask = "~r~"..v.price.."~s~ coins",
                    askX = true,
                    typee = "weapon",
                    weaponn = v.weapon,
                    pricee = v.price

                }

            end

            return all_weapons

        end

    },

    ['liste des ~b~voitures'] = {

        b = function()

            local all_cars = {}

            for _,v in pairs(Config.carsList) do 

                all_cars[#all_cars+1] = {

                    name = v.label,
                    ask = "~r~"..v.price.."~s~ coins",
                    askX = true,
                    pricee = v.price,
                    model = v.model

                }

            end

            return all_cars

        end

    }

}