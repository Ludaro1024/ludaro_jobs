function jobmenu_createJob(name, label, grades, id)
    if name == nil or label == nil then
        Config.Notify(framework_Locale("errorjob"), id)
        return
    else
        if grades == nil or (type(grades) == 'table' and not next(grades)) then
            grades = {
                {
                    grade = 0,
                    name = name .. '_0',
                    label = label .. '_0',
                    salary = 0,
                    skin_male = {},
                    skin_female = {}
                }
            }
        end
        shark = MySQL.insert.await('INSERT INTO `jobs` (name, label) VALUES (?, ?)', {
            name, label
        })

        for k, v in pairs(grades) do
            -- local sqlQuery = "INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (?, ?, ?, ?, ?, ?, ?)"
            -- MySQL.Async.execute(sqlQuery, {name, v.grade, v.name, v.label, v.salary, json.encode(v.skin_male), json.encode(v.skin_female)})
            gradess = MySQL.insert.await(
                'INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (?, ?, ?, ?, ?, ?, ?)',
                {
                    name, v.grade, v.name, v.label, v.salary, json.encode(v.skin_male), json.encode(v.skin_female)
                })
        end
        print(id, gradess)
        if shark or grades then
            Config.Notify(framework_Locale("success"), id)
        else
            Config.Notify(framework_Locale("errorjob"), id)
        end
    end
end

-- function refreshjobs()
--     ESX.RefreshJobs()
-- end

function cb_getJobs()
    local sqlQuery = "SELECT * FROM jobs"
    local result = MySQL.Sync.fetchAll(sqlQuery, {})

    for k, v in pairs(result) do
        local jobGradesQuery = "SELECT * FROM job_grades WHERE job_name = ?"
        local jobGrades = MySQL.Sync.fetchAll(jobGradesQuery, { v.name })
        v.grades = jobGrades
    end

    return result
end

function jobmenu_addGrade(job_name, grades, id)
    print(ESX.DumpTable(grades))
    print(job_name)
    gradess = MySQL.insert.await(
        'INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (?, ?, ?, ?, ?, ?, ?)',
        {
            job_name, grades.id, grades.name, grades.label, grades.salary, json.encode(grades.skin_male),
            json.encode(grades.skin_female)
        })

    if gradess then
        print(gradess)
        Config.Notify(framework_Locale("success"), id)
    else
        Config.Notify(framework_Locale("errorjob"), id)
    end
end

function jobmenu_deleteGrade(job_name, grade_name, id)
    print(job_name, grade_name)
    local sqlQuery = "DELETE FROM job_grades WHERE job_name = ? AND name = ?"
    local queries = {
        { query = sqlQuery, values = { job_name, grade_name } },
    }

    MySQL.Async.transaction(queries, function(status)
        if status then
            consoleLog("deletedjob with the name " .. job_name, 2)
            print(status)
            Config.Notify(framework_Locale("success"), id)
        else
            consoleLog('Transaction failed!')
            Config.Notify(framework_Locale("errorjob"), id)
        end
    end)
end

function jobmenu_deleteJob(name, id)
    societyname = string.find(name, "society_") and name or "society_" .. name
    print("deletejob with name" .. name)
    local sqlQuery = "DELETE FROM jobs WHERE name = ?"
    local sqlQuery2 = "DELETE FROM job_grades WHERE job_name = ?"
    local sqlQuery3 = "UPDATE users SET job = 'unemployed' WHERE job = ?"

    local sqlQuary4 = "DELETE FROM addon_account_data WHERE account_name = ?"

    local queries = {
        { query = sqlQuery,  values = { name } },
        { query = sqlQuery2, values = { name, } },
        { query = sqlQuery3, values = { name } },
        { query = sqlQuary4, values = { societyname } }
    }

    MySQL.Async.transaction(queries, function(status)
        if status then
            consoleLog("deletedjob with the name" .. name, 2)
            Config.Notify(framework_Locale("success"), id)
        else
            consoleLog('Transaction failed!')
            Config.Notify(framework_Locale("errorjob"), id)
        end
    end)
end

function jobmenu_changeNameGrade(old_name, new_name, id)
    local sqlQuery = "UPDATE job_grades SET name = ? WHERE name = ?"
    local queries = {
        { query = sqlQuery, values = { new_name, old_name } },
    }

    MySQL.Async.transaction(queries, function(status)
        if status then
            consoleLog("changed name from " .. old_name .. " to " .. new_name, 2)
            Config.Notify(framework_Locale("success"), id)
        else
            consoleLog('Transaction failed!')
            Config.Notify(framework_Locale("errorjob"), id)
        end
    end)
end

function jobmenu_changeLabelGrade(old_label, new_label, id)
    local sqlQuery = "UPDATE job_grades SET label = ? WHERE label = ?"
    local queries = {
        { query = sqlQuery, values = { new_label, old_label } },
    }

    MySQL.Async.transaction(queries, function(status)
        if status then
            consoleLog("changed label from " .. old_label .. " to " .. new_label, 2)
            Config.Notify(framework_Locale("success"), id)
        else
            consoleLog('Transaction failed!')
            Config.Notify(framework_Locale("errorjob"), id)
        end
    end)
end
