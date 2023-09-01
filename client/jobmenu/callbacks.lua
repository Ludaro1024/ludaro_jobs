function doesjobexist(job)
    return lib.callback.await('ludaro_jobs:doesjobexist', false, job)
end

function getjobname(id)
    return lib.callback.await('ludaro_jobs:getjobname', false, id)
end

function getjoblabel(id)
    return lib.callback.await('ludaro_jobs:getjoblabel', false, id)
end

function getgradename(id)
    return lib.callback.await('ludaro_jobs:getgradename', false, id)
end

function getgradename(id)
    return lib.callback.await('ludaro_jobs:getgradelabel', false, id)
end

function getgrade(id)
    return lib.callback.await('ludaro_jobs:getgrade', false, id)
end

function getjobs()
    return lib.callback.await('ludaro_jobs:getjobs', false)
end

function getjobinfo(job)
    return lib.callback.await('ludaro_jobs:getjobinfo', false, job)
end