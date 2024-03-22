RegisterNetEvent('ludaro_jobs:interactionserror')
AddEventHandler('ludaro_jobs:interactionserror', function()
    consoleLog("error while starting event!", 1)
    Config.Notify("error while using Interaction! Contact Admin Please!")
end)



RegisterNetEvent('ludaro_jobs:addinteraction')
AddEventHandler('ludaro_jobs:addinteraction', function(job_name, interaction_name)
    consoleLog("adding interaction", 2)
    interactions_sql_addInteractions(job_name, nametolabel(interaction_name), source)
end)



RegisterNetEvent('ludaro_jobs:removeinteraction')
AddEventHandler('ludaro_jobs:removeinteraction', function(job_name, interaction_name)
    consoleLog("remove interaction", 2)
    interactions_sql_removeInteractions(job_name, nametolabel(interaction_name))
end)

function nametolabel(name)
    for k, v in pairs(Config.Interactions) do
        if v.name == name then
            return k
        end
    end
end
