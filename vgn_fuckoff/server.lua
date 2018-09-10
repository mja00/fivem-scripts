ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('noahgay', function(source)
    if source ~= 0 then
        TriggerClientEvent("chatMessage", source, "", {0, 150, 150}, "Bad only console can do this!")
    else
        TriggerClientEvent('vgn_fuckoff:dropRequest', -1)
    end


end, true)

RegisterServerEvent('vgn_fuckoff:dropMe')
AddEventHandler('vgn_fuckoff:dropMe', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.kick("Server is restarting. Please reconnect when it is back up!")
end)
