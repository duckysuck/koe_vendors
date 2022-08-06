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
        TriggerServerEvent('koe_vendors:updateDB')
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
                event = "koe_vendors:getXP",
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

RegisterNetEvent('koe_vendors:getXP')
AddEventHandler('koe_vendors:getXP',function(data)
    local npc = data.npc
    local location = data.location
    TriggerServerEvent('koe_vendors:getPlayerXP', npc, location)
end)

RegisterNetEvent('koe_vendors:buyMenu')
AddEventHandler('koe_vendors:buyMenu',function(npc, location, crimlevel)
    local src = source
    local itemsForSale = Config.VendorLocations[npc].itemsforsale
    local illegal = Config.VendorLocations[npc].illegal
    local illegalString = nil
    local optionsLegal = {{title = 'Click an item below to purchase'}}
    local optionsIllegal = {{title = 'Click an item below to purchase'}}

    if illegal == false then
        illegalString = 'Legal'
    elseif illegal == true then
        illegalString = 'Illegal'
    end

    if illegal == false then
        for k, v in pairs(itemsForSale) do
            local labels = Config.VendorLocations[npc].itemsforsale[k].label
            local price = Config.VendorLocations[npc].itemsforsale[k].price
            local itemname = Config.VendorLocations[npc].itemsforsale[k].itemname
            local image = Config.VendorLocations[npc].itemsforsale[k].image

            table.insert(optionsLegal,
                {
                    title = labels,
                    event = 'koe_vendors:keyboard',
                    metadata = {'Price: $'..price},
                    image = image,
                    args = {price = price, item = itemname}
                }
            )
        end
    elseif illegal == true then
        for k, v in pairs(itemsForSale) do
            local labels = Config.VendorLocations[npc].itemsforsale[k].label
            local price = Config.VendorLocations[npc].itemsforsale[k].price
            local itemname = Config.VendorLocations[npc].itemsforsale[k].itemname
            local requiredXP = Config.VendorLocations[npc].itemsforsale[k].requiredXP
            local image = Config.VendorLocations[npc].itemsforsale[k].image

            table.insert(optionsIllegal,
                {
                    title = labels,
                    event = 'koe_vendors:amountIllegal',
                    metadata = {
                        {label = 'Price ', value = '$'..price},
                        {label = 'Required Crime Rating ', value = requiredXP},
                    },
                    image = image,
                    args = {price = price, item = itemname, requiredXP = requiredXP}
                }
            )
        end
    end

    if illegal == false then
        lib.registerContext({
            id = 'legalMenu',
            title = location,
            options = {
                {
                    title = 'This vendor is  ' ..illegalString
                },
                {
                    title = 'Items For Sale',
                    menu = 'legalItemsMenu',
                    description = 'Purchase goods from this vendor'
                },
                lib.registerContext({
                    id = 'legalItemsMenu',
                    menu = 'legalMenu',
                    title = location,
                    options = optionsLegal
                })
            }
        })
            lib.showContext('legalMenu')
    elseif illegal == true then
        lib.registerContext({
            id = 'illegalMenu',
            title = location,
            options = {
                {
                    title = 'This vendor is  ' ..illegalString
                },
                {
                    title = 'Current Crime Rating: ' ..crimlevel
                },
                {
                    title = 'Illegal Items For Sale',
                    menu = 'illegalItemsMenu',
                    description = 'Purchase goods from this vendor'
                },
                lib.registerContext({
                    id = 'illegalItemsMenu',
                    menu = 'illegalMenu',
                    title = location,
                    options = optionsIllegal
                })
            }
        })
            lib.showContext('illegalMenu')
    end

end)

RegisterNetEvent('koe_vendors:amountLegal')
AddEventHandler('koe_vendors:keyboard',function(data)
    local item = data.item
    price = data.price


    local input = lib.inputDialog('How many?', {'Amount x $'..price..'.00'})

    if input then
        local amount = tonumber(input[1])
        TriggerEvent('koe_vendors:purchaseLegal', item, amount, price)
    end
end)

RegisterNetEvent('koe_vendors:amountIllegal')
AddEventHandler('koe_vendors:amountIllegal',function(data)
    local item = data.item
    price = data.price
    neededXP = data.requiredXP

    local input2 = lib.inputDialog('How many?', {'Amount x $'..price..'.00'})

    if input2 then
        local amount = tonumber(input2[1])
        TriggerEvent('koe_vendors:purchaseIllegal', item, amount, price, neededXP)
    end
end)

RegisterNetEvent('koe_vendors:purchaseLegal')
AddEventHandler('koe_vendors:purchaseLegal',function(item, amount, price)
    TriggerServerEvent('koe_vendors:soldLegal', item, amount, price)
end)

RegisterNetEvent('koe_vendors:purchaseIllegal')
AddEventHandler('koe_vendors:purchaseIllegal',function(item, amount, price, neededXP)
    TriggerServerEvent('koe_vendors:soldIllegal', item, amount, price, neededXP)
end)
