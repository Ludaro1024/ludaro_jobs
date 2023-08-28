function createjob(name, label, grades, id)
    if name == nil or label == nil then
       Config.Notify(locale("errorjob"), id)
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
    Config.Notify(locale("success"), id)
    ESX.CreateJob(name, label, grades)
end
end



function refreshjobs()
    ESX.RefreshJobs()
end


function addgrade()
end

function deletejob(name)

    -- YOUR_CODE
    print("deletejob with name" .. name)
    local sqlQuery = "DELETE FROM jobs WHERE NAME = ?"
    local sqlQuery2 = "DELETE FROM job_grades WHERE job_name = ?"
    MySQL.Async.execute(sqlQuery, {name})
    MySQL.Async.execute(sqlQuery2, {name})
    refreshjobs()


end