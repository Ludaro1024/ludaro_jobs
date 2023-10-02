RegisterCommand(Config.Commands.interactions, function(_, _, _)
    local job = lib.callback.await('ludaro_jobs:getjobname', false)
    debug2(job)
    openInteractions(job)
end)

RegisterKeyMapping(Config.Commands.interactions, locale("interactions"), 'keyboard', Config.Keys.interactions)
