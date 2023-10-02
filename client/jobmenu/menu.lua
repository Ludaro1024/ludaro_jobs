if Config.Menu == "ox_lib" then
    -- TO BE DONE
end



if Config.Menu == "NativeUI" then
    middleitem = true
    _menuPool = NativeUI.CreatePool()


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if _menuPool:IsAnyMenuOpen() then
                _menuPool:ProcessMenus()
            else
                Citizen.Wait(150) -- this small line
            end
        end
    end)

    --print(ESX.DumpTable(jobs))
    deletedjobs = {}
    function openadminmenu()
        menuclosed = false
        jobs = getJobs()
        number = 1
        if not _menuPool:IsAnyMenuOpen() then
            mainmenu = NativeUI.CreateMenu(locale("adminmenu"), "")
            _menuPool:Add(mainmenu)
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)


            lib.showTextUI(locale("loading"), {
                position = "top-center",
                icon = 'hand',
                style = {
                    borderRadius = 0,
                    backgroundColor = 'black',
                    color = 'white'
                }
            })


            changestuff = {}

            done = false
            for k, v in pairs(jobs) do
                v.whitelist = false or lib.callback.await('ludaro_jobs:getwhitelist', false, v.name)
                v.society = false or lib.callback.await('ludaro_jobs:getSocietyAccount', false, v.name)
                v.jobinfo = getJobInfo(v.label)
                if k == #jobs then
                    done = true
                end
            end



            while not done do
                Citizen.Wait(1)
            end







            for k, v in pairs(jobs) do
                if lib.table.contains(deletedjobs, v.name) then
                    debug2("job is deleted")
                else
                    jobsmenu = _menuPool:AddSubMenu(mainmenu, v.label, v.name)
                    _menuPool:RefreshIndex()
                    _menuPool:MouseControlsEnabled(false)
                    _menuPool:MouseEdgeEnabled(false)
                    _menuPool:ControlDisablingEnabled(false)
                    jobsmenu.Item:RightLabel(">")
                    local name = NativeUI.CreateItem(locale("name"), "")
                    jobsmenu.SubMenu:AddItem(name)
                    name:RightLabel(v.name)


                    jobsmenu.SubMenu.OnMenuClosed = function(menu)
                        print(#changestuff)
                        if #changestuff > 0 then
                            -- do something
                            local alert = lib.alertDialog({
                                header = locale("unsaved"),
                                content = locale("you have unsaved content"),
                                centered = true,
                                cancel = true
                            })
                            if alert == "confirm" then
                                for k, v in pairs(changestuff) do
                                    if v.name then
                                        print("ah")
                                        TriggerServerEvent("ludaro_jobs:changename", v.job, v.name)
                                    end
                                    if v.label then
                                        TriggerServerEvent("ludaro_jobs:labelch", v.job, v.label)
                                    end
                                    if v.whitelist ~= nil then
                                        TriggerServerEvent("ludaro_jobs:setwhitelist", v.job, v.whitelist)
                                    end

                                    if v.bossmenu then
                                        menuclosed = true
                                        TriggerServerEvent("ludaro_jobs:setbossmenu", v.job, v.bossmenu)
                                    end
                                end
                            else
                                changestuff = {}
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        end
                    end
                    name.Activated = function(sender, index)
                        newname = KeyboardInput(locale("insertname"), "", 30)
                        if newname then
                            name:RightLabel(newname)
                            table.insert(changestuff, { job = v.name, name = newname })
                        end
                    end
                    local label = NativeUI.CreateItem(locale("label"), "")
                    jobsmenu.SubMenu:AddItem(label)
                    label:RightLabel(v.label)
                    label.Activated = function(sender, index)
                        newlabel = KeyboardInput(locale("insertlabel"), "", 30)
                        if newlabel then
                            label:RightLabel(newlabel)
                            table.insert(changestuff, { job = v.label, label = newlabel })
                        end
                    end
                    isWhitelistedadd = NativeUI.CreateCheckboxItem(locale("whitelisted"), false, "")
                    jobsmenu.SubMenu:AddItem(isWhitelistedadd)
                    isWhitelistedadd.Checked = v.whitelisted or false

                    isWhitelistedadd.CheckboxEvent = function(menu, item, checked)
                        table.insert(changestuff, { job = v.label, whitelist = checked })
                    end

                    grade = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("grade"), "")
                    _menuPool:RefreshIndex()
                    _menuPool:MouseControlsEnabled(false)
                    _menuPool:MouseEdgeEnabled(false)
                    _menuPool:ControlDisablingEnabled(false)





                    local sortedGrades = {}
                    for k, v in pairs(v.grades) do
                        table.insert(sortedGrades, v)
                    end
                    table.sort(sortedGrades, function(a, b) return a.grade < b.grade end)
                    for _, grad in ipairs(sortedGrades) do
                        gradeitem = _menuPool:AddSubMenu(grade.SubMenu, grad.name .. "(" .. grad.label .. ")", "")
                        gradeitem.Item:RightLabel(grad.grade .. " || " .. grad.salary .. locale("$"))
                        local salary = NativeUI.CreateItem(locale("salary"), "")
                        local name = NativeUI.CreateItem(locale("name"), "")
                        local label = NativeUI.CreateItem(locale("label"), "")
                        salary:RightLabel(grad.salary .. locale("$"))
                        name:RightLabel(grad.name)
                        label:RightLabel(grad.label)
                        gradeitem.SubMenu:AddItem(salary)
                        gradeitem.SubMenu:AddItem(name)
                        gradeitem.SubMenu:AddItem(label)



                        name.Activated = function(sender, index)
                            newgradename = KeyboardInput(locale("insertname"), "", 30)
                            if newgradename then
                                name:RightLabel(newgradename)
                            end
                        end
                        label.Activated = function(sender, index)
                            newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
                            if newgradelabel then
                                label:RightLabel(newgradelabel)
                            end
                        end
                        local deletegrade = _menuPool:AddSubMenu(gradeitem.SubMenu, locale("deletegrade"), "")
                        deletegrade.Item:RightLabel(">")
                        if middleitem then
                            deletegrade.Item._Text.Padding = { X = 180 }
                        end
                        local yes = NativeUI.CreateItem(locale("yes"), "")
                        deletegrade.SubMenu:AddItem(yes)
                        yes.Activated = function(sender, index)
                            TriggerServerEvent("ludaro_jobs:deletegrade", v.name, grad.name)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end

                        local confirm = _menuPool:AddSubMenu(gradeitem.SubMenu, locale("confirm"), "")
                        confirm.Item:RightLabel(">")
                        if middleitem then
                            confirm.Item._Text.Padding = { X = 180 }
                        end
                        local yes = NativeUI.CreateItem(locale("yes"), "")
                        confirm.SubMenu:AddItem(yes)
                        yes.Activated = function(sender, index)
                            if newgradename then
                                TriggerServerEvent("ludaro_jobs:changename", v.name, grad.name, newgradename)
                            end
                            if newgradelabel then
                                TriggerServerEvent("ludaro_jobs:labelch", v.name, grad.name, newgradelabel)
                            end
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    end

                    creategrade = NativeUI.CreateItem(locale("creategrade"), "")

                    creategrade.Activated = function(sender, index)
                        -- create a grade
                        newgrade = KeyboardInput(locale("insertname"), "", 30)
                        newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
                        if newgrade ~= "" and newgradelabel ~= "" then
                            newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                            if tonumber(newgradesalary) ~= nil then
                            else
                                -- Code to execute if newgradesalary is not a number
                                Config.Notify(locale("nonumber"))
                                newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                            end

                            if tonumber(newgradesalary) ~= nil then
                                salary = 0
                            end

                            newid = KeyboardInput(locale("insertid"), "", 30)


                            newGradeTable = {
                                id = newid or 0,
                                grade = 0,
                                name = newgrade,
                                label = newgradelabel,
                                salary = newgradesalary,
                                skin_male = {},
                                skin_female = {}
                            }
                            debug2(ESX.DumpTable(newGradeTable))
                            TriggerServerEvent("ludaro_jobs:addgrade", v.name, newGradeTable)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    end
                    grade.SubMenu:AddItem(creategrade)

                    interactions = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("interactions"), "")
                    interactions.Item:RightLabel(">")

                    local sortedInteractions = {}
                    for k, v in pairs(Config.Interactions) do
                        table.insert(sortedInteractions, v)
                    end
                    table.sort(sortedInteractions, function(a, b) return a.prio < b.prio end)
                    for _, inter in ipairs(sortedInteractions) do
                        interactionitem = _menuPool:AddSubMenu(interactions.SubMenu, inter.name, "")
                        -- interactionss = lib.callback.await('ludaro_jobs:getinteractions', false, v.name)
                        if tonumber(interactionss) == 0 or interactionss == false or interactionss == true
                            or interactionss == nil then
                            isiconinjob = "❌"
                        else
                            interactionss = json.decode(interactionss)
                            local foundMatch = false
                            for z, u in pairs(interactionss) do
                                --print(getInteractionName(u), inter.name)
                                if getInteractionName(u) == inter.name then
                                    foundMatch = true
                                    break
                                end
                            end
                            if foundMatch then
                                isiconinjob = "✅"
                            else
                                isiconinjob = "❌"
                            end
                        end

                        interactionitem.Item:RightLabel(isiconinjob or "|" .. inter.prio .. " | " .. isiconinjob)
                        local prio = NativeUI.CreateItem(locale("prio"), "")
                        local name = NativeUI.CreateItem(locale("name"), "")
                        local icon = NativeUI.CreateItem(locale("icon"), "")
                        prio:RightLabel(inter.prio)
                        name:RightLabel(inter.name)
                        icon:RightLabel(inter.icon)
                        interactionitem.SubMenu:AddItem(prio)
                        interactionitem.SubMenu:AddItem(name)
                        interactionitem.SubMenu:AddItem(icon)
                        if isiconinjob == "❌" then
                            local deleteinter = _menuPool:AddSubMenu(interactionitem.SubMenu, locale("addinteraction"),
                                "")
                            deleteinter.Item:RightLabel(">")
                            if middleitem then
                                deleteinter.Item._Text.Padding = { X = 180 }
                            end
                            local yes = NativeUI.CreateItem(locale("yes"), "")
                            deleteinter.SubMenu:AddItem(yes)
                            yes.Activated = function(sender, index)
                                TriggerServerEvent("ludaro_jobs:addinteraction", v.name, inter.name)
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        else
                            local deleteinter = _menuPool:AddSubMenu(interactionitem.SubMenu, locale("removeinteraction"),
                                "")
                            deleteinter.Item:RightLabel(">")
                            if middleitem then
                                deleteinter.Item._Text.Padding = { X = 180 }
                            end
                            local yes = NativeUI.CreateItem(locale("yes"), "")
                            deleteinter.SubMenu:AddItem(yes)
                            yes.Activated = function(sender, index)
                                TriggerServerEvent("ludaro_jobs:removeinteraction", v.name, inter.name)
                                _menuPool:CloseAllMenus()
                                openadminmenu()
                            end
                        end
                    end

                    society = v.society

                    if society == false then
                        local createsociety = NativeUI.CreateItem(locale("createsociety"), "")
                        jobsmenu.SubMenu:AddItem(createsociety)
                        createsociety.Activated = function(sender, index)
                            TriggerServerEvent("ludaro_jobs:createsociety", v.name)
                            _menuPool:CloseAllMenus()
                            openadminmenu()
                        end
                    else
                        local societymoney = NativeUI.CreateItem(locale("society-money"), "")
                        societymoney:RightLabel(society or 0 .. locale("$"))

                        societymoney.Activated = function(sender, index)
                            newsocietymoney = KeyboardInput(locale("insertmoney"), "", 30)
                            societymoney:RightLabel(newsocietymoney .. locale("$"))
                        end
                        jobsmenu.SubMenu:AddItem(societymoney)
                    end

                    --  coords2 = NativeUI.CreateItem(locale("coords"), VectorToString(GetEntityCoords(PlayerPedId())))
                    --     coords2.Activated = function(sender, index)
                    --         coords2:RightLabel(VectorToString(GetEntityCoords(PlayerPedId())))
                    --         table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId())})
                    --     end
                    --     jobsmenu.SubMenu:AddItem(coords2)

                    bossmenu = NativeUI.CreateItem(locale("bossmenu"), "")
                    jobsmenu.SubMenu:AddItem(bossmenu)
                    jobinfoo = json.decode(v.jobinfo)
                    if jobinfoo.bossmenu then
                        jobinfo = json.decode(jobinfo)
                        bossmenucoords = VectorToString(vector3(jobinfoo.bossmenu.x, jobinfoo.bossmenu.y,
                            jobinfoo.bossmenu.z))
                    else
                        bossmenucoords = "none"
                    end

                    --print(bossmenucoords)
                    bossmenu:RightLabel(bossmenucoords)

                    bossmenu.Activated = function(sender, index)
                        index.Label.Text._Text = VectorToString(GetEntityCoords(PlayerPedId()))
                        table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId()) })
                    end






                    deletejob = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("deletejob"), "")
                    if middleitem then
                        deletejob.Item._Text.Padding = { X = 180 }
                    end

                    deletejob.Item:RightLabel(">")

                    yes = NativeUI.CreateItem(locale("yes"), "")
                    deletejob.SubMenu:AddItem(yes)

                    yes.Activated = function(sender, index)
                        TriggerServerEvent("ludaro_jobs:deletejob", v.name)
                        table.insert(deletedjobs, v.name)
                        _menuPool:CloseAllMenus()
                        openadminmenu()
                    end



                    confirm = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("confirm"), "")
                    confirm.Item:RightLabel(">")
                    if middleitem then
                        confirm.Item._Text.Padding = { X = 180 }
                    end








                    yes = NativeUI.CreateItem(locale("yes"), "")
                    confirm.SubMenu:AddItem(yes)

                    yes.Activated = function(sender, index)
                        for k, v in pairs(changestuff) do
                            if v.name then
                                print("ah")
                                TriggerServerEvent("ludaro_jobs:changename", v.job, v.name)
                            end
                            if v.label then
                                TriggerServerEvent("ludaro_jobs:labelch", v.job, v.label)
                            end
                            if v.whitelist ~= nil then
                                TriggerServerEvent("ludaro_jobs:setwhitelist", v.job, v.whitelist)
                            end

                            if v.bossmenu then
                                menuclosed = true
                                TriggerServerEvent("ludaro_jobs:setbossmenu", v.job, v.bossmenu)
                            end
                        end
                        _menuPool:CloseAllMenus()
                        openadminmenu()
                    end
                end
            end

            mainmenu:Visible(true)
            lib.hideTextUI()

            addjob = _menuPool:AddSubMenu(mainmenu, locale("addjob"), "")
            addjob.Item:RightLabel(">")
            -- to add new job
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            name = NativeUI.CreateItem(locale("name"), "")
            addjob.SubMenu:AddItem(name)
            label = NativeUI.CreateItem(locale("label"), "")
            label.Activated = function(sender, index)
                newlabel = KeyboardInput(locale("insertname"), "", 30)
                if newlabel then
                    label:RightLabel(newlabel)
                end
            end
            name.Activated = function(sender, index)
                newname = KeyboardInput(locale("insertname"), "", 30)
                if newname then
                    name:RightLabel(newname)
                end
            end
            addjob.SubMenu:AddItem(label)
            isWhitelistedadd = NativeUI.CreateCheckboxItem(locale("whitelisted"), false, "")
            addjob.SubMenu:AddItem(isWhitelistedadd)

            grades = _menuPool:AddSubMenu(addjob.SubMenu, locale("grades"), "")
            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)

            grades.Item:RightLabel(">")
            addgrade = NativeUI.CreateItem(locale("addgrade"), "")




            grades.SubMenu:AddItem(addgrade)
            confirm = _menuPool:AddSubMenu(addjob.SubMenu, locale("confirm"), "")
            confirm.Item:RightLabel(">")


            _menuPool:RefreshIndex()
            _menuPool:MouseControlsEnabled(false)
            _menuPool:MouseEdgeEnabled(false)
            _menuPool:ControlDisablingEnabled(false)
            yes = NativeUI.CreateItem(locale("yes"), "")
            confirm.SubMenu:AddItem(yes)



            yes.Activated = function(sender, index)
                TriggerServerEvent("ludaro_jobs:createjob", newname, newlabel, gradess)
                --    Config.Notify(locale("success"))
                if newsocietymoney then
                    TriggerServerEvent("ludaro_jobs:setSocietyAccount", v.name or newname, newsocietymoney)
                end
                _menuPool:CloseAllMenus()
                openadminmenu()
            end
        end
        gradess = {}
        addgrade.Activated = function(sender, index)
            -- create a grade
            newgrade = KeyboardInput(locale("insertname"), "", 30)
            newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)

            if newgrade ~= "" and newgradelabel ~= "" then
                newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                if tonumber(newgradesalary) ~= nil then
                else
                    -- Code to execute if newgradesalary is not a number
                    Config.Notify(locale("nonumber"))
                    newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                end

                if tonumber(newgradesalary) ~= nil then
                    salary = 0
                end


                local newGradeTable = {
                    grade = 0,
                    name = newgrade,
                    label = newgradelabel,
                    salary = 0,
                    skin_male = {},
                    skin_female = {}
                }
                table.insert(gradess, newGradeTable)

                -- Insert the new grade table under name, salary, and label
                createdItems = {}
                for k, v in pairs(gradess) do
                    for k, v in pairs(gradess) do
                        if not createdItems[v.name] then
                            gradecreated = NativeUI.CreateItem(v.name .. " (" .. v.label .. ")", "")
                            grades.SubMenu:AddItem(gradecreated)
                            gradecreated:RightLabel(k - 1 .. " | " .. v.salary .. locale("$"))
                            createdItems[v.name] = true
                        end
                    end
                end
            end
        end
    end
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function VectorToString(vector)
    if type(vector) == "vector3" then
        return "(" .. math.round(vector.x) .. ", " .. math.round(vector.y) .. ", " .. math.round(vector.z) .. ")"
    elseif type(vector) == "vector4" then
        return "(" ..
            math.round(vector.x) ..
            ", " .. math.round(vector.y) .. ", " .. math.round(vector.z) .. ", " .. math.round(vector.w) .. ")"
    else
        return "NONE"
    end
end
