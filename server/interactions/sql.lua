

function getinteractions(name)
    local row = MySQL.single.await('SELECT * FROM jobs WHERE `name` = ? LIMIT 1', { name })
    if row then
        return row.interactions or 0
    else
        return false
    end
end

function addinteractions(name, value)
    interactions = getinteractions(name)
    if tonumber(interactions) ~= 0 or interactions == false or interactions == true then
        local decodedInteractions = json.decode(interactions)
        if not table.contains(decodedInteractions, value) then
            table.insert(decodedInteractions, value)
        end
        interactions = json.encode(decodedInteractions)
    else
        interactions = json.encode({ value })
    end
    MySQL.Async.execute('UPDATE jobs SET interactions = ? WHERE name = ?', { interactions, name })
end


function removeinteractions(name, value)
    interactions = getinteractions(name)
    if value == "all" then
        interactions = json.encode({})
    else
        if interactions then
            local decodedInteractions = json.decode(interactions)
            for k, v in pairs(decodedInteractions) do
                if v == value then
                    table.remove(decodedInteractions, k)
                end
            end
            interactions = json.encode(decodedInteractions)
        else
            interactions = json.encode({})
        end
    end
    MySQL.Async.execute('UPDATE jobs SET interactions = ? WHERE name = ?', { interactions, name })
    
end


function changelabel(old_label, new_label)
    MySQL.Async.execute('UPDATE jobs SET label = ? WHERE label = ?', { new_label, old_label })
   
    ESX.RefreshJobs()
end

function changename(old_name, new_name)
    MySQL.Async.execute('UPDATE jobs SET name = ? WHERE name = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE job_grades SET job_name = ? WHERE job_name = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE users SET job = ? WHERE job = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE addon_account_data SET account_name = ? WHERE account_name = ?', { "society_"..new_name, "society_"..old_name })
    MySQL.Async.execute('UPDATE users SET job = ? WHERE job = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE ADDON_ACCOUNT SET NAME = ? WHERE NAME = ?', { SOCIETY_NEW_NAME, SOCIETY_OLD_NAME })
    MySQL.Async.execute('UPDATE JOB_GRADES SET JOB_NAME = ? WHERE JOB_NAME = ?', { NEW_NAME, OLD_NAME })
    MySQL.Async.execute('UPDATE datastore_data SET name = ? WHERE name = ?', { society_new_name, society_old_name })

    
Citizen.Wait(2000)
    ESX.RefreshJobs()
end


function changegradename(job, old_name, new_name, id)
    MySQL.Async.execute('UPDATE job_grades SET name = ? WHERE job_name = ? AND name = ?', { new_name, job, old_name })
    ESX.RefreshJobs()
end

function changegradelabel(job, old_label, new_label, id)
    MySQL.Async.execute('UPDATE job_grades SET label = ? WHERE job_name = ? AND label = ?', { new_label, job, old_label })
    ESX.RefreshJobs()
end

