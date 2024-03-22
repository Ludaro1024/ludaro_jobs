function Callback_Framework_GetJobInfo()
    local info, job = lib.callback.await('ludaro_jobs:getjobinfo', false)
    return info, job
end

function Callback_Framework_GetPlayerJobData()
    local job = lib.callback.await('ludaro_jobs:getjobframework', false)
    return job.name
end

function Callback_Framework_GetJobData(job)
    local jobdata = lib.callback.await('ludaro_jobs:getjobs', false)
    for k, v in pairs(jobdata) do
        if v.name == job then
            return v
        end
    end
end

function Callback_Framework_GetJobMembers(job)
    return lib.callback.await('ludaro_jobs:getjobmembers', false, job)
end

function Callback_FrameWork_GetJobGrade()
    return lib.callback.await('ludaro_jobs:getgrade', false)
end

function Callback_Framework_GetPlayerMoney()
    return lib.callback.await('ludaro_jobs:getplayermoney', false)
end

function Callback_Framework_GetNearestPlayers()
    local coords = GetEntityCoords(PlayerPedId())
    local players = ESX.Game.GetPlayersInArea(coords, 10)
    return lib.callback.await('ludaro_jobs:getnearestplayers', false, players)
end

function Callback_Job_GetSociety(job)
    return lib.callback.await('ludaro_jobs:getsocietyaccount', false, job)
end

function Callback_Job_AddToSociety(job, money)
    return lib.callback.await('ludaro_jobs:addtosocietyaccount', false, job, money)
end

function Callback_Job_RemoveFromSociety(job, money)
    return lib.callback.await('ludaro_jobs:takefromsocietyaccount', false, job, money)
end

function Callback_Framework_GetJobGrade()
    return lib.callback.await('ludaro_jobs:getgrade', false)
end
