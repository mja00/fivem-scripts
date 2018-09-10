local currentHealth = GetEntityHealth(GetPlayerPed(-1))
local lockHealth = GetEntityHealth(GetPlayerPed(-1))
local hunger = 0
local thirst = 0
local pauseHealth = false
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('vgn_realhealth:pauseReal')
AddEventHandler('vgn_realhealth:pauseReal', function()
	pauseHealth = true
	Citizen.Wait(2000)
	pauseHealth = false
end)


--Health lock & no regen
Citizen.CreateThread(function()
	while true do
		if pauseHealth == false then
			local currentPed = GetPlayerPed(-1)
			TriggerEvent('esx_status:getStatus', 'hunger', function(status)
				hunger = status.val
			end)
			TriggerEvent('esx_status:getStatus', 'thirst', function(status)
				thirst = status.val
			end)
			Citizen.Wait(300)
			if HasEntityBeenDamagedByAnyObject(currentPed) or HasEntityBeenDamagedByAnyPed(currentPed) or HasEntityBeenDamagedByAnyVehicle(currentPed) or GetEntityHealth(currentPed) == 200  or hunger == 0 or thirst == 0 then
				currentHealth = GetEntityHealth(GetPlayerPed(-1))
				lockHealth = currentHealth
				ClearEntityLastDamageEntity(currentPed)
			else
				SetEntityHealth(currentPed, lockHealth)
			end
		else
			Citizen.Wait(0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerPed = GetPlayerPed(-1)
		local health = GetEntityHealth(GetPlayerPed(-1))
		Citizen.Wait(100)
		if health <= 199 and health >= 176 then
			RequestAnimSet("move_injured_generic")
      
      		while not HasAnimSetLoaded("move_injured_generic") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(playerPed, "move_injured_generic", true)
			--ESX.ShowNotification("99-76")
		elseif health <= 175 and health >= 151 then
			RequestAnimSet("move_heist_lester")
      
      		while not HasAnimSetLoaded("move_heist_lester") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(playerPed, "move_heist_lester", true)
			--ESX.ShowNotification("75-51")
		elseif health <= 150 and health >= 126 then
			RequestAnimSet("MOVE_M@DRUNK@SLIGHTLYDRUNK")
      
      		while not HasAnimSetLoaded("MOVE_M@DRUNK@SLIGHTLYDRUNK") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
			--ESX.ShowNotification("50-26")
		elseif health <= 125 and health >= 101 then
			RequestAnimSet("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP")
      
      		while not HasAnimSetLoaded("MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP") do
        		Citizen.Wait(0)
      		end

      		SetPedMovementClipset(playerPed, "MOVE_M@DRUNK@MODERATEDRUNK_HEAD_UP", true)
			--ESX.ShowNotification("25-1")
		elseif health == 200 then
			ResetPedMovementClipset(playerPed, 0.0)
			--ESX.ShowNotification("Normal")
		end
	end
end)
