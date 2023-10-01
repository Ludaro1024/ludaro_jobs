

function getalljobinfo()
    return lib.callback.await('ludaro_jobs:getalljobinfo', false)
end