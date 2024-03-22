lib = lib or {}
function cb_getSocietyAccount(name)
    local count = lib.callback.await('ludaro_jobs:getsocietyaccount', false, name) or 0
    return count
end

function cb_setSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:setsocietyaccount', false, name, howmuch) or 0
    return count
end

function cb_AddSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:addtosocietyaccount', false, name, howmuch) or 0
    return count
end

function cb_takeFromSocietyAccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:takefromsocietyaccount', false, name, howmuch) or 0
    return count
end
