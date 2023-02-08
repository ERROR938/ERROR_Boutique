Config = {}

Config.getESX = "esx:getSharedObject"

Config.weapons = true -- true si vous voulez des armes dans la boutique / false si vous n'en voulez pas
Config.money = true -- true si vous voulez de l'argent dans la boutique / false si vous n'en voulez pas

Config.serverName = "La taverne du pirate" -- nom de votre serveur

Config.colors = {255, 255, 255} -- couleurs RGB du menu

Config.weaponList = {

    {label = "Pistolet", weapon = "weapon_pistol", price = 200},
    {label = "Pistolet de combat", weapon = "weapon_combatpistol", price = 400},
    {label = "Tazer", weapon = "weapon_stungun", price = 600},

}

Config.cashList = {

    {label = "Kichta de ~g~1000~s~$", somme = 1000, price = 500},
    {label = "Kichta de ~g~10000~s~$", somme = 10000, price = 1000},
    {label = "Kichta de ~g~100000~s~$", somme = 100000, price = 1500},

}

Config.commune = {

    {label = "Pistolet", weapon = "weapon_pistol"},
    {label = "Pistolet de combat", weapon = "weapon_combatpistol"},
    {label = "Pain", item = "bread", nb = 20},
    {label = "Dominator 7", model = "dominator7"},
    {label = "Paragon", model = "paragon"},

}

Config.carsList = {

    {label = "Itali GTO", model = "italigto", price = 4000},
    {label = "Paragon", model = "paragon", price = 4000},

}

Config.caisses = {

    {label = "Caisse ~b~commune", loot = Config.commune, price = 200}

}