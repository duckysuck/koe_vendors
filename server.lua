local framework = Config.Framework

local ESX, QBCore

if framework == 'esx' then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif framework == 'qb' then
    QBCore = exports['qb-core']:GetCoreObject()
end
----------------------------------------------------------------

RegisterNetEvent('koe_vendors:getCrimRating')
AddEventHandler('koe_vendors:getCrimRating', function(npc, location, items,illegal)
    local src = source

    if Config.Framework == 'esx' then
        local identifier =  ESX.GetPlayerFromId(src).identifier
        local crimlevel = exports['koe_vendors']:getCrimLevel(identifier)

        TriggerClientEvent('koe_vendors:buyMenu', src, npc, location, crimlevel, items, illegal)
    elseif Config.Framework == 'qb' then
        local identifier = QBCore.Functions.GetIdentifier(src, 'license')
        local crimlevel = exports['koe_vendors']:getCrimLevel(identifier)

        TriggerClientEvent('koe_vendors:buyMenu', src, npc, location, crimlevel, items, illegal)
    end
end)
 
--HANDLES BUY ITEMS--
---------------------
RegisterNetEvent('koe_vendors:soldLegal')
AddEventHandler('koe_vendors:soldLegal', function(item, amount, price)
    local src = source
    local xPlayer = nil
    if Config.Framework == 'esx' then
        xPlayer = ESX.GetPlayerFromId(src)
    elseif Config.Framework == 'qb' then
        xPlayer = QBCore.Functions.GetPlayer(src)
    end
    local charge = amount * price

    if Config.Framework == 'esx' then
        if exports.ox_inventory:CanCarryItem(src, item, amount) then
            if xPlayer.getMoney() >= charge then
                xPlayer.addInventoryItem(item, amount)
                xPlayer.removeInventoryItem('money', charge)
                TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You bought '..item..' x'..amount..' for $'..price, duration = 8000, position = 'top'})
            else
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough money", duration = 8000, position = 'top'})
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough space", duration = 8000, position = 'top'})
        end
    elseif Config.Framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.GetMoney('cash') >= charge then
            xPlayer.Functions.AddItem(item, amount)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', amount)
            TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You bought '..item..' x'..amount..' for $'..price, duration = 8000, position = 'top'})
            xPlayer.Functions.RemoveMoney('cash', charge, 'Bought items')
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough money", duration = 8000, position = 'top'})
        end
    end
 
end)

RegisterNetEvent('koe_vendors:soldIllegal')
AddEventHandler('koe_vendors:soldIllegal', function(item, amount, price, neededXP)
    local src = source
    local xPlayer = nil
    local identifier = nil
    local crimlevel = nil
    local charge = amount * price

    if Config.Framework == 'esx' then
        xPlayer = ESX.GetPlayerFromId(src)
    elseif Config.Framework == 'qb' then
        xPlayer = QBCore.Functions.GetPlayer(src)
    end

    if Config.Framework == 'esx' then
        identifier =  ESX.GetPlayerFromId(src).identifier
        crimlevel = exports['koe_vendors']:getCrimLevel(identifier)
    elseif Config.Framework == 'qb' then
        identifier = QBCore.Functions.GetIdentifier(src, 'license')
        crimlevel = exports['koe_vendors']:getCrimLevel(identifier)
    end


    if Config.Framework == 'esx' then
        if crimlevel >= neededXP then
            if exports.ox_inventory:CanCarryItem(src, item, amount) then
                if xPlayer.getAccount('black_money').money >= charge then
                    
                    xPlayer.addInventoryItem(item, amount)
                    xPlayer.removeInventoryItem('black_money', charge)

                    TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You bought '..item..' x'..amount..' for $'..price, duration = 8000, position = 'top'})
                else
                    TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough Dirty money", duration = 8000, position = 'top'})
                end
            else
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough space", duration = 8000, position = 'top'})
            end
        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "You need a crime rating of "..neededXP..' but yours is '..crimlevel, duration = 8000, position = 'top'})
        end
    elseif Config.Framework =='qb' then
        if crimlevel >= neededXP then
            local qbMoney = xPlayer.Functions.GetMoney('cash')

            if qbMoney >= charge then

                local removedMoney = xPlayer.Functions.RemoveMoney('cash', charge, 'Bye money cause cool!')

                if removedMoney then
                    xPlayer.Functions.AddItem(item, amount)
                end
                    
                TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = 'You bought '..item..' x'..amount..' for $'..price, duration = 8000, position = 'top'})
            else
                TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Not enough cash", duration = 8000, position = 'top'})
            end

        else
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "You need a crime rating of "..neededXP..' but yours is '..crimlevel, duration = 8000, position = 'top'})
        end
    end
end)


--SERVER EXPORTS--
------------------
function setCrimlevel(identifier, level)
    if Config.Framework == 'esx' then
        MySQL.Async.execute(
            "UPDATE `users` SET `crim_level`= @xp WHERE `identifier` = @identifier",
            {["@xp"] = level, ["@identifier"] = identifier},
            function()
        end)
    elseif Config.Framework == 'qb' then
        MySQL.Async.execute(
            "UPDATE `players` SET `crim_level`= @xp WHERE `license` = @identifier",
            {["@xp"] = level, ["@identifier"] = identifier},
            function()
        end)
    end
end

function getCrimLevel(identifier)
    if Config.Framework == 'esx' then
        return tonumber(
            MySQL.Sync.fetchScalar(
                "SELECT `crim_level` FROM users WHERE identifier = @identifier ",
                {["@identifier"] = identifier}
            )
        )
    elseif Config.Framework == 'qb' then
        return tonumber(
            MySQL.Sync.fetchScalar(
                "SELECT `crim_level` FROM players WHERE license = @identifier ",
                {["@identifier"] = identifier}
            )
        )
    end
end

function giveCrimLevel(identifier, amount)
    local currentLevel = exports['koe_vendors']:getCrimLevel(identifier)
    local newCrimLevel = amount + currentLevel

    if Config.Framework == 'esx' then
        if newCrimLevel <= 0 then
            MySQL.Async.execute(
            "UPDATE `users` SET `crim_level`= @xp WHERE `identifier` = @identifier",
            {["@xp"] = 0, ["@identifier"] = identifier},
            function()
            end)
        else
            MySQL.Async.execute(
                "UPDATE `users` SET `crim_level`= `crim_level` + @amount WHERE `identifier` = @identifier",
                {["@amount"] = amount, ["@identifier"] = identifier},
                function()
            end)
        end
    elseif Config.Framework == 'qb' then
        if newCrimLevel <= 0 then
            MySQL.Async.execute(
            "UPDATE `players` SET `crim_level`= @xp WHERE `license` = @identifier",
            {["@xp"] = 0, ["@identifier"] = identifier},
            function()
            end)
        else
            MySQL.Async.execute(
                "UPDATE `players` SET `crim_level`= `crim_level` + @amount WHERE `license` = @identifier",
                {["@amount"] = amount, ["@identifier"] = identifier},
                function()
            end)
        end
    end
end

RegisterNetEvent('koe_vendors:getCivRating')
AddEventHandler('koe_vendors:getCivRating', function(location, npc, illegal, items)
    local src = source
    local identifier = nil
    local level 
    
    if Config.Framework == 'esx' then
        identifier =  ESX.GetPlayerFromId(src).identifier
    elseif Config.Framework == 'qb' then
        identifier = QBCore.Functions.GetIdentifier(src, 'license')
    end

    local civRating = exports['koe_vendors']:getCivLevel(identifier)
    local crimRating = exports['koe_vendors']:getCrimLevel(identifier)

    if civRating <= 99 then
        level = 0
    elseif civRating <= 199 then
        level = 1 
    elseif civRating <= 299 then
        level = 2
    elseif civRating <= 1000 then
        level = 3
    elseif civRating <= 2000 then
        level = 4
    elseif civRating <= 3000 then
        level = 5
    elseif civRating <= 6000 then
        level = 6
    elseif civRating <= 8000 then
        level = 7
    elseif civRating <= 10000 then
        level = 8
    elseif civRating <= 12000 then
        level = 9
    elseif civRating >= 15000 then
        level = 10
    end

    TriggerClientEvent('koe_vendors:sellMenu', src, location, npc, illegal, items, civRating, level, crimRating)
end)


RegisterNetEvent('koe_vendors:SellShit')
AddEventHandler('koe_vendors:SellShit', function(location, illegal, npc, civRating, level, items)
    local src = source
    local items = items
    local items2 = {}
    local xPlayer = nil

    if Config.Framework == 'esx' then
        xPlayer = ESX.GetPlayerFromId(source)
    elseif Config.Framework == 'qb' then
        xPlayer = QBCore.Functions.GetPlayer(src)
    end

    local soldfor
    local bonus = nil

    if illegal == false then

        for k, v in pairs(items) do
            
            local itemCount = nil

            if Config.Framework == 'esx' then
                itemCount = xPlayer.getInventoryItem(k).count
            elseif Config.Framework == 'qb' then
                itemCount = xPlayer.Functions.GetItemByName(k).amount
            end
            local price = v.price * itemCount

            if level == 0 then  
                bonus = price * 0.00
                price = price + bonus 
                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end
            elseif level == 1 then
                bonus = price * 0.05
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                  
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 2 then
                bonus = price * 0.07
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 3 then
                bonus = price * 0.09
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end
            
            elseif level == 4 then
                bonus = price * 0.11
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 5 then
                bonus = price * 0.13
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 6 then
                bonus = price * 0.15
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 7 then
                bonus = price * 0.17
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 8 then
                bonus = price * 0.19
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end

            elseif level == 9 then
                bonus = price * 0.25
                price = price + bonus 

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end
                
            elseif level == 10 then
                bonus = price * 0.30
                price = price + bonus

                if Config.Framework == 'esx' then
                    xPlayer.removeInventoryItem(k, itemCount) 
                    xPlayer.addAccountMoney('money', price)
                elseif Config.Framework == 'qb' then
                    xPlayer.Functions.RemoveItem(k, itemCount)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                    xPlayer.Functions.AddMoney('cash', price, 'Sold items')
                end
            end
        end
    
    else
        for k, v in pairs(items) do
            local itemCount = nil

            if Config.Framework == 'esx' then
                itemCount = xPlayer.getInventoryItem(k).count
            elseif Config.Framework == 'qb' then
                itemCount = xPlayer.Functions.GetItemByName(k).amount
            end
            local price = v.price * itemCount

            if Config.Framework == 'esx' then
                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('black_money', price * itemCount)
            elseif Config.Framework == 'qb' then
                xPlayer.Functions.RemoveItem(k, itemCount)
                local info = {
                    worth = price * itemCount
                }
                xPlayer.Functions.AddItem('markedbills', 1, false, info)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[k], 'remove', itemCount)
                TriggerClientEvent('inventory:client:ItemBox', src,QBCore.Shared.Items['markedbills'], 'add',1)
            end

        end
    end
end)


--SERVER EXPORTS--
------------------
function setCivLevel(identifier, level)
    if Config.Framework == 'esx' then
        MySQL.Async.execute(
            "UPDATE `users` SET `civ_level`= @xp WHERE `identifier` = @identifier",
            {["@xp"] = level, ["@identifier"] = identifier},
            function()
        end)
    elseif Config.Framework == 'qb' then
        MySQL.Async.execute(
            "UPDATE `players` SET `civ_level`= @xp WHERE `license` = @license",
            {["@xp"] = level, ["@license"] = identifier},
            function()
        end)
    end
end

function getCivLevel(identifier)
    if Config.Framework == 'esx' then
        return tonumber(
            MySQL.Sync.fetchScalar(
                "SELECT `civ_level` FROM users WHERE identifier = @identifier ",
                {["@identifier"] = identifier}
            )
        )
    elseif Config.Framework == 'qb' then
        return tonumber(
            MySQL.Sync.fetchScalar(
                "SELECT `civ_level` FROM players WHERE license = @license ",
                {["@license"] = identifier}
            )
        )
    end
end

function giveCivLevel(identifier, amount)
    local currentLevel = exports['koe_vendors']:getCivLevel(identifier)
    local newCivlevel = amount + currentLevel
    if Config.Framework == 'esx' then
        if newCivlevel <= 0 then
            MySQL.Async.execute(
            "UPDATE `users` SET `civ_level`= @xp WHERE `identifier` = @identifier",
            {["@xp"] = 0, ["@identifier"] = identifier},
            function()
            end)
        else
            MySQL.Async.execute(
                "UPDATE `users` SET `civ_level`= `civ_level` + @amount WHERE `identifier` = @identifier",
                {["@amount"] = amount, ["@identifier"] = identifier},
                function()
            end)
        end
    elseif Config.Framework == 'qb' then
        if newCivlevel <= 0 then
            MySQL.Async.execute(
            "UPDATE `players` SET `civ_level`= @xp WHERE `license` = @license",
            {["@xp"] = 0, ["@license"] = identifier},
            function()
            end)
        else
            MySQL.Async.execute(
                "UPDATE `players` SET `civ_level`= `civ_level` + @amount WHERE `license` = @license",
                {["@amount"] = amount, ["@license"] = identifier},
                function()
            end)
        end
    end
end


RegisterNetEvent('koe_vendors:ratingsForMenu')
AddEventHandler('koe_vendors:ratingsForMenu', function()
    local src = source
    local identifier = nil


    if Config.Framework == 'esx' then
        identifier = ESX.GetPlayerFromId(src).identifier
    elseif Config.Framework == 'qb' then
        identifier = QBCore.Functions.GetIdentifier(src, 'license')
    end
    print(identifier)
    local crimRatingForMenu = exports['koe_vendors']:getCrimLevel(identifier)
    local civRatingForMenu = exports['koe_vendors']:getCivLevel(identifier)
    
    TriggerClientEvent('koe_vendors:ratingsMenu', src, crimRatingForMenu, civRatingForMenu)
end)