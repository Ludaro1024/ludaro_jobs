lib = lib or {}
function getsocietyaccount(name)
    local count = lib.callback.await('ludaro_jobs:getsocietyaccount', false, name) or 0
return count
end

function setsocietyaccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:setsocietyaccount', false, name, howmuch) or 0
    return count
end

function addtosocietyaccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:addtosocietyaccount', false, name, howmuch) or 0
    return count
end

function takefromsocietyaccount(name, howmuch)
    local count = lib.callback.await('ludaro_jobs:takefromsocietyaccount', false, name, howmuch) or 0
    return count
end



