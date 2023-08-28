RegisterNetEvent('ludaro_jobs:Notify')
AddEventHandler('ludaro_jobs:Notify', function(txt)
 Config.Notify(txt)
end)