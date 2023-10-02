function debug2(msg, level)
    level = level or 1
    if Config.Debug >= level then
        local lineInfo = debug.getinfo(2, "Sl")
        local lineStr = ""
        if lineInfo then
            lineStr = " (" .. lineInfo.source .. ":" .. lineInfo.currentline .. ")"
        end

        if msg == nil then
            print("[Ludaro|Debug]" .. lineStr .. ": nil")
        elseif type(msg) == "table" then
            print("[Ludaro|Debug]" .. lineStr .. ":")
            print(ESX.DumpTable(msg))
        else
            print("[Ludaro|Debug]" .. lineStr .. ": " .. tostring(msg))
        end
    end
end

print("Ludaro Debugging Loaded check readme for debug commands and prints!")

-- addonaccount
if Config.Debug >= 2 then
    print("added command /getSocietyAccount [account_name]")
    print("added command /setSocietyAccount [name] [amount]")
    print("added command /addToSocietyAccount [name] [amount]")
    print("added command /takeFromSocietyAccount [name] [amount]")


    RegisterCommand("getSocietyAccount", function(source, args, rawCommand)
        if isAdmin() then
            if args[1] then
                local count = getSocietyAccount(args[1])
                print(count)
                Config.Notify(tostring(count))
            else
                print("please add an account name")
            end
        else
            print(isAdmin())
        end
    end)

    RegisterCommand("setSocietyAccount", function(source, args, rawCommand)
        if isAdmin() then
            if args[1] and args[2] then
                local count = setSocietyAccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
            else
                print("please add an account name and amount")
            end
        else
            print(isAdmin())
        end
    end)

    RegisterCommand("addToSocietyAccount", function(source, args, rawCommand)
        if isAdmin() then
            if args[1] and args[2] then
                local count = addToSocietyAccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
            else
                print("please add an account name and amount")
            end
        else
            print(isAdmin())
        end
    end)

    RegisterCommand("takeFromSocietyAccount", function(source, args, rawCommand)
        if isAdmin() then
            if args[1] and args[2] then
                local count = takeFromSocietyAccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
            else
                print("please add an account name and amount")
            end
        else
            print(isAdmin())
        end
    end)
    print("added command /refreshjobs")
    RegisterCommand("refreshjobs", function(source, args, rawCommand)
        if isAdmin() then
            TriggerServerEvent("ludaro_jobs:refreshjobs")
        else
            print(isAdmin())
        end
    end)

    print("added command /createjob [job_name] [job_label] [grade]")
    print("grade is optional")

    RegisterCommand("createjob", function(source, args, rawCommand)
        if isAdmin() then
            if args[1] and args[2] then
                local jobexist = doesJobExist(args[1])
                if jobexist == nil or jobexist == false then
                    print("job already exists")
                    return
                end
                if not args[3] then
                    print("grades are not given.. creating grade called " .. args[1] .. "_0")
                end
                TriggerServerEvent("ludaro_jobs:createjob", args[1], args[2], args[3] or nil)
            else
                print("Please provide both job_name and job_label.")
            end
        else
            print(isAdmin())
        end
    end)
end
