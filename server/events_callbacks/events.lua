-- RegisterNetEvent('ludaro_jobs:refreshjobs')
-- AddEventHandler('ludaro_jobs:refreshjobs', function()
--     debug2("refreshing jobs", 2)
-- refreshjobs()
-- end)

RegisterNetEvent('ludaro_jobs:createjob')
AddEventHandler('ludaro_jobs:createjob', function(job_name, job_label, grade)
    debug2("creating job", 2)
    print(job_name, job_label, grade, source)
    createjob(job_name, job_label, grade, source)
end)

RegisterNetEvent('ludaro_jobs:deletejob')
AddEventHandler('ludaro_jobs:deletejob', function(job_name)
    debug2("deleting job", 2)
deletejob(job_name, source)
end)

RegisterNetEvent('ludaro_jobs:createsociety')
AddEventHandler('ludaro_jobs:createsociety', function(job_name)
    debug2("creating society..", 2)
created = createsociety(job_name, source)
print(created)
end)

RegisterNetEvent('ludaro_jobs:addgrade')
AddEventHandler('ludaro_jobs:addgrade', function(job_name, grades)
    debug2("creating grade", 2)
addgrade(job_name, grades, source)
end)

RegisterNetEvent('ludaro_jobs:deletegrade')
AddEventHandler('ludaro_jobs:deletegrade', function(job_name, grade_name)
    debug2("creating grade", 2)
deletegrade(job_name, grade_name, source)
end)


RegisterNetEvent('ludaro_jobs:changename')
AddEventHandler('ludaro_jobs:changename', function(old_name, new_name, grade)
    debug2("changing name", 2)
    if grade == nil then
changename(old_name, new_name, source)
    else
        changegradename(old_name, new_name, grade, source)
    end
end)

RegisterNetEvent('ludaro_jobs:labelch')
AddEventHandler('ludaro_jobs:labelch', function(old_label, new_label, grade)
    debug2("changing label", 2)
    if grade == nil then
changelabel(old_label, new_label, source)
    else
        changegradelabel(old_label, new_label, grade, source)
    end
end)


RegisterNetEvent('ludaro_jobs:setwhitelist')
AddEventHandler('ludaro_jobs:setwhitelist', function(jobname, value)
    print("ah")
    debug2("changing whitelist", 2)
    print(jobname, value)
    setwhitelist(jobname, value)
end)

RegisterNetEvent('ludaro_jobs:setbossmenu')
AddEventHandler('ludaro_jobs:setbossmenu', function(job, value)
    debug2("changing bossmenu", 2)
    setbossmenu(job, value)
end)