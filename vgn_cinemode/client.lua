ESX = nil
isHudHidden = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citiz​​​en.Creat​eThread(function()
	while true do
		Citi​zen.Wait(0)
		if isHudHid​den then
			Draw​Rect(0.0,  1.0,  2.0,  0.2,  0,0,0,255)
			DrawRect(0.0,  0.0,  2.0,  0.2,  0,0,0,255)
			Display​Radar(false)
			--DisplayHud(false)
			Displa​yCash(false)
			DisplayAreaName(false)
		end
		if not isHudHidden then
			DisplayRadar(true)
			DisplayHud(true)
			Display​Cash(false)
			Displ​ayAreaName(true)
		end
	end
end)

RegisterCommand('cinemode', function(source, args)
	if args[1] == "on" then
		TriggerEvent('hud:hideCompass', true)
		TriggerEvent('hud:hideStreet', true)
		TriggerEvent('hud:hideVoice', true)
		TriggerEvent('hud:hideWatermark', true)
		TriggerEvent('esx_status:setDisplay', 0.0)
		TriggerEvent('es:setMoneyDisplay', 0)
		ESX.UI.HUD.SetDisplay(0.0)
		isHudHidden = true
	elseif args[1] == "off" then
		TriggerEvent('hud:hideCompass', false)
		TriggerEvent('hud:hideStreet', false)
		TriggerEvent('hud:hideVoice', false)
		TriggerEvent('hud:hideWatermark', false)
		TriggerEvent('esx_status:setDisplay', 0.5)
		TriggerEvent('es:setMoneyDisplay', 1)
		ESX.UI.HUD.SetDisplay(1.0)
		isHudHidden = false
	end
end, false)