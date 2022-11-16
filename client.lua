----Gets Framework-------------------------------------------------------------------------------------------------------------------------------
local framework = Config.Framework
local ESX, QBCore

CreateThread(function()
    if framework == 'esx' then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function (xPlayer)
            ESX.PlayerData = xPlayer
        end)

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function (job)
            ESX.PlayerData.job = job
        end)
    elseif framework == 'qb' then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)


if Config.Framework == 'esx' then
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        CreateBlipsVendors()
        TriggerEvent('koe_vendors:spawnZones')
    end)
    
    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        ESX.PlayerData = xPlayer
        PlayerLoaded = true
    end)

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        ESX.PlayerData.job = job
    end)

    AddEventHandler('esx:onPlayerSpawn', function()
        local ped = PlayerPedId()
    end)
elseif Config.Framework == 'qb' then
    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        CreateBlipsVendors()
        TriggerEvent('koe_vendors:spawnZones')
    end)
end

AddEventHandler('onResourceStart', function(resourceName)
	if (resourceName == GetCurrentResourceName()) then
        TriggerEvent('koe_vendors:spawnZones')
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------

local peds = {}
local zonesSpawned = false
local PlayerData = {}
local vendors

RegisterCommand('ratings', function(source)
	TriggerServerEvent('koe_vendors:ratingsForMenu')
end)

------BUY ITEMS NPC FUNCTIONS-----------------
----------------------------------------------

function CreateBlipsVendors()
    for k, v in pairs(Config.VendorLocations) do

        if (v.blip ~= nil) then
            local vendorblip = AddBlipForCoord(v.coords)
            SetBlipSprite(vendorblip, v.blip.sprite)
            SetBlipDisplay(vendorblip, 2)
            SetBlipScale(vendorblip, 0.5)
            SetBlipColour(vendorblip, 0)
            SetBlipAsShortRange(vendorblip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentSubstringPlayerName(v.blip.label)
            EndTextCommandSetBlipName(vendorblip)
        end

    end
end

RegisterNetEvent('koe_vendors:spawnZones')
AddEventHandler('koe_vendors:spawnZones',function()
    local vendorNPC = {}
    local peds = {}
    local items = {}

    for k, v in pairs(Config.VendorLocations) do
        table.insert(peds, v)
    end

    for i = 1, #peds do
        local pedZones = lib.points.new(peds[i].coords, 30, {zone = k, data = peds[i]})
    
        function pedZones:onEnter()
            lib.requestModel(self.data.model)
            vendorNPC[i] = CreatePed(5, self.data.model, self.data.coords.x, self.data.coords.y, self.data.coords.z, self.data.heading, false, false)
            FreezeEntityPosition(vendorNPC[i], true)
            SetEntityInvincible(vendorNPC[i], true)
            SetBlockingOfNonTemporaryEvents(vendorNPC[i], true)
            
            if Config.Framework == 'esx' then
                exports.qtarget:AddEntityZone("vendors", vendorNPC[i], {
                    name="vendors",
                    debugPoly=false,
                    useZ = true
                        }, {
                    options = {
                        {
                            event = "koe_vendors:WhichMenu",
                            icon = "fa-solid fa-clipboard",
                            label = "Open Menu",
                            location = self.data.location,
                            npc = peds[i].location,
                            illegal = self.data.illegal,
                            items =self.data.items,
                            type = self.data.type,
                            canInteract = function()
                                local player = PlayerPedId()
                                return IsPedOnFoot(player)
                            end,
                        },                                     
                    },
                    distance = 2
                })
            elseif Config.Framework == 'qb' then
                exports['qb-target']:AddEntityZone("vendors", vendorNPC[i], {
                    name="vendors",
                    debugPoly=false,
                    useZ = true
                        }, {
                    options = {
                        {
                            event = "koe_vendors:WhichMenu",
                            icon = "fa-solid fa-clipboard",
                            label = "Open Menu",
                            location = self.data.location,
                            npc = peds[i].location,
                            illegal = self.data.illegal,
                            items =self.data.items,
                            type = self.data.type,
                            canInteract = function()
                                local player = PlayerPedId()
                                return IsPedOnFoot(player)
                            end,
                        },                                     
                    },
                    distance = 2
                })
            end
        end

        function pedZones:onExit()
            DeletePed(vendorNPC[i])
        end
    end
end)


RegisterNetEvent('koe_vendors:WhichMenu')   
AddEventHandler('koe_vendors:WhichMenu',function(data)
    npc = data.npc
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
    TriggerServerEvent('koe_vendors:getCrimRating', npc, location, items, illegal)
end)

RegisterNetEvent('koe_vendors:buyMenu')
AddEventHandler('koe_vendors:buyMenu',function(npc, location, crimlevel, items, illegal)
    local src = source
    local items = items
    local illegal = illegal
    local illegalString = nil
    local optionsLegal = {{title = 'Click an item below to purchase'}}
    local optionsIllegal = {{title = 'Click an item below to purchase'}}

    if illegal == false then
        illegalString = 'Legal'
    elseif illegal == true then
        illegalString = 'Illegal'
    end

    if illegal == false then
        for k, v in pairs(items) do
            local labels = v.label
            local price = v.price
            local itemname = v.itemname
            local image = v.image

            if Config.ContextMenu == 'ox_lib' then
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
            if Config.ContextMenu == 'qb' then
                table.insert(optionsLegal,
                    {
                        header = labels,
                        txt = {'Price: $'..price},
                        params = {
                            event = 'koe_vendors:keyboard',
                            args = {price = price, item = itemname, image = image}
                        }
                        
                    }
                )
            end
        end
    elseif illegal == true then
        for k, v in pairs(items) do
            local labels = v.label
            local price = v.price
            local itemname = v.itemname
            local requiredXP = v.requiredXP
            local image = v.image

            if Config.ContextMenu == 'ox_lib' then
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
            if Config.ContextMenu == 'qb' then
                table.insert(optionsIllegal,
                    {
                        header = labels,
                        txt = {'Price: $'..price..' Required Rating: '..requiredXP},
                        params = {
                            event = 'koe_vendors:amountIllegal',
                            args = {price = price, item = itemname, requiredXP = requiredXP}
                        }
                        
                    }
                )
            end
        end
    end

    if illegal == false then
        if Config.ContextMenu == 'ox_lib' then
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
        end
        if Config.ContextMenu == 'qb' then
            exports['qb-menu']:openMenu(optionsLegal)
        end

    elseif illegal == true then
        if Config.ContextMenu == 'ox_lib' then
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
        if Config.ContextMenu == 'qb' then
            exports['qb-menu']:openMenu(optionsIllegal)
        end
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
        local options = {{title = 'Civ Rating: '..civRating, icon = 'fas fa-ranking-star', metadata = {'Current Civilian Rating!'}},{title = 'CLICK HERE TO SELL', description = 'This npc will buy any items listed below.', arrow = true, event = 'koe_vendors:sellCheck', icon = 'fas fa-basket-shopping', args = {location = location, illegal = illegal, npc = npc, civRating = civRating, level = level, items = items}}}

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
        local options = {{title = 'Crim Rating: '..crimRating, icon = 'fas fa-ranking-star', metadata = {'Current Civilian Rating!'}},{title = 'CLICK HERE TO SELL', description = 'This npc will buy any items listed below.', arrow = true, event = 'koe_vendors:sellCheck', icon = 'fas fa-basket-shopping', args = {location = location, illegal = illegal,  npc = npc, civRating = civRating, level = level, items = items}}}

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
    items = data.items
    TriggerServerEvent('koe_vendors:SellShit', location, illegal, npc, civRating, level, items)
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