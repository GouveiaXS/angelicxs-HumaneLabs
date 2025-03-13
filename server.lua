ESX = nil
QBcore = nil

if Config.UseESX then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    TriggerEvent('qs-core:getSharedObject', function(obj) QS = obj end)
elseif Config.UseQBCore then
    QBCore = exports['qb-core']:GetCoreObject()
end





RegisterSeverEvent('angelicxs-humanelabs:server:relationships', function()
    TriggerClientEvent('angelicxs-humanelabs:client:relationships', -1)
end)

if Config.UseESX then
    ESX.RegisterServerCallback('angelicxs-humanelabs:SecurityCard:ESX', function(source,cb)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getInventoryItem(Config.SecurityCardName).count >= 1 then
            if Config.RemoveSecurityCardName then
                xPlayer.removeInventoryItem(Config.SecurityCardName,1)
            end
            cb(true)
        else
            cb(false)
        end
    end)
elseif Config.UseQBCore then
    QBCore.Functions.CreateCallback('angelicxs-humanelabs:SecurityCard:QBCore', function(source, cb)
        local Player = QBCore.Functions.GetPlayer(source)
        if Config.RemoveSecurityCardName then
            Player.Functions.RemoveItem(Config.SecurityCardName, 1)
        end
    end)
end