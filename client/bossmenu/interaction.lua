function CreateInteractionZone(info, job)
	local name = job.name
	local coords

	if info.bossmenu and (info.bossmenu.x or info.bossmenu.y or info.bossmenu.z) then
		coords = vector3(info.bossmenu.x, info.bossmenu.y, info.bossmenu.z)
	else
		coords = vector3(info.x, info.y, info.z)
	end

	local Range = tonumber(Config.bossmenu.Range)

	local function InsideInteraction()
		Config.TextUI.ThreadInZone(coords, framework_Locale("TextUIInteraction"))
		if IsControlJustReleased(0, 38) then
			OpenBossMenu(coords)
		end
	end

	local function onEnterInteraction()
		Config.TextUI.Enterzone(coords, framework_Locale("TextUIInteraction"))
	end

	local function onLeaveInteraction()
		Config.TextUI.ExitZone(coords, framework_Locale("TextUIInteractionleave"))
	end
	ZONES[name .. "Interaction"] = lib.zones.box({
		coords = coords,
		size = vec3(Range, Range, Range),
		rotation = 0,
		debug = Config.Debug == 3,
		inside = InsideInteraction,
		onEnter = onEnterInteraction,
		onExit = onLeaveInteraction,
		info = info,
		name = info.name,
	})
end
