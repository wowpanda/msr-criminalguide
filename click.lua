
-- Change this to your server name
local servername = "Mister-Gaming"; 

local menuEnabled = false 

AddEventHandler("playerSpawned", function(spawn)
   
end)

RegisterNetEvent("ToggleActionmenu2")
AddEventHandler("ToggleActionmenu2", function()
	ToggleActionMenu()
end)

RegisterNetEvent("KillcriminaltutorialMenu")
AddEventHandler("KillcriminaltutorialMenu", function()
	killcriminaltutorialMenu() 
end)

function ToggleActionMenu()
	Citizen.Trace("criminaltutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then 
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true 
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end 
end 

function killcriminaltutorialMenu() 
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end


RegisterNUICallback('close', function(data, cb)  
  ToggleActionMenu()
  cb('ok')
end)


RegisterNUICallback('spawnButton', function(data, cb) 

	TriggerEvent("criminaltutorial:spawn", source)
	SetNotificationTextEntry("STRING")
  AddTextComponentString("~g~Informationen von 2500€ erhalten.")
  DrawNotification(true, false)
  	ToggleActionMenu()
  	SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
  	cb('ok')
end)




