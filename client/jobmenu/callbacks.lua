function cb_doesJobExist(job)
    return lib.callback.await('ludaro_jobs:doesjobexist', false, job)
end

function cb_getJobName(id)
    return lib.callback.await('ludaro_jobs:getjobname', false, id)
end

function cb_getJobLabel(id)
    return lib.callback.await('ludaro_jobs:getjoblabel', false, id)
end

function cb_getGradeName(id)
    return lib.callback.await('ludaro_jobs:getgradename', false, id)
end

function cb_getGradeLabel(id)
    return lib.callback.await('ludaro_jobs:getgradelabel', false, id)
end

function cb_getGrade(id)
    return lib.callback.await('ludaro_jobs:getgrade', false, id)
end

function cb_getJobs()
    return lib.callback.await('ludaro_jobs:getjobs', false)
end

function Callback_Framework_GetJobInfo(job)
    return lib.callback.await('ludaro_jobs:getjobinfo', false, job)
end
