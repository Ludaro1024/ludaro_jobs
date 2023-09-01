Config = {}
Config.Debug = 0 -- 0 = off, 1 = on -- 2 ALOT -- 3 EVERYTHING
Config.Locale = 'de'
Config.Menu = "NativeUI" -- ox_lib or NativeUI or NUI  CURRENTLY ONLY NATIVEUI
Config.AdminGroups = {"admin", "owner"}
Config.AutoSQL = true -- makes all the sql automaticly upon startup if it doesnt exist
Config.Keys = {interactions = "F6"} -- this is client bound and will only set it once upon joining first when the script hasnt ben loaded in any other server! editable iongame in the settings menu
Config.Commands = { adminmenu = "ljob", interactions = "interactionss",}
Config.Interactions = {
      ["cuff"] = {
        prio = 1, -- the prio of the interaction in the menu ( 1 = its on the top)
        name =  "Put on Cuffs", -- name of the event in the menu
        client = false,-- if false then its server side
        eventname = nil,
        eventargs = {true, true},
        icon = "cuff", --read readme for icons
      },
      ["uncuff"] = {
        prio = 2, -- the prio of the interaction in the menu ( 1 = its on the top)
        name =  "Put off Cuffs", -- name of the event in the menu
        client = false,-- if false then its server side
        eventname = "ljobs:cuff", 
        icon = 4, -- read readme for icons
      }
}
Config.Translation = {
    ['de'] = {
        ["adminmenu"] = "Ludaro-Jobs Admin-Menü",
        ["$"] = "$",
        ["salary"] = "Gehalt",
        ["name"] = "Name",
        ["label"] = "Label",
        ["insertsalary"] = "Gehalt einfügen",
        ["nonumber"] = "Keine Nummer",
        ["insertname"] = "Namen einfügen",
        ["insertlabel"] = "Label einfügen",
        ["creategrade"] = "Rang erstellen",
        ["grades"] = "Ränge",
        ["confirm"] = "~g~Bestätigen",
        ["interactions"] = "Interaktionen",
        ["yes"] = "Ja",
        ["addjob"] = "Job hinzufügen",
        ["addgrade"] = "Rang hinzufügen",
        ["success"] = "Erfolg",
        ["grade"] = "Ränge",
        ["errorjob"] = "Fehler beim Job Erstellen! Job Wurde nicht erstellt",
        ["deletejob"] = "~r~Lösche Job",
        ["society-money"] = "Gesellschafts-Kontostand:",
        ["createsociety"] = "Gesellschaft-Erstellen",
        ["insertmoney"] = "Geld eingeben:",
        ["insertid"] = "ID eingeben:",
        ["deletegrade"] = "~r~Rang Löschen:",
        ["whitelisted"] = "Ist Gewhitelisted?",
    },
    ['en'] = {
        ["adminmenu"] = "Ludaro-Jobs Admin Menu",
        ["$"] = "$",
        ["salary"] = "Salary",
        ["name"] = "Name",
        ["label"] = "Label",
        ["insertsalary"] = "Insert Salary",
        ["nonumber"] = "No Number",
        ["insertname"] = "Insert Name",
        ["insertlabel"] = "Insert Label",
        ["creategrade"] = "Create Grade",
        ["grades"] = "Grades",
        ["confirm"] = "Confirm",
        ["interactions"] = "Interactions",
        ["yes"] = "Yes",
        ["addjob"] = "Add Job",
        ["addgrade"] = "Add Grade",
        ["success"] = "Success",
        ["grade"] = "grade",
        ["errorjob"] = "Error creating job! Job was not created",
        ["deletejob"] = "~r~Delete Job",
        ["society-money"] = "Society-Money:",
        ["createsociety"] = "Create Society",
        ["insertmoney"] = "Geld eingeben:",
        ["insertid"] = "Insert ID:",
    }
}
Config.Notify = function(txt, source)
   if source == nil then
    ESX.ShowNotification(txt)
   else
    xplayer = ESX.GetPlayerFromId(source)
    xplayer.showNotification(txt)
   end
end
Config.TextUI = {}

Config.TextUI.Enterzone = function()
end

Config.TextUI.ExitZone = function()
end

Config.TextUI.ThreadInZone = function()
end

