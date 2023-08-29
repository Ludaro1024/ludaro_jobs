if Config.Menu == "NativeUI" then
    function openinteractions(job)
        interactions = lib.callback.await('ludaro_jobs:getinteractions', false, job)
        if tonumber(interactions) == 0 or interactions == false or interactions == true  then
            Config.Notify(locale("nointeractions"))
        else
            interactions = json.decode(interactions)
            mainmenu = NativeUI.CreateMenu(locale("interactions") .. " | " .. job, "")
            _menuPool:Add(mainmenu)
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            mainmenu:Visible(true)
            local sortedInteractions = {}
            for k, v in pairs(interactions) do
                table.insert(sortedInteractions, v)
            end
            table.sort(sortedInteractions, function(a, b)
                return getprio(a) < getprio(b)
            end)
            for k, v in ipairs(sortedInteractions) do
                local item = NativeUI.CreateItem(getinteractionname(v) or v, "")
                mainmenu:AddItem(item)
                item:SetRightBadge(tonumber(getinteractionicon(v)) or 0)
                item.Activated = function()
                    if getinteractioneventtype(v) == true then
                        TriggerEvent(getinteractioneventname(v) or "ludaro_jobs:interactionserror", geteventargs(v) or {})
                    else
                        TriggerServerEvent(getinteractioneventname(v) or "ludaro_jobs:interactionserror",
                            geteventargs(v) or {})
                    end
                end
            end
        end
    end
end
