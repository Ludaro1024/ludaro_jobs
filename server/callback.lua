-- FRAMEWORK
lib.callback.register('ludaro_jobs:getGroup', function(source)
    return getGroup(source)
end)
-- FRAMEWORK END

-- ADDONACCOUNT DATA
lib.callback.register('ludaro_jobs:getSocietyAccount', function(source, name)
    return getSocietyAccount(name)
end)

lib.callback.register('ludaro_jobs:setSocietyAccount', function(source, name, howmuch)
    return setSocietyAccount(name, howmuch)
end)

lib.callback.register('ludaro_jobs:addToSocietyAccount', function(source, name, howmuch)
    return addToSocietyAccount(name, howmuch)
end)


lib.callback.register('ludaro_jobs:takeFromSocietyAccount', function(source, name, howmuch)
    return takeFromSocietyAccount(name, howmuch)
end)
-- ADDON ACCOUNT DATA END


-- JOB STUFF
lib.callback.register('ludaro_jobs:doesJobExist', function(source, name)
    return lib.table.contains(ESX.getJobs(), name)
end)


lib.callback.register('ludaro_jobs:getGrade', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.grade
end)

lib.callback.register('ludaro_jobs:getJobLabel', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.label
end)

lib.callback.register('ludaro_jobs:getGradeName', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.grade_name
end)

lib.callback.register('ludaro_jobs:getJobName', function(source, id)
    return getjob(source or id)
end)

lib.callback.register('ludaro_jobs:getJobs', function(source, id)
    return getJobs()
end)
-- JOB STUFF END

-- INTERACTIONS
lib.callback.register('ludaro_jobs:getinteractions', function(source, job)
    return getinteractions(job)
end)

lib.callback.register('ludaro_jobs:getwhitelist', function(source, job)
    return getwhitelist(job)
end)

lib.callback.register('ludaro_jobs:getbossmenu', function(source, job, value)
    return getbossmenu(job)
end)
