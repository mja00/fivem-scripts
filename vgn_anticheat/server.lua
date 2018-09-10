ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('vgn:InvisDetected')
AddEventHandler('vgn:InvisDetected', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getPermissions() < 3 then
		Citizen.Trace("\n\n"..xPlayer.getName().." has been kicked for invisibility.\n\n")
		TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Invis Check', xPlayer.name..' has failed the invisibility check and was kicked.', '', true)
		xPlayer.kick("Possible Modmenu detected. Cheating is not tolerated on VGN.   [Failed invisibility check]")
		MySQL.Async.execute(
			'INSERT INTO vgn_anticheat (identifier, name, offense, details) VALUES (@identifier, @name, @offense, @details)',
			{
				['@identifier'] = xPlayer.identifier,
				['@name'] = xPlayer.name,
				['@offense'] = 'invisibility check',
				['@details'] = 'Failed',
			},
			function(rowsChanged)
			end)
	end
end)

RegisterServerEvent('vgn:godModePass')
AddEventHandler('vgn:godModePass', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	--TriggerClientEvent("chatMessage", source, "", {242, 211, 13}, "You've passed the godmode check.")
	TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Godmode Check', xPlayer.name..' has passed the godmode check.', '', true)
end)

RegisterServerEvent('vgn:godModeFail')
AddEventHandler('vgn:godModeFail', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getPermissions() < 3 then
		Citizen.Trace("\n\n"..xPlayer.getName().." has been kicked for godmode.\n\n")
		TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Godmode Check', xPlayer.name..' has failed the godmode check and was kicked.', '', true)
		--xPlayer.kick("Possible Modmenu detected. Cheating is not tolerated on VGN.   [Failed godmode check]")
		MySQL.Async.execute(
			'INSERT INTO vgn_anticheat (identifier, name, offense, details) VALUES (@identifier, @name, @offense, @details)',
			{
				['@identifier'] = xPlayer.identifier,
				['@name'] = xPlayer.name,
				['@offense'] = 'Godmode check',
				['@details'] = 'Failed',
			},
			function(rowsChanged)
			end)
	end
end)

TriggerEvent('es:addAdminCommand', 'godmodecheck', 3, function(source, args, user)
	--TriggerClientEvent("chatMessage", -1, "VGN", {255, 0, 0}, "An admin has initiated a godmode check. Standby")
	TriggerClientEvent('vgn:adminGodmodeCheck', -1)
end, function(source, args, user)
	TriggerClientEvent("chatMessage", source, "", {242, 211, 13}, "You do not have permission for this command.")
end)

RegisterServerEvent('vgn:illegalWeapon')
AddEventHandler('vgn:illegalWeapon', function(weapon)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getPermissions() < 3 then
		Citizen.Trace("\n\n"..xPlayer.getName().." has been kicked for illegal weapon. ["..weapon.."]\n\n")
		TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Illegal Weapon', xPlayer.name..' has an illegal weapon('..weapon..') and has been kicked.', '', true)
		--xPlayer.kick("Possible Modmenu detected. Cheating is not tolerated on VGN.   [Illegal weapon: "..weapon.."]")
		MySQL.Async.execute(
			'INSERT INTO vgn_anticheat (identifier, name, offense, details) VALUES (@identifier, @name, @offense, @details)',
			{
				['@identifier'] = xPlayer.identifier,
				['@name'] = xPlayer.name,
				['@offense'] = 'Illegal Weapon',
				['@details'] = weapon,
			},
			function(rowsChanged)
			end)
	end
end)

