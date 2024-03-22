-- FRAMEWORK
lib.callback.register("ludaro_jobs:getGroup", function(source)
	return framework_cb_getGroup(source)
end)

lib.callback.register("ludaro_jobs:getjobframework", function(source, job)
	if job then
		return Callback_Framework_GetJobData(job)
	else
		return framework_cb_getJob(source)
	end
end)
-- FRAMEWORK END

-- ADDONACCOUNT DATA
lib.callback.register("ludaro_jobs:getsocietyaccount", function(source, name)
	return cb_getSocietyAccount(name)
end)

lib.callback.register("ludaro_jobs:setsocietyaccount", function(source, name, howmuch)
	return cb_setSocietyAccount(name, howmuch)
end)

lib.callback.register("ludaro_jobs:addtosocietyaccount", function(source, name, howmuch)
	return cb_AddSocietyAccount(name, howmuch)
end)

lib.callback.register("ludaro_jobs:takefromsocietyaccount", function(source, name, howmuch)
	return cb_takeFromSocietyAccount(name, howmuch)
end)
-- ADDON ACCOUNT DATA END

-- JOB STUFF
lib.callback.register("ludaro_jobs:doesjobexist", function(source, name)
	return lib.table.contains(ESX.GetJobs(), name)
end)

lib.callback.register("ludaro_jobs:getgrade", function(source, id)
	return framework_getPlayer(id or source).job.grade
end)

lib.callback.register("ludaro_jobs:getjoblabel", function(source, id)
	return framework_getPlayer(id or source).job.label
end)

lib.callback.register("ludaro_jobs:getgradename", function(source, id)
	return framework_getPlayer(id or source).job.grade_name
end)

lib.callback.register("ludaro_jobs:getplayermoney", function(source, id)
	return framework_getPlayer(id or source).getMoney()
end)

lib.callback.register("ludaro_jobs:getjobname", function(source, id)
	return sql_getJob(source or id)
end)

lib.callback.register("ludaro_jobs:getjobs", function(source, id)
	jobs = cb_getJobs()
	for k, v in pairs(jobs) do
		v.whitelist = false or sql_getWhitelist(v.name)
		v.society = false or cb_getSocietyAccount(v.name)
		v.jobinfo = Callback_Framework_GetJobInfo(v.label)
	end

	return jobs
end)
-- JOB STUFF END

-- INTERACTIONS
lib.callback.register("ludaro_jobs:getinteractions", function(source, job)
	return interactions_sql_getInteractions(job)
end)

lib.callback.register("ludaro_jobs:getwhitelist", function(source, job)
	return sql_getWhitelist(job)
end)

lib.callback.register("ludaro_jobs:getjobinfo", function(source, job)
	if job == nil then
		job = sql_getJob(source)
	end

	return Callback_Framework_GetJobInfo(job), framework_getPlayer(source).job
end)

lib.callback.register("ludaro_jobs:getalljobinfo", function(source)
	return sql_getAllJobInfo(), framework_getPlayer(source).job
end)

lib.callback.register("ludaro_jobs:getjobmembers", function(source, job)
	playerstable = {}

	players = ESX.GetExtendedPlayers("job", job)

	for k, v in pairs(players) do
		table.insert(
			playerstable,
			{ grade = v.getJob().grade, job = v.getJob().name, identifier = v.identifier, name = v.getName() }
		)
	end
	return playerstable
end)

lib.callback.register("ludaro_jobs:getplayerdata", function(source, id)
	playerstable = {}
	xPlayer = framework_getPlayer(id)
	table.insert(
		playerstable,
		{ grade = xPlayer.job.grade, job = xPlayer.job.name, identifier = xPlayer.identifier, name = xPlayer.getName() }
	)
	return playerstable
end)

lib.callback.register("ludaro_jobs:getnearestplayers", function(source, players)
	nearbyplayers = {}

	for k, v in pairs(players) do
		xPlayer = framework_getPlayer(v)
		table.insert(
			nearbyplayers,
			{
				grade = xPlayer.job.grade,
				job = xPlayer.job.name,
				identifier = xPlayer.identifier,
				name = xPlayer.getName(),
			}
		)
	end

	return nearbyplayers
end)
