ESX = nil
TriggerEvent('esx:getShared​Object', function(obj) ESX = obj end)

--[[RegisterServerEvent('vgn:InvisDetected')
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
end)--]]

RegisterServerEvent('vgn:godModePass')
AddEventHandler('vgn:godModePass', function()
	local xPlayer = ESX.G​etPlayerFromId(source)
	--TriggerClientEvent("chatMessage", source, "", {242, 211, 13}, "You've passed the godmode check.")
	TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Godmode Check', xPlayer.name..' has passed the godmode check.', '', true)
end)

RegisterServerEvent('vgn:godModeFail')
AddEventHandler('vgn:godModeFail', function()
	local xPlayer = ESX.Get​PlayerFromId(source)
  if not IsPlayerAceAllowed(source, "ac.noKick") then
    if xPlayer.getPermissions() < 3 then
      Citizen.Trace("\n"..xPlayer.getName().." has been kicked for godmode.")
      TriggerEvent('DiscordBot:ToDiscord', 'kill', 'Godmode Check', xPlayer.name..' has failed the godmode check and was kicked.', '', true)
      DropPlayer(sou​rce, "Possible Modmenu detected. Cheating is not tolerated on VGN.   [Failed godmode check]")
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
  end
end)

TriggerEvent('es:addAdmi​nCommand', 'godmodecheck', 3, function(source, args, user)
	TriggerClientEvent("chatMessage", -1, "VGN", {255, 0, 0}, "An admin has initiated a godmode check. Standby")
	TriggerClientEvent('vgn:adminGodmodeCheck', -1)
end, function(source, args, user)
  local xPlayer = ESX.GetPlayerFromId(source)
  if xPlayer.identifier == "steam:1100001032438e6" then
    Trigger​ClientEvent('vgn:adminGodmodeCheck', -1)
    TriggerClientEvent("chatMessage", -1, "VGN", {255, 0, 0}, "Danny S. has initiated a godmode check. This is most likely a test. Standby. ")
  else 
    TriggerClientE​vent("chatMessage", source, "", {242, 211, 13}, "You do not have permission for this command.")
  end
end)

TriggerEvent('es:addAdminCommand', 'aclookup', 3, function(source, args, user)
    if args[2] == nil then
      TriggerClientEvent("chatMessage", source, "AC", {255,0,0}, "You must provide a player ID.")
    else
      local xPlayer = ESX.GetPlayerFromId(args[2])
      MySQL.Async.fetchAll('SELECT * FRO​M vgn_anticheat WHERE identifier = @identifier ORDER BY id DESC LIMIT 1',
        {
          ['@identifier'] = xPlayer.identifier
        },
        function(result)
          TriggerClientEvent("chatMe​ssage", source, result[1].name, {255, 0, 0}, "Latest infraction: "..result[1].offense.." | Details: "..result[1].details)
        end)
    end
end, function(source, args, user)
  if IsPlayerAceAllow​ed(source, "ac.lookup") then
    if args[2] == nil then
      TriggerClientEvent("chatMessage", source, "AC", {255,0,0}, "You must provide a player ID.")
    else
      local xPlayer = ESX.GetPlayerFromId(args[2])
      MySQL.Async.fetchAll('SELECT * FROM vgn_anticheat WHERE identifier = @identifier ORDER BY id DESC LIMIT 1',
        {
          ['@identifier'] = xPlayer.identifier
        },
        function(result)
          TriggerClientEvent("chatMessage", source, result[1].name, {255, 0, 0}, "Latest infraction: "..result[1].offense.." | Details: "..result[1].details)
        end)
    end
  else
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SE​LECT * FROM vgn_anticheat WHERE identifier = @identifier ORDER BY id DESC LIMIT 1',
      {
        ['@identifier'] = xPlayer.identifier
      },
      function(result)
        TriggerClientEven​t("chatMessage", source, result[1].name, {255, 0, 0}, "Latest infraction: "..result[1].offense.." | Details: "..result[1].details)
      end)
  end
end)

RegisterServerEvent('vgn:illegalWeapon')
AddEventHandler('vgn:illegalWeapon', function(weapon)
	local xPlayer = ESX​.GetPlayerFromId(source)
  if IsPlayerAceAllowed(source, "ac.noKick") then
    Citizen.Trace("\nNo kick")
  else
    if xPlayer.getPermissions() < 3 then
      Citizen.Trace("\n"..xPlayer.getName().." has been kicked for illegal weapon. ["..weapon.."]")
      TriggerEvent('DiscordB​ot:ToDiscord', 'kill', 'Illegal Weapon', xPlayer.name..' has an illegal weapon('..weapon..') and has been kicked.', '', true)
      DropPlayer(source, "Possible Modmenu detected. Cheating is not tolerated on VGN.   [Illegal weapon: "..weapon.."]")
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
  end
end)


RegisterServerEvent('vgn:ge​tNoRemoveAce')
AddEventH​andler('vgn:getNoRemoveAce', function()
  if IsPlayerAceAllowed(source, "ac.noRemove") then
    TriggerClientEvent('vgn:getNoRemoveAceReturn', source, true)
  else
    TriggerClientEvent('vg​n:getNoRemoveAceReturn', source, false)
  end
end)
RegisterServerEvent("vgn:getNoCheckAce")
AddEventHandler("vgn:getNoCheckAce", function()
    if IsPlayerAceAll​owed(source, "ac.noCheck") then
        TriggerClientEvent("vgn:getNoCheckAceReturn", source, true)
    else
        TriggerClientEvent("vgn:getNoCheckAceReturn", source, false)
    end
end)
