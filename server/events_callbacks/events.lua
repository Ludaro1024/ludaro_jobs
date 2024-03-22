-- RegisterNetEvent('ludaro_jobs:refreshjobs')
-- AddEventHandler('ludaro_jobs:refreshjobs', function()
--     debug2("refreshing jobs", 2)
-- refreshjobs()
-- end)

RegisterNetEvent("ludaro_jobs:createjob")
AddEventHandler("ludaro_jobs:createjob", function(job_name, job_label, grade)
	consoleLog("creating job", 2)
	--(job_name, job_label, grade, source)
	jobmenu_createJob(job_name, job_label, grade, source)
end)

RegisterNetEvent("ludaro_jobs:deletejob")
AddEventHandler("ludaro_jobs:deletejob", function(job_name)
	consoleLog("deleting job", 2)
	jobmenu_deleteJob(job_name, source)
end)

RegisterNetEvent("ludaro_jobs:createsociety")
AddEventHandler("ludaro_jobs:createsociety", function(job_name)
	consoleLog("creating society..", 2)
	created = sql_createSociety(job_name, source)
	--(created)
end)

RegisterNetEvent("ludaro_jobs:addgrade")
AddEventHandler("ludaro_jobs:addgrade", function(job_name, grades)
	consoleLog("creating grade", 2)
	jobmenu_addGrade(job_name, grades, source)
end)

RegisterNetEvent("ludaro_jobs:deletegrade")
AddEventHandler("ludaro_jobs:deletegrade", function(job_name, grade_name)
	consoleLog("creating grade", 2)
	jobmenu_deleteGrade(job_name, grade_name, source)
end)

RegisterNetEvent("ludaro_jobs:changename")
AddEventHandler("ludaro_jobs:changename", function(old_name, new_name, grade)
	consoleLog("changing name", 2)
	if grade == nil then
		interactions_sql_changeName(old_name, new_name, source)
	else
		interactions_sql_changeGradeName(old_name, new_name, grade, source)
	end
end)

RegisterNetEvent("ludaro_jobs:labelch")
AddEventHandler("ludaro_jobs:labelch", function(old_label, new_label, grade)
	consoleLog("changing label", 2)
	if grade == nil then
		interactions_sql_changeLabel(old_label, new_label, source)
	else
		interactions_sql_changeGradeLabel(old_label, new_label, grade, source)
	end
end)

RegisterNetEvent("ludaro_jobs:setwhitelist")
AddEventHandler("ludaro_jobs:setwhitelist", function(jobname, value)
	--("ah")
	consoleLog("changing whitelist", 2)
	--(jobname, value)
	sql_setWhitelist(jobname, value)
end)

RegisterNetEvent("ludaro_jobs:setbossmenu")
AddEventHandler("ludaro_jobs:setbossmenu", function(job, value)
	consoleLog("changing bossmenu", 2)
	sql_setBossMenu(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerred")
AddEventHandler("ludaro_jobs:setmarkerred", function(job, value)
	consoleLog("changing marker red", 2)
	sql_setMarkerColor(job, value, nil, nil)
end)

RegisterNetEvent("ludaro_jobs:setmarkergreen")
AddEventHandler("ludaro_jobs:setmarkergreen", function(job, value)
	consoleLog("changing marker green", 2)
	sql_setMarkerColor(job, nil, value, nil)
end)

RegisterNetEvent("ludaro_jobs:setmarkerblue")
AddEventHandler("ludaro_jobs:setmarkerblue", function(job, value)
	consoleLog("changing marker blue", 2)
	sql_setMarkerColor(job, nil, nil, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkeralpha")
AddEventHandler("ludaro_jobs:setmarkeralpha", function(job, value)
	consoleLog("changing marker alpha", 2)
	sql_updateJobInfo(job, nil, nil, nil, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerid")
AddEventHandler("ludaro_jobs:setmarkerid", function(job, value)
	consoleLog("changing marker", 2)
	sql_setMarkerID(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerbobupanddown")
AddEventHandler("ludaro_jobs:setmarkerbobupanddown", function(job, value)
	consoleLog("changing marker bobupanddown", 2)
	sql_setMarkerBobUpAndDown(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerfacecamera")
AddEventHandler("ludaro_jobs:setmarkerfacecamera", function(job, value)
	consoleLog("changing marker facecamera", 2)
	sql_setMarkerFaceCamera(job, value)
end)

-- scalex
RegisterNetEvent("ludaro_jobs:setmarkerscalex")
AddEventHandler("ludaro_jobs:setmarkerscalex", function(job, value)
	consoleLog("changing marker scalex", 2)
	sql_setMarkerScaleX(job, value)
end)

-- scaley
RegisterNetEvent("ludaro_jobs:setmarkerscaley")
AddEventHandler("ludaro_jobs:setmarkerscaley", function(job, value)
	consoleLog("changing marker scaley", 2)
	sql_setMarkerScaleY(job, value)
end)

-- scalez
RegisterNetEvent("ludaro_jobs:setmarkerscalez")
AddEventHandler("ludaro_jobs:setmarkerscalez", function(job, value)
	consoleLog("changing marker scalez", 2)
	sql_setMarkerScaleZ(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerxoffset")
AddEventHandler("ludaro_jobs:setmarkerxoffset", function(job, value)
	consoleLog("changing marker xoffset", 2)
	sql_setMarkerXOffset(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkeryoffset")
AddEventHandler("ludaro_jobs:setmarkeryoffset", function(job, value)
	consoleLog("changing marker yoffset", 2)
	sql_setMarkerYOffset(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerzoffset")
AddEventHandler("ludaro_jobs:setmarkerzoffset", function(job, value)
	consoleLog("changing marker zoffset", 2)
	sql_setMarkerZOffset(job, value)
end)

RegisterNetEvent("ludaro_jobs:setmarkerenabled")
AddEventHandler("ludaro_jobs:setmarkerenabled", function(job, value)
	consoleLog("changing marker enabled", 2)
	sql_setMarkerEnabled(job, value)
end)

RegisterNetEvent("ludaro_jobs:setxoffsetnpc")
AddEventHandler("ludaro_jobs:setmarkerxoffsetnpc", function(job, value)
	consoleLog("changing marker xoffsetnpc", 2)
	setmarkerxoffsetnpc(job, value)
end)

RegisterNetEvent("ludaro_jobs:setyoffsetnpc")
AddEventHandler("ludaro_jobs:setmarkeryoffsetnpc", function(job, value)
	consoleLog("changing marker yoffsetnpc", 2)
	setmarkeryoffsetnpc(job, value)
end)

RegisterNetEvent("ludaro_jobs:setzoffsetnpc")
AddEventHandler("ludaro_jobs:setmarkerzoffsetnpc", function(job, value)
	consoleLog("changing marker zoffsetnpc", 2)
	setmarkerzoffsetnpc(job, value)
end)

RegisterNetEvent("ludaro_jobs:setnpcmodel")
AddEventHandler("ludaro_jobs:setnpcmodel", function(job, value)
	consoleLog("changing npc model", 2)
	sql_setNPCModel(job, value)
end)

RegisterNetEvent("ludaro_jobs:setnpcenabled")
AddEventHandler("ludaro_jobs:setnpcenabled", function(job, value)
	consoleLog("changing npc enabled", 2)
	sql_setNpcEnabled(job, value)
end)

-- "ludaro_jobs:setnpcheading
RegisterNetEvent("ludaro_jobs:setnpcheading")
AddEventHandler("ludaro_jobs:setnpcheading", function(job, value)
	consoleLog("changing npc heading", 2)
	sql_setNpcHeading(job, value)
end)

RegisterNetEvent("ludaro_jobs:setgaragename")
AddEventHandler("ludaro_jobs:setgaragename", function(job, value)
	consoleLog("changing garage name", 2)
	sql_setGarageName(job, value)
end)

RegisterNetEvent("ludaro_jobs:setgarageenabled")
AddEventHandler("ludaro_jobs:setgarageenabled", function(job, value)
	consoleLog("changing garage enabled", 2)
	sql_setGarageEnabled(job, value)
end)

RegisterNetEvent("ludaro_jobs:setgaragemingrade")
AddEventHandler("ludaro_jobs:setgaragemingrade", function(job, value)
	consoleLog("changing garage min grade", 2)
	sql_setGarageMinGrade(job, value)
end)

RegisterNetEvent("ludaro_jobs:setgaragesocietyname")
AddEventHandler("ludaro_jobs:setgaragesocietyname", function(job, value)
	consoleLog("changing garage society name", 2)
	sql_setGarageSocietyName(job, value)
end)

RegisterNetEvent("ludaro_jobs:setgaragecoords")
AddEventHandler("ludaro_jobs:setgaragecoords", function(job, value)
	consoleLog("changing garage coords", 2)
	sql_setGarageCoords(job, value)
end)

RegisterNetEvent("ludaro_jobs:promote")
AddEventHandler("ludaro_jobs:promote", function(identifier, value)
	xPlayer = framework_getPlayer(identifier)
	xPlayer.setJob(xPlayer.job.name, xPlayer.job.grade + 1)
end)

RegisterNetEvent("ludaro_jobs:demote")
AddEventHandler("ludaro_jobs:demote", function(identifier, value)
	xPlayer = framework_getPlayer(identifier)
	xPlayer.setJob(xPlayer.job.name, xPlayer.job.grade - 1)
end)

RegisterNetEvent("ludaro_jobs:kick")
AddEventHandler("ludaro_jobs:kick", function(identifier)
	xPlayer = framework_getPlayer(identifier)
	xPlayer.setJob("unemployed", 0)
end)

--TriggerServerEvent("ludaro_jobs:changegrade", v.identifier, newgrade)
RegisterNetEvent("ludaro_jobs:changegrade")
AddEventHandler("ludaro_jobs:changegrade", function(identifier, value)
	xPlayer = framework_getPlayer(identifier)
	xPlayer.setJob(xPlayer.job.name, value)
end)

-- RegisterNetEvent('ludaro_jobs:createblip')
-- AddEventHandler('ludaro_jobs:createblip', function(job, value)

-- end)

-- RegisterNetEvent('ludaro_jobs:deleteblip')
-- AddEventHandler('ludaro_jobs:deleteblip', function(job, value)

-- end)

-- RegisterNetEvent('ludaro_jobs:deletebossblip')
-- AddEventHandler('ludaro_jobs:deletebossblip', function(job)

-- end)

-- RegisterNetEvent('ludaro_jobs:createbossblip')
-- AddEventHandler('ludaro_jobs:createbossblip', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:createbossblip')
-- AddEventHandler('ludaro_jobs:createbossblip', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossblipname')
-- AddEventHandler('ludaro_jobs:setbossblipname', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossblipsprite')
-- AddEventHandler('ludaro_jobs:setbossblipsprite', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossblipcolor')
-- AddEventHandler('ludaro_jobs:setbossblipcolor', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossblipscale"')
-- AddEventHandler('ludaro_jobs:setbossblipscale"', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossblipshortrange')
-- AddEventHandler('ludaro_jobs:setbossblipshortrange', function(job, values)

-- end)
-- RegisterNetEvent('ludaro_jobs:setbossblipshowblip')
-- AddEventHandler('ludaro_jobs:setbossblipshowblip', function(job, values)

-- end)

-- RegisterNetEvent('ludaro_jobs:setbossminimumgrade')
-- AddEventHandler('ludaro_jobs:setbossminimumgrade', function(job, values)

-- end)
