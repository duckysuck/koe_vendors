----Gets ESX-----
ESX = nil
local ox_inventory = exports.ox_inventory
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------


-- RegisterNetEvent('koe_vendors:updateDB')
-- AddEventHandler('koe_vendors:updateDB', function(npc, location)
--     local itemsForSale = Config.VendorLocations.blackMarket.itemsforsale

--     MySQL.Async.execute('TRUNCATE koe_vendors', {
--     })

--     for k, v in ipairs(itemsForSale) do
--         local i = tostring(v.itemname)
--         itemstock = tonumber(v.stock)

--         MySQL.Async.execute('INSERT INTO koe_vendors (item_name, stock) VALUES (@item_name, @stock)', {
--             ['@item_name'] = i,
--             ['@stock'] = itemstock,
--         })
--     end
-- end)


    -- MySQL.Async.fetchAll('SELECT * FROM koe_vendors',
    -- function(result)
    --     local stockInfo = {}

    --     for k, v in ipairs(result) do
    --             for o,p in pairs(v) do
    --                 print(o, p)
    --             end
    --         table.insert(stockInfo,v)

    --     end
       
    -- end)


RegisterNetEvent('koe_vendors:getCrimRating')
AddEventHandler('koe_vendors:getCrimRating', function(npc, location)
    local src = source
    local identifier =  ESX.GetPlayerFromId(src).identifier
    local crimlevel = exports['koe_vendors']:getCrimLevel(identifier)

    TriggerClientEvent('koe_vendors:buyMenu', src, npc, location, crimlevel)
end)

--HANDLES BUY ITEMS--
---------------------
RegisterNetEvent('koe_vendors:soldLegal')
AddEventHandler('koe_vendors:soldLegal', function(item, amount, price)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local charge = amount * price

    if ox_inventory:CanCarryItem(src, item, amount) then
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

end)

RegisterNetEvent('koe_vendors:soldIllegal')
AddEventHandler('koe_vendors:soldIllegal', function(item, amount, price, neededXP)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local charge = amount * price
    local identifier =  xPlayer.identifier
    local crimlevel = exports['koe_vendors']:getCrimLevel(identifier)


    if crimlevel >= neededXP then
        if ox_inventory:CanCarryItem(src, item, amount) then
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
end)


--SERVER EXPORTS--
------------------
function setCrimlevel(identifier, level)
    MySQL.Async.execute(
        "UPDATE `users` SET `crim_level`= @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
    end)
    if Config.DebugPrints then
        print(identifier..' Crim level was set to '..level)
    end
end

function getCrimLevel(identifier)
    if Config.DebugPrints then
        print('Got '..identifier..' Crim Rating')
    end

    return tonumber(
        MySQL.Sync.fetchScalar(
            "SELECT `crim_level` FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    )
end

function giveCrimLevel(identifier, amount)
    MySQL.Async.execute(
        "UPDATE `users` SET `crim_level`= `crim_level` + @amount WHERE `identifier` = @identifier",
        {["@amount"] = amount, ["@identifier"] = identifier},
        function()
    end)
    if Config.DebugPrints then
        print(identifier..'Received '..amount..' Crim Rating')
    end
end

RegisterNetEvent('koe_vendors:getCivRating')
AddEventHandler('koe_vendors:getCivRating', function(location, npc, illegal, items)
    local src = source
    local identifier =  ESX.GetPlayerFromId(src).identifier
    local civRating = exports['koe_vendors']:getCivLevel(identifier)
    local crimRating = exports['koe_vendors']:getCrimLevel(identifier)
    local level 

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
    elseif civRating <= 2500 then
        level = 5
    elseif civRating <= 3000 then
        level = 6
    elseif civRating <= 3500 then
        level = 7
    elseif civRating <= 4000 then
        level = 8
    elseif civRating <= 4500 then
        level = 9
    elseif civRating >= 5000 then
        level = 10
    end

    TriggerClientEvent('koe_vendors:sellMenu', src, location, npc, illegal, items, civRating, level, crimRating)
end)


RegisterNetEvent('koe_vendors:SellShit')
AddEventHandler('koe_vendors:SellShit', function(location, illegal, npc, civRating, level)
    local items = {}
    local sellableItems = Config.VendorLocations[npc].sellableitems
    local xPlayer = ESX.GetPlayerFromId(source)
    local soldfor
    local bonus = nil

    if illegal == false then

        for k, v in pairs(sellableItems) do

            table.insert(items, k)
            local itemCount = xPlayer.getInventoryItem(k).count
            local price = v.price * itemCount

            if level == 0 then  
                bonus = price * 0.00
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 1 then
                bonus = price * 0.05
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 2 then
                bonus = price * 0.07
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 3 then
                bonus = price * 0.09
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)
            
            elseif level == 4 then
                bonus = price * 0.11
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 5 then
                bonus = price * 0.13
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 6 then
                bonus = price * 0.15
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 7 then
                bonus = price * 0.17
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)

            elseif level == 8 then
                bonus = price * 0.19
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', v.price * itemCount * 0.19 )

            elseif level == 9 then
                bonus = price * 0.25
                price = price + bonus 

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price)
                
            elseif level == 10 then
                bonus = price * 0.30
                price = price + bonus

                xPlayer.removeInventoryItem(k, itemCount) 
                xPlayer.addAccountMoney('money', price )
            end
        end
    
    else
        for k, v in pairs(sellableItems) do
            table.insert(items, k)
            local itemCount = xPlayer.getInventoryItem(k).count
    
            xPlayer.removeInventoryItem(k, itemCount) 
            xPlayer.addAccountMoney('black_money', v.price * itemCount)
        end
    end
end)


--SERVER EXPORTS--
------------------
function setCivLevel(identifier, level)
    MySQL.Async.execute(
        "UPDATE `users` SET `civ_level`= @xp WHERE `identifier` = @identifier",
        {["@xp"] = level, ["@identifier"] = identifier},
        function()
    end)
    if Config.DebugPrints then
        print(identifier..' Civ level was set to '..level)
    end
end

function getCivLevel(identifier)
    if Config.DebugPrints then
        print('Got '..identifier..' Civ Rating')
    end
    return tonumber(
        MySQL.Sync.fetchScalar(
            "SELECT `civ_level` FROM users WHERE identifier = @identifier ",
            {["@identifier"] = identifier}
        )
    )
end

function giveCivLevel(identifier, amount)
    MySQL.Async.execute(
        "UPDATE `users` SET `civ_level`= `civ_level` + @amount WHERE `identifier` = @identifier",
        {["@amount"] = amount, ["@identifier"] = identifier},
        function()
    end)
    if Config.DebugPrints then
        print(identifier..'Received '..amount..' Civ Rating')
    end
end


RegisterNetEvent('koe_vendors:ratingsForMenu')
AddEventHandler('koe_vendors:ratingsForMenu', function()
    local src = source
    identifier =  ESX.GetPlayerFromId(src).identifier

    local crimRatingForMenu = exports['koe_vendors']:getCrimLevel(identifier)
    local civRatingForMenu = exports['koe_vendors']:getCivLevel(identifier)
    
    TriggerClientEvent('koe_vendors:ratingsMenu', src, crimRatingForMenu, civRatingForMenu)
end)