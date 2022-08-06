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


RegisterNetEvent('koe_vendors:getPlayerXP')
AddEventHandler('koe_vendors:getPlayerXP', function(npc, location)
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
end

function getCrimLevel(identifier)
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
end
