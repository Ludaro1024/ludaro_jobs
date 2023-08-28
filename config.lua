Config = {}
Config.Debug = 3 -- 0 = off, 1 = on -- 2 ALOT -- 3 EVERYTHING
Config.Locale = 'de'
Config.Menu = "NativeUI" -- ox_lib or NativeUI or NUI 
Config.AdminGroups = {"admin", "owner"}
Config.AutoSQL = true -- makes all the sql automaticly upon startup if it doesnt exist
Config.Commands = { adminmenu = "debug"}
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
        ["confirm"] = "Bestätigen",
        ["interactions"] = "Interaktionen",
        ["yes"] = "Ja",
        ["addjob"] = "Job hinzufügen",
        ["addgrade"] = "Rang hinzufügen",
        ["success"] = "Erfolg",
        ["grade"] = "Ränge",
        ["errorjob"] = "Fehler beim Job Erstellen! Job Wurde nicht erstellt",
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