function getinteractionname(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return interaction
    end
return Config.Interactions[string.lower(interaction)].name
end

function getinteractioneventtype(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
return Config.Interactions[string.lower(interaction)].eventtype
end

function getinteractioneventname(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return "ludaro_jobs:interactionserror"
    end
return Config.Interactions[string.lower(interaction)].eventname
end

function getinteractionicon(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return interaction
    end
return Config.Interactions[string.lower(interaction)].icon
end

function geteventargs(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
end
return Config.Interactions[string.lower(interaction)].eventargs
end

function getprio(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
end
return Config.Interactions[string.lower(interaction)].prio
end

function getallinteractions()
    local interactions = {}
    for k, v in pairs(Config.Interactions) do
        table.insert(interactions, k)
    end
    return interactions
end