RegisterNetEvent('ludaro_jobs:Notify')
AddEventHandler('ludaro_jobs:Notify', function(txt)
    Config.Notify(txt)
end)

if Config.Menu == "NativeUI" then
    RegisterNetEvent('ludaro_jobs:openInteractions')
    AddEventHandler('ludaro_jobs:openInteractions', function(job)
        openInteractions(job)
    end)
    AddEventHandler('esx:onPlayerDeath', function(data)
        _menuPool:CloseAllMenus()
    end)
end
