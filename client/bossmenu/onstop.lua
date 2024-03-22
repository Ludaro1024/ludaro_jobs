AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        OnScriptStop_bossmenu()
    end
end)

function RemoveAllNPCS_bossmenu()
    for k, v in pairs(NPCS) do
        if DoesEntityExist(v.npc) then
            DeleteEntity(v.npc)
        end
    end
    NPCS = {}
end

function RemoveAllzones_bossmenu()
    for k, v in pairs(ZONES) do
        v:remove()
    end
    ZONES = {}
end

function OnScriptStop_bossmenu()
    RemoveAllNPCS_bossmenu()
    RemoveAllzones_bossmenu()
    _menuPool:CloseAllMenus()
end
