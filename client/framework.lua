-- ESX
if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end


function getGroup()
    local group = lib.callback.await('ludaro_jobs:getGroup', false) or "user"
    return group
end

function isAdmin()
    local group = getGroup()
    if lib.table.contains(Config.AdminGroups, group) then
        return true
    else
        return false
    end
end

function locale(msg)
    local translation = Config.Translation[Config.Locale][msg]
    if translation then
        return translation
    else
        return "translation not found: " .. msg
    end
end
