-- ESX
if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end


function cb_getGroup()
    group = lib.callback.await('ludaro_jobs:getGroup', false) or "user"
    return group
end

function cb_isAdmin()
    return lib.table.contains(Config.AdminGroups, cb_getGroup())
end

function framework_Locale(msg)
    local translation = Config.Translation[Config.Locale][msg]
    if translation then
        return translation
    else
        return "translation not found: " .. msg
    end
end
