----Gets ESX-------------------------------------------------------------------------------------------------------------------------------
ESX = nil
local peds = {}
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
        CreateBlipsVendors()
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
        CreateBlipsVendors()
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------
local zonesSpawned = false
local PlayerData = {}
local vendors

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterCommand('ratings', function(source)
	TriggerServerEvent('koe_vendors:ratingsForMenu')
end)

------BUY ITEMS NPC FUNCTIONS-----------------
----------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)

        for k, v in pairs(Config.VendorLocations) do 
            local npcCoords = v.pzCoords
            local pedCoords = GetEntityCoords(PlayerPedId()) 
            local dst = #(npcCoords - pedCoords)
            
            if dst < 30 and zonesSpawned == false then
                TriggerEvent('koe_vendors:spawnZones')
                zonesSpawned = true
            end
            -- if dst >= 31  then
            --     npcSpawned = false
            --     DeleteEntity(vendors)
            -- end
        end
    end
end)


function CreateBlipsVendors()
    for k, v in pairs(Config.VendorLocations) do
        if (v.blip ~= nil) then
            local blip = AddBlipForCoord(v.pzCoords)
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

RegisterNetEvent('koe_vendors:spawnZones')
AddEventHandler('koe_vendors:spawnZones',function()
  
    for locations, info in pairs(Config.VendorLocations) do

        exports.qtarget:AddBoxZone(info.location, info.pzCoords, info.pzW, info.pzH,{
            name= info.location,
            heading= info.pzHeading,
            debugPoly= false,
            minZ= info.pzMin,  
            maxZ= info.pzMax,
            },
                {
                options = {
                    {
                    event = "koe_vendors:WhichMenu",
                    icon = "fa-solid fa-clipboard",
                    label = "Open Menu",
                    location = info.location,
                    npc = locations,
                    illegal = info.illegal,
                    items = info.sellableitems,
                    type = info.type,
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

-- RegisterNetEvent('koe_vendors:spawnPeds')
-- AddEventHandler('koe_vendors:spawnPeds',function()
  
--     for locations, info in pairs(Config.VendorLocations) do
--         local hash = GetHashKey(info.npcmodel)

--         if not HasModelLoaded(hash) then
--             RequestModel(hash)
--             Wait(10)
--         end
--         while not HasModelLoaded(hash) do 
--             Wait(10)
--         end

--         vendors = CreatePed(5, hash, info.npccoords , info.npcheading, true, true)
--         -- Wait Until The Ped Is Created
--         while not DoesEntityExist(vendors) do Wait(0) end

--         FreezeEntityPosition(vendors, true)
--         SetEntityInvincible(vendors, true)
--         SetBlockingOfNonTemporaryEvents(vendors, true)
--         SetModelAsNoLongerNeeded(hash)


    
--             exports['qtarget']:AddTargetEntity(vendors, 
--             {
--                 options = {
--                     {
--                     event = "koe_vendors:WhichMenu",
--                     icon = "fa-solid fa-clipboard",
--                     label = "Open Menu",
--                     location = info.location,
--                     npc = locations,
--                     illegal = info.illegal,
--                     items = Config.VendorLocations[locations].sellableitems,
--                     type = info.type,
--                     canInteract = function()
--                         local player = PlayerPedId()
--                         return IsPedOnFoot(player)
--                     end,
--                     },                                     
--                 },
--                     distance = 2.5
--             }) 
--     end

-- end)

RegisterNetEvent('koe_vendors:WhichMenu')
AddEventHandler('koe_vendors:WhichMenu',function(data)
    local npc = data.npc
    local location = data.location
    local illegal = data.illegal
    items = data.items
    typeOfVendor = data.type

    if typeOfVendor == 'vendor' then
        TriggerEvent('koe_vendors:getCrimR', npc, location, illegal, items)
    else
        TriggerEvent('koe_vendors:buffer', npc, location, illegal, items)
    end
end)

RegisterNetEvent('koe_vendors:getCrimR')
AddEventHandler('koe_vendors:getCrimR',function(npc, location, illegal, items)
    local npc = npc
    local location = location
    TriggerServerEvent('koe_vendors:getCrimRating', npc, location)
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

---------SELLING NPC FUNCTIONS-------------------
-------------------------------------------------
--VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV-


RegisterNetEvent('koe_vendors:buffer')
AddEventHandler('koe_vendors:buffer',function(npc, location, illegal, items)
    location = location
    npc = npc
    illegal = illegal
    items = items

    TriggerServerEvent('koe_vendors:getCivRating', location, npc, illegal, items)
end)

RegisterNetEvent('koe_vendors:sellMenu')
AddEventHandler('koe_vendors:sellMenu',function(location, npc, illegal, items, civRating, level, crimRating)
    local civRating = civRating
    items = items
    local itemLabels = {}

    if not illegal then
        local options = {{title = 'Civ Rating: '..civRating, icon = 'fas fa-ranking-star', metadata = {'Current Civilian Rating!'}},{title = 'CLICK HERE TO SELL', description = 'This npc will buy any items listed below.', arrow = true, event = 'koe_vendors:sellCheck', icon = 'fas fa-basket-shopping', args = {location = location, illegal = illegal, npc = npc, civRating = civRating, level = level}}}

        for k, v in pairs(items) do 
            table.insert(itemLabels,v.label)
        end

        table.sort(itemLabels, function(a, b) return a:lower() < b:lower() end)

        for k2, v2 in ipairs(itemLabels) do
              
            local labels = {}
            table.insert(labels, v2)
            table.insert(options,
                {
                    title = labels,
                }
            )

        end

        lib.registerContext({
            id = 'sellermenu',
            title = location,
            options = options
        })

        lib.showContext('sellermenu')
    else
        local options = {{title = 'Crim Rating: '..crimRating, icon = 'fas fa-ranking-star', metadata = {'Current Civilian Rating!'}},{title = 'CLICK HERE TO SELL', description = 'This npc will buy any items listed below.', arrow = true, event = 'koe_vendors:sellCheck', icon = 'fas fa-basket-shopping', args = {location = location, illegal = illegal,  npc = npc, civRating = civRating, level = level}}}

        for k, v in pairs(items) do 
            table.insert(itemLabels,v.label)
        end

        table.sort(itemLabels, function(a, b) return a:lower() < b:lower() end)

        for k2, v2 in ipairs(itemLabels) do
              
            local labels = {}
            table.insert(labels, v2)
            table.insert(options,
                {
                    title = labels,
                }
            )

        end

        lib.registerContext({
            id = 'sellermenu',
            title = location,
            options = options
        })

        lib.showContext('sellermenu')
    end

end)


RegisterNetEvent('koe_vendors:sellCheck')
AddEventHandler('koe_vendors:sellCheck',function(data)
    location = data.location
    illegal = data.illegal
    npc = data.npc
    civRating = data.civRating
    level = data.level
    TriggerServerEvent('koe_vendors:SellShit', location, illegal, npc, civRating, level)
end)
--------------------------------------------------
--------------------------------------------------

RegisterNetEvent('koe_vendors:ratingsMenu')
AddEventHandler('koe_vendors:ratingsMenu',function(crimRatingForMenu, civRatingForMenu)
    lib.registerContext({
        id = 'ratingsmenu',
        title = 'Current Ratings',
        options = {
            {
                title = 'Civilian Rating',
                icon = 'fas fa-ranking-star',
                description = 'Current Rating: '..civRatingForMenu,
            },
            {
                title = 'Criminal Rating',
                icon = 'fas fa-ranking-star',
                description = 'Current Rating: '..crimRatingForMenu,
            },

        },
    })

    lib.showContext('ratingsmenu')
end)