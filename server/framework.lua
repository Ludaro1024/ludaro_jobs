if GetResourceState("es_extended") == "started" then
	if exports["es_extended"] and exports["es_extended"].getSharedObject then
		ESX = exports["es_extended"]:getSharedObject()
	else
		TriggerEvent("esx:getSharedObject", function(obj)
			ESX = obj
		end)
	end
end

function framework_cb_getGroup(id)
	return framework_getPlayer(id).getGroup() or "user"
end

function framework_Locale(msg)
	local translation = Config.Translation[Config.Locale][msg]
	if translation then
		return translation
	else
		return "translation not found: " .. msg
	end
end

function table.contains(table, element)
	for _, value in pairs(table) do
		if value == element then
			return true
		end
	end
	return false
end

function framework_getPlayer(source)
	if tonumber(source) then
		return ESX.GetPlayerFromId(source)
	else
		return ESX.GetPlayerFromIdentifier(source)
	end
end

function framework_getGrade(source)
	local xPlayer = framework_getPlayer(source)
	if xPlayer then
		return xPlayer.job.grade
	end
end

function framework_cb_getJob(source)
	local xPlayer = framework_getPlayer(source)
	if xPlayer then
		return xPlayer.job
	end
end
