if Config.Menu == "ox_lib" then

-- jobs = getjobs()
-- function indextoname(index)
--     local count = 0
--     for k, v in pairs(jobs) do
--         count = count + 1
--         if count == index then
--             return v.name
--         end
--     end
--     return nil
-- end
-- print(ESX.DumpTable(jobs))
-- local menu = {}
-- for k, v in pairs(jobs) do
--     table.insert(menu, {label = k, description = v.name})
-- end


--     -- ADMIN MENU TO SEE JOBS EDIT AND CREATE THEM
--     lib.registerMenu({
--         id = 'adminmenu',
--         title = locale("adminmenu"),
--         position = 'top-right',
--         onSideScroll = function(selected, scrollIndex, args)
--         end,
--         onSelected = function(selected, secondary, args)
--         end,
--         onCheck = function(selected, checked, args)
--         end,
--         onClose = function(keyPressed)
--         end,
--         options = menu
--     }, function(selected, scrollIndex, args)
--         debug2('Selected button: ' .. selected, 3)
--         print(selected)
--         print(indextoname(selected))

--     end)
--     RegisterCommand(Config.Commands.adminmenu, function()
--         lib.showMenu('adminmenu')
--     end)
end

if Config.Menu == "NativeUI" then
    _menuPool = NativeUI.CreatePool()

    jobs = getjobs()
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
        RegisterCommand(Config.Commands.adminmenu, function()
        openadminmenu()
    end)
--print(ESX.DumpTable(jobs))
deletedjobs = {}
    function openadminmenu()
        number = 1
        if not _menuPool:IsAnyMenuOpen() then
        mainmenu = NativeUI.CreateMenu(locale("adminmenu"), "")
        _menuPool:Add(mainmenu)
    _menuPool:RefreshIndex()
    _menuPool:MouseControlsEnabled(false)
    _menuPool:MouseEdgeEnabled(false)
    _menuPool:ControlDisablingEnabled(false)
    mainmenu:Visible(true)
    changestuff = {}
    for k,v in pairs(jobs) do
        if lib.table.contains(deletedjobs, v.name) then
            print("job is deleted")
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
        name.Activated = function(sender, index)
            newname = KeyboardInput(locale("insertname"), "", 30)
            if newname then
                name:RightLabel(newname)
                table.insert(changestuff, { job = k, name = newname})
            end
        end
        local label = NativeUI.CreateItem(locale("label"), "")
        jobsmenu.SubMenu:AddItem(label)
        label:RightLabel(v.label)
        label.Activated = function(sender, index)
            newlabel = KeyboardInput(locale("insertlabel"), "", 30)
            if newlabel then
                label:RightLabel(newlabel)
                table.insert(changestuff, { job = k, label = newlabel})
            end
        end

  
        grade = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("grade"), "")
        _menuPool:RefreshIndex()
        _menuPool:MouseControlsEnabled(false)
        _menuPool:MouseEdgeEnabled(false)
        _menuPool:ControlDisablingEnabled(false)
  

        
        

        local sortedGrades = {}
        for k,v in pairs(v.grades) do
            table.insert(sortedGrades, v)
        end
        table.sort(sortedGrades, function(a, b) return a.grade < b.grade end)
        for _,v in ipairs(sortedGrades) do
            gradeitem = _menuPool:AddSubMenu(grade.SubMenu, v.label, "")
            gradeitem.Item:RightLabel(v.grade .. " || "  .. v.salary .. locale("$"))
             local salary = NativeUI.CreateItem(locale("salary"), "")
            local name = NativeUI.CreateItem(locale("name"), "")
            local label = NativeUI.CreateItem(locale("label"), "")
            salary:RightLabel(v.salary .. locale("$"))
            name:RightLabel(v.name)
            label:RightLabel(v.label)
            gradeitem.SubMenu:AddItem(salary)
            gradeitem.SubMenu:AddItem(name)
            gradeitem.SubMenu:AddItem(label)

            salary.Activated = function(sender, index)
                newgradesalary = KeyboardInput(locale("insertsalary"), "", 30)
                if newgradesalary then
                    if type(newgradesalary) == "number" then
                        print("its a number")
                        salary:RightLabel(newgradesalary)
                    else
                        print("wrong..")
                        Config.Notify(locale("nonumber"))
                    end
                end
                end
              name.Activated = function(sender, index)
                newgradename = KeyboardInput(locale("insertname"), "", 30)
                if newgradename then
                    name:RightLabel(newname)
                end
                end
                label.Activated = function(sender, index)
                    newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
                    if newgradelabel then
                        label:RightLabel(newlabel)
                    end
                    end


        end
        local gradess = {}
        creategrade = NativeUI.CreateItem(locale("creategrade"), "")
        grade.SubMenu:AddItem(creategrade)
        creategrade._Enabled = false
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
            for k,v in pairs(gradess) do 
                for k,v in pairs(gradess) do 
                    if not createdItems[v.name] then
                        gradecreated = NativeUI.CreateItem(v.name .. " (" .. v.label .. ")", "")
                        grade.SubMenu:AddItem(gradecreated)
                        print("added item")
                        gradecreated:RightLabel(k - 1 .. " | " .. v.salary .. locale("$"))
                        createdItems[v.name] = true
                        _menuPool:RefreshIndex()
                    end
                end
            end
        end
        
        end


        interactions = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("interactions"), "")
        interactions.Item:RightLabel(">")

        deletejob = _menuPool:AddSubMenu(jobsmenu.SubMenu, locale("deletejob"), "")

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






 

        yes = NativeUI.CreateItem(locale("yes"), "")
        confirm.SubMenu:AddItem(yes)

        yes.Activated = function(sender, index)
        print(ESX.DumpTable(changestuff))
        end
      
    end
end
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
        --isWhitelistedadd = NativeUI.CreateCheckboxItem(locale("whitelisted"), false, "")
       -- addjob.SubMenu:AddItem(isWhitelistedadd)

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
        _menuPool:CloseAllMenus()
        openadminmenu()
        end
        end
        gradess = {}
        addgrade.Activated = function(sender, index)
            -- create a grade
            newgrade = KeyboardInput(locale("insertname"), "", 30)
            newgradelabel = KeyboardInput(locale("insertlabel"), "", 30)
            print(newgrade)
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
            for k,v in pairs(gradess) do 
                for k,v in pairs(gradess) do 
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


