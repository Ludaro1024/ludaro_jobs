function Refresh_bossmenu()
	for k, v in pairs(lib.points.getAllPoints()) do
		v:remove()
	end
	OnScriptStop_bossmenu()
	OnScriptStart_bossmenu()
end

RegisterNetEvent("esx:setJob", function(job, lastJob)
	Refresh_bossmenu()
end)
