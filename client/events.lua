RegisterNetEvent('ludaro_jobs:Notify')
AddEventHandler('ludaro_jobs:Notify', function(txt)
    Config.Notify(txt)
end)

if Config.Menu == "NativeUI" then
    RegisterNetEvent('ludaro_jobs:openinteractions')
    AddEventHandler('ludaro_jobs:openinteractions', function(job)
        openInteractionsMenu(job)
    end)
    AddEventHandler('esx:onPlayerDeath', function(data)
        _menuPool:CloseAllMenus()
    end)
end
