Config = {}

-- Blip Creation

Config.UseBlip = false

Config.BlipLocation = {
    {title="Shady Dealer", colour=37, id=47, x = -462.73, y = -66.37, z = 44.90},
} 

-- Ped Spawns

Config.Peds = {
    {
        type = 'donglenpc',
        position = vector4(-392.1338, 2960.1555, 18.7911, 253.8992)
    },
}

-- Menu Contents

Config.RobberyList = {
    [1] = {
        bank = true,
        Header = "Fleeca Banks",
        minCops = 3,
    },
    [2] = {
        bank = true,
        Header = "Paleto Bank",
        minCops = 6,
    },
    [3] = {
        bank = true,
        Header = "Pacific Bank",
        minCops = 5,
    },
    [4] = {
        bank = true,
        Header = "Vangelico Jewllery",
        minCops = 5,
    },
    [5] = {
        bank = true,
        Header = "24/7 Store",
        minCops = 0,
    },
}

Config.Shop = {
    [1] = {
        item = "electronickit",
        price = 3594,
        type = "cash",
        icon = "fa-solid fa-bolt",
    },
    [2] = {
        item = "gatecrack",
        price = 2390,
        type = "cash",
        icon = "fa-solid fa-circle",
    },
    [3] = {
        item = "thermite",
        price = 4912,
        type = "cash",
        icon = "fa-solid fa-fire",
    },
    [4] = {
        item = "trojan_usb",
        price = 2000,
        type = "cash",
        icon = "fab fa-usb",
    },
    [5] = {
        item = "drill",
        price = 1790,
        type = "cash",
        icon = "fa-solid fa-circle",
    }
}
