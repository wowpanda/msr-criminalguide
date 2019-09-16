Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local menuOpen = false
local wasOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent("criminaltutorial:spawn")
AddEventHandler("criminaltutorial:spawn", function()
    DoScreenFadeOut(1000)
  	-- Here is where you set where you want to player to spawn after they complete the criminaltutorial
    --SetEntityCoords(GetPlayerPed(-1), tonumber("-1556.64"), tonumber("-3234.5"), tonumber("26.34"), 1, 0, 0, 1)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)   
end)

local blips = {
  -- Example {title="", colour=, id=, x=, y=, z=},

   {title="Informant", colour=40, id=480, x = 393.8358, y = -877.671325, z = 28.34915}
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, vector3(393.8358, -877.671325, 28.34915), true) < 2.5 then
			if not menuOpen then
				ESX.ShowHelpNotification('Drücke [E] zum kaufen von Informationen')

				if IsControlJustReleased(0, Keys['E']) then

					ESX.TriggerServerCallback('msr-criminalguide:buyAccess', function (hasEnoughMoney)
						if hasEnoughMoney then
							wasOpen = true	
							TriggerEvent("ToggleActionmenu2", source)
						else
							ESX.ShowNotification("Besorg dir erstmal 2500€, bevor du mich irgendwas fragst")
						end
					end)
				end
			else
				Citizen.Wait(500)
			end
		else
			if wasOpen then
				
				
			end

			Citizen.Wait(500)
		end
	end
end)
    
Citizen.CreateThread(function()

  for _, info in pairs(blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 1.0)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
  BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)





