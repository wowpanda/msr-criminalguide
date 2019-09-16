ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
    AddEventHandler('chatMessage', function(source, name, msg)
        sm = stringsplit(msg, " ");
        
        
        if sm[1] == "/criminaltutorial" then
        CancelEvent()
        TriggerClientEvent("ToggleActionmenu2", source)
        
        end
       
    end)
    
    userlist = {}
    
    
    -- First spawn event
    RegisterServerEvent('criminaltutorial:firstspawn')
    AddEventHandler("criminaltutorial:firstspawn", function(spawn)
         
        local firstSpawn = true
    
        local identsList = GetPlayerIdentifiers(source)
            for bi,newuserslist in ipairs(userlist) do
                for i,theId in ipairs(identsList) do
                    if newuserslist == theId  then 
                         firstSpawn = false
                        return
                    end
                end
            end
    
        if firstSpawn then
            TriggerClientEvent("ToggleActionmenu2", source)
            for i,identifier in ipairs(identsList) do
                if string.find(identifier, "license:") then
                    addNewUser(identifier..";".."\n")
                end
            end  
        else
             TriggerClientEvent("KillcriminaltutorialMenu", source)
        end
    
    end)
    
    
    
    function stringsplit(inputstr, sep)
        if sep == nil then
            sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
        end
        return t
    end
    
    function addNewUser(addUserObj)
            userlist = {}
        
            local content = LoadResourceFile(GetCurrentResourceName(), "players.txt")
            
            if not addUserObj then
                for index,value in ipairs(stringsplit(content, "\n")) do
                    curstring = "" 
                    for i = 1, #value do 
                        if string.sub(value,i,i) == ";" then break end 
                        curstring = curstring..string.sub(value,i,i) 
                    end
                   
    
                    userlist[index] = curstring
                   
                end
            else
                if string.len(content) > 1 then
                    content = content.."\n"..addUserObj
                else
                    content = content..""..addUserObj
                end
                for index,value in ipairs(stringsplit(content, "\n")) do
                    curstring = "" 
                    for i = 1, #value do 
                        if string.sub(value,i,i) == ";" then break end 
                        curstring = curstring..string.sub(value,i,i)
                    end
                    
    
                    userlist[index] = curstring
                    
                end
            end
            SaveResourceFile(GetCurrentResourceName(), "players.txt", content, -1)
        end
    
       function loopUpdateUsers()
            addNewUser()
            SetTimeout(300000, loopUpdateUsers)
        end
        loopUpdateUsers()
    end)
  

    ESX.RegisterServerCallback('msr-criminalguide:buyAccess', function (source, cb)

        local price = 2500
        local xPlayer     = ESX.GetPlayerFromId(source)
    
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            cb(true)
        else
            cb(false)
        end
    end)