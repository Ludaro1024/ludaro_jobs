function doesJobExist(job)
    return lib.callback.await('ludaro_jobs:doesJobExist', false, job)
end

function getJobName(id)
    return lib.callback.await('ludaro_jobs:getJobName', false, id)
end

function getJobLabel(id)
    return lib.callback.await('ludaro_jobs:getJobLabel', false, id)
end

function getGradeName(id)
    return lib.callback.await('ludaro_jobs:getGradeName', false, id)
end

-- QUESTION: Why tf double functions?
function getGradeName(id)
    return lib.callback.await('ludaro_jobs:getGradelabel', false, id)
end

function getGrade(id)
    return lib.callback.await('ludaro_jobs:getGrade', false, id)
end

function getJobs()
    return lib.callback.await('ludaro_jobs:getJobs', false)
end

function getJobInfo(job)
    return lib.callback.await('ludaro_jobs:getJobInfo', false, job)
end
