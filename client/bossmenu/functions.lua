NPCS = {}
ZONES = {}

function HasEnoughMoney(money)
	local playerMoney = Callback_Framework_GetPlayerMoney()
	if playerMoney >= money then
		return true
	else
		return false
	end
end
function isgradehighenough(job, info)
	if info.minimumgrade == nil then
		grade = Config.DefaultMinimumGrade
	else
		grade = info.minimumgrade
	end
	playergrade = Callback_Framework_GetJobGrade()
	if playergrade >= grade then
		return true
	else
		return false
	end
end
