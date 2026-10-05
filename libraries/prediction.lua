local Prediction = {}

local EPSILON = 1e-6
local MAX_TIME = 4
local STEP = 1 / 90
local MAX_TARGET_SPEED = 120
local LONG_VELOCITY_WINDOW = 0.18
local SHORT_VELOCITY_WINDOW = 0.1
local WALK_CAP = 45
local KNOCK_DECAY = 0.12
local VELOCITY_SMOOTH_TIME = 0.08

local tracks = setmetatable({}, {__mode = 'k'})
local floorParams = RaycastParams.new()
floorParams.FilterType = Enum.RaycastFilterType.Include
local floorMap = nil

local function validNumber(value)
	return type(value) == 'number' and value == value and math.abs(value) < math.huge
end

local function validVector(value)
	return typeof(value) == 'Vector3' and validNumber(value.X) and validNumber(value.Y) and validNumber(value.Z)
end

local function flat(v)
	return Vector3.new(v.X, 0, v.Z)
end

Prediction.Raycast = function(origin, direction, params)
	return workspace:Raycast(origin, direction, params)
end

local function getFloorParams(fallback)
	local map = workspace:FindFirstChild('Map')
	if map then
		if map ~= floorMap then
			floorMap = map
			floorParams.FilterDescendantsInstances = {map}
		end
		return floorParams
	end
	return fallback
end

local function castDown(position, distance, params)
	if not params then return nil end
	return Prediction.Raycast(position + Vector3.new(0, 1, 0), Vector3.new(0, -(distance + 1), 0), params)
end

Prediction.GetSpawnPosition = function(positionFrom, aimPoint, relX, relY, relZ)
	if not validVector(positionFrom) or not validVector(aimPoint) then
		return positionFrom
	end
	if (aimPoint - positionFrom).Magnitude <= EPSILON then
		return positionFrom
	end
	return (CFrame.new(positionFrom, aimPoint) * CFrame.new(relX or 0.8, relY or -0.6, relZ or 0)).Position
end

Prediction.ProjectilePosition = function(origin, velocity, gravity, t)
	return origin + velocity * t + Vector3.new(0, -0.5 * gravity * t * t, 0)
end

local function solve3(m, r)
	local a, b, c = m[1], m[2], m[3]
	local det = a[1] * (b[2] * c[3] - b[3] * c[2]) - a[2] * (b[1] * c[3] - b[3] * c[1]) + a[3] * (b[1] * c[2] - b[2] * c[1])
	if math.abs(det) < 1e-12 then return nil end
	local function col(i)
		local mm = {{a[1], a[2], a[3]}, {b[1], b[2], b[3]}, {c[1], c[2], c[3]}}
		mm[1][i], mm[2][i], mm[3][i] = r[1], r[2], r[3]
		local x, y, z = mm[1], mm[2], mm[3]
		return (x[1] * (y[2] * z[3] - y[3] * z[2]) - x[2] * (y[1] * z[3] - y[3] * z[1]) + x[3] * (y[1] * z[2] - y[2] * z[1])) / det
	end
	return col(1), col(2), col(3)
end

local function fitLine(samples, now, window, axis)
	local n, st, sv, stt, stv = 0, 0, 0, 0, 0
	local first, last
	for i = #samples, 1, -1 do
		local s = samples[i]
		local dt = s.t - now
		if dt < -window then break end
		local v = s.p[axis]
		n += 1
		st += dt
		sv += v
		stt += dt * dt
		stv += dt * v
		first = first or s.t
		last = s.t
	end
	if n < 3 or (first - last) < window * 0.4 then return nil end
	local denom = n * stt - st * st
	if math.abs(denom) < 1e-9 then return nil end
	return (n * stv - st * sv) / denom
end

local function fitArc(samples, now, window, since)
	local s00, s01, s02, s03, s04 = 0, 0, 0, 0, 0
	local r0, r1, r2 = 0, 0, 0
	local n, first, last = 0, nil, nil
	for i = #samples, 1, -1 do
		local s = samples[i]
		local dt = s.t - now
		if dt < -window or (since and s.t <= since) then break end
		local y = s.p.Y
		local d2 = dt * dt
		n += 1
		s00 += 1
		s01 += dt
		s02 += d2
		s03 += d2 * dt
		s04 += d2 * d2
		r0 += y
		r1 += y * dt
		r2 += y * d2
		first = first or s.t
		last = s.t
	end
	if n < 10 or (first - last) < 0.2 then return nil end
	local _, b, c = solve3({{s00, s01, s02}, {s01, s02, s03}, {s02, s03, s04}}, {r0, r1, r2})
	if not b then return nil end
	return b, -2 * c
end

local function fitKnown(samples, now, window, since, g0)
	local n, st, sz, stt, stz = 0, 0, 0, 0, 0
	local first, last
	for i = #samples, 1, -1 do
		local s = samples[i]
		local dt = s.t - now
		if dt < -window or (since and s.t <= since) then break end
		local z = s.p.Y + 0.5 * g0 * dt * dt
		n += 1
		st += dt
		sz += z
		stt += dt * dt
		stz += dt * z
		first = first or s.t
		last = s.t
	end
	if n < 3 or (first - last) < 0.04 then return nil end
	local denom = n * stt - st * st
	if math.abs(denom) < 1e-9 then return nil end
	return (n * stz - st * sz) / denom
end

Prediction.Observe = function(root, position)
	if typeof(root) ~= 'Instance' or not validVector(position) then return end
	local now = os.clock()
	local track = tracks[root]
	if not track then
		track = {samples = {}, history = {}}
		tracks[root] = track
	end
	local samples = track.samples
	local last = samples[#samples]
	if last and now - last.t < 1 / 120 then return end
	if last and (position - last.p).Magnitude < 1e-4 and now - last.t < 0.15 then return end
	if last and (position - last.p).Magnitude > 60 then
		table.clear(samples)
		table.clear(track.history)
	end
	table.insert(samples, {t = now, p = position})
	while #samples > 60 or (samples[1] and now - samples[1].t > 1) do
		table.remove(samples, 1)
	end

	local vx = fitLine(samples, now, LONG_VELOCITY_WINDOW, 'X')
	local vz = fitLine(samples, now, LONG_VELOCITY_WINDOW, 'Z')
	local shortX = fitLine(samples, now, SHORT_VELOCITY_WINDOW, 'X')
	local shortZ = fitLine(samples, now, SHORT_VELOCITY_WINDOW, 'Z')
	local g0 = workspace.Gravity
	local onGround = track.groundT and now - track.groundT < 0.05

	if vx and vz then
		local horizontal = Vector3.new(vx, 0, vz)

		if shortX and shortZ then
			local recent = Vector3.new(shortX, 0, shortZ)

			if horizontal.Magnitude > 2 and recent.Magnitude > 2 then
				local directionDot = horizontal.Unit:Dot(recent.Unit)
				local speedChange = math.abs(recent.Magnitude - horizontal.Magnitude)

				if directionDot < 0.7 or speedChange > 8 then
					horizontal = recent
				else
					horizontal = horizontal:Lerp(recent, 0.35)
				end
			else
				horizontal = recent
			end
		end

		local vy = fitLine(samples, now, 0.1, 'Y') or 0
		local grav = nil

		if not onGround then
			local vyKnown = fitKnown(samples, now, 0.15, track.groundT, g0)
			if vyKnown then
				vy = vyKnown
			end

			local vyArc, g = fitArc(samples, now, 0.35, track.groundT)
			if vyArc and g and g > g0 * 0.4 and g < g0 * 1.6 then
				grav = g
			end
		end

		local measuredVelocity = Vector3.new(horizontal.X, vy, horizontal.Z)
		if track.vel and track.velT then
			local dt = math.clamp(now - track.velT, 0, 0.1)
			local alpha = 1 - math.exp(-dt / VELOCITY_SMOOTH_TIME)
			local oldHorizontal = flat(track.vel)
			local newHorizontal = flat(measuredVelocity)
			local smoothedHorizontal = oldHorizontal:Lerp(newHorizontal, alpha)
			track.vel = Vector3.new(smoothedHorizontal.X, measuredVelocity.Y, smoothedHorizontal.Z)
		else
			track.vel = measuredVelocity
		end
		track.gravity = grav
		track.velT = now

		table.insert(track.history, {
			t = now,
			v = horizontal
		})

		while track.history[1] and now - track.history[1].t > 1 do
			table.remove(track.history, 1)
		end
	end

	local minY = math.huge
	for i = #samples, 1, -1 do
		if now - samples[i].t > 1.2 then break end
		minY = math.min(minY, samples[i].p.Y)
	end
	track.minY = minY
	local prev = samples[#samples - 1]
	if prev then
		local lift = minY + 0.5
		if prev.p.Y <= lift and position.Y > lift then
			track.jumps = track.jumps or {}
			table.insert(track.jumps, now)
			while track.jumps[1] and now - track.jumps[1] > 2 do
				table.remove(track.jumps, 1)
			end
			track.peak = position.Y
		elseif track.peak and position.Y > track.peak then
			track.peak = position.Y
		end
		if track.peak and prev.p.Y > lift and position.Y <= lift then
			track.jumpH = track.peak - minY
			track.peak = nil
		end
	end

	local count = #samples
	if count >= 4 then
		local low, high = math.huge, -math.huge
		local oldest = nil
		for i = count, 1, -1 do
			local s = samples[i]
			if now - s.t > 0.15 then break end
			low = math.min(low, s.p.Y)
			high = math.max(high, s.p.Y)
			oldest = s
		end
		if oldest and now - oldest.t >= 0.12 and high - low < 0.15 then
			track.groundY = position.Y
			track.groundT = now
		end
	end
end

local function isStrafing(track, horizontal)
	if not track or horizontal.Magnitude < 4 then return false end
	local now = os.clock()
	for i = #track.history, 1, -1 do
		local h = track.history[i]
		local age = now - h.t
		if age > 0.7 then break end
		if age > 0.2 and h.v.Magnitude > 4 and h.v.Unit:Dot(horizontal.Unit) < -0.3 then
			return true
		end
	end
	return false
end

Prediction.SolveTrajectory = function(origin, projectileSpeed, gravity, targetPos, targetVelocity, playerGravity, playerHeight, playerJump, params, targetAirborne, targetRootPosition, targetRoot, minimumTime, strict, motionScale)
	projectileSpeed = tonumber(projectileSpeed) or 0
	gravity = tonumber(gravity) or 0
	playerGravity = tonumber(playerGravity) or workspace.Gravity
	playerHeight = tonumber(playerHeight) or 2
	targetVelocity = validVector(targetVelocity) and targetVelocity or Vector3.zero
	motionScale = math.clamp(tonumber(motionScale) or 1, 0, 1)

	if typeof(targetRootPosition) == 'Instance' and targetRootPosition:IsA('BasePart') then
		targetRoot = targetRootPosition
		targetRootPosition = targetRoot.Position
	end

	if not validVector(origin) or not validVector(targetPos) or not validNumber(projectileSpeed) or projectileSpeed <= EPSILON or not validNumber(gravity) then
		if strict then return nil end
		return targetPos, targetPos
	end

	if not validVector(targetRootPosition) then
		targetRootPosition = targetPos
	end
	local partOffset = targetPos - targetRootPosition

	local rootHalf = 1
	if typeof(targetRoot) == 'Instance' and targetRoot:IsA('BasePart') then
		rootHalf = targetRoot.Size.Y / 2
	else
		targetRoot = nil
	end
	local standOffset = playerHeight + rootHalf

	local track = targetRoot and tracks[targetRoot]
	local fresh = track and track.vel and os.clock() - track.velT < 0.25
	local horizontal = flat(targetVelocity)
	local vy = targetVelocity.Y

	if fresh and targetVelocity.Magnitude > EPSILON then
		horizontal = flat(track.vel)
		vy = track.vel.Y

		if track.gravity then
			playerGravity = track.gravity
		end
	end

	if horizontal.Magnitude > MAX_TARGET_SPEED then
		horizontal = horizontal.Unit * MAX_TARGET_SPEED
	end

	local bhop = nil
	if track and track.jumps and #track.jumps >= 2 and track.jumpH and track.jumpH > 1 and track.minY and playerGravity > EPSILON then
		local last = track.jumps[#track.jumps]
		local period = last - track.jumps[#track.jumps - 1]
		if period > 0.25 and period < 1.2 and os.clock() - last < period * 1.5 then
			local jv = math.sqrt(2 * playerGravity * track.jumpH)
			bhop = {
				last = last,
				period = period,
				jv = jv,
				air = 2 * jv / playerGravity,
				ground = track.minY
			}
		end
	end

	local floorCheck = getFloorParams(params)
	local steady = track and track.groundT and os.clock() - track.groundT < 0.2
	local airborne = true
	local below = floorCheck and castDown(targetRootPosition, standOffset + 1.2, floorCheck)
	if below and math.abs(vy) < 6 then
		airborne = false
	elseif math.abs(vy) < 1 and (steady or targetAirborne == false) then
		airborne = false
	end
	if not airborne then
		vy = 0
	end
    
	local floorY = nil
	if airborne and playerGravity > EPSILON then
		local apexY = targetRootPosition.Y + (vy > 0 and (vy * vy) / (2 * playerGravity) or 0)
		local guessT = math.min((targetPos - origin).Magnitude / projectileSpeed, MAX_TIME)
		local candidates = {
			castDown(targetRootPosition + horizontal * guessT, 300, floorCheck),
			castDown(targetRootPosition, 300, floorCheck)
		}
		for _, hit in candidates do
			if hit then
				local y = hit.Position.Y + standOffset
				if y <= apexY + 0.5 then
					floorY = y
					break
				end
			end
		end
		if not floorY and track then
			if track.groundY and os.clock() - track.groundT < 1.5 and vy > -40 and track.groundY <= apexY + 0.5 then
				floorY = track.groundY
			end
		end
	end

	local function leadAt(t)
		local speed = horizontal.Magnitude
		if speed <= EPSILON then return Vector3.zero end
		local walk = math.min(speed, WALK_CAP)
		local dist = walk * t
		if speed > walk then
			dist += (speed - walk) * KNOCK_DECAY * (1 - math.exp(-t / KNOCK_DECAY))
		end
		return horizontal.Unit * dist
	end

	local function rootAt(t)
		local pos = targetRootPosition + leadAt(t)
		if bhop then
			local tj = (os.clock() - bhop.last + t) % bhop.period
			local y = bhop.ground
			if tj < bhop.air then
				y = bhop.ground + bhop.jv * tj - 0.5 * playerGravity * tj * tj
			end
			pos = Vector3.new(pos.X, y, pos.Z)
		elseif airborne then
			local y = targetRootPosition.Y + vy * t - 0.5 * playerGravity * t * t
			if floorY and y < floorY and vy - playerGravity * t < 0 then
				y = floorY
			end
			pos = Vector3.new(pos.X, y, pos.Z)
		end
		return targetRootPosition:Lerp(pos, motionScale)
	end

	local half = Vector3.new(0, 0.5 * gravity, 0)
	local function miss(t)
		local need = rootAt(t) + partOffset - origin + half * t * t
		return need.Magnitude - projectileSpeed * t
	end

	local t = nil
	local lastT = 0
	local current = STEP
	while current <= MAX_TIME do
		if miss(current) <= 0 then
			local low, high = lastT, current
			for _ = 1, 30 do
				local mid = (low + high) / 2
				if miss(mid) > 0 then
					low = mid
				else
					high = mid
				end
			end
			t = high
			break
		end
		lastT = current
		current += current < 0.5 and STEP or STEP * 2
	end

	if not t then
		if strict then return nil end
		return targetPos, targetPos
	end

	if minimumTime and t < minimumTime then
		t = minimumTime
	end

	local impact = rootAt(t) + partOffset
	if t <= EPSILON then
		return impact, impact, 0
	end

	local velocity = (impact - origin + half * t * t) / t
	if not validVector(velocity) or velocity.Magnitude <= EPSILON then
		if strict then return nil end
		return targetPos, targetPos
	end
	velocity = velocity.Unit * projectileSpeed

	return origin + velocity, impact, t
end

Prediction.IsTrajectoryClear = function(origin, velocity, gravity, travelTime, params)
	if not validVector(origin) or not validVector(velocity) or not validNumber(travelTime) then
		return false
	end
	local steps = math.clamp(math.ceil(travelTime / 0.05), 1, 40)
	local last = origin
	for i = 1, steps do
		local point = Prediction.ProjectilePosition(origin, velocity, gravity, travelTime * (i / steps))
		local hit = Prediction.Raycast(last, point - last, params)
		if hit then
			return false, hit
		end
		last = point
	end
	return true
end

Prediction.markKnockback = function() end
Prediction.expectKnockback = function() end
Prediction.trackShot = function() end
Prediction.reportHit = function() end
Prediction.setLatency = function() end
Prediction.getLatency = function() return 0 end

return Prediction
