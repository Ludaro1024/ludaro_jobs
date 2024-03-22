function consoleLog(msg, level)
    level = level or 1
    if Config.Debug >= level then
        local lineInfo = debug.getinfo(2, "Sl") or ""
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

if Config.Debug ~= 0 then
print("Ludaro Debugging Loaded check readme for debug commands and prints!")
end