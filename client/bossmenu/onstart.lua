function getInfo_bossmenu()
	local info, job = Callback_Framework_GetJobInfo()
	--print(info)
	if info == false then
		return false, job
	else
		return json.decode(info), job
	end
	--return json.decode(info), job
end

function CreateBossMenus(info, name)
	--print(isgradehighenough(name, info))
	if isgradehighenough(name, info) then
		if type(info["markerenabled"]) == "boolean" and info["markerenabled"] == true then
			CreateMarkers(info, name)
		end
		-- Check other fields in a similar manner
		if type(info["npcenabled"]) == "boolean" and info["npcenabled"] == true then
			CreateNPCs(info, name)
		end
		CreateInteractionZone(info, name)
	end
end

function OnScriptStart_bossmenu()
	local info, name = getInfo_bossmenu()
	CreateBossMenus(info, name)
end

OnScriptStart_bossmenu()
