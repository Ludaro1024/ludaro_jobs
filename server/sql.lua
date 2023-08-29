if Config.AutoSQL then
    -- addon_account_data
    MySQL.ready(function()
        MySQL.Async.execute('CREATE TABLE IF NOT EXISTS addon_account_data (id INT AUTO_INCREMENT PRIMARY KEY, account_name VARCHAR(255), money INT, owner VARCHAR(255))', {})
    end)
end

-- ADDON ACCOUNT DATA
function getsocietyaccount(name)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', {name})
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
    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', {name})
    if row then
        return false
    else
        result = MySQL.insert.await('INSERT INTO addon_account_data (account_name, money, owner) VALUES (@account_name, @money, @owner)', {
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


function setsocietyaccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?', {howmuch, name})
    print(result)
    return result or false
end

function addtosocietyaccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', {name})
    if not row then return false end

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?', {row.money + howmuch, name})
    return result or false
end

function takefromsocietyaccount(name, howmuch)
    name = string.find(name, "society_") and name or "society_" .. name

    local row = MySQL.single.await('SELECT * FROM addon_account_data WHERE `account_name` = ? LIMIT 1', {name})
    if not row then return false end

    local result = MySQL.update.await('UPDATE addon_account_data SET money = ? WHERE account_name = ?', {row.money - howmuch, name})
    return result or false
end

-- ADDON ACCOUNT DATA END


function getjob(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local identifier = xPlayer.getIdentifier()
    local row = MySQL.single.await('SELECT * FROM users WHERE `identifier` = ? LIMIT 1', {identifier})
    if row then
        return row.job or false
    else
        return xPlayer.job.name or false
    end
end

