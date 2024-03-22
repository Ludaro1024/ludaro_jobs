function interactions_sql_getInteractions(name)
    local row = MySQL.single.await('SELECT interactions FROM jobs WHERE `name` = ? LIMIT 1', { name })
    print(row == "[]")
    if row == "[]" then
        return false
    else
        return row
    end
end

function interactions_sql_addInteractions(name, value)
    interactions = interactions_sql_getInteractions(name)
    print(interactions)
    if tonumber(interactions) ~= 0 or interactions == false or interactions == true or #interactions ~= 0 then
        local decodedInteractions = {} or json.decode(interactions)
        if not table.tableContains(decodedInteractions, value) then
            table.insert(decodedInteractions, value)
        end
        interactions = json.encode(decodedInteractions)
    else
        interactions = json.encode({ value })
    end
    print(" did it")
    print(ESX.DumpTable(interactions))
    print(name)
    MySQL.Async.execute('UPDATE jobs SET interactions = ? WHERE name = ?', { interactions, name })
end

function interactions_sql_removeInteractions(name, value)
    interactions = interactions_sql_getInteractions(name)
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

function interactions_sql_changeLabel(old_label, new_label)
    MySQL.Async.execute('UPDATE jobs SET label = ? WHERE label = ?', { new_label, old_label })

    ESX.RefreshJobs()
end

function interactions_sql_changeName(old_name, new_name)
    MySQL.Async.execute('UPDATE jobs SET name = ? WHERE name = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE job_grades SET job_name = ? WHERE job_name = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE users SET job = ? WHERE job = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE addon_account_data SET account_name = ? WHERE account_name = ?',
        { "society_" .. new_name, "society_" .. old_name })
    MySQL.Async.execute('UPDATE users SET job = ? WHERE job = ?', { new_name, old_name })
    MySQL.Async.execute('UPDATE ADDON_ACCOUNT SET NAME = ? WHERE NAME = ?', { SOCIETY_NEW_NAME, SOCIETY_OLD_NAME })
    MySQL.Async.execute('UPDATE JOB_GRADES SET JOB_NAME = ? WHERE JOB_NAME = ?', { NEW_NAME, OLD_NAME })
    MySQL.Async.execute('UPDATE datastore_data SET name = ? WHERE name = ?', { society_new_name, society_old_name })


    Citizen.Wait(2000)
    ESX.RefreshJobs()
end

function interactions_sql_changeGradeName(job, old_name, new_name, id)
    MySQL.Async.execute('UPDATE job_grades SET name = ? WHERE job_name = ? AND name = ?', { new_name, job, old_name })
    ESX.RefreshJobs()
end

function interactions_sql_changeGradeLabel(job, old_label, new_label, id)
    MySQL.Async.execute('UPDATE job_grades SET label = ? WHERE job_name = ? AND label = ?', { new_label, job, old_label })
    ESX.RefreshJobs()
end
