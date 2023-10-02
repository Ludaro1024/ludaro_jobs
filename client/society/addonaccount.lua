lib = lib or {}
function getSocietyAccount(name)
    local count = lib.callback.await('ludaro_jobs:getSocietyAccount', false, name) or 0
    return count
end

function setSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:setSocietyAccount', false, name, howmuch) or 0
    return count
end

function addToSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:addToSocietyAccount', false, name, howmuch) or 0
    return count
end

function takeFromSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:takeFromSocietyAccount', false, name, howmuch) or 0
    return count
end
