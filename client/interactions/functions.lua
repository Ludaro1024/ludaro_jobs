function getInteractionName(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return interaction
    end
    return Config.Interactions[string.lower(interaction)].name
end

function getInteractionEventType(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].eventtype
end

function getInteractionEventName(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return "ludaro_jobs:interactionserror"
    end
    return Config.Interactions[string.lower(interaction)].eventname
end

function getInteractionIcon(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return interaction
    end
    return Config.Interactions[string.lower(interaction)].icon
end

function getEventArgs(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].eventargs
end

function getPrio(interaction)
    if Config.Interactions[string.lower(interaction)] == nil then
        return false
    end
    return Config.Interactions[string.lower(interaction)].prio
end

function getAllinteractions()
    local interactions = {}
    for k, _ in pairs(Config.Interactions) do
        table.insert(interactions, k)
    end
    return interactions
end
