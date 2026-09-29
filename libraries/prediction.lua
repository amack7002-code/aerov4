--!nocheck

local module = {}
local workspace = game:GetService('Workspace')
local stats = game:GetService('Stats')
local eps = 1e-9
local RAY_LIMIT = 600

local function isZero(d)
	return d > -eps and d < eps
end

local function validNumber(v)
	return type(v) == 'number' and v == v and v ~= math.huge and v ~= -math.huge
end

local function validVector(v)
	if typeof(v) ~= 'Vector3' then return false end
	return validNumber(v.X) and validNumber(v.Y) and validNumber(v.Z)
end

local function cuberoot(x)
	return (x > 0) and math.pow(x, 1 / 3) or -math.pow(math.abs(x), 1 / 3)
end

local function solveQuadric(c0, c1, c2)
	local p = c1 / (2 * c0)
	local q = c2 / c0
	local D = p * p - q

	if isZero(D) then
		return {-p}
	elseif D < 0 then
		return {}
	end

	local sqrtD = math.sqrt(D)
	return {sqrtD - p, -sqrtD - p}
end

local function solveCubic(c0, c1, c2, c3)
	local A = c1 / c0
	local B = c2 / c0
	local C = c3 / c0

	local sqA = A * A
	local p = (1 / 3) * (-(1 / 3) * sqA + B)
	local q = 0.5 * ((2 / 27) * A * sqA - (1 / 3) * A * B + C)

	local cbP = p * p * p
	local D = q * q + cbP
	local results

	if isZero(D) then
		if isZero(q) then
			results = {0}
		else
			local u = cuberoot(-q)
			results = {2 * u, -u}
		end
	elseif D < 0 then
		local phi = (1 / 3) * math.acos(-q / math.sqrt(-cbP))
		local t = 2 * math.sqrt(-p)
		results = {
			t * math.cos(phi),
			-t * math.cos(phi + math.pi / 3),
			-t * math.cos(phi - math.pi / 3)
		}
	else
		local sqrtD = math.sqrt(D)
		local u = cuberoot(sqrtD - q)
		local v = -cuberoot(sqrtD + q)
		results = {u + v}
	end

	local sub = (1 / 3) * A
	for i = 1, #results do
		results[i] = results[i] - sub
	end
	return results
end

function module.solveQuartic(c0, c1, c2, c3, c4)
	if isZero(c0) then
		return solveCubic(c1, c2, c3, c4)
	end

	local A = c1 / c0
	local B = c2 / c0
	local C = c3 / c0
	local D = c4 / c0

	local sqA = A * A
	local p = -0.375 * sqA + B
	local q = 0.125 * sqA * A - 0.5 * A * B + C
	local r = -(3 / 256) * sqA * sqA + 0.0625 * sqA * B - 0.25 * A * C + D

	local results

	if isZero(r) then
		results = solveCubic(1, 0, p, q)
		table.insert(results, 0)
	else
		local cubic = solveCubic(1, -0.5 * p, -r, 0.5 * r * p - 0.125 * q * q)
		local z = cubic[1]
		if not z then return {} end

		local u = z * z - r
		local v = 2 * z - p

		if isZero(u) then
			u = 0
		elseif u > 0 then
			u = math.sqrt(u)
		else
			return {}
		end

		if isZero(v) then
			v = 0
		elseif v > 0 then
			v = math.sqrt(v)
		else
			return {}
		end

		results = solveQuadric(1, q < 0 and -v or v, z - u)
		local second = solveQuadric(1, q < 0 and v or -v, z + u)
		for _, root in second do
			table.insert(results, root)
		end
	end

	local sub = 0.25 * A
	for i = 1, #results do
		results[i] = results[i] - sub
	end
	return results
end

local function interceptResidual(relativePosition, targetVelocity, halfRelativeAcceleration, projectileSpeed, t)
	local offset = relativePosition + targetVelocity * t + halfRelativeAcceleration * (t * t)
	return offset:Dot(offset) - projectileSpeed * projectileSpeed * t * t
end

function module.SolveIntercept(origin, projectileSpeed, projectileAcceleration, targetPosition, targetVelocity, targetAcceleration, minimumTime, maximumTime, preferHigh)
	if not validVector(origin)
		or not validVector(projectileAcceleration)
		or not validVector(targetPosition)
		or not validVector(targetVelocity)
		or not validVector(targetAcceleration)
		or not validNumber(projectileSpeed)
		or projectileSpeed <= eps
	then
		return nil
	end

	local minT = math.max(tonumber(minimumTime) or 0, eps)
	local maxT = tonumber(maximumTime) or 10
	if not validNumber(maxT) or maxT < minT then return nil end

	local wantHigh = preferHigh == true
	local relativePosition = targetPosition - origin
	local halfRelativeAcceleration = (targetAcceleration - projectileAcceleration) * 0.5
	local bestTime

	local function acceptRoot(root)
		if not validNumber(root) or root < minT or root > maxT then return end
		local residual = math.abs(interceptResidual(relativePosition, targetVelocity, halfRelativeAcceleration, projectileSpeed, root))
		local scale = math.max(projectileSpeed * projectileSpeed * root * root, 1)
		if residual <= math.max(0.05, scale * 0.001) then
			if not bestTime then
				bestTime = root
			elseif wantHigh then
				if root > bestTime then bestTime = root end
			elseif root < bestTime then
				bestTime = root
			end
		end
	end

	local c4 = halfRelativeAcceleration:Dot(halfRelativeAcceleration)
	local c3 = 2 * targetVelocity:Dot(halfRelativeAcceleration)
	local c2 = targetVelocity:Dot(targetVelocity) + 2 * relativePosition:Dot(halfRelativeAcceleration) - projectileSpeed * projectileSpeed
	local c1 = 2 * relativePosition:Dot(targetVelocity)
	local c0 = relativePosition:Dot(relativePosition)

	if math.abs(c4) > eps then
		local roots = module.solveQuartic(c4, c3, c2, c1, c0)
		if roots then
			for _, root in roots do
				acceptRoot(root)
			end
		end
	elseif math.abs(c2) > eps then
		local discriminant = c1 * c1 - 4 * c2 * c0
		if discriminant >= 0 then
			local squareRoot = math.sqrt(discriminant)
			acceptRoot((-c1 - squareRoot) / (2 * c2))
			acceptRoot((-c1 + squareRoot) / (2 * c2))
		end
	elseif math.abs(c1) > eps then
		acceptRoot(-c0 / c1)
	end

	if not bestTime then
		local steps = 96
		local previousTime = minT
		local previousValue = interceptResidual(relativePosition, targetVelocity, halfRelativeAcceleration, projectileSpeed, previousTime)

		for step = 1, steps do
			local currentTime = minT + ((maxT - minT) * step / steps)
			local currentValue = interceptResidual(relativePosition, targetVelocity, halfRelativeAcceleration, projectileSpeed, currentTime)

			if validNumber(previousValue) and validNumber(currentValue) then
				if previousValue == 0 then
					bestTime = previousTime
					break
				end
				if (previousValue < 0) ~= (currentValue < 0) then
					local low, high = previousTime, currentTime
					for _ = 1, 48 do
						local mid = (low + high) * 0.5
						local midValue = interceptResidual(relativePosition, targetVelocity, halfRelativeAcceleration, projectileSpeed, mid)
						if not validNumber(midValue) then break end
						if (previousValue < 0) == (midValue < 0) then
							low = mid
						else
							high = mid
						end
					end
					bestTime = (low + high) * 0.5
					break
				end
			end

			previousTime = currentTime
			previousValue = currentValue
		end
	end

	if not bestTime then return nil end

	local displacement = relativePosition + targetVelocity * bestTime + halfRelativeAcceleration * (bestTime * bestTime)
	if displacement.Magnitude <= eps then return nil end

	local initialVelocity = displacement / bestTime
	return {
		FlightTime = bestTime,
		InitialVelocity = initialVelocity,
		ImpactPosition = targetPosition + targetVelocity * bestTime + targetAcceleration * (0.5 * bestTime * bestTime)
	}
end

local function predictVertical(groundY, currentY, vy, jumpImpulse, holdingJump, gravity, t)
	local g = gravity
	if not validNumber(g) or g <= eps then return currentY + vy * t end

	local j = math.max(jumpImpulse or 1, 1)
	local apex = j * j / (2 * g)
	local period = 2 * j / g
	local rise = math.clamp(currentY - groundY, 0, apex)

	if rise < 0.5 and math.abs(vy) < 5 then
		return currentY
	end

	local sqrtTerm = math.sqrt(math.max(j * j - 2 * g * rise, 0))
	local phase
	if vy >= 0 then
		phase = (j - sqrtTerm) / g
	else
		phase = (j + sqrtTerm) / g
	end

	local cycleT = phase + t

	if holdingJump then
		local tau = cycleT % period
		return groundY + j * tau - 0.5 * g * tau * tau
	end

	if cycleT >= period then
		return groundY
	end

	return groundY + j * cycleT - 0.5 * g * cycleT * cycleT
end

module.predictVertical = predictVertical

local rawLatency = 0.1
local latencyClock = 0

function module.setLatency(value)
	if validNumber(value) then
		rawLatency = math.clamp(value, 0, 1)
	end
end

function module.getRawLatency()
	if tick() - latencyClock < 1 then return rawLatency end
	latencyClock = tick()
	local ok, value = pcall(function()
		return stats.Network.ServerStatsItem['Data Ping']:GetValue() / 1000
	end)
	if ok and validNumber(value) then
		rawLatency = math.clamp(value, 0.01, 1)
	end
	return rawLatency
end

local latencyBias = 0

function module.getLatency()
	return module.getRawLatency() + latencyBias
end

function module.getLatencyBias()
	return latencyBias
end

local shotLog = {}
local residualSpread = 0

function module.trackShot(targetRoot)
	if typeof(targetRoot) ~= 'Instance' then return end
	shotLog[targetRoot] = {
		time = workspace:GetServerTimeNow(),
		position = targetRoot.Position
	}
end

function module.reportHit(targetRoot)
	local entry = shotLog[targetRoot]
	if not entry then return end
	shotLog[targetRoot] = nil
	local drift = (targetRoot.Position - entry.position).Magnitude
	residualSpread = residualSpread + (drift - residualSpread) * 0.25
end

function module.getResidualSpread()
	return residualSpread
end

local knockbackLog = setmetatable({}, {__mode = 'k'})

function module.markKnockback(target, multiplier, impulse)
	if typeof(target) ~= 'Instance' then return end
	knockbackLog[target] = {
		time = workspace:GetServerTimeNow(),
		multiplier = multiplier or 1,
		impulse = impulse
	}
end

function module.expectKnockback(target, arrival, impulse, multiplier)
	module.markKnockback(target, multiplier, impulse)
	return arrival
end

function module.Raycast(origin, direction, params)
	if not validVector(origin) or not validVector(direction) then return nil end
	return workspace:Raycast(origin, direction, params)
end

module.IsTrajectoryClear = function(origin, velocity, gravity, travelTime, params, target, ignored)
	if not validVector(origin) or not validVector(velocity) then return true end
	if not validNumber(travelTime) or travelTime <= 0 then return true end

	local steps = math.clamp(math.ceil(travelTime / 0.06), 3, 24)
	local previous = origin
	local accel = Vector3.new(0, -(gravity or 0), 0)

	for i = 1, steps do
		local t = travelTime * (i / steps)
		local point = origin + velocity * t + accel * (0.5 * t * t)
		local segment = point - previous
		if segment.Magnitude > eps then
			for _, drop in {0, 0.3} do
				local from = previous - Vector3.new(0, drop, 0)
				local result = workspace:Raycast(from, segment, params)
				if result then
					local hit = result.Instance
					if hit ~= ignored and (not target or not hit:IsDescendantOf(target)) then
						return false, result
					end
				end
			end
		end
		previous = point
	end

	return true
end

module.SpawnTracer = function(from, to, custom)
	if not validVector(from) or not validVector(to) then return end
	local part = Instance.new('Part')
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.Material = Enum.Material.Neon
	part.Color = (custom and custom.Color) or Color3.fromRGB(120, 220, 255)
	part.Transparency = (custom and custom.Transparency) or 0.4
	part.Size = Vector3.new(0.12, 0.12, (to - from).Magnitude)
	part.CFrame = CFrame.lookAt((from + to) * 0.5, to)
	part.Parent = workspace
	game:GetService('Debris'):AddItem(part, (custom and custom.Life) or 0.4)
	return part
end

module.SpawnArcTracer = function(origin, aimDirection, projectileSpeed, gravity, travelTime, steps, custom)
	if not validVector(origin) or not validVector(aimDirection) then return end
	steps = math.clamp(steps or 12, 2, 40)
	local velocity = aimDirection.Unit * (projectileSpeed or 100)
	local accel = Vector3.new(0, -(gravity or 0), 0)
	local previous = origin
	for i = 1, steps do
		local t = (travelTime or 1) * (i / steps)
		local point = origin + velocity * t + accel * (0.5 * t * t)
		module.SpawnTracer(previous, point, custom)
		previous = point
	end
end

local runService = game:GetService('RunService')
local playersService = game:GetService('Players')

local tracked = setmetatable({}, {__mode = 'k'})
local SAMPLE_WINDOW = 1.2
local SHORT_WINDOW = 0.12
local MID_WINDOW = 0.25
local LONG_WINDOW = 1
local MAX_HORIZONTAL_SPEED = 60
local MAX_RISE_RATE = 20
local GROUND_SLACK = 0.45
local PILLAR_BIAS = 0.6

local groundParams = RaycastParams.new()
groundParams.FilterType = Enum.RaycastFilterType.Include
local groundParamsClock = -1
local groundMode = 'none'

local function refreshGroundParams()
	local now = os.clock()
	if now - groundParamsClock < 2 then return groundMode ~= 'none' end
	groundParamsClock = now
	local map = workspace:FindFirstChild('Map')
	if map then
		groundParams.FilterType = Enum.RaycastFilterType.Include
		groundParams.FilterDescendantsInstances = {map}
		groundMode = 'map'
	else
		local ignore = {}
		for _, plr in playersService:GetPlayers() do
			if plr.Character then
				table.insert(ignore, plr.Character)
			end
		end
		if workspace.CurrentCamera then
			table.insert(ignore, workspace.CurrentCamera)
		end
		groundParams.FilterType = Enum.RaycastFilterType.Exclude
		groundParams.FilterDescendantsInstances = ignore
		groundMode = 'exclude'
	end
	return true
end

local function getStandHeight(root)
	local char = root.Parent
	local hum = char and char:FindFirstChildOfClass('Humanoid')
	if hum and hum.RigType == Enum.HumanoidRigType.R15 then
		return hum.HipHeight + root.Size.Y * 0.5
	elseif hum then
		return root.Size.Y * 0.5 + 2
	end
	return 3
end

local function castFloor(position, depth)
	if not refreshGroundParams() then return nil end
	return workspace:Raycast(position, Vector3.new(0, -depth, 0), groundParams)
end

local function sampleRoot(root, data, now)
	local pos = root.Position
	local vel = root.AssemblyLinearVelocity
	local samples = data.samples
	table.insert(samples, {t = now, p = pos})
	while #samples > 2 and now - samples[1].t > SAMPLE_WINDOW do
		table.remove(samples, 1)
	end

	local stand = getStandHeight(root)
	data.stand = stand
	local hit = castFloor(pos, stand + 3)
	local grounded = false
	if hit then
		local gap = pos.Y - hit.Position.Y
		grounded = gap <= stand + GROUND_SLACK and vel.Y < 4
		data.floorHitY = hit.Position.Y
	end

	if grounded then
		if not data.groundY or math.abs(pos.Y - data.groundY) > 0.05 then
			table.insert(data.grounds, {t = now, y = pos.Y})
		end
		data.groundY = pos.Y
		data.groundTime = now
	end
	while #data.grounds > 1 and now - data.grounds[1].t > SAMPLE_WINDOW do
		table.remove(data.grounds, 1)
	end
	data.airborne = not grounded
end

runService.Heartbeat:Connect(function()
	local now = os.clock()
	for root, data in tracked do
		if not root.Parent or now - data.lastUse > 5 then
			tracked[root] = nil
		else
			sampleRoot(root, data, now)
		end
	end
end)

local function getTrack(root)
	if typeof(root) ~= 'Instance' or not root:IsA('BasePart') then return nil end
	local data = tracked[root]
	local now = os.clock()
	if not data then
		data = {samples = {}, grounds = {}, lastUse = now}
		tracked[root] = data
		sampleRoot(root, data, now)
	end
	data.lastUse = now
	return data
end

local function windowVelocity(samples, window)
	local count = #samples
	if count < 2 then return nil end
	local last = samples[count]
	local first
	for i = count - 1, 1, -1 do
		first = samples[i]
		if last.t - first.t >= window then break end
	end
	local dt = last.t - first.t
	if dt < math.min(window * 0.6, 0.07) then return nil end
	local d = last.p - first.p
	return Vector3.new(d.X, 0, d.Z) / dt
end

local function countReversals(samples)
	local count = #samples
	if count < 4 then return 0 end
	local now = samples[count].t
	local reversals = 0
	local previous
	local anchor = samples[count]
	for i = count - 1, 1, -1 do
		local s = samples[i]
		if now - s.t > LONG_WINDOW then break end
		if anchor.t - s.t >= 0.05 then
			local d = anchor.p - s.p
			local v = Vector3.new(d.X, 0, d.Z) / (anchor.t - s.t)
			if v.Magnitude > 4 then
				if previous and previous:Dot(v) < 0 then
					reversals += 1
				end
				previous = v
			end
			anchor = s
		end
	end
	return reversals
end

local function horizontalVelocity(data, root, fallback)
	local raw = root and root.AssemblyLinearVelocity or fallback or Vector3.zero
	raw = Vector3.new(raw.X, 0, raw.Z)
	if not data then return raw end
	local samples = data.samples
	local mid = windowVelocity(samples, MID_WINDOW)
	if not mid then return raw end
	local short = windowVelocity(samples, SHORT_WINDOW) or mid
	local base = mid
	if short.Magnitude > 1 and mid.Magnitude > 1 and short.Unit:Dot(mid.Unit) < 0.7 then
		base = short
	end
	local reversals = countReversals(samples)
	if reversals >= 2 then
		local long = windowVelocity(samples, LONG_WINDOW) or base
		local w = math.clamp((reversals - 1) / 3, 0, 1)
		base = base:Lerp(long, w)
	end
	return base
end

local function riseRate(data)
	local grounds = data and data.grounds
	if not grounds or #grounds < 2 then return 0 end
	local first, last = grounds[1], grounds[#grounds]
	local dt = last.t - first.t
	if dt < 0.2 or os.clock() - last.t > 0.9 then return 0 end
	local rate = (last.y - first.y) / dt
	if rate < 1.5 then return 0 end
	return math.min(rate, MAX_RISE_RATE)
end

module.LeadScale = 1
module.MaxLead = 45
module.MaxVerticalLead = 14

function module.setLead(scale, maxLead, maxVertical)
	if validNumber(scale) then module.LeadScale = math.clamp(scale, 0, 2) end
	if validNumber(maxLead) then module.MaxLead = math.max(maxLead, 0) end
	if validNumber(maxVertical) then module.MaxVerticalLead = math.max(maxVertical, 0) end
end

local function buildPredictor(targetPos, targetVelocity, root, targetAirborne, playerGravity)
	local data = root and getTrack(root)
	local rootPos = root and root.Position or targetPos
	local partOffset = targetPos - rootPos

	local hv
	if root then
		hv = horizontalVelocity(data, root, targetVelocity)
	else
		hv = Vector3.new(targetVelocity.X, 0, targetVelocity.Z)
	end
	if hv.Magnitude > MAX_HORIZONTAL_SPEED then
		hv = hv.Unit * MAX_HORIZONTAL_SPEED
	end
	hv = hv * module.LeadScale

	local vy = root and root.AssemblyLinearVelocity.Y or targetVelocity.Y
	local airborne
	if data then
		airborne = data.airborne == true
	elseif targetAirborne ~= nil then
		airborne = targetAirborne == true
	else
		airborne = math.abs(vy) > 3
	end

	local g = validNumber(playerGravity) and playerGravity > 0 and playerGravity or workspace.Gravity
	local stand = data and data.stand or 3
	local rise = riseRate(data)
	local pillaring = rise > 0
	local bias = pillaring and PILLAR_BIAS or 0

	return function(t)
		local flat = hv * t
		if flat.Magnitude > module.MaxLead then
			flat = flat.Unit * module.MaxLead
		end

		local y = rootPos.Y
		if airborne then
			y = rootPos.Y + vy * t - 0.5 * g * t * t
			if root then
				local probe = Vector3.new(rootPos.X + flat.X, math.max(rootPos.Y, y) + 1, rootPos.Z + flat.Z)
				local hit = castFloor(probe, (probe.Y - y) + stand + 60)
				if hit then
					local floorRoot = hit.Position.Y + stand
					if y < floorRoot then
						y = floorRoot
					end
				end
			end
		end

		if pillaring then
			local groundY = data.groundY or rootPos.Y
			y = math.max(y, rootPos.Y, groundY + rise * t)
		end

		local dy = math.clamp(y - rootPos.Y, -module.MaxVerticalLead, module.MaxVerticalLead)
		return rootPos + partOffset + flat + Vector3.new(0, dy + bias, 0)
	end
end

module.PredictPosition = function(targetPos, targetVelocity, time, targetRoot, targetAirborne, playerGravity)
	if not validVector(targetPos) or not validNumber(time) then return targetPos end
	local root = typeof(targetRoot) == 'Instance' and targetRoot or nil
	return buildPredictor(targetPos, validVector(targetVelocity) and targetVelocity or Vector3.zero, root, targetAirborne, playerGravity)(time)
end

function module.GetSpawnPosition(positionFrom, aimPoint, relX, relY, relZ)
	if not validVector(positionFrom) or not validVector(aimPoint) then return positionFrom end
	if (aimPoint - positionFrom).Magnitude <= eps then return positionFrom end
	return (CFrame.new(positionFrom, aimPoint) * CFrame.new(relX or 0.8, relY or -0.6, relZ or 0)).Position
end

local function solveStatic(origin, projectileSpeed, projectileAccel, point, minimumTime, maxTime)
	return module.SolveIntercept(origin, projectileSpeed, projectileAccel, point, Vector3.zero, Vector3.zero, minimumTime, maxTime, false)
end

module.SolveTrajectory = function(origin, projectileSpeed, gravity, targetPos, targetVelocity, playerGravity, playerHeight, playerJump, params, targetAirborne, targetRootPosition, targetRoot, minimumTime, strict)
	targetVelocity = targetVelocity or Vector3.zero
	projectileSpeed = tonumber(projectileSpeed) or 0
	gravity = tonumber(gravity) or 0

	if not validVector(origin)
		or not validVector(targetPos)
		or not validVector(targetVelocity)
		or not validNumber(projectileSpeed)
		or projectileSpeed <= eps
		or not validNumber(gravity)
	then
		if strict then return nil end
		return targetPos, targetPos, 0
	end

	local projectileAccel = Vector3.new(0, -gravity, 0)
	local maxTime = 10
	if validNumber(minimumTime) then
		maxTime = math.max(maxTime, minimumTime + 1)
	end

	local root = typeof(targetRoot) == 'Instance' and targetRoot or (typeof(targetRootPosition) == 'Instance' and targetRootPosition) or nil
	local predict = buildPredictor(targetPos, targetVelocity, root, targetAirborne, playerGravity)
	local latency = module.getRawLatency() * 0.5

	local solution = solveStatic(origin, projectileSpeed, projectileAccel, targetPos, minimumTime, maxTime)
	if not solution then
		if strict then return nil end
		return targetPos, targetPos, 0
	end

	local aimPoint = targetPos
	for _ = 1, 8 do
		local nextAim = predict(solution.FlightTime + latency)
		local nextSolution = solveStatic(origin, projectileSpeed, projectileAccel, nextAim, minimumTime, maxTime)
		if not nextSolution then break end
		local settled = math.abs(nextSolution.FlightTime - solution.FlightTime) < 0.001
		solution = nextSolution
		aimPoint = nextAim
		if settled then break end
	end

	local launchVelocity = solution.InitialVelocity
	if not validVector(launchVelocity) or launchVelocity.Magnitude <= eps then
		if strict then return nil end
		return targetPos, targetPos, 0
	end

	if params and solution.FlightTime then
		local clear = module.IsTrajectoryClear(origin, launchVelocity, gravity, solution.FlightTime * 0.97, params, nil, nil)
		if clear == false and root then
			for _, raise in {0.6, 1.2, 1.8} do
				local raised = aimPoint + Vector3.new(0, raise, 0)
				local raisedSolution = solveStatic(origin, projectileSpeed, projectileAccel, raised, minimumTime, maxTime)
				if raisedSolution and validVector(raisedSolution.InitialVelocity) then
					if module.IsTrajectoryClear(origin, raisedSolution.InitialVelocity, gravity, raisedSolution.FlightTime * 0.97, params, nil, nil) ~= false then
						solution = raisedSolution
						launchVelocity = raisedSolution.InitialVelocity
						aimPoint = raised
						clear = true
						break
					end
				end
			end
		end
		if clear == false and strict then
			return nil
		end
	end

	return origin + launchVelocity, aimPoint, solution.FlightTime
end

return module
