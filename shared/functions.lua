Config.Notify = function(txt, source)
    if source == nil then
        ESX.ShowNotification(txt)
    else
        xplayer = ESX.GetPlayerFromId(source)
        xplayer.showNotification(txt)
    end
end
Config.TextUI = {}

Config.TextUI.Enterzone = function(coords, msg)
end

Config.TextUI.ExitZone = function(coords, msg)
end

Config.TextUI.ThreadInZone = function(coords, msg)
    ESX.ShowHelpNotification(msg)
end

Config.OpenCustomGarageClient = function(jobname, society)
    -- insert ur own garage here if you have one
end