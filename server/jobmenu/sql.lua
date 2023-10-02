-- ADDON ACCOUNT DATA
function getSocietyAccount(name)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', { name })
    if row then
        return row.money, row.owner, row.account_name or 0
    else
        return false
    end
end

function createsociety(name, ownerid)
    name = string.find(name, "society_") and name or "society_" .. name
    print(ownerid)
    if ownerid ~= nil then
        local xPlayer = ESX.GetPlayerFromId(ownerid)
        owner = xPlayer.getIdentifier()
        -- print(owner)
    else
        owner = nil
    end
    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', { name })
    if row then
        return false
    else
        result = MySQL.insert.await(
            'INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, @owner)', {
                ['@account_name'] = name,
                ['@money'] = 0,
                ['@owner'] = owner
            })
        while result == nil do
            Citizen.Wait(1000)
            --    print("ah..")
        end
        return result
    end
end

function setSocietyAccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?', { howmuch, name })
    print(result)
    return result or false
end

function addToSocietyAccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', { name })
    if not row then return false end

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?',
        { row.money + howmuch, name })
    return result or false
end

function takeFromSocietyAccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', { name })
    if not row then return false end

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?',
        { row.money - howmuch, name })
    return result or false
end

-- ADDON ACCOUNT DATA END


function getjob(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local identifier = xPlayer.getIdentifier()
    local row = MySQL.single.await('SELECT * FROM users WHERE `identifier` = ? LIMIT 1', { identifier })
    if row then
        return row.job or false
    else
        return xPlayer.job.name or false
    end
end

function getwhitelist(jobname)
    local row = MySQL.single.await('SELECT * FROM jobs WHERE `name` = ? LIMIT 1', { jobname })
    if row then
        return row.whitelisted
    else
        return false
    end
end

function setwhitelist(jobname, value)
    local row = MySQL.single.await('SELECT * FROM jobs WHERE `label` = ? LIMIT 1', { jobname })
    if row then
        vaLue = false
        local result = MySQL.update.await('UPDATE jobs SET whitelisted = ? WHERE label = ?', { value, jobname })
        print(result)
        return result or false
    else
        return false
    end
end

function getjobinfo(job)
    local row = MySQL.single.await('SELECT ludaro_jobs_info FROM jobs WHERE `label` = ? LIMIT 1', { job })
    if row then
        return row.ludaro_jobs_info
    else
        return false
    end
end

function setbossmenu(job, value)
    local row = MySQL.single.await('SELECT * FROM jobs WHERE `label` = ? LIMIT 1', { job })
    if row then
        if row.ludaro_jobs_info then
            local ludaro_jobs_info = json.decode(row.ludaro_jobs_info)
            ludaro_jobs_info.bossmenu = value
            local result = MySQL.update.await('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?',
                { json.encode(ludaro_jobs_info), job })

            return result or false
        else
            local result = MySQL.update.await('UPDATE jobs SET ludaro_jobs_info = ? WHERE label = ?',
                { json.encode({ bossmenu = value }), job })

            return result or false
        end
    else
        return false
    end
end

function getalljobinfo()

end
