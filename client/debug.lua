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

function print(msg)
    debug2(msg)
end

print("Ludaro Debugging Loaded check readme for debug commands and prints!")

-- addonaccount
if Config.Debug >= 2 then
    print("added command /getsocietyaccount [account_name]")
    print("added command /setsocietyaccount [name] [amount]")
    print("added command /addtosocietyaccount [name] [amount]")
    print("added command /takefromsocietyaccount [name] [amount]")


   RegisterCommand("getsocietyaccount", function(source, args, rawCommand)
    if isadmin() then 
        if args[1] then
            local count = getsocietyaccount(args[1])
            print(count)
            Config.Notify(tostring(count))
        else
            print("please add an account name")
        end
    else
        print(isadmin())
    end
   end)

    RegisterCommand("setsocietyaccount", function(source, args, rawCommand)
     if isadmin() then 
          if args[1] and args[2] then
                local count = setsocietyaccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
          else
                print("please add an account name and amount")
          end
     else
          print(isadmin())
     end
    end)

    RegisterCommand("addtosocietyaccount", function(source, args, rawCommand)
     if isadmin() then 
          if args[1] and args[2] then
                local count = addtosocietyaccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
          else
                print("please add an account name and amount")
          end
     else
          print(isadmin())
     end
    end)

    RegisterCommand("takefromsocietyaccount", function(source, args, rawCommand)
     if isadmin() then 
          if args[1] and args[2] then
                local count = takefromsocietyaccount(args[1], args[2])
                print(count)
                Config.Notify(tostring(count))
          else
                print("please add an account name and amount")
          end
     else
          print(isadmin())
     end
    end)
    print("added command /refreshjobs")
    RegisterCommand("refreshjobs", function(source, args, rawCommand)
        if isadmin() then 
            TriggerServerEvent("ludaro_jobs:refreshjobs")
        else
            print(isadmin())
        end
    end)

    print("added command /createjob [job_name] [job_label] [grade]")
    print("grade is optional")

    RegisterCommand("createjob", function(source, args, rawCommand)
        if isadmin() then 
            if args[1] and args[2] then

                local jobexist = doesjobexist(args[1])
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
            print(isadmin())
        end
    end)
end
