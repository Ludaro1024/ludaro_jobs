RegisterNetEvent('ludaro_jobs:Notify')
AddEventHandler('ludaro_jobs:Notify', function(txt)
 Config.Notify(txt)
end)

AddEventHandler('esx:onPlayerDeath', function(data)
_menuPool:CloseAllMenus()
end)