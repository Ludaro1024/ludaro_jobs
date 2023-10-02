function getAllJobInfo()
    return lib.callback.await('ludaro_jobs:getAllJobInfo', false)
end
