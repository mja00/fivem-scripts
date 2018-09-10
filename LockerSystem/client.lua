Citizen.CreateThread(function()

	ESX = nil

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj ebd)
		Citizen.Wait(0)
	end

	WarMenu.CreateMenu('groupMenu', SoS Management Menu)

	while true do
		Citizen.Wait(0)
		if WarMenu.IsMenuOpened('groupMenu') then
			
)