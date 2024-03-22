if Config.Menu == "NativeUI" then
	function decodeJsonStrings(table)
		for _, entry in ipairs(table) do
			if entry["ludaro_jobs_info"] then
				local decoded, _, err = json.decode(entry["ludaro_jobs_info"], 1, nil)
				if not err then
					entry["ludaro_jobs_info"] = decoded
				else
					print("Error decoding JSON:", err)
				end
			end
		end
	end

	function OpenBossMenu(info)
		local job = Callback_Framework_GetPlayerJobData()
		local jobinfo = Callback_Framework_GetJobData(job)
		if isgradehighenough(job, info) then
			local sortedGrades = {}
			for k, v in pairs(jobinfo.grades) do
				table.insert(sortedGrades, v)
			end
			table.sort(sortedGrades, function(a, b)
				return a.grade < b.grade
			end)
			local menu = NativeUI.CreateMenu(framework_Locale("bossmenu"), "")
			_menuPool:Add(menu)
			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			menu:Visible(true)

			local grades = _menuPool:AddSubMenu(menu, framework_Locale("grades"), "")
			local members = _menuPool:AddSubMenu(menu, framework_Locale("members"), "")

			local recruit = _menuPool:AddSubMenu(menu, framework_Locale("recruit"), "")
			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			for _, grad in pairs(sortedGrades) do
				gradeitem = _menuPool:AddSubMenu(grades.SubMenu, grad.name .. "(" .. grad.label .. ")", "")
				gradeitem.Item:RightLabel(grad.grade .. " || " .. grad.salary .. framework_Locale("$"))
				local salary = NativeUI.CreateItem(framework_Locale("salary"), "")
				local name = NativeUI.CreateItem(framework_Locale("name"), "")
				salary:RightLabel(grad.salary .. framework_Locale("$"))
				name:RightLabel(grad.name)
				gradeitem.SubMenu:AddItem(salary)
				gradeitem.SubMenu:AddItem(name)
				name.Activated = function(sender, index)
					newgradename = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
					if newgradename then
						name:RightLabel(newgradename)
					end
				end

				local deletegrade = _menuPool:AddSubMenu(gradeitem.SubMenu, framework_Locale("deletegrade"), "")
				deletegrade.Item:RightLabel(">")
				if middleitem then
					deletegrade.Item._Text.Padding = { X = 180 }
				end
				local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
				deletegrade.SubMenu:AddItem(yes)
				yes.Activated = function(sender, index)
					TriggerServerEvent("ludaro_jobs:deletegrade", v.name, grad.name)
					_menuPool:CloseAllMenus()
					OpenBossMenu(info)
				end

				local confirm = _menuPool:AddSubMenu(gradeitem.SubMenu, framework_Locale("confirm"), "")
				confirm.Item:RightLabel(">")
				if middleitem then
					confirm.Item._Text.Padding = { X = 180 }
				end

				local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
				confirm.SubMenu:AddItem(yes)
				yes.Activated = function(sender, index)
					if newgradename then
						TriggerServerEvent("ludaro_jobs:changename", v.name, grad.name, newgradename)
					end

					_menuPool:CloseAllMenus()
					OpenBossMenu(info)
				end
			end
			creategrade = NativeUI.CreateItem(framework_Locale("creategrade"), "")

			creategrade.Activated = function(sender, index)
				-- create a grade
				newgrade = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
				newgradelabel = functions_KeyBoardInput(framework_Locale("insertlabel"), "", 30)
				if newgrade ~= "" and newgradelabel ~= "" then
					newgradesalary = functions_KeyBoardInput(framework_Locale("insertsalary"), "", 30)
					if tonumber(newgradesalary) ~= nil then
					else
						-- Code to execute if newgradesalary is not a number
						Config.Notify(framework_Locale("nonumber"))
						newgradesalary = functions_KeyBoardInput(framework_Locale("insertsalary"), "", 30)
					end

					if tonumber(newgradesalary) ~= nil then
						salary = 0
					end

					newid = functions_KeyBoardInput(framework_Locale("insertid"), "", 30)

					newGradeTable = {
						id = newid or 0,
						grade = 0,
						name = newgrade,
						label = newgradelabel,
						salary = newgradesalary,
						skin_male = {},
						skin_female = {},
					}
					consoleLog(ESX.DumpTable(newGradeTable))
					TriggerServerEvent("ludaro_jobs:addgrade", v.name, newGradeTable)
					_menuPool:CloseAllMenus()
					OpenBossMenu(info)
				end
			end
			grades.SubMenu:AddItem(creategrade)

			jobmembers = Callback_Framework_GetJobMembers(job)
			members.Item:RightLabel("> " .. #jobmembers)
			for k, v in pairs(jobmembers) do
				local member = _menuPool:AddSubMenu(members.SubMenu, v.name, "")
				_menuPool:RefreshIndex()
				_menuPool:MouseControlsEnabled(false)
				_menuPool:MouseEdgeEnabled(false)
				_menuPool:ControlDisablingEnabled(false)
				member.Item:RightLabel(v.grade)
				local promote = NativeUI.CreateItem(framework_Locale("promote"), "")
				local demote = NativeUI.CreateItem(framework_Locale("demote"), "")
				local kick = NativeUI.CreateItem(framework_Locale("kick"), "")
				local grade = NativeUI.CreateItem(framework_Locale("grade"), "")
				member.SubMenu:AddItem(promote)
				member.SubMenu:AddItem(demote)
				member.SubMenu:AddItem(kick)
				member.SubMenu:AddItem(grade)
				-- to be done server side
				promote.Activated = function(sender, index)
					TriggerServerEvent("ludaro_jobs:promote", v.identifier, v.grade)
				end
				demote.Activated = function(sender, index)
					TriggerServerEvent("ludaro_jobs:demote", v.identifier, v.grade)
				end
				kick.Activated = function(sender, index)
					TriggerServerEvent("ludaro_jobs:kick", v.identifier)
				end
				grade.Activated = function(sender, index)
					newgrade = functions_KeyBoardInput(framework_Locale("insertgrade"), "", 30)
					if newgrade then
						TriggerServerEvent("ludaro_jobs:changegrade", v.identifier, newgrade)
					end
				end
			end

			nearestplayers = Callback_Framework_GetNearestPlayers()
			if #nearestplayers == 0 then
				recruit.Item:Enabled(false)
			end
			for k, v in pairs(nearestplayers) do
				local recruitplayer = _menuPool:AddSubMenu(recruit.SubMenu, v.name, "")
				local recruit = NativeUI.CreateItem(framework_Locale("recruit"), "")
				recruitplayer.SubMenu:AddItem(recruit)
				recruit.Activated = function(sender, index)
					-- to be done serverside
					TriggerServerEvent("ludaro_jobs:recruit", v.identifier, v.name, v.job, v.grade)
					_menuPool:CloseAllMenus()
					OpenBossMenu(info)
				end
			end
			societymoney = Callback_Job_GetSociety(job)

			if societymoney ~= false or societymoney ~= nil then
				local society = _menuPool:AddSubMenu(menu, framework_Locale("society"), "")
				local withdraw = NativeUI.CreateItem(framework_Locale("withdraw"), "")
				local deposit = NativeUI.CreateItem(framework_Locale("deposit"), "")
				society.SubMenu:AddItem(withdraw)
				society.SubMenu:AddItem(deposit)
				society.Item:RightLabel(societymoney .. framework_Locale("$"))
				withdraw.Activated = function(sender, index)
					withdrawamount = functions_KeyBoardInput(framework_Locale("insertamount"), "", 30)
					if tonumber(withdrawamount) ~= nil and withdrawamount < societymoney then
						Callback_Job_AddToSociety(job, withdrawamount)
					else
						Config.Notify(framework_Locale("nonumber"))
					end
				end
				deposit.Activated = function(sender, index)
					depositamount = functions_KeyBoardInput(framework_Locale("insertamount"), "", 30)
					if tonumber(depositamount) ~= nil then
						if HasEnoughMoney(depositamount) then
							Callback_Job_RemoveFromSociety(job, depositamount)
						else
							Config.Notify(framework_Locale("notenoughmoney"))
						end
					else
						Config.Notify(framework_Locale("nonumber"))
					end
				end
			end
			-- add a function to only let the highest grade member open it and let it decide which people can open instead of the admin itself :)

			consoleLog("Opening Bossmenu for job: " .. job)
		end
	end
end
