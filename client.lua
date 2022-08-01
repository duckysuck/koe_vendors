----Gets ESX-------------------------------------------------------------------------------------------------------------------------------
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()

end)

Citizen.CreateThread(function()
	RegisterNetEvent('esx:playerLoaded')
	AddEventHandler('esx:playerLoaded', function (xPlayer)
		while ESX == nil do
			Citizen.Wait(0)
		end
		ESX.PlayerData = xPlayer
		PlayerLoaded = true
        CreateBlips()
	end)
end) 

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('onResourceStart', function(resourceName)
	if (resourceName == GetCurrentResourceName()) then
        while (ESX == nil) do Citizen.Wait(100) end        
        Citizen.Wait(5000)
        ESX.PlayerLoaded = true
        CreateBlips()
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------


local npcSpawned = false
local orgNpc
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

--Spawn NPC--
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)

        for k, v in pairs(Config.VendorLocations) do 
            local npcCoords = v.npccoords
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local dst = #(npcCoords - pedCoords)
            
            if dst < 30 and npcSpawned == false then
                TriggerEvent('koe_vendors:spawnPed')
                npcSpawned = true
            end
            -- if dst >= 31  then
            --     npcSpawned = false
            --     DeleteEntity(vendors)
            -- end
        end
    end
end)

function CreateBlips()
    for k, v in pairs(Config.VendorLocations) do
        if (v.blip ~= nil) then
            local blip = AddBlipForCoord(v.npccoords)
            SetBlipSprite (blip, v.blip.sprite)
            SetBlipDisplay(blip, 6)
            SetBlipScale  (blip, 1.1)
            SetBlipColour (blip, v.blip.colour)
            SetBlipAsShortRange(blip, true)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(v.blip.label)
            EndTextCommandSetBlipName(blip)
        end
    end
end

RegisterNetEvent('koe_vendors:spawnPed')
AddEventHandler('koe_vendors:spawnPed',function()
    for locations, info in pairs(Config.VendorLocations) do
        local hash = GetHashKey(info.npcmodel)
        if not HasModelLoaded(hash) then
            RequestModel(hash)
            Wait(10)
        end
        while not HasModelLoaded(hash) do 
            Wait(10)
        end

        vendors = CreatePed(5, hash, info.npccoords , info.npcheading, false, false)
        FreezeEntityPosition(vendors, true)
        SetEntityInvincible(vendors, true)
        SetBlockingOfNonTemporaryEvents(vendors, true)
        SetModelAsNoLongerNeeded(hash)

        exports['qtarget']:AddEntityZone(info.location, vendors, 
        {                
            name=info.location,
            debugPoly=false,
            useZ = true
        }, 
        {
            options = {
                {
                event = "koe_vendors:buyMenu",
                icon = "fa-solid fa-clipboard",
                label = "Open Menu",
                location = info.location,
                npc = locations,
                canInteract = function()
                    local player = PlayerPedId()
                    return IsPedOnFoot(player)
                end,
                },                                     
            },
                distance = 2.5
        })  
    end

end)
 

RegisterNetEvent('koe_vendors:buyMenu')
AddEventHandler('koe_vendors:buyMenu',function(data)
    local labels = Config.VendorLocations[data.npc].itemsforsale
    local options = {{title = 'Click an item below to purchase'}}

    for k, v in pairs(labels) do
        local labels = Config.VendorLocations[data.npc].itemsforsale[k].label
        local price = Config.VendorLocations[data.npc].itemsforsale[k].price
        local itemname = Config.VendorLocations[data.npc].itemsforsale[k].itemname
        local image = Config.VendorLocations[data.npc].itemsforsale[k].image

        table.insert(options,
            {
                title = labels,
                event = 'koe_vendors:keyboard',
                metadata = {'Price: $'..price},
                image = image,
                args = {price = price, item = itemname}
            }
        )
    end

    lib.registerContext({
        id = 'mainmenu',
        title = data.location,
        options = {
            {
                title = 'Items For Sale',
                menu = 'itemsMenu',
                description = 'Purchase goods from this vendor'
            },
            {
                title = 'Silly Cars',
                menu = 'carmenu',
                description = 'Purchase silly cars from this vendor'
            },

            lib.registerContext({
                id = 'itemsMenu',
                menu = 'mainmenu',
                title = data.location,
                options = options
            })
        }
    })
        lib.showContext('mainmenu')

end)

RegisterNetEvent('koe_vendors:keyboard')
AddEventHandler('koe_vendors:keyboard',function(data)
    local item = data.item
    price = data.price

    local input = lib.inputDialog('How many?', {'Amount x $'..price..'.00'})

    if input then
        local amount = tonumber(input[1])
        TriggerEvent('koe_vendors:purchase', item, amount, price)
    end
end)

RegisterNetEvent('koe_vendors:purchase')
AddEventHandler('koe_vendors:purchase',function(item, amount, price)
    TriggerServerEvent('koe_vendors:sold', item, amount, price)
end)
