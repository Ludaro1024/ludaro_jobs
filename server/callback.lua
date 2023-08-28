
-- FRAMEWORK 
lib.callback.register('ludaro_jobs:getGroup', function(source)
    return getgroup(source)
end)
-- FRAMEWORK END

-- ADDONACCOUNT DATA
lib.callback.register('ludaro_jobs:getsocietyaccount', function(source, name)
    return getsocietyaccount(name)
end)

lib.callback.register('ludaro_jobs:setsocietyaccount', function(source, name, howmuch)
    return setsocietyaccount(name, howmuch)
end)

lib.callback.register('ludaro_jobs:addtosocietyaccount', function(source, name, howmuch)
    return addtosocietyaccount(name, howmuch)
end)


lib.callback.register('ludaro_jobs:takefromsocietyaccount', function(source, name, howmuch)
    return takefromsocietyaccount(name, howmuch)
end)
-- ADDON ACCOUNT DATA END


-- JOB STUFF
lib.callback.register('ludaro_jobs:doesjobexist', function(source, name)
    return lib.table.contains(ESX.GetJobs(), name)
end)


lib.callback.register('ludaro_jobs:getgrade', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.name
end)

lib.callback.register('ludaro_jobs:getjoblabel', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.name
end)

lib.callback.register('ludaro_jobs:getgradename', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.name
end)

lib.callback.register('ludaro_jobs:getjoblabel', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.name
end)

lib.callback.register('ludaro_jobs:getjobname', function(source, id)
    return ESX.GetPlayerFromId(id or source).job.name
end)

lib.callback.register('ludaro_jobs:getjobs', function(source, id)
    return ESX.GetJobs()
end)
-- JOB STUFF END


