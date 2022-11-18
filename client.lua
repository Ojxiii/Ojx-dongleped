local QBCore = exports['qb-core']:GetCoreObject()
local CurrentCops = 0


local BankRobberyCD = false

-- Blip Creation

Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlip then
	   		info.blip = AddBlipForCoord(info.x, info.y, info.z)
	   		SetBlipSprite(info.blip, info.id)
	   		SetBlipDisplay(info.blip, 4)
	   		SetBlipScale(info.blip, 0.6)	
	   		SetBlipColour(info.blip, info.colour)
	   		SetBlipAsShortRange(info.blip, true)
	   		BeginTextCommandSetBlipName("STRING")
	   		AddTextComponentString('<FONT FACE="Sora">'.. info.title)
	   		EndTextCommandSetBlipName(info.blip)
	 	end
   	end	
end)

RegisterNetEvent('Ojx-dongle:activity', function()
            local header = {
                {
                    isMenuHeader = true,
                    icon = "fa-solid fa-circle-info",
                    header = " Available Robberies",
                }
            }
            for k, v in pairs(Config.RobberyList) do
                if CurrentCops >= v.minCops then
                    if not v.bank or (v.bank and not BankRobberyCD) then
                        header[#header+1] = {
                            header = v.Header,
                            txt = "Available",
                            icon = "fas fa-check-circle",
                            isMenuHeader = true,
                        }
                    else
                        header[#header+1] = {
                            header = v.Header,
                            txt = "Not Available'",
                            icon = "fas fa-times-circle",
                            isMenuHeader = true,
                        }
                    end
                else
                    header[#header+1] = {
                        header = v.Header,
                        txt = "Not Available",
                        icon = "fas fa-times-circle",
                        isMenuHeader = true,
                    }
                end
            end
            header[#header+1] = {
                header = "Close (ESC)",
                icon = "fa-solid fa-angle-left",
                isMenuHeader = true,
                params = {
                    event = "",
                }
            }
        
            exports['qb-menu']:openMenu(header)
        end)

RegisterNetEvent('Ojx-dongle:buyitems', function(data)
    local header = {
        {
            isMenuHeader = true,
            icon = "fa-solid fa-circle-info",
            header = "Practice Makes Perfect!"
        }
    }
    for k, v in pairs(Config.Shop) do
        if QBCore.Shared.Items[v.item].label then
            header[#header+1] = {
                header = QBCore.Shared.Items[v.item].label,
                txt = "Price: "..v.price,
                icon = v.icon,
                params = {
                    isServer = true,
                    event = "Ojx-dongle:server:buyshit",
                    args = k
                }
            }
        end
    end
    header[#header+1] = {
        header = "Close (ESC)",
        icon = "fa-solid fa-angle-left",
        isMenuHeader = true,
        params = {
            event = "",
        }
    }

    exports['qb-menu']:openMenu(header)
end)

-- Ped Creation

function SetupDongleBoss(coords)
    RequestModel(`ig_djgeneric_01`)
    while not HasModelLoaded(`ig_djgeneric_01`) do
    Wait(1)
    end
    donglenpc = CreatePed(2, `ig_djgeneric_01`, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
    SetPedFleeAttributes(donglenpc, 0, 0)
    SetPedDiesWhenInjured(donglenpc, false)
    TaskStartScenarioInPlace(donglenpc, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)
    SetPedKeepTask(donglenpc, true)
    SetBlockingOfNonTemporaryEvents(donglenpc, true)
    SetEntityInvincible(donglenpc, true)
    FreezeEntityPosition(donglenpc, true)
end

function CreatePeds()
    for i = 1, #Config.Peds do
        if Config.Peds[i].type == 'donglenpc' then
            SetupDongleBoss(Config.Peds[i].position, i)
        end
    end
end

CreateThread(function()
    CreatePeds()
end)

-- Bank Robbery Triggers

-- do something like when a TriggerClientEvent('Ojx-dongle:client:SetBankCD', -1, true) when a bank is being robbed
-- do something like TriggerClientEvent('Ojx-dongle:client:SetBankCD', -1, false) when a bank can be hit again

RegisterNetEvent('Ojx-dongle:client:SetBankCD', function(bool)
    BankRobberyCD = bool
end)

RegisterNetEvent('police:SetCopCount', function(amount)
    CurrentCops = amount
end)

-- Target Exports

CreateThread(function()
    exports['qb-target']:AddTargetModel('ig_djgeneric_01', {
        options = {
            { 
                type = "client",
                event = "Ojx-dongle:activity",
                icon = "fas fa-circle",
                label = "Check Availability",
                job = "all",
            },
            {
                type = "client",
                event = "Ojx-dongle:buyitems",
                icon = "fas fa-circle",
                label = "Purchase Equıpment",
                job = "all",
            },
        },
        distance = 3.0 
    })

end)

