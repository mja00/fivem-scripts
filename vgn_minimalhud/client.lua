ESX = nil
isHudHidden = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerE​vent('e​sx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerEvent('hud:hideCompass', true)
		Trigge​rEvent('hud:hideStreet', true)
		TriggerE​vent('hu​d:hideVoice', true)
		TriggerEvent('hud:hideWatermark', true)
		Trigge​rEv​ent('esx_status:setDisplay', 0.0)
		TriggerEvent('es:setMoneyDisplay', 0)
		ESX.UI.HUD.SetDisplay(0.0)
  end)

Citizen.CreateThread(function()
	while true do
		Citizen.​Wait(0)
		if isHudHidden then
			Disp​layRadar(false)
			--Disp​layHud(false)
			DisplayCash(false)
			DisplayAreaName(false)
		end​
		if not isHudHidden then
			DisplayRadar(true)
			DisplayHud(true)
			Display​Cash(false)
			DisplayAreaName(true)
		end
	end
end)

RegisterCommand('minimalhud', function(source, args)
	if args[1] == "on" then
		TriggerEvent('hud:hideCompass', true)
		TriggerEvent('hud:hideStreet', true)
		TriggerEvent('hud:hideVoice', true)
		TriggerEvent('hud:hideWatermark', true)
		TriggerEvent('esx_status:setDisplay', 0.0)
		TriggerEvent('es:setMoneyDisplay', 0)
		ESX.UI.HUD.SetDisplay(0.0)
	elseif args[1] == "off" then
		TriggerEvent('hud:hideCompass', false)
		TriggerEvent('hud:hideStreet', false)
		TriggerEvent('hud:hideVoice', false)
		TriggerEvent('hud:hideWatermark', false)
		TriggerEvent('esx_status:setDisplay', 0.5)
		TriggerEvent('es:setMoneyDisplay', 1)
		ESX.UI.HUD.SetDisplay(1.0)
	end
end, false)