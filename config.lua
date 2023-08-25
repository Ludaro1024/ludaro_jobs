Config = {}
Config.Debug = 2 -- 0 = off, 1 = on -- 2 ALOT -- 3 EVERYTHING
Config.Locale = 'en'

Config.AdminGroups = {"admin", "owner"}

Config.Notify = function(txt)
ESX.ShowNotification(txt)
end
