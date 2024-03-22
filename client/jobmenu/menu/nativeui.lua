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

	deletedjobs = {}
	function openadminmenu()
		menuclosed = false
		jobs = cb_getJobs()
		number = 1
		if not _menuPool:IsAnyMenuOpen() then
			mainmenu = NativeUI.CreateMenu(framework_Locale("adminmenu"), "")
			_menuPool:Add(mainmenu)
			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			changestuff = {}
			for k, v in pairs(jobs) do
				--(v.jobinfo)

				if lib.table.contains(deletedjobs, v.name) then
					consoleLog("job is deleted " .. v.name)
				else
					jobsmenu = _menuPool:AddSubMenu(mainmenu, v.label, v.name)
					_menuPool:RefreshIndex()
					_menuPool:MouseControlsEnabled(false)
					_menuPool:MouseEdgeEnabled(false)
					_menuPool:ControlDisablingEnabled(false)
					jobsmenu.Item:RightLabel(">")
					local name = NativeUI.CreateItem(framework_Locale("name"), "")
					jobsmenu.SubMenu:AddItem(name)
					name:RightLabel(v.name)

					jobsmenu.SubMenu.OnMenuClosed = function(menu)
						if #changestuff > 0 then
							-- do something
							local alert = lib.alertDialog({
								header = framework_Locale("unsaved"),
								content = framework_Locale("you have unsaved content"),
								centered = true,
								cancel = true,
							})
							if alert == "confirm" then
								for k, v in pairs(changestuff) do
									if v.name then
										--("ah")
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
										Citizen.Wait(1000)
										Refresh_bossmenu()
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
						newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
						if newname then
							name:RightLabel(newname)
							table.insert(changestuff, { job = v.name, name = newname })
						end
					end
					local label = NativeUI.CreateItem(framework_Locale("label"), "")
					jobsmenu.SubMenu:AddItem(label)
					label:RightLabel(v.label)
					label.Activated = function(sender, index)
						newlabel = functions_KeyBoardInput(framework_Locale("insertlabel"), "", 30)
						if newlabel then
							label:RightLabel(newlabel)
							table.insert(changestuff, { job = v.label, label = newlabel })
						end
					end
					isWhitelistedadd = NativeUI.CreateCheckboxItem(framework_Locale("whitelisted"), false, "")
					jobsmenu.SubMenu:AddItem(isWhitelistedadd)
					isWhitelistedadd.Checked = v.whitelisted or false

					isWhitelistedadd.CheckboxEvent = function(menu, item, checked)
						table.insert(changestuff, { job = v.label, whitelist = checked })
					end

					grade = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("grade"), "")
					_menuPool:RefreshIndex()
					_menuPool:MouseControlsEnabled(false)
					_menuPool:MouseEdgeEnabled(false)
					_menuPool:ControlDisablingEnabled(false)

					local sortedGrades = {}
					for k, v in pairs(v.grades) do
						table.insert(sortedGrades, v)
					end
					table.sort(sortedGrades, function(a, b)
						return a.grade < b.grade
					end)
					for _, grad in ipairs(sortedGrades) do
						gradeitem = _menuPool:AddSubMenu(grade.SubMenu, grad.name .. "(" .. grad.label .. ")", "")
						gradeitem.Item:RightLabel(grad.grade .. " || " .. grad.salary .. framework_Locale("$"))
						local salary = NativeUI.CreateItem(framework_Locale("salary"), "")
						local name = NativeUI.CreateItem(framework_Locale("name"), "")
						local label = NativeUI.CreateItem(framework_Locale("label"), "")
						salary:RightLabel(grad.salary .. framework_Locale("$"))
						name:RightLabel(grad.name)
						label:RightLabel(grad.label)
						gradeitem.SubMenu:AddItem(salary)
						gradeitem.SubMenu:AddItem(name)
						gradeitem.SubMenu:AddItem(label)

						name.Activated = function(sender, index)
							newgradename = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
							if newgradename then
								name:RightLabel(newgradename)
							end
						end
						label.Activated = function(sender, index)
							newgradelabel = functions_KeyBoardInput(framework_Locale("insertlabel"), "", 30)
							if newgradelabel then
								label:RightLabel(newgradelabel)
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
							openadminmenu()
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
							if newgradelabel then
								TriggerServerEvent("ludaro_jobs:labelch", v.name, grad.name, newgradelabel)
							end
							_menuPool:CloseAllMenus()
							openadminmenu()
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
							openadminmenu()
						end
					end
					grade.SubMenu:AddItem(creategrade)

					interactions = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("interactions"), "")
					interactions.Item:RightLabel(">")

					local sortedInteractions = {}
					for k, v in pairs(Config.Interactions) do
						table.insert(sortedInteractions, v)
					end
					table.sort(sortedInteractions, function(a, b)
						return a.prio < b.prio
					end)
					for _, inter in ipairs(sortedInteractions) do
						interactionitem = _menuPool:AddSubMenu(interactions.SubMenu, inter.name, "")
						-- interactionss = lib.callback.await('ludaro_jobs:getinteractions', false, v.name)
						if
							tonumber(interactionss) == 0
							or interactionss == false
							or interactionss == true
							or interactionss == nil
						then
							isiconinjob = "❌"
						else
							interactionss = json.decode(interactionss)
							local foundMatch = false
							for z, u in pairs(interactionss) do
								----(getinteractionname(u), inter.name)
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
						local prio = NativeUI.CreateItem(framework_Locale("prio"), "")
						local name = NativeUI.CreateItem(framework_Locale("name"), "")
						local icon = NativeUI.CreateItem(framework_Locale("icon"), "")
						prio:RightLabel(inter.prio)
						name:RightLabel(inter.name)
						icon:RightLabel(inter.icon)
						interactionitem.SubMenu:AddItem(prio)
						interactionitem.SubMenu:AddItem(name)
						interactionitem.SubMenu:AddItem(icon)
						if isiconinjob == "❌" then
							local deleteinter =
								_menuPool:AddSubMenu(interactionitem.SubMenu, framework_Locale("addinteraction"), "")
							deleteinter.Item:RightLabel(">")
							if middleitem then
								deleteinter.Item._Text.Padding = { X = 180 }
							end
							local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
							deleteinter.SubMenu:AddItem(yes)
							yes.Activated = function(sender, index)
								TriggerServerEvent("ludaro_jobs:addinteraction", v.name, inter.name)
								_menuPool:CloseAllMenus()
								openadminmenu()
							end
						else
							local deleteinter =
								_menuPool:AddSubMenu(interactionitem.SubMenu, framework_Locale("removeinteraction"), "")
							deleteinter.Item:RightLabel(">")
							if middleitem then
								deleteinter.Item._Text.Padding = { X = 180 }
							end
							local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
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
						local createsociety = NativeUI.CreateItem(framework_Locale("createsociety"), "")
						jobsmenu.SubMenu:AddItem(createsociety)
						createsociety.Activated = function(sender, index)
							TriggerServerEvent("ludaro_jobs:createsociety", v.name)
							_menuPool:CloseAllMenus()
							openadminmenu()
						end
					else
						local societymoney = NativeUI.CreateItem(framework_Locale("society-money"), "")
						societymoney:RightLabel(society or 0 .. framework_Locale("$"))

						societymoney.Activated = function(sender, index)
							newsocietymoney = functions_KeyBoardInput(framework_Locale("insertmoney"), "", 30)
							if newsocietymoney == nil then
								newsocietymoney = society
							end
							societymoney:RightLabel(newsocietymoney or 0 .. framework_Locale("$"))
						end
						jobsmenu.SubMenu:AddItem(societymoney)
					end

					--  coords2 = NativeUI.CreateItem(locale("coords"), VectorToString(GetEntityCoords(PlayerPedId())))
					--     coords2.Activated = function(sender, index)
					--         coords2:RightLabel(VectorToString(GetEntityCoords(PlayerPedId())))
					--         table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId())})
					--     end
					--     jobsmenu.SubMenu:AddItem(coords2)

					bossmenumenu = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("bossmenu"), "")
					bossmenumenu.Item:RightLabel(">")
					bossmenu = NativeUI.CreateItem(framework_Locale("bossmenucoords"), "")
					bossmenumenu.SubMenu:AddItem(bossmenu)

					jobinfoo = json.decode(v.jobinfo)

					if Config.bossmenu.Marker then
						marker = _menuPool:AddSubMenu(bossmenumenu.SubMenu, framework_Locale("marker"), "")
						marker.Item:RightLabel(">")

						markertypes = {}
						for i = 1, 43 do
							table.insert(markertypes, i)
						end

						colors = {}
						for i = 1, 255 do
							table.insert(colors, i)
						end

						markertype = NativeUI.CreateListItem(
							framework_Locale("markerid"),
							markertypes,
							json.decode(v.jobinfo).markerid or 0,
							""
						)
						marker.SubMenu:AddItem(markertype)

						scale = _menuPool:AddSubMenu(marker.SubMenu, framework_Locale("scale"), "")
						scale.Item:RightLabel(">")

						scalex = NativeUI.CreateItem(framework_Locale("scalex"), "")
						scale.SubMenu:AddItem(scalex)
						scaley = NativeUI.CreateItem(framework_Locale("scaley"), "")
						scale.SubMenu:AddItem(scaley)
						scalez = NativeUI.CreateItem(framework_Locale("scalez"), "")
						scale.SubMenu:AddItem(scalez)

						offset = _menuPool:AddSubMenu(marker.SubMenu, framework_Locale("offset"), "")
						offset.Item:RightLabel(">")

						xoffset = NativeUI.CreateItem(framework_Locale("xoffset"), "")
						offset.SubMenu:AddItem(xoffset)
						yoffset = NativeUI.CreateItem(framework_Locale("yoffset"), "")
						offset.SubMenu:AddItem(yoffset)
						zoffset = NativeUI.CreateItem(framework_Locale("zoffset"), "")
						offset.SubMenu:AddItem(zoffset)

						color = _menuPool:AddSubMenu(marker.SubMenu, framework_Locale("color"), "")
						color.Item:RightLabel(">")

						red = NativeUI.CreateItem(framework_Locale("red"), "")
						color.SubMenu:AddItem(red)
						red.Activated = function(sender, index)
							newred = functions_KeyBoardInput(framework_Locale("insertred"), "", 30)
							if tonumber(newred) ~= nil and tonumber(newgreen) <= 255 then
								index.Label.Text._Text = newred
								table.insert(changestuff, { job = v.label, markerred = newred })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						red:RightLabel(json.decode(v.jobinfo).markerred or 0)

						green = NativeUI.CreateItem(framework_Locale("green"), "")
						color.SubMenu:AddItem(green)
						green.Activated = function(sender, index)
							newgreen = functions_KeyBoardInput(framework_Locale("insertgreen"), "", 30)
							if tonumber(newgreen) ~= nil and tonumber(newgreen) <= 255 then
								index.Label.Text._Text = newgreen
								table.insert(changestuff, { job = v.label, markergreen = newgreen })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						green:RightLabel(json.decode(v.jobinfo).markergreen or 0)
						blue = NativeUI.CreateItem(framework_Locale("blue"), "")
						color.SubMenu:AddItem(blue)
						blue.Activated = function(sender, index)
							newblue = functions_KeyBoardInput(framework_Locale("insertblue"), "", 30)
							if tonumber(newblue) ~= nil and tonumber(newblue) <= 255 then
								index.Label.Text._Text = newblue
								table.insert(changestuff, { job = v.label, markerblue = newblue })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						blue:RightLabel(json.decode(v.jobinfo).markerblue or 0)

						alpha = NativeUI.CreateItem(framework_Locale("alpha"), "")
						color.SubMenu:AddItem(alpha)
						alpha.Activated = function(sender, index)
							newalpha = functions_KeyBoardInput(framework_Locale("insertalpha"), "", 30)
							if tonumber(newalpha) ~= nil and tonumber(newalpha) <= 255 then
								index.Label.Text._Text = newalpha
								table.insert(changestuff, { job = v.label, markeralpha = newalpha })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						alpha:RightLabel(json.decode(v.jobinfo).markeralpha or 0)

						coloritem = NativeUI.CreateItem(framework_Locale("color"), "")

						bobupanddown = NativeUI.CreateCheckboxItem(framework_Locale("bobupanddown"), false, "")
						marker.SubMenu:AddItem(bobupanddown)

						facecamera = NativeUI.CreateCheckboxItem(framework_Locale("facecamera"), false, "")
						marker.SubMenu:AddItem(facecamera)
						markerenabled = NativeUI.CreateCheckboxItem(framework_Locale("markerenabled"), false, "")
						marker.SubMenu:AddItem(markerenabled)
						bobupanddown.Checked = json.decode(v.jobinfo).markerbobupanddown or false
						facecamera.Checked = json.decode(v.jobinfo).markerfacecamera or false
						markerenabled.Checked = json.decode(v.ludaro_jobs_info).markerenabled or false

						marker.SubMenu.OnListChange = function(sender, index, number)
							table.insert(changestuff, { job = v.label, markerid = number })
						end

						scalex.Activated = function(sender, index)
							newscalex = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newscalex) ~= nil then
								index.Label.Text._Text = newscalex
								table.insert(changestuff, { job = v.label, scalex = newscalex })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						scalex:RightLabel(json.decode(v.jobinfo).scalex or 0)

						scaley.Activated = function(sender, index)
							newscaley = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newscaley) ~= nil then
								index.Label.Text._Text = newscaley
								table.insert(changestuff, { job = v.label, scaley = newscaley })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						scaley:RightLabel(json.decode(v.jobinfo).scaley or 0)

						scalez.Activated = function(sender, index)
							newscalez = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newscalez) ~= nil then
								index.Label.Text._Text = newscalez
								table.insert(changestuff, { job = v.label, scalez = newscalez })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						scalez:RightLabel(json.decode(v.jobinfo).scalez or 0)

						xoffset.Activated = function(sender, index)
							newxoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newxoffset) ~= nil then
								index.Label.Text._Text = newxoffset
								table.insert(changestuff, { job = v.label, xoffset = newxoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						xoffset:RightLabel(json.decode(v.jobinfo).xoffset or 0)

						yoffset.Activated = function(sender, index)
							newyoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newyoffset) ~= nil then
								index.Label.Text._Text = newyoffset
								table.insert(changestuff, { job = v.label, yoffset = newyoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						yoffset:RightLabel(json.decode(v.jobinfo).yoffset or 0)

						zoffset.Activated = function(sender, index)
							newzoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newzoffset) ~= nil then
								index.Label.Text._Text = newzoffset
								table.insert(changestuff, { job = v.label, zoffset = newzoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end
						zoffset:RightLabel(json.decode(v.jobinfo).zoffset or 0)

						bobupanddown.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, markerbobupanddown = checked })
						end

						-- rotate.CheckboxEvent = function(menu, item, checked)
						--     table.insert(changestuff, { job = v.label, markerrotate = checked})
						-- end

						facecamera.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, markerfacecamera = checked })
						end

						markerenabled.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, markerenabled = checked })
						end
					end
					if Config.bossmenuNPC then
						npc = _menuPool:AddSubMenu(bossmenumenu.SubMenu, framework_Locale("NPC"), "")
						npc.Item:RightLabel(">")

						offset = _menuPool:AddSubMenu(npc.SubMenu, framework_Locale("offset"), "")
						offset.Item:RightLabel(">")

						xoffset = NativeUI.CreateItem(framework_Locale("xoffset"), "")
						offset.SubMenu:AddItem(xoffset)
						yoffset = NativeUI.CreateItem(framework_Locale("yoffset"), "")
						offset.SubMenu:AddItem(yoffset)
						zoffset = NativeUI.CreateItem(framework_Locale("zoffset"), "")
						offset.SubMenu:AddItem(zoffset)

						xoffset.Activated = function(sender, index)
							newxoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newxoffset) ~= nil then
								index.Label.Text._Text = newxoffset
								table.insert(changestuff, { job = v.label, xoffsetnpc = newxoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						yoffset.Activated = function(sender, index)
							newyoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newyoffset) ~= nil then
								index.Label.Text._Text = newyoffset
								table.insert(changestuff, { job = v.label, yoffsetnpc = newyoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						zoffset.Activated = function(sender, index)
							newzoffset = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newzoffset) ~= nil then
								index.Label.Text._Text = newzoffset
								table.insert(changestuff, { job = v.label, zoffsetnpc = newzoffset })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						model = NativeUI.CreateItem(framework_Locale("model"), "")
						npc.SubMenu:AddItem(model)
						model.Activated = function(sender, index)
							newmodel = functions_KeyBoardInput(framework_Locale("insertmodel"), "", 30)
							if tostring(newmodel) ~= nil then
								index.Label.Text._Text = newmodel
								table.insert(changestuff, { job = v.label, npcmodel = newmodel })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						heading = NativeUI.CreateItem(framework_Locale("heading"), "")
						npc.SubMenu:AddItem(heading)
						heading.Activated = function(sender, index)
							newheading = GetEntityHeading(PlayerPedId())
							print(newheading)
							index.Label.Text._Text = tostring(newheading)
							table.insert(changestuff, { job = v.label, npcheading = newheading })
						end

						npcenabled = NativeUI.CreateCheckboxItem(framework_Locale("npcenabled"), false, "")
						npc.SubMenu:AddItem(npcenabled)
						npcenabled.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, npcenabled = checked })
						end

						-- merken: xoffsetnpc, yoffsetnpc, zoffsetnpc, npcmodel, npcheading
					end

					if v.blipname then
						editblip = _menuPool:AddSubMenu(bossmenumenu.SubMenu, framework_Locale("editblip"), "")
						editblip.Item:RightLabel(">")
						if middleitem then
							editblip.Item._Text.Padding = { X = 180 }
						end
						local name = NativeUI.CreateItem(framework_Locale("name"), "")
						local sprite = NativeUI.CreateItem(framework_Locale("sprite"), "")
						local color = NativeUI.CreateItem(framework_Locale("color"), "")
						local scale = NativeUI.CreateItem(framework_Locale("scale"), "")
						local shortrange = NativeUI.CreateCheckboxItem(framework_Locale("shortrange"), false, "")
						local showblip = NativeUI.CreateCheckboxItem(framework_Locale("showblip"), false, "")
						editblip.SubMenu:AddItem(name)
						editblip.SubMenu:AddItem(sprite)
						editblip.SubMenu:AddItem(color)
						editblip.SubMenu:AddItem(scale)
						editblip.SubMenu:AddItem(shortrange)
						editblip.SubMenu:AddItem(showblip)
						name:RightLabel(v.bossmenu.blip.name)
						sprite:RightLabel(v.bossmenu.blip.sprite)
						color:RightLabel(v.bossmenu.blip.color)
						scale:RightLabel(v.bossmenu.blip.scale)
						shortrange.Checked = v.bossmenu.blip.shortrange or false
						showblip.Checked = v.bossmenu.blip.showblip or false

						name.Activated = function(sender, index)
							newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
							if newname then
								name:RightLabel(newname)
								table.insert(changestuff, { job = v.label, blipname = newname })
							end
						end

						sprite.Activated = function(sender, index)
							newsprite = functions_KeyBoardInput(framework_Locale("insertsprite"), "", 30)
							if tonumber(newsprite) ~= nil then
								sprite:RightLabel(newsprite)
								table.insert(changestuff, { job = v.label, blipsprite = newsprite })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						color.Activated = function(sender, index)
							newcolor = functions_KeyBoardInput(framework_Locale("insertcolor"), "", 30)
							if tonumber(newcolor) ~= nil then
								color:RightLabel(newcolor)
								table.insert(changestuff, { job = v.label, blipcolor = newcolor })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						scale.Activated = function(sender, index)
							newscale = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newscale) ~= nil then
								scale:RightLabel(newscale)
								table.insert(changestuff, { job = v.label, blipscale = newscale })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						shortrange.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, blipshortrange = checked })
						end

						showblip.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, blipshowblip = checked })
						end

						local deleteblip = _menuPool:AddSubMenu(editblip.SubMenu, framework_Locale("deleteblip"), "")
						deleteblip.Item:RightLabel(">")
						if middleitem then
							deleteblip.Item._Text.Padding = { X = 180 }
						end
						local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
						deleteblip.SubMenu:AddItem(yes)
						yes.Activated = function(sender, index)
							TriggerServerEvent("ludaro_jobs:deletebossblip", v.name)
							_menuPool:CloseAllMenus()
							openadminmenu()
						end
					else
						createblip = _menuPool:AddSubMenu(bossmenumenu.SubMenu, framework_Locale("createblip"), "")
						createblip.Item:RightLabel(">")
						if middleitem then
							createblip.Item._Text.Padding = { X = 180 }
						end
						local name = NativeUI.CreateItem(framework_Locale("name"), "")
						local sprite = NativeUI.CreateItem(framework_Locale("sprite"), "")
						local color = NativeUI.CreateItem(framework_Locale("color"), "")
						local scale = NativeUI.CreateItem(framework_Locale("scale"), "")
						local shortrange = NativeUI.CreateCheckboxItem(framework_Locale("shortrange"), false, "")
						local showblip = NativeUI.CreateCheckboxItem(framework_Locale("showblip"), false, "")
						createblip.SubMenu:AddItem(name)
						createblip.SubMenu:AddItem(sprite)
						createblip.SubMenu:AddItem(color)
						createblip.SubMenu:AddItem(scale)
						createblip.SubMenu:AddItem(shortrange)
						createblip.SubMenu:AddItem(showblip)

						if v.bossmenu then
							name:RightLabel(v.bossmenu.blip.name or "none")
							sprite:RightLabel(v.bossmenu.blip.sprite or 0)
							color:RightLabel(v.bossmenu.blip.color or 0)
							scale:RightLabel(v.bossmenu.blip.scale or 0)
							shortrange.Checked = v.bossmenu.blip.shortrange or false
							showblip.Checked = v.bossmenu.blip.showblip or false
						else
							name:RightLabel("none") -- if you dont have a blip it will show none at the
						end

						name.Activated = function(sender, index)
							newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
							if newname then
								name:RightLabel(newname)
								table.insert(changestuff, { job = v.label, blipname = newname })
							end
						end

						sprite.Activated = function(sender, index)
							newsprite = functions_KeyBoardInput(framework_Locale("insertsprite"), "", 30)
							if tonumber(newsprite) ~= nil then
								sprite:RightLabel(newsprite)
								table.insert(changestuff, { job = v.label, blipsprite = newsprite })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						color.Activated = function(sender, index)
							newcolor = functions_KeyBoardInput(framework_Locale("insertcolor"), "", 30)
							if tonumber(newcolor) ~= nil then
								color:RightLabel(newcolor)
								table.insert(changestuff, { job = v.label, blipcolor = newcolor })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						scale.Activated = function(sender, index)
							newscale = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
							if tonumber(newscale) ~= nil then
								scale:RightLabel(newscale)
								table.insert(changestuff, { job = v.label, blipscale = newscale })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						shortrange.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, blipshortrange = checked })
						end

						showblip.CheckboxEvent = function(menu, item, checked)
							table.insert(changestuff, { job = v.label, blipshowblip = checked })
						end
						minimumgradee = NativeUI.CreateItem(framework_Locale("minimumgrade"), "")
						jobsmenu.SubMenu:AddItem(minimumgradee)
						minimumgradee:RightLabel(v.minimumgrade or Config.DefaultMinimumGrade)
						minimumgradee.Activated = function(sender, index)
							newminimumgrade = functions_KeyBoardInput(framework_Locale("insertminimumgrade"), "", 30)
							if tonumber(newminimumgrade) ~= nil then
								minimumgradee:RightLabel(newminimumgrade)
								--print(minimumgradee.Label.Text._Text)
								minimumgradee.Label.Text._Text = newminimumgrade
								table.insert(changestuff, { job = v.label, minimumgrade = newminimumgrade })
							else
								Config.Notify(framework_Locale("nonumber"))
							end
						end

						local createblip = _menuPool:AddSubMenu(createblip.SubMenu, framework_Locale("createblip"), "")
						createblip.Item:RightLabel(">")
						if middleitem then
							createblip.Item._Text.Padding = { X = 180 }
						end
					end

					bossmenucoords_table = json.decode(v.jobinfo).bossmenu
					if type(bossmenucoords_table) == "table" then
						bossmenucoords = VectorToString(
							vector3(bossmenucoords_table.x, bossmenucoords_table.y, bossmenucoords_table.z)
						)
						bossmenu:RightLabel(bossmenucoords)
					end

					bossmenu.Activated = function(sender, index)
						index.Label.Text._Text = VectorToString(GetEntityCoords(PlayerPedId()))
						table.insert(changestuff, { job = v.label, bossmenu = GetEntityCoords(PlayerPedId()) })
					end

					blips = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("blips"), "")
					blips.Item:RightLabel(">")
					if v.blips then
						for k, v in pairs(v.blips) do
							blip = _menuPool:AddSubMenu(blips.SubMenu, v.name, "")
							blip.Item:RightLabel(">")
							local name = NativeUI.CreateItem(framework_Locale("name"), "")
							local sprite = NativeUI.CreateItem(framework_Locale("sprite"), "")
							local color = NativeUI.CreateItem(framework_Locale("color"), "")
							local scale = NativeUI.CreateItem(framework_Locale("scale"), "")
							local shortrange = NativeUI.CreateCheckboxItem(framework_Locale("shortrange"), false, "")
							local showblip = NativeUI.CreateCheckboxItem(framework_Locale("showblip"), false, "")

							name:RightLabel(v.name)
							sprite:RightLabel(v.sprite)
							color:RightLabel(v.color)
							scale:RightLabel(v.scale)
							shortrange.Checked = v.shortrange or false
							showblip.Checked = v.showblip or false

							blip.SubMenu:AddItem(name)
							blip.SubMenu:AddItem(sprite)
							blip.SubMenu:AddItem(color)
							blip.SubMenu:AddItem(scale)
							blip.SubMenu:AddItem(shortrange)
							blip.SubMenu:AddItem(showblip)
							blipchanges = {}
							name.Activated = function(sender, index)
								newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
								if newname then
									name:RightLabel(newname)
									blipchanges.name = newname
								end
							end

							sprite.Activated = function(sender, index)
								newsprite = functions_KeyBoardInput(framework_Locale("insertsprite"), "", 30)
								if tonumber(newsprite) ~= nil then
									sprite:RightLabel(newsprite)
									blipchanges.sprite = newsprite
								else
									Config.Notify(framework_Locale("nonumber"))
								end
							end

							color.Activated = function(sender, index)
								newcolor = functions_KeyBoardInput(framework_Locale("insertcolor"), "", 30)
								if tonumber(newcolor) ~= nil then
									color:RightLabel(newcolor)
									blipchanges.color = newcolor
								else
									Config.Notify(framework_Locale("nonumber"))
								end
							end

							scale.Activated = function(sender, index)
								newscale = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
								if tonumber(newscale) ~= nil then
									scale:RightLabel(newscale)
									blipchanges.scale = newscale
								else
									Config.Notify(framework_Locale("nonumber"))
								end
							end

							shortrange.CheckboxEvent = function(menu, item, checked)
								blipchanges.shortrange = checked
							end

							showblip.CheckboxEvent = function(menu, item, checked)
								blipchanges.showblip = checked
							end

							local deleteblip = _menuPool:AddSubMenu(blip.SubMenu, framework_Locale("deleteblip"), "")
							deleteblip.Item:RightLabel(">")
							if middleitem then
								deleteblip.Item._Text.Padding = { X = 180 }
							end
							local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
							deleteblip.SubMenu:AddItem(yes)
							yes.Activated = function(sender, index)
								TriggerServerEvent("ludaro_jobs:deleteblip", v.name, blip.name)
								_menuPool:CloseAllMenus()
								openadminmenu()
							end

							blip.SubMenu.Closed = function(sender)
								if next(blipchanges) then
									TriggerServerEvent("ludaro_jobs:changeblip", blipchanges)
									_menuPool:CloseAllMenus()
									openadminmenu()
								end
							end
						end
					end

					createblip = _menuPool:AddSubMenu(blips.SubMenu, framework_Locale("createblip"), "")
					createblip.Item:RightLabel(">")
					if middleitem then
						createblip.Item._Text.Padding = { X = 180 }
					end

					local name = NativeUI.CreateItem(framework_Locale("name"), "")
					local sprite = NativeUI.CreateItem(framework_Locale("sprite"), "")
					local color = NativeUI.CreateItem(framework_Locale("color"), "")
					local scale = NativeUI.CreateItem(framework_Locale("scale"), "")
					local shortrange = NativeUI.CreateCheckboxItem(framework_Locale("shortrange"), false, "")
					local showblip = NativeUI.CreateCheckboxItem(framework_Locale("showblip"), false, "")

					createblip.SubMenu:AddItem(name)
					createblip.SubMenu:AddItem(sprite)
					createblip.SubMenu:AddItem(color)
					createblip.SubMenu:AddItem(scale)
					createblip.SubMenu:AddItem(shortrange)
					createblip.SubMenu:AddItem(showblip)

					blipchangesnew = {}

					name.Activated = function(sender, index)
						newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
						if newname then
							name:RightLabel(newname)
							blipchangesnew.name = newname
						end
					end

					sprite.Activated = function(sender, index)
						newsprite = functions_KeyBoardInput(framework_Locale("insertsprite"), "", 30)
						if tonumber(newsprite) ~= nil then
							sprite:RightLabel(newsprite)
							blipchangesnew.sprite = newsprite
						else
							Config.Notify(framework_Locale("nonumber"))
						end
					end

					color.Activated = function(sender, index)
						newcolor = functions_KeyBoardInput(framework_Locale("insertcolor"), "", 30)
						if tonumber(newcolor) ~= nil then
							color:RightLabel(newcolor)
							blipchangesnew.color = newcolor
						else
							Config.Notify(framework_Locale("nonumber"))
						end
					end

					scale.Activated = function(sender, index)
						newscale = functions_KeyBoardInput(framework_Locale("insertscale"), "", 30)
						if tonumber(newscale) ~= nil then
							scale:RightLabel(newscale)
							blipchangesnew.scale = newscale
						else
							Config.Notify(framework_Locale("nonumber"))
						end
					end

					shortrange.CheckboxEvent = function(menu, item, checked)
						blipchangesnew.shortrange = checked
					end

					showblip.CheckboxEvent = function(menu, item, checked)
						blipchangesnew.showblip = checked
					end

					local confirm = _menuPool:AddSubMenu(createblip.SubMenu, framework_Locale("confirm"), "")
					confirm.Item:RightLabel(">")
					if middleitem then
						confirm.Item._Text.Padding = { X = 180 }
					end

					-- garage = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("Garage"), "")
					-- garageinfo = {} or json.decode(jobinfo).garage

					-- garageName = NativeUI.CreateItem(framework_Locale("garagename"), "")

					-- if doesgaragexist then
					-- 	garageName:RightLabel(garageinfo.name)
					-- end
					-- garageCoords = NativeUI.CreateItem(framework_Locale("garageCoords"), "")

					-- if doesgaragexist then
					-- 	garageCoords:RightLabel(VectorToString(vector3(garageinfo.x, garageinfo.y, garageinfo.z)))
					-- end
					-- garageSocietyName = NativeUI.CreateItem(framework_Locale("garageSocietyName"), "")

					-- garageMinGrade = NativeUI.CreateItem(framework_Locale("garageMinGrade"), "")
					-- changestuff.garage = {}
					-- if garageinfo then
					-- 	garageMinGrade(tostring(garageinfo.grade))
					-- end

					-- garageName.Activated = function(sender, index)
					-- 	local namee = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
					-- 	if namee then
					-- 		garageName:RightLabel(namee)
					-- 		print(namee)
					-- 		changestuff.garage.name = namee
					-- 	end
					-- end

					-- garageCoords.Activated = function(sender, index)
					-- 	local coords = functions_KeyBoardInput(framework_Locale("insertcoords"), "", 30)
					-- 	if coords then
					-- 		garageCoords:RightLabel(coords)
					-- 		changestuff.garage.coords = coords
					-- 	end
					-- end

					-- garageSocietyName.Activated = function(sender, index)
					-- 	local societyName = functions_KeyBoardInput(framework_Locale("insertsocietyname"), "", 30)
					-- 	if societyName then
					-- 		garageSocietyName:RightLabel(societyName)
					-- 		changestuff.garage.societyName = societyName
					-- 	end
					-- end

					-- garageMinGrade.Activated = function(sender, index)
					-- 	local minGrade = functions_KeyBoardInput(framework_Locale("insertmingrade"), "", 30)
					-- 	if tonumber(minGrade) ~= nil then
					-- 		garageMinGrade:RightLabel(minGrade)
					-- 		changestuff.garage.minGrade = minGrade
					-- 	else
					-- 		Config.Notify(framework_Locale("nonumber"))
					-- 	end
					-- end
					-- garage.SubMenu:AddItem(garageName)
					-- garage.SubMenu:AddItem(garageCoords)
					-- garage.SubMenu:AddItem(garageSocietyName)
					-- garage.SubMenu:AddItem(garageMinGrade)

					local yes = NativeUI.CreateItem(framework_Locale("yes"), "")
					confirm.SubMenu:AddItem(yes)
					yes.Activated = function(sender, index)
						TriggerServerEvent("ludaro_jobs:createbossblip", blipchangesnew)
						_menuPool:CloseAllMenus()
						openadminmenu()
					end

					jobmenu_deleteJob = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("deletejob"), "")
					if middleitem then
						jobmenu_deleteJob.Item._Text.Padding = { X = 180 }
					end

					jobmenu_deleteJob.Item:RightLabel(">")

					yes = NativeUI.CreateItem(framework_Locale("yes"), "")
					jobmenu_deleteJob.SubMenu:AddItem(yes)

					yes.Activated = function(sender, index)
						TriggerServerEvent("ludaro_jobs:deletejob", v.name)
						table.insert(deletedjobs, v.name)
						_menuPool:CloseAllMenus()
						openadminmenu()
					end

					confirm = _menuPool:AddSubMenu(jobsmenu.SubMenu, framework_Locale("confirm"), "")
					confirm.Item:RightLabel(">")
					if middleitem then
						confirm.Item._Text.Padding = { X = 180 }
					end

					yes = NativeUI.CreateItem(framework_Locale("yes"), "")
					confirm.SubMenu:AddItem(yes)
					-- here
					yes.Activated = function(sender, index)
						print(ESX.DumpTable(changestuff))
						for k, v in pairs(changestuff) do
							if ex(v.name) then
								TriggerServerEvent("ludaro_jobs:changename", v.job, v.name)
								Citizen.Wait(1000)
							end
							if ex(v.label) then
								TriggerServerEvent("ludaro_jobs:labelch", v.job, v.label)
								Citizen.Wait(1000)
							end
							if ex(v.whitelist) then
								TriggerServerEvent("ludaro_jobs:setwhitelist", v.job, v.whitelist)
								Citizen.Wait(1000)
							end
							if ex(v.bossmenu) then
								menuclosed = true
								TriggerServerEvent("ludaro_jobs:setbossmenu", v.job, v.bossmenu)
								Citizen.Wait(1000)
								Refresh_bossmenu()
							end
							if ex(v.markerred) then
								TriggerServerEvent("ludaro_jobs:setmarkerred", v.job, v.markerred)
								Citizen.Wait(1000)
							end
							if ex(v.markerblue) then
								TriggerServerEvent("ludaro_jobs:setmarkerblue", v.job, v.markerblue)
								Citizen.Wait(1000)
							end
							if ex(v.markergreen) then
								TriggerServerEvent("ludaro_jobs:setmarkergreen", v.job, v.markergreen)
								Citizen.Wait(1000)
							end
							if ex(v.markeralpha) then
								TriggerServerEvent("ludaro_jobs:setmarkeralpha", v.job, v.markeralpha)
								Citizen.Wait(1000)
							end
							if ex(v.markerid) then
								TriggerServerEvent("ludaro_jobs:setmarkerid", v.job, v.markerid)
								Citizen.Wait(1000)
							end
							if ex(v.markerbobupanddown) then
								TriggerServerEvent("ludaro_jobs:setmarkerbobupanddown", v.job, v.markerbobupanddown)
								Citizen.Wait(1000)
							end
							if ex(v.markerfacecamera) then
								TriggerServerEvent("ludaro_jobs:setmarkerfacecamera", v.job, v.markerfacecamera)
								Citizen.Wait(1000)
							end
							if ex(v.scalex) then
								TriggerServerEvent("ludaro_jobs:setmarkerscalex", v.job, v.scalex)
								Citizen.Wait(1000)
							end
							if ex(v.scaley) then
								TriggerServerEvent("ludaro_jobs:setmarkerscaley", v.job, v.scaley)
								Citizen.Wait(1000)
							end
							if ex(v.scalez) then
								TriggerServerEvent("ludaro_jobs:setmarkerscalez", v.job, v.scalez)
								Citizen.Wait(1000)
							end
							if ex(v.xoffset) then
								TriggerServerEvent("ludaro_jobs:setmarkerxoffset", v.job, v.xoffset)
								Citizen.Wait(1000)
							end
							if ex(v.yoffset) then
								TriggerServerEvent("ludaro_jobs:setmarkeryoffset", v.job, v.yoffset)
								Citizen.Wait(1000)
							end
							if ex(v.zoffset) then
								TriggerServerEvent("ludaro_jobs:setmarkerzoffset", v.job, v.zoffset)
								Citizen.Wait(1000)
							end
							if ex(v.markerenabled) then
								TriggerServerEvent("ludaro_jobs:setmarkerenabled", v.job, v.markerenabled)
								Citizen.Wait(1000)
							end
							if ex(v.xoffsetnpc) then
								TriggerServerEvent("ludaro_jobs:setxoffsetnpc", v.job, v.xoffsetnpc)
								Citizen.Wait(1000)
							end
							if ex(v.yoffsetnpc) then
								TriggerServerEvent("ludaro_jobs:setyoffsetnpc", v.job, v.yoffsetnpc)
								Citizen.Wait(1000)
							end
							if ex(v.zoffsetnpc) then
								TriggerServerEvent("ludaro_jobs:setzoffsetnpc", v.job, v.zoffsetnpc)
								Citizen.Wait(1000)
							end
							print(v.npcmodel)
							if ex(v.npcmodel) then
								TriggerServerEvent("ludaro_jobs:setnpcmodel", v.job, v.npcmodel)
								Citizen.Wait(1000)
							end
							if ex(v.npcheading) then
								TriggerServerEvent("ludaro_jobs:setnpcheading", v.job, v.npcheading)
								Citizen.Wait(1000)
							end
							if ex(v.npcenabled) then
								TriggerServerEvent("ludaro_jobs:setnpcenabled", v.job, v.npcenabled)
								Citizen.Wait(1000)
							end
							if ex(v.blipname) then
								TriggerServerEvent("ludaro_jobs:setbossblipname", v.job, v.blipname)
								Citizen.Wait(1000)
							end
							if ex(v.blipsprite) then
								TriggerServerEvent("ludaro_jobs:setbossblipsprite", v.job, v.blipsprite)
								Citizen.Wait(1000)
							end
							if ex(v.blipcolor) then
								TriggerServerEvent("ludaro_jobs:setbossblipcolor", v.job, v.blipcolor)
								Citizen.Wait(1000)
							end
							if ex(v.blipscale) then
								TriggerServerEvent("ludaro_jobs:setbossblipscale", v.job, v.blipscale)
								Citizen.Wait(1000)
							end
							if ex(v.blipshortrange) then
								TriggerServerEvent("ludaro_jobs:setbossblipshortrange", v.job, v.blipshortrange)
								Citizen.Wait(1000)
							end
							if ex(v.blipshowblip) then
								TriggerServerEvent("ludaro_jobs:setbossblipshowblip", v.job, v.blipshowblip)
								Citizen.Wait(1000)
							end
							if ex(v.minimumgrade) then
								TriggerServerEvent("ludaro_jobs:setbossminimumgrade", v.job, v.minimumgrade)
								Citizen.Wait(1000)
							end
							if ex(v.garage) then
								if ex(v.garage.name) then
									TriggerServerEvent("ludaro_jobs:setgaragename", v.job, v.garage.name)
								end
								if ex(v.garage.coords) then
									TriggerServerEvent("ludaro_jobs:setgaragecoords", v.job, v.garage.coords)
								end
								if ex(v.garage.societyName) then
									TriggerServerEvent("ludaro_jobs:setgaragesocietyname", v.job, v.garage.societyName)
								end
								if ex(v.garage.minGrade) then
									TriggerServerEvent("ludaro_jobs:setgaragemingrade", v.job, v.garage.minGrade)
								end
								if ex(v.garage.enabled) then
									TriggerServerEvent("ludaro_jobs:setgarageenabled", v.job, v.garage.enabled)
								end
							end
						end
						_menuPool:CloseAllMenus()
						openadminmenu()
						Refresh_bossmenu()
					end
				end
			end

			mainmenu:Visible(true)
			-- lib.hideTextUI()

			addjob = _menuPool:AddSubMenu(mainmenu, framework_Locale("addjob"), "")
			addjob.Item:RightLabel(">")
			-- to add new job
			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			name = NativeUI.CreateItem(framework_Locale("name"), "")
			addjob.SubMenu:AddItem(name)
			label = NativeUI.CreateItem(framework_Locale("label"), "")
			label.Activated = function(sender, index)
				newlabel = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
				if newlabel then
					label:RightLabel(newlabel)
				end
			end
			name.Activated = function(sender, index)
				newname = functions_KeyBoardInput(framework_Locale("insertname"), "", 30)
				if newname then
					name:RightLabel(newname)
				end
			end
			addjob.SubMenu:AddItem(label)
			isWhitelistedadd = NativeUI.CreateCheckboxItem(framework_Locale("whitelisted"), false, "")
			addjob.SubMenu:AddItem(isWhitelistedadd)

			grades = _menuPool:AddSubMenu(addjob.SubMenu, framework_Locale("grades"), "")
			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)

			grades.Item:RightLabel(">")
			jobmenu_addGrade = NativeUI.CreateItem(framework_Locale("addgrade"), "")

			grades.SubMenu:AddItem(jobmenu_addGrade)
			confirm = _menuPool:AddSubMenu(addjob.SubMenu, framework_Locale("confirm"), "")
			confirm.Item:RightLabel(">")

			_menuPool:RefreshIndex()
			_menuPool:MouseControlsEnabled(false)
			_menuPool:MouseEdgeEnabled(false)
			_menuPool:ControlDisablingEnabled(false)
			yes = NativeUI.CreateItem(framework_Locale("yes"), "")
			confirm.SubMenu:AddItem(yes)

			yes.Activated = function(sender, index)
				TriggerServerEvent("ludaro_jobs:createjob", newname, newlabel, gradess)
				--    Config.Notify(locale("success"))
				if newsocietymoney then
					TriggerServerEvent("ludaro_jobs:setsocietyaccount", v.name or newname, newsocietymoney)
				end
				_menuPool:CloseAllMenus()
				openadminmenu()
			end
		end
		gradess = {}
		jobmenu_addGrade.Activated = function(sender, index)
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

				local newGradeTable = {
					grade = 0,
					name = newgrade,
					label = newgradelabel,
					salary = 0,
					skin_male = {},
					skin_female = {},
				}
				table.insert(gradess, newGradeTable)

				createdItems = {}
				for k, v in pairs(gradess) do
					for k, v in pairs(gradess) do
						if not createdItems[v.name] then
							gradecreated = NativeUI.CreateItem(v.name .. " (" .. v.label .. ")", "")
							grades.SubMenu:AddItem(gradecreated)
							gradecreated:RightLabel(k - 1 .. " | " .. v.salary .. framework_Locale("$"))
							createdItems[v.name] = true
						end
					end
				end
			end
		end
	end
end
function functions_KeyBoardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry("FMMC_KEY_TIP1", TextEntry)
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

function ex(n)
	if n == nil then
		return false
	else
		return true
	end
end
function VectorToString(vector)
	if type(vector) == "vector3" then
		return "(" .. math.round(vector.x) .. ", " .. math.round(vector.y) .. ", " .. math.round(vector.z) .. ")"
	elseif type(vector) == "vector4" then
		return "("
			.. math.round(vector.x)
			.. ", "
			.. math.round(vector.y)
			.. ", "
			.. math.round(vector.z)
			.. ", "
			.. math.round(vector.w)
			.. ")"
	else
		return "NONE"
	end
end
