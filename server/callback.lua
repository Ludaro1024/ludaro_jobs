
-- FRAMEWORK 

lib.callback.register('ludaro_jobs:getGroup', function(source)
    return getgroup(source)
end)

-- FRAMEWORK END

-- ADDONACCOUNT DATA
lib.callback.register('ludaro_jobs:getsocietyaccount', function(source, name)
    return getsocietyaccount(name)
end)

lib.callback.register('ludaro_jobs:setsocietyaccount', function(source, name, howmuch)
    return setsocietyaccount(name, howmuch)
end)

lib.callback.register('ludaro_jobs:addtosocietyaccount', function(source, name, howmuch)
    return addtosocietyaccount(name, howmuch)
end)


lib.callback.register('ludaro_jobs:takefromsocietyaccount', function(source, name, howmuch)
    return takefromsocietyaccount(name, howmuch)
end)

-- ADDON ACCOUNT DATA END