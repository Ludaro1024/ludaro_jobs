if (GetResourceState("es_extended") == "started") then
    if (exports["es_extended"] and exports["es_extended"].getSharedObject) then
        ESX = exports["es_extended"]:getSharedObject()
    else
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
    end
end

function getgroup(id)
    return ESX.GetPlayerFromId(id).getGroup() or "user"
end
function locale(msg)
    local translation = Config.Translation[Config.Locale][msg]
    if translation then
        return translation
    else
       return "translation not found: " .. msg
    end
end
