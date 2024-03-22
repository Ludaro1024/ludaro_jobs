Zones = {}
function CreateNPCs(info, job)
	local name = job.name
	local coords = vector3(info.bossmenu.x, info.bossmenu.y, info.bossmenu.z)
	local range = tonumber(Config.bossmenu.NPCRange)
	local xoffsetnpc = tonumber(info.xoffsetnpc) or 0
	local yoffsetnpc = tonumber(info.yoffsetnpc) or 0
	local zoffsetnpc = tonumber(info.zoffsetnpc) or 0

	-- Adjust x-coordinate based on xoffsetnpc
	if xoffsetnpc > 0 then
		coords.x = coords.x + xoffsetnpc
	elseif xoffsetnpc < 0 then
		coords.x = coords.x - math.abs(xoffsetnpc)
	end

	-- Adjust y-coordinate based on yoffsetnpc
	if yoffsetnpc > 0 then
		coords.y = coords.y + yoffsetnpc
	elseif yoffsetnpc < 0 then
		coords.y = coords.y - math.abs(yoffsetnpc)
	end

	-- Adjust z-coordinate based on zoffsetnpc
	if zoffsetnpc > 0 then
		coords.z = coords.z + zoffsetnpc
	elseif zoffsetnpc < 0 then
		coords.z = coords.z - math.abs(zoffsetnpc)
	end

	local function onNpcEnter(self)
		CreateNPC(
			coords,
			self.info.bossmenu.model or Config.bossmenu.DefaultModel,
			self.name,
			self.info.npcheading or 200
		)
	end

	local function onNpcExit(self)
		DeleteNPC(self.name)
	end

	local function InsideNPC(self) end
	if ZONES[name .. "NPC"] then
		ZONES[name .. "NPC"]:remove()
	end
	Zones[name .. "NPC"] = lib.zones.box({
		coords = coords,
		size = vec3(range, range, range),
		rotation = 0,
		debug = Config.Debug == 3,
		inside = InsideNPC,
		onEnter = onNpcEnter,
		onExit = onNpcExit,
		info = info,
		name = name,
	})
end

function CreateNPC(coords, model, name, heading)
	loadModel(model)
	local npc = CreatePed(4, model, coords.x, coords.y, coords.z, heading, false, true)
	SetEntityAsMissionEntity(npc, true, true)
	SetBlockingOfNonTemporaryEvents(npc, true)
	SetPedDiesWhenInjured(npc, false)
	SetPedCanPlayAmbientAnims(npc, true)
	SetPedCanRagdollFromPlayerImpact(npc, false)
	SetEntityInvincible(npc, true)
	FreezeEntityPosition(npc, true)
	table.insert(NPCS, { npc = npc, name = name })
	return npc
end

-- The rest of your code remains unchanged
function DeleteNPC(name)
	for k, v in pairs(NPCS) do
		if v.name == name then
			DeleteEntity(v.npc)
			table.remove(NPCS, k)
			break -- Added break to exit the loop once the NPC is found and deleted
		end
	end
end

function loadModel(model)
	if not HasModelLoaded(model) then
		RequestModel(model)
		while not HasModelLoaded(model) do
			Wait(1)
		end
	end
end
