function CreateMarkers(info, job)
	ZONES[info.name .. "Marker"]:remove()
	name = job.name
	local coords = vec3(info.bossmenu.x, info.bossmenu.y, info.bossmenu.z)
	local range = Config.bossmenu.MarkerRange
	info.name = name
	function OnEnterMarker(self) end

	function OnLeaveMarker(self) end

	-- fuck this pls redo the marker table lukas :( your horrible at tables
	local function InsideMarker(self)
		if self.bossmenu.markerenabled then
			local marker = Config.DefaultMarker
			local xOffset = tonumber(self.bossmenu.xoffset) or 0
			local yOffset = tonumber(self.bossmenu.yoffset) or 0
			local zOffset = tonumber(self.bossmenu.zoffset) or 0

			local adjustedX = self.coords.x
			local adjustedY = self.coords.y
			local adjustedZ = self.coords.z

			if xOffset < 0 then
				adjustedX = adjustedX - math.abs(xOffset)
			elseif xOffset > 0 then
				adjustedX = adjustedX + xOffset
			end

			if yOffset < 0 then
				adjustedY = adjustedY - math.abs(yOffset)
			elseif yOffset > 0 then
				adjustedY = adjustedY + yOffset
			end

			if zOffset < 0 then
				adjustedZ = adjustedZ - math.abs(zOffset)
			elseif zOffset > 0 then
				adjustedZ = adjustedZ + zOffset
			end

			local scalex = tonumber(string.format("%.1f", tonumber(self.bossmenu.scalex) or marker.scalex))
			local scaley = tonumber(string.format("%.1f", tonumber(self.bossmenu.scaley) or marker.scaley))
			local scalez = tonumber(string.format("%.1f", tonumber(self.bossmenu.scalez) or marker.scalez))

			DrawMarker(
				self.bossmenu.markerid,
				adjustedX,
				adjustedY,
				adjustedZ,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				0.0,
				scalex,
				scaley,
				scalez,
				self.bossmenu.markerred or marker.red,
				self.bossmenu.markergreen or marker.green,
				self.bossmenu.markerblue or marker.blue,
				self.bossmenu.markeralpha or marker.alpha,
				self.bossmenu.markerbobupanddown or marker.bobupanddown,
				self.bossmenu.markerfacecamera or marker.facecamera,
				2,
				nil,
				nil,
				false
			)
		end
	end

	ZONES[info.name .. "Marker"] = lib.zones.box({
		coords = coords,
		size = vec3(range, range, range),
		rotation = 0,
		debug = Config.Debug == 3,
		inside = InsideMarker,
		onEnter = onEnterMarker,
		onExit = onLeaveMarker,
		info = info,
		bossmenu = info,
		name = name,
	})
end
