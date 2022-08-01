----Gets ESX-----
ESX = nil
local ox_inventory = exports.ox_inventory
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
----------------------------------------------------------------

RegisterNetEvent('koe_vendors:sold')
AddEventHandler('koe_vendors:sold', function(item, amount, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local charge = amount * price

    if ox_inventory:CanCarryItem(source, item, amount) then
        if xPlayer.getMoney() >= charge then
            xPlayer.addInventoryItem(item, amount)
            xPlayer.removeInventoryItem('money', charge)
            TriggerClientEvent('ox_lib:notify', source, {type = 'success', description = 'You bought '..item..' x'..amount..' for $'..price, duration = 8000, position = 'top'})
        else
            TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = "Not enough money", duration = 8000, position = 'top'})
        end
    else
        TriggerClientEvent('ox_lib:notify', source, {type = 'error', description = "Not enough space", duration = 8000, position = 'top'})
    end

end)
