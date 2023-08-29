
RegisterNetEvent('ludaro_jobs:interactionserror')
AddEventHandler('ludaro_jobs:interactionserror', function()
debug2("error while starting event!", 1)
Config.Notify("error while using Interaction!")
end)