ESX = nil
local PlayerData = {}

--Setting perms locally
local noRemove = false
local noCheck = false

Citizen.CreateThread(function()
    TriggerServerEvent("vgn:getNoRemoveAce")
end)
Citizen.CreateThread(function()
    TriggerServerEvent("vgn:getNoChe​ckAce")
end)

RegisterNetEvent("vgn:getNoRemoveAceReturn")
AddEventHandler("vgn:getNoRemoveAceReturn", function(isAllowed)
    noRemove = isAllowed
end)
RegisterNetEvent("vgn:getNoCheckAceReturn")
AddEventHandler("vgn:g​etNoCheckAceReturn", function(isAllowed)
    noCheck = isAllowed
end)

TriggerEvent('esx:getSh​aredObject', function(obj) ESX = obj end)

-- Invis check
--[[Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		if not IsEntityVisible(GetPlayerPed(-1)) then
			TriggerServerEvent('vgn:InvisDetected')
		end
	end
end)]]

-- God mode check
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    if noCheck == false then
      Citizen.Wait(15000)
      TriggerEvent('vgn_realhealth:pauseReal')
      local p​revHealth = GetEntityHealth(GetPlayerPed(-1))
      local playerCoords = GetEntityCoords(GetPlayerPed(-1))
      StartEntityFire(GetPlayerPed(-1))
      local randomAmt = math.random(30,100)
      for i=1, 40, 1 do
          Citizen.Wait(1)
          SetEntityCoords(GetPlayerPed(-1), playerCoords.x, playerCoords.y, playerCoords.z+randomAmt)
          if i == 1 then
              StartEntityFire(GetPlayerPed(-1))
          end
          if i == 35 then
              StopEntityFire(GetPlayerPed(-1))
          end
      end
      Citizen.Wait(100)
      SetEntityCoords(GetPlayerPed(-1), playerCoords.x, playerCoords.y, playerCoords.z)
      Citizen.Wait(10)
      if GetEntityHealth(GetPlayerPed(-1)) < 200 then
          SetEntityH​ealth(GetPlayerPed(-1), prevHealth)
          TriggerServerEvent('vgn:godModePass')
      else
          TriggerServerEvent('vgn:godModeFail')
      end
    else
      ESX.ShowNotification("You bypass the god check")
    end

end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

--Get job



RegisterNetEvent('vgn:adminGodmodeCheck')
AddEventHandler('vgn:adminGod​modeCheck', function()
    TriggerEvent('vgn_realhealth:pauseReal')
    local prevHealth = GetEntityHealth(GetPlayerPed(-1))
    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
    StartEntityFire(GetPlayerPed(-1))
    local randomAmt = math.random(30,100)
    for i=1, 40, 1 do
        Citizen.Wait(1)
        SetEntityCoords(GetPlayerPed(-1), playerCoords.x, playerCoords.y, playerCoords.z+randomAmt)
        if i == 1 then
            StartEntityFire(GetPlayerPed(-1))
        end
        if i == 35 then
            StopEnti​tyFire(GetPlayerPed(-1))
        end
    end
    Citizen.Wait(100)
    SetEntityCoords(GetPlayerPed(-1), playerCoords.x, playerCoords.y, playerCoords.z)
    Citiz​en.Wait(10)
    if GetEntityHealth(GetPlayerPed(-1)) < 200 then
        SetEntityHealth(GetPlayerPed(-1), prevHealth)
        TriggerServerEvent('vgn:godModePass')
    else
        TriggerServerEvent('vgn:godModeFail')
    end

end)


-- Illegal weapon detection
Citizen.CreateThread(function()
    while true do
        local currentPed = GetPlayerPed(-1)
        Citizen.Wait(5000)
        if PlayerData.job.name ~= nil then
	        if noRemove == false then
	            if HasPedGotWeapon(currentPed, GetHashKey("WEAPON_GRENADELAUNCHER"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_GRENADELAUNCHER"))
	                TriggerSe​rverEvent('vgn:illegalWeapon', "Grenade Launcher")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_GRENADELAUNCHER_SMOKE"))
	                TriggerServerEvent('vgn:illegalWeapon', "Grenade Launcher Smoke")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_RPG"), false) then
	                RemoveWeapon​FromPed(currentPed, GetHashKey("WEAPON_RPG"))
	                TriggerServerEvent('vgn:illegalWeapon', "RPG")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_MINIGUN"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_MINIGUN"))
	                TriggerServerEvent('vgn:illegalWeapon', "Minigun")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_STICKYBOMB"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_STICKYBOMB"))
	                TriggerServerEvent('vgn:illegalWeapon', "Stickybomb")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_HOMINGLAUNCHER"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_HOMINGLAUNCHER"))
	                TriggerServerEvent('vgn:illegalWeapon', "Homing RPG")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_PROXMINE"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_PROXMINE"))
	                TriggerServerEvent('vgn:illegalWeapon', "Proximity Mine")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_RAILGUN"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_RAILGUN"))
	                TriggerServerEv​ent('vgn:illegalWeapon', "Railgun")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_SNIPERRIFLE"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_SNIPERRIFLE"))
	                TriggerServerEvent('vgn:illegalWeapon', "Sniper Rifle")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_HEAVYSNIPER"), false) then
	                RemoveWeaponFromPed(currentPed, GetHashKey("WEAPON_HEAVYSNIPER"))
	                TriggerServerEvent('vgn:illegalWeapon', "Heavy Sniper")
	            elseif HasPedGotWeapon(currentPed, GetHashKey("WEAPON_COMPACTLAUNCHER"), false) then
	                RemoveWe​aponFromPed(currentPed, GetHashKey("WEAPON_COMPACTLAUNCHER"))
	                TriggerServerEvent('vgn:illegalWeapon', "Compact Grenade Launcher")
	            end
	        else
	            --Do nothing, or something else if they're a cop. Do what you want I'm a comment not a cop, unlike the person who'd be having this done on them.
	        end
	    else
	    end            
    end​
end​)

--[[Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(GetPlayerPed(-1))
        if GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, -258.11, -979.85, 31.22, 1) < 4.0 then
            if GetEntityHealth(GetPlayerPed(-1)) < 150 then
                SetEntityHealth(GetPlayerPed(-1), 150)
            end
        else
            --Do nothing
        end
    end
end)]]

