-- bedwars lobby

local run = function(func) func() end
local cloneref = cloneref or function(obj) return obj end
local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local inputService = cloneref(game:GetService('UserInputService'))
local tweenService = cloneref(game:GetService('TweenService'))
local runService = cloneref(game:GetService('RunService')) 
local httpService = cloneref(game:GetService('HttpService'))
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local sessioninfo = vape.Libraries.sessioninfo
local bedwars = {}

local function notif(...)
	return vape:CreateNotification(...)
end

run(function()
	local function dumpRemote(tab)
		local ind = table.find(tab, 'Client')
		return ind and tab[ind + 1] or ''
	end
	local KnitInit, Knit
	repeat
		KnitInit, Knit = pcall(function()
			return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 9)
		end)
		if KnitInit then break end
		task.wait(0.1)
	until KnitInit

	if not debug.getupvalue(Knit.Start, 1) then
		repeat task.wait(0.1) until debug.getupvalue(Knit.Start, 1)
	end

	local Flamework = require(replicatedStorage['rbxts_include']['node_modules']['@flamework'].core.out).Flamework
	local InventoryUtil = require(replicatedStorage.TS.inventory['inventory-util']).InventoryUtil
	local Client = require(replicatedStorage.TS.remotes).default.Client
	local OldGet, OldBreak = Client.Get
	local function safeGetProto(func, index)
		if not func then return nil end
		local success, proto = pcall(safeGetProto, func, index)
		if success then
			return proto
		else
			warn("function:", func, "index:", index) 
			return nil
		end
	end

	bedwars = setmetatable({
	 	MatchHistroyApp = require(lplr.PlayerScripts.TS.controllers.global["match-history"].ui["match-history-moderation-app"]).MatchHistoryModerationApp,
	 	MatchHistroyController = Knit.Controllers.MatchHistoryController,
		AbilityController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/ability/ability-controller@AbilityController'),
		AnimationType = require(replicatedStorage.TS.animation['animation-type']).AnimationType,
		AnimationUtil = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out['shared'].util['animation-util']).AnimationUtil,
		AppController = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.controllers['app-controller']).AppController,
		BedBreakEffectMeta = require(replicatedStorage.TS.locker['bed-break-effect']['bed-break-effect-meta']).BedBreakEffectMeta,
		BedwarsKitMeta = require(replicatedStorage.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta,
		ClickHold = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out.client.ui.lib.util['click-hold']).ClickHold,
		Client = Client,
		ClientConstructor = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts'].net.out.client),
		MatchHistoryController = require(lplr.PlayerScripts.TS.controllers.global['match-history']['match-history-controller']),
		PlayerProfileUIController = require(lplr.PlayerScripts.TS.controllers.global['player-profile']['player-profile-ui-controller']),
		TitleTypes = require(game.ReplicatedStorage.TS.locker.title['title-type']).TitleType,
		TitleTypesMeta =  require(game.ReplicatedStorage.TS.locker.title['title-meta']).TitleMeta,
		EmoteType = require(replicatedStorage.TS.locker.emote['emote-type']).EmoteType,
		GameAnimationUtil = require(replicatedStorage.TS.animation['animation-util']).GameAnimationUtil,
		NotificationController = Flamework.resolveDependency('@easy-games/game-core:client/controllers/notification-controller@NotificationController'),
		getIcon = function(item, showinv)
			local itemmeta = bedwars.ItemMeta[item.itemType]
			return itemmeta and showinv and itemmeta.image or ''
		end,
		getInventory = function(plr)
			local suc, res = pcall(function()
				return InventoryUtil.getInventory(plr)
			end)
			return suc and res or {
				items = {},
				armor = {}
			}
		end,
		HudAliveCount = require(lplr.PlayerScripts.TS.controllers.global['top-bar'].ui.game['hud-alive-player-counts']).HudAlivePlayerCounts,
		ItemMeta = (function()
			local ok, mod = pcall(require, replicatedStorage.TS.item['item-meta'])
			if ok and mod and mod.getItemMeta then
				return debug.getupvalue(mod.getItemMeta, 1) or {}
			end
			return {}
		end)(),
		Knit = Knit,
		KnockbackUtil = require(replicatedStorage.TS.damage['knockback-util']).KnockbackUtil,
		MageKitUtil = require(replicatedStorage.TS.games.bedwars.kit.kits.mage['mage-kit-util']).MageKitUtil,
		NametagController = Knit.Controllers.NametagController,
		PartyController = Flamework.resolveDependency('@easy-games/lobby:client/controllers/party-controller@PartyController'),
		ProjectileMeta = require(replicatedStorage.TS.projectile['projectile-meta']).ProjectileMeta,
		QueryUtil = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil,
		QueueCard = require(lplr.PlayerScripts.TS.controllers.global.queue.ui['queue-card']).QueueCard,
		QueueMeta = require(replicatedStorage.TS.game['queue-meta']).QueueMeta,
		Roact = require(replicatedStorage['rbxts_include']['node_modules']['@rbxts']['roact'].src),
		RuntimeLib = require(replicatedStorage['rbxts_include'].RuntimeLib),
		SoundList = require(replicatedStorage.TS.sound['game-sound']).GameSound,
		Store = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
		TeamUpgradeMeta = (function()
			local ok, mod = pcall(require, replicatedStorage.TS.games.bedwars['team-upgrade']['team-upgrade-meta'])
			if ok and mod and mod.getTeamUpgradeMetaForQueue then
				return debug.getupvalue(mod.getTeamUpgradeMetaForQueue, 6) or {}
			end
			return {}
		end)(),
		UILayers = require(replicatedStorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).UILayers,
		VisualizerUtils = require(lplr.PlayerScripts.TS.lib.visualizer['visualizer-utils']).VisualizerUtils,
		WeldTable = require(replicatedStorage.TS.util['weld-util']).WeldUtil,
		WinEffectMeta = require(replicatedStorage.TS.locker['win-effect']['win-effect-meta']).WinEffectMeta,
		ZapNetworking = require(lplr.PlayerScripts.TS.lib.network),
	}, {
		__index = function(self, ind)
			rawset(self, ind, Knit.Controllers[ind])
			return rawget(self, ind)
		end
	})

	local kills = sessioninfo:AddItem('Kills')
	local beds = sessioninfo:AddItem('Beds')
	local wins = sessioninfo:AddItem('Wins')
	local games = sessioninfo:AddItem('Games')

	vape:Clean(function()
		table.clear(bedwars)
	end)
end)

for _, v in {'AntiRagdoll', 'TriggerBot', 'SilentAim', 'AutoRejoin', 'Rejoin', 'Disabler', 'Timer', 'ServerHop', 'MouseTP', 'MurderMystery', 'NameTags', 'Killaura', 'AimAssist', 'AutoClicker', 'Reach', 'AntiFall', 'Fly', 'HitBoxes', 'LongJump', 'Speed', 'Swim', 'PlayerModel', 'Search', 'Waypoints', 'Blink', 'StaffDetector', ''} do
	vape:Remove(v)
end

run(function()
	local Sprint
	local old
	
	Sprint = vape.Categories.Combat:CreateModule({
		Name = 'Sprint',
		Function = function(callback)
			if callback then
				if inputService.TouchEnabled then pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = false end) end
				old = bedwars.SprintController.stopSprinting
				bedwars.SprintController.stopSprinting = function(...)
					local call = old(...)
					bedwars.SprintController:startSprinting()
					return call
				end
				Sprint:Clean(entitylib.Events.LocalAdded:Connect(function() bedwars.SprintController:stopSprinting() end))
				bedwars.SprintController:stopSprinting()
			else
				if inputService.TouchEnabled then pcall(function() lplr.PlayerGui.MobileUI['2'].Visible = true end) end
				bedwars.SprintController.stopSprinting = old
				bedwars.SprintController:stopSprinting()
			end
		end,
		Tooltip = 'Sets your sprinting to true.'
	})
end)
	
run(function()
	local AutoGamble
	local SpawnRemote = bedwars.Client:GetNamespace('RewardCrate'):Get('SpawnRewardCrate')
	local OpenRemote = bedwars.Client:GetNamespace('RewardCrate'):Get('OpenRewardCrate')
	local crateTypes = {'level_up_crate', 'diamond_lucky_crate', 'afk_crate', 'murder_crate', 'kitskin_crate'}

	local function getNextCrateId(skip)
		local active = bedwars.CrateAltarController and bedwars.CrateAltarController.activeCrates
		if type(active) ~= 'table' then return nil end
		for _, crateList in pairs(active) do
			if type(crateList) == 'table' then
				for _, crate in pairs(crateList) do
					if type(crate) == 'table' then
						local id = crate.attributes and crate.attributes.crateId
						if not id and crate.instance then
							local ok, a = pcall(function() return crate.instance:GetAttribute('crateId') end)
							if ok then id = a end
						end
						if id and not (skip and skip[id]) then
							return id
						end
					end
				end
			end
		end
		return nil
	end

	AutoGamble = vape.Categories.Minigames:CreateModule({
		Name = 'AutoGamble',
		Function = function(callback)
			if callback then
				pcall(function()
					AutoGamble:Clean(bedwars.Client:GetNamespace('RewardCrate'):Get('CrateOpened'):Connect(function(data)
						if data.openingPlayer == lplr then
							local tab = bedwars.CrateItemMeta and bedwars.CrateItemMeta[data.reward.itemType] or {displayName = data.reward.itemType or 'unknown'}
							notif('AutoGamble', 'Won '..tab.displayName, 5)
						end
					end))
				end)

				task.spawn(function()
					local opened = {}
					local spawnAltar = 1
					local knownType = nil
					repeat
						local crateId = getNextCrateId(opened)
						if crateId then
							opened[crateId] = true
							OpenRemote:SendToServer({ crateId = crateId })
							task.wait(1)
						else
							local list = knownType and {knownType} or crateTypes
							local spawned = false
							for _, ct in ipairs(list) do
								if not AutoGamble.Enabled then break end
								SpawnRemote:SendToServer({ altarId = spawnAltar, crateType = ct, useAltarUpgrade = false })
								for _ = 1, 12 do
									if not AutoGamble.Enabled then break end
									if getNextCrateId(opened) then
										knownType = ct
										spawned = true
										break
									end
									task.wait(0.2)
								end
								if spawned then break end
							end
							spawnAltar = spawnAltar == 1 and 0 or 1
							if not spawned then
								knownType = nil
								task.wait(0.5)
							end
						end
					until not AutoGamble.Enabled
				end)
			end
		end,
		Tooltip = 'auto opens whatever crate u own on whatever altar is open'
	})
end)
	
run(function()
    local ok, err = pcall(function()
        repeat task.wait() until vape and vape.Categories and vape.Categories.Render
        local ClanModule
        local ClanColor = Color3.new(1, 1, 1)
        local enabledFlag = false
        local EquippedTag = nil
    
        local SavedTags = {}
        local TagToggles = {}
        
        local function safeSet(attr, value)
            local lp = game.Players.LocalPlayer
            if lp and lp.SetAttribute then
                pcall(function()
                    lp:SetAttribute(attr, value)
                end)
            end
        end
        
        local function buildTag()
            if not EquippedTag then return "" end
            local hex = string.format("#%02X%02X%02X",
                ClanColor.R * 255,
                ClanColor.G * 255,
                ClanColor.B * 255
            )
            return "<font color='"..hex.."'>"..EquippedTag.."</font>"
        end
        
        local function updateClanTag()
            if enabledFlag then
                safeSet("ClanTag", buildTag())
            else
                safeSet("ClanTag", "")
            end
        end
        
        local function createTagToggles()
            for i, toggle in pairs(TagToggles) do
                if toggle and toggle.Object then
                    toggle.Object:Remove()
                end
            end
            TagToggles = {}
            
            for i, tag in ipairs(SavedTags) do
                if tag and tag ~= "" then
                    TagToggles[i] = ClanModule:CreateToggle({
                        Name = tag,
                        Function = function(callback)
                            if callback then
                                EquippedTag = tag
                                for j, otherToggle in pairs(TagToggles) do
                                    if j ~= i and otherToggle and otherToggle.Enabled then
                                        otherToggle:Toggle()
                                    end
                                end
                            else
                                if EquippedTag == tag then
                                    EquippedTag = nil
                                end
                            end
                            updateClanTag()
                        end
                    })
                end
            end
        end
        
        ClanModule = vape.Categories.Render:CreateModule({
            Name = "CustomClanTag",
            HoverText = "Click tags to equip/unequip",
            Function = function(state)
                enabledFlag = state
                if state then
                    createTagToggles()
                end
                updateClanTag()
            end
        })
        
        ClanModule:CreateColorSlider({
            Name = "Tag Color",
            Function = function(h, s, v)
                ClanColor = Color3.fromHSV(h, s, v)
                updateClanTag()
            end
        })
        
        ClanModule:CreateTextList({
            Name = "Clan Tags",
            Placeholder = "Add tags here",
            Function = function(list)
                SavedTags = {}
                for i, tag in ipairs(list) do
                    if tag and tag ~= "" then
                        table.insert(SavedTags, tag)
                    end
                end
                createTagToggles()
            end
        })
        
    end)
    if not ok then
        warn("CustomClanTag error:", err)
    end
end)

run(function()
	local ViewMatchHistory
	ViewMatchHistory = vape.Categories.Utility:CreateModule({
		Name = "ViewMatchHistory",
		Function = function(callback)
			if callback then
				ViewMatchHistory:Toggle(false)
				local d = nil
				bedwars.MatchHistroyController:requestMatchHistory(lplr.Name):andThen(function(Data)
					if Data then
						bedwars.AppController:openApp({app = bedwars.MatchHistroyApp,appId = "MatchHistoryApp",},Data)
					end
				end)
			else
				return
			end
		end,
		Tooltip = "matchhisory"
	})																								
end)

run(function()
	local OGNameTags
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local CollectionService = game:GetService("CollectionService")
	local LP = Players.LocalPlayer
	local FLAME_IMAGE = "rbxassetid://7101948108"
	local BedwarsImageId = require(ReplicatedStorage.TS.image["image-id"]).BedwarsImageId
	local TITLE_STROKE_TRANSP = nil
	local WIN_TEXT_PULL_LEFT = 14
	local ORIGINAL_NAMETAG_SCALE = 1.17
	local TITLE_TEXT_SIZE = 14
	local FLAME_ASPECT_RATIO = 0.8
	
	local KnitClient
	do
		local ok, knitMod = pcall(function()
			return require(ReplicatedStorage.rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
		end)
		if ok then KnitClient = knitMod end
	end
	
	local function divisionToRankKey(division)
		if division >= 0 and division <= 3 then return "BRONZE_RANK"
		elseif division >= 4 and division <= 7 then return "SILVER_RANK"
		elseif division >= 8 and division <= 11 then return "GOLD_RANK"
		elseif division >= 12 and division <= 15 then return "PLATINUM_RANK"
		elseif division >= 16 and division <= 19 then return "DIAMOND_RANK"
		elseif division >= 20 and division <= 23 then return "EMERALD_RANK"
		elseif division == 24 then return "NIGHTMARE_RANK"
		end
		return "RANDOM_KIT_RENDER"
	end
	
	local function requestNametagData(callback)
		if not KnitClient or not KnitClient.Controllers or not KnitClient.Controllers.NametagController then return end
		local ctrl = KnitClient.Controllers.NametagController
		local ok, promise = pcall(function()
			return ctrl:requestNametagData(LP)
		end)
		if not ok or not promise then return end
		if typeof(promise) == "table" and promise.andThen then
			promise:andThen(function(data) callback(data) end)
		end
	end
	
	local function findLocalOriginalNametag(char)
		local head = char:FindFirstChild("Head")
		if not head then return nil end
		
		local direct = head:FindFirstChild("Nametag")
		if direct and direct:IsA("BillboardGui") then
			return direct
		end
		
		for _, gui in ipairs(CollectionService:GetTagged("EntityNameTag")) do
			if gui:IsA("BillboardGui") and (gui.Adornee == head or gui:IsDescendantOf(char)) then
				return gui
			end
		end
		
		return nil
	end
	
	local function scaleOriginalNametagSlightly(originalGui)
		if not originalGui then return end
		
		local attrW = originalGui:GetAttribute("BaseSizeW")
		local attrH = originalGui:GetAttribute("BaseSizeH")
		
		if type(attrW) ~= "number" or type(attrH) ~= "number" then
			originalGui:SetAttribute("BaseSizeW", originalGui.Size.X.Scale)
			originalGui:SetAttribute("BaseSizeH", originalGui.Size.Y.Scale)
			attrW = originalGui.Size.X.Scale
			attrH = originalGui.Size.Y.Scale
		end
		
		local w = (attrW or originalGui.Size.X.Scale) * ORIGINAL_NAMETAG_SCALE
		local h = (attrH or originalGui.Size.Y.Scale) * ORIGINAL_NAMETAG_SCALE
		
		originalGui.Size = UDim2.fromScale(w, h)
	end
	
	local function hideMiddleNameAndLevel(originalGui)
		if not originalGui then return end
		
		local container = originalGui:FindFirstChild("DisplayNameContainer", true)
		if container and container:IsA("GuiObject") then container.Visible = false end
		
		local nameLabel = originalGui:FindFirstChild("DisplayName", true)
		if nameLabel and nameLabel:IsA("TextLabel") then nameLabel.Visible = false end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local t = tostring(d.Text or "")
				if t:match("^%(%d+%)") then d.Visible = false end
			end
		end
	end
	
	local function hideOldWinStreakOnly(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local name = string.lower(d.Name or "")
				local txt = tostring(d.Text or "")
				if name:find("winstreak") or name:find("streak") or txt:find("🔥") then
					d.Visible = false
				end
			elseif d:IsA("ImageLabel") then
				local name = string.lower(d.Name or "")
				local img = tostring(d.Image or "")
				if name:find("winstreak") or name:find("streak") or img == FLAME_IMAGE then
					d.Visible = false
				end
			end
		end
	end
	
	local RANK_ICON_IMAGES = {}
	do
		local keys = {
			"BRONZE_RANK","SILVER_RANK","GOLD_RANK","PLATINUM_RANK",
			"DIAMOND_RANK","EMERALD_RANK","NIGHTMARE_RANK",
		}
		for _, k in ipairs(keys) do
			local img = BedwarsImageId[k]
			if type(img) == "string" and img ~= "" then
				RANK_ICON_IMAGES[img] = true
			end
		end
	end
	
	local function hideOldRankIconOnly(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("ImageLabel") then
				local name = string.lower(d.Name or "")
				local img = tostring(d.Image or "")
				
				if RANK_ICON_IMAGES[img] then
					d.Visible = false
				elseif name:find("rank") or name:find("division") or name:find("elo") then
					d.Visible = false
				end
			end
		end
	end
	
	local function fixRoleTextScaling(originalGui)
		if not originalGui then return end
		
		for _, d in ipairs(originalGui:GetDescendants()) do
			if d:IsA("TextLabel") then
				local name = string.lower(d.Name or "")
				
				if name:find("title") or name:find("playertitle") or name:find("role") then
					d.TextScaled = true
					
					if TITLE_STROKE_TRANSP ~= nil then
						d.TextStrokeTransparency = TITLE_STROKE_TRANSP
					end
				end
			end
		end
	end
	
	local function hideOtherLocalBillboards(char)
		for _, inst in ipairs(char:GetDescendants()) do
			if inst:IsA("BillboardGui") and not CollectionService:HasTag(inst, "EntityNameTag") then
				if inst.Name ~= "LocalRankStreakGui" then
					inst.Enabled = false
				end
			end
		end
	end
	
	local function createHeadLockedGui(head)
		local existing = head:FindFirstChild("LocalRankStreakGui")
		if existing and existing:IsA("BillboardGui") then
			return existing
		end
		
		local bb = Instance.new("BillboardGui")
		bb.Name = "LocalRankStreakGui"
		bb.Parent = head
		bb.Adornee = head
		bb.AlwaysOnTop = true
		bb.ResetOnSpawn = false
		bb.MaxDistance = 1000
		
		bb.Size = UDim2.fromScale(7.2, 0.9)
		bb.StudsOffset = Vector3.new(0.44, 1.45, 0)
		
		local main = Instance.new("Frame")
		main.BackgroundTransparency = 1
		main.Size = UDim2.fromScale(1, 1)
		main.Parent = bb
		
		local row = Instance.new("Frame")
		row.Name = "Row"
		row.BackgroundTransparency = 1
		row.AnchorPoint = Vector2.new(0.5, 0.5)
		row.Position = UDim2.fromScale(0.525, 0.5)
		row.Size = UDim2.fromScale(1, 1)
		row.Parent = main
		
		local layout = Instance.new("UIListLayout")
		layout.FillDirection = Enum.FillDirection.Horizontal
		layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		layout.VerticalAlignment = Enum.VerticalAlignment.Center
		layout.Padding = UDim.new(0, 10)  
		layout.Parent = row
		
		local rank = Instance.new("ImageLabel")
		rank.Name = "RankIcon"
		rank.BackgroundTransparency = 1
		rank.Size = UDim2.fromScale(0.16, 0.95)
		rank.Parent = row
		local rAspect = Instance.new("UIAspectRatioConstraint")
		rAspect.AspectRatio = 1
		rAspect.Parent = rank
		
		local winGroup = Instance.new("Frame")
		winGroup.Name = "WinGroup"
		winGroup.BackgroundTransparency = 1
		winGroup.Size = UDim2.fromScale(0.28, 1.05)  
		winGroup.Parent = row
		
		local flame = Instance.new("ImageLabel")
		flame.Name = "WinFlame"
		flame.BackgroundTransparency = 1
		flame.Image = FLAME_IMAGE
		flame.AnchorPoint = Vector2.new(0, 0.5)
		flame.Position = UDim2.fromScale(0, 0.5)
		flame.Size = UDim2.fromScale(0.24, 1.05)
		flame.Parent = winGroup
		
		local fAspect = Instance.new("UIAspectRatioConstraint")
		fAspect.AspectRatio = FLAME_ASPECT_RATIO  
		fAspect.Parent = flame
		
		local num = Instance.new("TextLabel")
		num.Name = "WinStreak"
		num.BackgroundTransparency = 1
		num.Font = Enum.Font.Gotham
		num.TextColor3 = Color3.fromRGB(255, 255, 255)
		num.TextStrokeTransparency = 1
		num.TextXAlignment = Enum.TextXAlignment.Left
		num.TextYAlignment = Enum.TextYAlignment.Center
		
		num.TextScaled = true
		
		num.AnchorPoint = Vector2.new(0, 0.5)
		num.Position = UDim2.fromScale(0.28, 0.5) 
		num.Size = UDim2.new(0.72, 0, 0.94, 0)   
		num.Parent = winGroup
		
		local winLayout = Instance.new("UIListLayout")
		winLayout.FillDirection = Enum.FillDirection.Horizontal
		winLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
		winLayout.VerticalAlignment = Enum.VerticalAlignment.Center
		winLayout.Padding = UDim.new(0, 2)
		winLayout.Parent = winGroup
		
		return bb
	end
	
	local function forceWinTextStyle(gui) end
	
	local function updateGui(gui, data)
		if not gui then return end
		
		local streak = 0
		local division = -1
		if data then
			if data.winstreak ~= nil then streak = tonumber(data.winstreak) or 0 end
			if data.rankDivision ~= nil then division = tonumber(data.rankDivision) or -1 end
		end
		
		local rank = gui:FindFirstChild("RankIcon", true)
		if rank and rank:IsA("ImageLabel") then
			local key = divisionToRankKey(division)
			rank.Image = BedwarsImageId[key] or ""
		end
		
		local flame = gui:FindFirstChild("WinFlame", true)
		if flame and flame:IsA("ImageLabel") then
			flame.Image = FLAME_IMAGE
		end
		
		local num = gui:FindFirstChild("WinStreak", true)
		if num and num:IsA("TextLabel") then
			num.Text = tostring(streak)
		end
		
		forceWinTextStyle(gui)
	end
	
	local activeLoop = nil
	
	local function setup(char)
		local head = char:WaitForChild("Head", 5)
		if not head then return end
		
		local headGui = createHeadLockedGui(head)
		
		activeLoop = task.spawn(function()
			while char.Parent and OGNameTags.Enabled do
				task.wait(0.25)
				
				hideOtherLocalBillboards(char)
				
				local original = findLocalOriginalNametag(char)
				if original then
					hideMiddleNameAndLevel(original)
					hideOldWinStreakOnly(original)
					hideOldRankIconOnly(original)
				end
				
				requestNametagData(function(data)
					updateGui(headGui, data)
				end)
				
				forceWinTextStyle(headGui)
			end
		end)
	end
	
	local function cleanup()
		if activeLoop then
			task.cancel(activeLoop)
			activeLoop = nil
		end
		
		if LP.Character then
			local head = LP.Character:FindFirstChild("Head")
			if head then
				local customGui = head:FindFirstChild("LocalRankStreakGui")
				if customGui then
					customGui:Destroy()
				end
			end
		end
		
		if LP.Character then
			local original = findLocalOriginalNametag(LP.Character)
			if original then
				local attrW = original:GetAttribute("BaseSizeW")
				local attrH = original:GetAttribute("BaseSizeH")
				if attrW and attrH then
					original.Size = UDim2.fromScale(attrW, attrH)
				end
				
				for _, d in ipairs(original:GetDescendants()) do
					if d:IsA("GuiObject") then
						d.Visible = true
					end
				end
			end
		end
	end
	
	OGNameTags = vape.Categories.Render:CreateModule({
		Name = 'OGNameTags',
		Function = function(callback)
			if callback then
				if LP.Character then
					setup(LP.Character)
				end
				
				OGNameTags:Clean(LP.CharacterAdded:Connect(function(char)
					setup(char)
				end))
			else
				cleanup()
			end
		end,
		Tooltip = 'Custom nametag with rank icon and winstreak (lobby only)'
	})
	
	local TitleSizeSlider = OGNameTags:CreateSlider({
		Name = 'Title Scale',
		Min = 1.0,
		Max = 1.5,
		Default = 1.17,
		Decimal = 100,
		Function = function(val)
			ORIGINAL_NAMETAG_SCALE = val
			if LP.Character and OGNameTags.Enabled then
				local original = findLocalOriginalNametag(LP.Character)
				if original then
					scaleOriginalNametagSlightly(original)
					fixRoleTextScaling(original)
				end
			end
		end,
		Tooltip = 'Scale original nametag to make title/role bigger'
	})
end)

run(function()
	local TC
	local list
	local TABLE = {}
	local old
	TC = vape.Categories.Render:CreateModule({
	Name = "TitleChanger",
	Function = function(callback)
		if callback then
			if old then else old = lplr:GetAttribute("TitleType") end
				local att = list.Value or ""
				lplr:SetAttribute("TitleType",att)
				task.wait(.85) 
				if lplr:GetAttribute("TitleType") == old then
					att = list.Value or ""
					lplr:SetAttribute("TitleType",att)
				end
			else
				lplr:SetAttribute("TitleType",old)
				old = nil
			end
		end,
		Tooltip ='Client Sided Titles :D'
	})
	for _, v in pairs(bedwars.TitleTypes) do
		TABLE[#TABLE+1] = v
	end
	list = TC:CreateDropdown({
		Name = "Titles",
		List = TABLE,
		Function = function()
			if old then else old = lplr:GetAttribute("TitleType") end
				lplr:SetAttribute("TitleType",list.Value)
			end,
		})
end)

run(function()
	local LeaderboardSpoof
	local RS = game.ReplicatedStorage

	local CURRENT_BOARD = "Ranked"
	local CUSTOM_POSITION = 1
	local CUSTOM_STAT = 5000
	local SHOW_IN_LIST = true
	local savedFullLeaderboards = nil

	local ClientStore
	pcall(function() ClientStore = bedwars.Store end)

	local function getBoardKey()
		if CURRENT_BOARD == "Ranked" then
			local key = "RankPoints_S15"
			pcall(function()
				key = require(RS.TS.rank["rank-util"]).RankUtil.activeRankMeta.leaderboard
			end)
			return key, true
		elseif CURRENT_BOARD == "Overall Wins" then
			return "OverallWins", false
		elseif CURRENT_BOARD == "Monthly Wins" then
			return "Wins", false
		elseif CURRENT_BOARD == "Top Gifters" then
			return "gift_leaderboard", false
		end
		return nil, false
	end

	local function computeRankDisplay(totalRP)
		local result = nil
		pcall(function()
			local RankMeta = require(RS.TS.rank["rank-meta"]).RankMeta
			local divisionIndex = math.min(math.floor(totalRP / 100), 24) 
			local remainder = totalRP - divisionIndex * 100            
			local rankInfo = RankMeta[divisionIndex]
			if rankInfo then
				result = {
					image = rankInfo.image,
					rankName = rankInfo.name,
					rankStatValue = remainder,   
				}
			end
		end)
		return result
	end

	local function doDispatch()
		if not ClientStore then return end
		local boardKey, isRanked = getBoardKey()
		if not boardKey then return end

		local state = ClientStore:getState()
		local currentLeaderboards = state.Leaderboard and state.Leaderboard.leaderboards

		if not savedFullLeaderboards and currentLeaderboards then
			savedFullLeaderboards = {}
			for k, v in pairs(currentLeaderboards) do
				savedFullLeaderboards[k] = v
			end
		end

		local lp = game.Players.LocalPlayer
		local rankDisplay = isRanked and computeRankDisplay(CUSTOM_STAT) or nil

		local localUser = {
			username = lp.Name,
			avatarImage = "rbxthumb://type=AvatarHeadShot&id=" .. lp.UserId .. "&w=60&h=60",
			statValue = rankDisplay and rankDisplay.rankStatValue or CUSTOM_STAT,  
			userId = lp.UserId,
		}
		if rankDisplay then
			localUser.statRank = rankDisplay
		end

		local newLeaderboards = {}
		if currentLeaderboards then
			for k, v in pairs(currentLeaderboards) do
				newLeaderboards[k] = v
			end
		end

		local currentBoardData = currentLeaderboards and currentLeaderboards[boardKey]
		local users = {}
		if currentBoardData and currentBoardData.users then
			for _, u in ipairs(currentBoardData.users) do
				if u.userId ~= lp.UserId then
					table.insert(users, u)
				end
			end
		end

		if SHOW_IN_LIST then
			local pos = math.max(1, math.min(CUSTOM_POSITION, #users + 1))
			table.insert(users, pos, localUser)
		end

		local newData = {
			lastRefresh = os.time(),
			users = users,
			leaderboardPosition = CUSTOM_POSITION,
			localStatValue = rankDisplay and rankDisplay.rankStatValue or CUSTOM_STAT,  
		}
		if rankDisplay then
			newData.localStatRank = rankDisplay
		end
		if currentBoardData and currentBoardData.nextReset then
			newData.nextReset = currentBoardData.nextReset
		end

		newLeaderboards[boardKey] = newData

		ClientStore:dispatch({
			type = "UpdateAllLeaderboards",
			leaderboards = newLeaderboards,
		})
	end

	local function doRevert()
		if not ClientStore or not savedFullLeaderboards then return end
		ClientStore:dispatch({
			type = "UpdateAllLeaderboards",
			leaderboards = savedFullLeaderboards,
		})
		savedFullLeaderboards = nil
	end

	LeaderboardSpoof = vape.Categories.Minigames:CreateModule({
		Name = "LeaderboardSpoof",
		Function = function(enabled)
			if enabled then doDispatch() else doRevert() end
		end,
		Tooltip = "Spoof your leaderboard stats (client sided only)"
	})

	LeaderboardSpoof:CreateDropdown({
		Name = "Board",
		List = {"Ranked", "Overall Wins", "Monthly Wins", "Top Gifters"},
		Default = "Ranked",
		Function = function(val)
			CURRENT_BOARD = val
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateSlider({
		Name = "Position",
		Min = 1,
		Max = 200,
		Default = 1,
		Decimal = 1,
		Function = function(val)
			CUSTOM_POSITION = math.floor(val)
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateSlider({
		Name = "Stat Value",
		Min = 1,
		Max = 4000,
		Default = 2400,
		Decimal = 1,
		Function = function(val)
			CUSTOM_STAT = math.floor(val)
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})

	LeaderboardSpoof:CreateToggle({
		Name = "Show In List",
		Default = true,
		Function = function(state)
			SHOW_IN_LIST = state
			if LeaderboardSpoof.Enabled then doDispatch() end
		end
	})
end)

run(function()
	local NameTags
	local StreamProof
	local Targets
	local Color
	local Background
	local DisplayName
	local Health
	local HealthColorToggle
	local HealthColorFull
	local HealthColorMid
	local HealthColorLow
	local Distance
	local Equipment
	local Loot
	local Potions
	local potionDefs = {
		{name = 'PotSerpent', attr = 'StatusEffect_serpents_touch_potion', item = 'serpents_touch_potion', timed = true},
		{name = 'PotFury', attr = 'StatusEffect_fury_potion', item = 'fury_potion', timed = true},
		{name = 'PotInvis', attr = 'StatusEffect_invisibility', item = 'invisibility_potion', timed = true},
		{name = 'PotJump', attr = 'JumpBoost', item = 'jump_potion', timed = false},
		{name = 'PotPie', attr = 'SpeedPieBuff', item = 'speed_pie', timed = false}
	}
	local function potionActive(char, def)
		if not char then return false end
		local val = char:GetAttribute(def.attr)
		if val == nil then return false end
		if def.timed then
			return type(val) == 'number' and val > workspace:GetServerTimeNow()
		end
		return val ~= false and val ~= 0
	end
	local Boss
	local ShowKits
	local KitTracker
	local Rank
	local DeviceIcon
	local GloopIndicator
	local Enchant
	local Scale
	local FontOption
	local Teammates
	local DistanceCheck
	local DistanceLimit
	local Strings, Sizes, Reference = {}, {}, {}
	local bossNametags = {}
	local Folder = Instance.new('Folder')
	Folder.Parent = vape.gui
	local methodused
	local Removed
	local lastUpdate = {}
	local kitCache = {}
	local lootCache = {}
	local equipmentCache = {}
	local enchantCache = {}
	local healthCache = {}
	local charCache = {}
	local enchantConnections = {}
	local gloopConnections = {}
	local kitTrackerConnections = {}
	local billboardCache = {}
	local tick = tick
	local math_floor = math.floor
	local math_round = math.round
	local math_clamp = math.clamp
	local math_huge = math.huge
	local string_format = string.format
	local vector2new = Vector2.new
	local vector3new = Vector3.new
	local color3fromHSV = Color3.fromHSV
	local color3new = Color3.new
	local gameCamera = workspace.CurrentCamera	
	local getfontsize = vape.Libraries.getfontsize
	local store = {inventories = {}}
	local remotes = {}
	local vapeEvents = setmetatable({}, {
		__index = function(self, key)
			local event = Instance.new('BindableEvent')
			rawset(self, key, event)
			return event
		end
	})

	local function getShieldAttribute(char)
		local total = char:GetAttribute('TotalShield')
		if type(total) == 'number' then
			return math.max(total, 0)
		end
		local returned = 0
		for name, val in char:GetAttributes() do
			if name:find('Shield') and type(val) == 'number' and val > 0 then
				returned += val
			end
		end
		return returned
	end

	local function removeTags(str)
		str = str:gsub('<br%s*/>', '\n')
		return (str:gsub('<[^<>]->', ''))
	end

	local function getWorldFolder()
	    local Map = workspace:FindFirstChild("Map")
	    if not Map then return nil end
	    local Worlds = Map:FindFirstChild("Worlds")
	    if not Worlds then return nil end
	    for _, world in Worlds:GetChildren() do
	        return world
	    end
	    return nil
	end

	local function addBlur(parent)
		local blur = Instance.new('ImageLabel')
		blur.Name = 'Blur'
		blur.Size = UDim2.new(1, 89, 1, 52)
		blur.Position = UDim2.fromOffset(-48, -31)
		blur.BackgroundTransparency = 1
		blur.Image = getcustomasset('aerov4/assets/new/blur.png')
		blur.ScaleType = Enum.ScaleType.Slice
		blur.SliceCenter = Rect.new(52, 31, 261, 502)
		blur.Parent = parent
		return blur
	end

	local kitImageIds = {
		['none'] = "rbxassetid://16493320215",
		["random"] = "rbxassetid://79773209697352",
		["cowgirl"] = "rbxassetid://9155462968",
		["davey"] = "rbxassetid://9155464612",
		["warlock"] = "rbxassetid://15186338366",
		["ember"] = "rbxassetid://9630017904",
		["black_market_trader"] = "rbxassetid://18922642482",
		["yeti"] = "rbxassetid://9166205917",
		["scarab"] = "rbxassetid://137137517627492",
		["defender"] = "rbxassetid://131690429591874",
		["cactus"] = "rbxassetid://104436517801089",
		["oasis"] = "rbxassetid://120283205213823",
		["berserker"] = "rbxassetid://90258047545241",
		["sword_shield"] = "rbxassetid://131690429591874",
		["airbender"] = "rbxassetid://74712750354593",
		["gun_blade"] = "rbxassetid://138231219644853",
		["frost_hammer_kit"] = "rbxassetid://11838567073",
		["spider_queen"] = "rbxassetid://95237509752482",
		["archer"] = "rbxassetid://9224796984",
		["axolotl"] = "rbxassetid://9155466713",
		["baker"] = "rbxassetid://9155463919",
		["barbarian"] = "rbxassetid://9166207628",
		["builder"] = "rbxassetid://9155463708",
		["necromancer"] = "rbxassetid://11343458097",
		["cyber"] = "rbxassetid://9507126891",
		["sorcerer"] = "rbxassetid://97940108361528",
		["bigman"] = "rbxassetid://9155467211",
		["spirit_assassin"] = "rbxassetid://10406002412",
		["farmer_cletus"] = "rbxassetid://9155466936",
		["ice_queen"] = "rbxassetid://9155466204",
		["grim_reaper"] = "rbxassetid://9155467410",
		["spirit_gardener"] = "rbxassetid://132108376114488",
		["hannah"] = "rbxassetid://10726577232",
		["shielder"] = "rbxassetid://9155464114",
		["summoner"] = "rbxassetid://18922378956",
		["glacial_skater"] = "rbxassetid://84628060516931",
		["dragon_sword"] = "rbxassetid://16215630104",
		["lumen"] = "rbxassetid://9630018371",
		["flower_bee"] = "rbxassetid://101569742252812",
		["jellyfish"] = "rbxassetid://18129974852",
		["melody"] = "rbxassetid://9155464915",
		["mimic"] = "rbxassetid://14783283296",
		["miner"] = "rbxassetid://9166208461",
		["nazar"] = "rbxassetid://18926951849",
		["seahorse"] = "rbxassetid://11902552560",
		["elk_master"] = "rbxassetid://15714972287",
		["rebellion_leader"] = "rbxassetid://18926409564",
		["void_hunter"] = "rbxassetid://122370766273698",
		["taliyah"] = "rbxassetid://13989437601",
		["angel"] = "rbxassetid://9166208240",
		["harpoon"] = "rbxassetid://18250634847",
		["void_walker"] = "rbxassetid://78915127961078",
		["spirit_summoner"] = "rbxassetid://95760990786863",
		["triple_shot"] = "rbxassetid://9166208149",
		["void_knight"] = "rbxassetid://73636326782144",
		["regent"] = "rbxassetid://9166208904",
		["vulcan"] = "rbxassetid://9155465543",
		["owl"] = "rbxassetid://12509401147",
		["dasher"] = "rbxassetid://9155467645",
		["disruptor"] = "rbxassetid://11596993583",
		["wizard"] = "rbxassetid://13353923546",
		["aery"] = "rbxassetid://9155463221",
		["agni"] = "rbxassetid://17024640133",
		["alchemist"] = "rbxassetid://9155462512",
		["spearman"] = "rbxassetid://9166207341",
		["beekeeper"] = "rbxassetid://9312831285",
		["falconer"] = "rbxassetid://17022941869",
		["bounty_hunter"] = "rbxassetid://9166208649",
		["blood_assassin"] = "rbxassetid://12520290159",
		["battery"] = "rbxassetid://10159166528",
		["steam_engineer"] = "rbxassetid://15380413567",
		["vesta"] = "rbxassetid://9568930198",
		["beast"] = "rbxassetid://9155465124",
		["dino_tamer"] = "rbxassetid://9872357009",
		["drill"] = "rbxassetid://12955100280",
		["elektra"] = "rbxassetid://13841413050",
		["fisherman"] = "rbxassetid://9166208359",
		["queen_bee"] = "rbxassetid://12671498918",
		["card"] = "rbxassetid://13841410580",
		["frosty"] = "rbxassetid://9166208762",
		["gingerbread_man"] = "rbxassetid://9155464364",
		["ghost_catcher"] = "rbxassetid://9224802656",
		["tinker"] = "rbxassetid://17025762404",
		["ignis"] = "rbxassetid://13835258938",
		["oil_man"] = "rbxassetid://9166206259",
		["jade"] = "rbxassetid://9166306816",
		["dragon_slayer"] = "rbxassetid://10982192175",
		["paladin"] = "rbxassetid://11202785737",
		["pinata"] = "rbxassetid://10011261147",
		["merchant"] = "rbxassetid://9872356790",
		["metal_detector"] = "rbxassetid://9378298061",
		["slime_tamer"] = "rbxassetid://15379766168",
		["nyoka"] = "rbxassetid://17022941410",
		["midnight"] = "rbxassetid://9155462763",
		["pyro"] = "rbxassetid://9155464770",
		["raven"] = "rbxassetid://9166206554",
		["santa"] = "rbxassetid://9166206101",
		["sheep_herder"] = "rbxassetid://9155465730",
		["smoke"] = "rbxassetid://9155462247",
		["spirit_catcher"] = "rbxassetid://9166207943",
		["star_collector"] = "rbxassetid://9872356516",
		["styx"] = "rbxassetid://17014536631",
		["block_kicker"] = "rbxassetid://15382536098",
		["trapper"] = "rbxassetid://9166206875",
		["hatter"] = "rbxassetid://12509388633",
		["ninja"] = "rbxassetid://15517037848",
		["jailor"] = "rbxassetid://11664116980",
		["warrior"] = "rbxassetid://9166207008",
		["mage"] = "rbxassetid://10982191792",
		["void_dragon"] = "rbxassetid://10982192753",
		["cat"] = "rbxassetid://15350740470",
		["wind_walker"] = "rbxassetid://9872355499",
		['skeleton'] = "rbxassetid://120123419412119",
		['winter_lady'] = "rbxassetid://83274578564074",
		['soul_broker'] = 'rbxassetid://130409166262430'
	}
	
	local function getTeamColor(ent)
		local plr = ent and ent.Player
		if not plr then return nil end
		local theirTeam = tonumber(plr:GetAttribute('Team'))
		if not theirTeam then return nil end
		local myTeam = tonumber(lplr:GetAttribute('Team'))
		if myTeam and myTeam == theirTeam then return nil end
		local entry = getgenv().aeroTeamColors[theirTeam]
		return entry and entry.color
	end
	local udim2fromOffset = UDim2.fromOffset

	local function getChainsawImage(level)
		if not level or level < 1 or level > 5 then return '' end
		local success, img = pcall(function()
			local imageModule = require(game:GetService("ReplicatedStorage"):WaitForChild("TS"):WaitForChild("image"):WaitForChild("image-id"))
			local ids = {
				[1] = imageModule.BedwarsImageId.WOOD_TINKER_MECH,
				[2] = imageModule.BedwarsImageId.IRON_TINKER_MECH,
				[3] = imageModule.BedwarsImageId.DIAMOND_TINKER_MECH,
				[4] = imageModule.BedwarsImageId.EMERALD_TINKER_MECH,
				[5] = imageModule.BedwarsImageId.VOID_TINKER_MECH,
			}
			return ids[level]
		end)
		if success and img then
			return img
		end
		local fallback = {
			[1] = "rbxassetid://1234567890", 
			[2] = "rbxassetid://1234567891", 
			[3] = "rbxassetid://1234567892", 
			[4] = "rbxassetid://1234567893", 
			[5] = "rbxassetid://1234567894", 
		}
		return fallback[level] or ''
	end

	local function splitHealth(ent)
		local shield = ent.Character and getShieldAttribute(ent.Character) or 0
		return math.round((ent.Health or 0) - shield), math.round(shield)
	end

	local function getHealthColor(ent)
		local hp = splitHealth(ent)
		local ratio = math.clamp(hp / (ent.MaxHealth and ent.MaxHealth > 0 and ent.MaxHealth or 1), 0, 1)
		if HealthColorToggle and HealthColorToggle.Enabled then
			local fullC = Color3.fromHSV(HealthColorFull.Hue, HealthColorFull.Sat, HealthColorFull.Value)
			local midC  = Color3.fromHSV(HealthColorMid.Hue,  HealthColorMid.Sat,  HealthColorMid.Value)
			local lowC  = Color3.fromHSV(HealthColorLow.Hue,  HealthColorLow.Sat,  HealthColorLow.Value)
			if ratio >= 0.5 then
				return fullC:Lerp(midC, (1 - ratio) / 0.5)
			else
				return midC:Lerp(lowC, (0.5 - ratio) / 0.5)
			end
		else
			if ratio >= 0.7 then
				return Color3.fromRGB(0, 255, 0)
			elseif ratio >= 0.3 then
				return Color3.fromRGB(255, 255, 0)
			elseif ratio >= 0.1 then
				return Color3.fromRGB(255, 165, 0)
			else
				return Color3.fromRGB(255, 0, 0)
			end
		end
	end

	local function getHealthColorStr(ent)
		local c = getHealthColor(ent)
		return 'rgb('..math.floor(c.R*255)..','..math.floor(c.G*255)..','..math.floor(c.B*255)..')'
	end

	local function healthRich(ent)
		local hp, shield = splitHealth(ent)
		local text = '<font color="'..getHealthColorStr(ent)..'">'..hp..'</font>'
		if shield > 0 then
			text = text..' <font color="rgb(255,255,255)">'..shield..'</font>'
		end
		return text
	end

	local function healthPlain(ent)
		local hp, shield = splitHealth(ent)
		return shield > 0 and (hp..' +'..shield) or tostring(hp)
	end

	local enchantImageMap = nil
	local function buildEnchantMap()
		if enchantImageMap then return enchantImageMap end
		enchantImageMap = {}
		task.spawn(function()
			if vape.ThreadFix then setthreadidentity(8) end
			local ok, meta = pcall(function()
				return require(game:GetService('ReplicatedStorage').TS.enchant['enchant-meta'])
			end)
			if not ok or not meta then return end
			for _, subMeta in pairs({meta.EnchantMeta, meta.ToolEnchantMeta, meta.ArmorEnchantMeta}) do
				if type(subMeta) == 'table' then
					for _, v in pairs(subMeta) do
						if type(v) == 'table' and v.statusEffect and v.image then
							enchantImageMap[v.statusEffect] = v.image
						end
					end
				end
			end
		end)
		return enchantImageMap
	end

	local function getActiveEnchantImage(char)
		if not char then return '' end
		local map = buildEnchantMap()
		for attr, val in pairs(char:GetAttributes()) do
			if attr:sub(1, 13) == 'StatusEffect_' and type(val) == 'number' and val < 0 then
				local effectName = attr:sub(14)
				if not effectName:find('stacks') then
					local img = map[effectName]
					if img and img ~= '' then return img end
				end
			end
		end
		return ''
	end

	local function getBossDisplayName(ent)
		if not ent.NPC or not ent.Character then return nil end
		local char = ent.Character
		if char:GetAttribute("BossType") == "Bhaa" then
			return "Bhaa"
		end
		if char.Name:lower() == "bhaa" then
			return "Bhaa"
		end
		if char:FindFirstChild("BhaaModel") or char:FindFirstChild("BhaaHead") then
			return "Bhaa"
		end
		if char.Name == "Titan" then
			return "Titan"
		end
		return nil
	end

	local function shouldShow(ent)
		if not Targets.Players.Enabled and ent.Player then return false end
		local isBoss = ent.NPC and ent.Character and getBossDisplayName(ent) ~= nil
		if isBoss then
			if not Boss.Enabled then return false end
		else
			if not Targets.NPCs.Enabled and ent.NPC then return false end
			if Teammates.Enabled and (ent.Player and lplr:GetAttribute('Team') and ent.Player:GetAttribute('Team') == lplr:GetAttribute('Team')) and (not ent.Friend) then return false end
		end
		return true
	end

	local Added = {
		Normal = function(ent)
			if Reference[ent] then Removed.Normal(ent) end
			for oldEnt in Reference do
				if oldEnt ~= ent and (not oldEnt.Character or not oldEnt.Character.Parent or (oldEnt.Player and ent.Player and oldEnt.Player == ent.Player)) then
					Removed.Normal(oldEnt)
				end
			end
			if not Targets.Players.Enabled and ent.Player then return end
			local bossDisplayName = ent.NPC and ent.Character and getBossDisplayName(ent) or nil
			local isBoss = bossDisplayName ~= nil
			if isBoss then
				if not Boss.Enabled then return end
			else
				if not Targets.NPCs.Enabled and ent.NPC then return end
				if Teammates.Enabled and (ent.Player and lplr:GetAttribute('Team') and ent.Player:GetAttribute('Team') == lplr:GetAttribute('Team')) and (not ent.Friend) then return end
			end

			local entityName = bossDisplayName or (ent.Player and nil) or ent.Character.Name
			Strings[ent] = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or entityName

			if Health.Enabled then
				Strings[ent] = Strings[ent]..' '..healthRich(ent)
			end

			if Distance.Enabled then
				Strings[ent] = '[%s] ' .. Strings[ent]
			end
			local textSize = 14 * Scale.Value
			local fontFace = FontOption.Value
			local size = getfontsize(removeTags(Strings[ent]), textSize, fontFace, vector2new(100000, 100000))
			local nametag = Instance.new('TextLabel')
			nametag.Name = ent.Player and ent.Player.Name or ent.Character.Name
			nametag.Size = udim2fromOffset(size.X + 8, size.Y + 7)
			nametag.AnchorPoint = vector2new(0.5, 1)
			nametag.BackgroundColor3 = color3new()
			nametag.BackgroundTransparency = Background.Value
			nametag.BorderSizePixel = 0
			nametag.Visible = false
			nametag.Text = Strings[ent]
			nametag.TextColor3 = getTeamColor(ent) or color3fromHSV(Color.Hue, Color.Sat, Color.Value)
			nametag.RichText = true
			nametag.TextSize = textSize
			nametag.FontFace = fontFace
			nametag.Parent = Folder

			if KitTracker and KitTracker.Enabled and ent.Player then
			  pcall(function()
				local vkRoman = {'I','II','III','IV','V'}
				local ktLabel = Instance.new('TextLabel')
				ktLabel.Name = 'KitTrackerLabel'
				ktLabel.BackgroundTransparency = 1
				ktLabel.TextScaled = false
				ktLabel.TextSize = 13
				ktLabel.FontFace = FontOption.Value
				ktLabel.RichText = true
				ktLabel.AnchorPoint = Vector2.new(1, 0.5)
				ktLabel.Position = UDim2.new(0, -2, 0.5, 0)
				ktLabel.Size = UDim2.new(0, 40, 1, 0)
				ktLabel.ZIndex = 2
				ktLabel.Parent = nametag

				local stroke = Instance.new('UIStroke')
				stroke.Color = Color3.new(0, 0, 0)
				stroke.Thickness = 1.5
				stroke.Parent = ktLabel

				local ktEventsBound = false
				local function updateKtLabel()
					if not KitTracker.Enabled then ktLabel.Text = '' return end
					local playerKit = ent.Player:GetAttribute('PlayingAsKits') or 'none'
					if playerKit == 'void_knight' then
						local tier = ent.Player:GetAttribute('VoidKnightTier') or 0
						if tier > 0 then
							ktLabel.Text = '【' .. (vkRoman[tier] or tostring(tier)) .. '】'
							ktLabel.TextColor3 = Color3.fromRGB(180, 80, 255)
						else
							ktLabel.Text = ''
						end
					elseif playerKit == 'block_kicker' then
						local char = ent.Character
						local count = (char and char:GetAttribute('BlockKickerKit_BlockCount')) or ent.Player:GetAttribute('BlockKickerKit_BlockCount') or 0
						ktLabel.Text = count > 0 and '【' .. tostring(count) .. '】' or ''
						ktLabel.TextColor3 = Color3.fromRGB(100, 210, 100)
					elseif playerKit == 'elk_master' then
						local char = ent.Character
						local isMounted = char and char:FindFirstChild('elk') ~= nil
						if isMounted then
							ktLabel.Text = '【🦌】'
							ktLabel.TextColor3 = Color3.fromRGB(160, 220, 80)
						else
							ktLabel.Text = ''
						end
					elseif playerKit == 'summoner' then
						local tier = ent.Player:GetAttribute("Summoner_ClawLevel") or 0
						if not tier or tier == 0 then ktLabel.Text = '' return end
						ktLabel.Text = '【 ' .. (vkRoman[tier] or tostring(tier)) .. ' 】'
						ktLabel.TextColor3 = Color3.fromRGB(191, 0, 255)
					elseif playerKit == 'paladin' then
						ktLabel.Text = '【 🪽 】'
						ktLabel.TextColor3 = Color3.fromRGB(255, 242, 150)
					elseif playerKit == 'davey' then
						local tier = ent.Character and ent.Character:GetAttribute('StatusEffect_powdered_stacks') or 0
						if tier > 0 then
							ktLabel.Text = '【 ' .. tostring(tier) .. ' 】'
						else
							ktLabel.Text = ''
						end
						ktLabel.TextColor3 = Color3.fromRGB(255, 105, 130)
					elseif playerKit == 'airbender' then
						ktLabel.Text = ''
						ktLabel.TextColor3 = Color3.fromRGB(255, 200, 80)
						if not ktEventsBound then
							ktEventsBound = true
							if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
							task.spawn(function()
								table.insert(kitTrackerConnections[ent], bedwars.Client:Get("Airbender_UseTornadoFromServer"):Connect(function(p12)
									if not KitTracker.Enabled then ktLabel.Text = '' return end
									if p12.tornadoData.owner == ent.Player then
										ktLabel.Text = '【 🌪️ 】'
									end
								end))
								table.insert(kitTrackerConnections[ent], bedwars.Client:Get("Airbender_EndTornadoFromServer"):Connect(function(p13)
									if not KitTracker.Enabled then ktLabel.Text = '' return end
									if p13.tornadoData.owner == ent.Player then
										ktLabel.Text = ''
									end
								end))
							end)
						end
					elseif playerKit == 'hatter' then
						ktLabel.Text = ''
						ktLabel.TextColor3 = Color3.fromRGB(45, 15, 80)
						if not ktEventsBound then
							ktEventsBound = true
							if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
							task.spawn(function()
								if vape.ThreadFix then setthreadidentity(8) end
								table.insert(kitTrackerConnections[ent], bedwars.Client:OnEvent("HatterUseTeleport", function(p14)
									if vape.ThreadFix then setthreadidentity(8) end
									if not KitTracker.Enabled then ktLabel.Text = '' return end
									local dtc = p14.arriveTime - workspace:GetServerTimeNow() + 0.05
									if p14.hatterPlayer == ent.Player then
										ktLabel.Text = '【 🎩 】'
										task.wait(dtc)
										if vape.ThreadFix then setthreadidentity(8) end
										ktLabel.Text = ''
									else
										ktLabel.Text = ''
									end
								end))
							end)
						end
					elseif playerKit == 'black_market_trader' then
						ktLabel.Text = ''
						ktLabel.TextColor3 = Color3.fromRGB(30, 10, 60)
						if not ktEventsBound then
							ktEventsBound = true
							if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
							task.spawn(function()
								table.insert(kitTrackerConnections[ent], bedwars.Client:Get("BlackMarketPlaceShop"):Connect(function(p15)
									if not KitTracker.Enabled then ktLabel.Text = '' return end
									if p15.shopOwnerUserId == ent.Player.UserId then
										ktLabel.Text = '【 🏪 】'
									end
								end))
								local worldFolder = getWorldFolder()
								local blocks = worldFolder:WaitForChild("Blocks", math.huge)
								table.insert(kitTrackerConnections[ent], blocks.ChildAdded:Connect(function(obj)
									if obj.Name == 'black_market_shop' and obj:GetAttribute('PlacedByUserId') == ent.Player.UserId then
									local billboard = Instance.new('BillboardGui')
									billboard.Parent = obj
									billboard.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
									billboard.Size = UDim2.fromOffset(36, 36)
									billboard.AlwaysOnTop = true
									billboard.ClipsDescendants = false
									local blur = addBlur(billboard)
									blur.Visible = Background.Enabled
									local image = Instance.new('ImageLabel')
									image.Size = UDim2.fromOffset(36, 36)
									image.Position = UDim2.fromScale(0.5, 0.5)
									image.AnchorPoint = Vector2.new(0.5, 0.5)
									image.BackgroundColor3 = Color3.fromHSV(0, 0, 0)
									image.BackgroundTransparency = 0.85
									image.BorderSizePixel = 0
									image.Image = bedwars.getIcon({itemType = 'shadow_coin'}, true)
									image.Parent = billboard
									local uicorner = Instance.new('UICorner')
									uicorner.CornerRadius = UDim.new(0, 4)
									uicorner.Parent = image
									if not billboardCache[ent] then billboardCache[ent] = {} end
									table.insert(billboardCache[ent], billboard)
									end
								end))
							end)
						end
					elseif playerKit == 'wizard' then
						ktLabel.TextColor3 = Color3.fromRGB(100, 70, 220)
						local function getStaffTier(v)
							local inv = store.inventories[v] and store.inventories[v].items or {}
							for _, item in inv do
								local nowstr = string.lower(item.itemType or '')
								if string.find(nowstr, 'wizard_staff') then
									return tonumber(item.itemType:sub(#item.itemType, #item.itemType)) or 1
								end
							end
						end
						local tier = getStaffTier(ent.Player)
						if not tier or tier < 0 then ktLabel.Text = '' return end
						ktLabel.Text = '【' .. (vkRoman[tier] or tostring(tier)) .. '】'
					elseif playerKit == 'aery' then
						ktLabel.TextColor3 = Color3.fromRGB(130, 210, 255)
						local stacks = ent.Player:GetAttribute('AeryStacks') or 0
						ktLabel.Text = '【' .. tostring(stacks) .. '】'
					elseif playerKit == 'mimic' then
						ktLabel.TextColor3 = Color3.fromRGB(180, 210, 60)
						ktLabel.Text = ''
						if not ktEventsBound then
							ktEventsBound = true
							if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
							task.spawn(function()
								if vape.ThreadFix then setthreadidentity(8) end
								table.insert(kitTrackerConnections[ent], bedwars.Client:OnEvent("ValidatedMimicBlock", function(p14)
									if not KitTracker.Enabled then ktLabel.Text = '' return end
									if vape.ThreadFix then setthreadidentity(8) end
									if p14.player == ent.Player then
										ktLabel.Text = '【 👔 】'
									else
										ktLabel.Text = ''
									end
								end))
								local val = workspace:FindFirstChild('DisguisedPlayerBlock_' .. ent.Player.UserId) ~= nil
								if val then ktLabel.Text = '【 👔 】' end
							end)
						end
					elseif playerKit == 'disruptor' then
						ktLabel.TextColor3 = Color3.fromRGB(40, 180, 140)
						if not ktEventsBound then
							ktEventsBound = true
							if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
							task.spawn(function()
								local worldFolder = getWorldFolder()
								local blocks = worldFolder:WaitForChild("Blocks", math.huge)
								table.insert(kitTrackerConnections[ent], blocks.ChildAdded:Connect(function(obj)
									if obj.Name == 'satellite_dish' and obj:GetAttribute('PlacedByUserId') == ent.Player.UserId then
									local billboard = Instance.new('BillboardGui')
									billboard.Parent = obj
									billboard.StudsOffsetWorldSpace = Vector3.new(0, 3, 0)
									billboard.Size = UDim2.fromOffset(36, 36)
									billboard.AlwaysOnTop = true
									billboard.ClipsDescendants = false
									local blur = addBlur(billboard)
									blur.Visible = Background.Enabled
									local image = Instance.new('ImageLabel')
									image.Size = UDim2.fromOffset(36, 36)
									image.Position = UDim2.fromScale(0.5, 0.5)
									image.AnchorPoint = Vector2.new(0.5, 0.5)
									image.BackgroundColor3 = Color3.fromHSV(0, 0, 0)
									image.BackgroundTransparency = 0.85
									image.BorderSizePixel = 0
									image.Image = bedwars.getIcon({itemType = 'satellite_dish'}, true)
									image.Parent = billboard
									local uicorner = Instance.new('UICorner')
									uicorner.CornerRadius = UDim.new(0, 4)
									uicorner.Parent = image
									if not billboardCache[ent] then billboardCache[ent] = {} end
									table.insert(billboardCache[ent], billboard)
									end
								end))
							end)
						end
						ktLabel.Text = '【 ' .. (ent.Player:GetAttribute('DisruptorTarget') and ent.Player:GetAttribute('DisruptorTarget') .. ' Team' or 'Unknown Team') .. ' 】'
					elseif playerKit == 'winter_lady' then
						ktLabel.TextColor3 = Color3.fromRGB(200, 225, 255)
						local function getWandTier(v)
							local inv = store.inventories[v] and store.inventories[v].items or {}
							for _, item in inv do
								local nowstr = string.lower(item.itemType or '')
								if string.find(nowstr, 'frost_staff') then
									return tonumber(item.itemType:sub(#item.itemType, #item.itemType)) or 1
								end
							end
						end
						local tier = getWandTier(ent.Player)
						if not tier or tier < 0 then ktLabel.Text = '' return end
						ktLabel.Text = '【' .. (vkRoman[tier] or tostring(tier)) .. '】'
					elseif playerKit == 'warrior' then
						ktLabel.TextColor3 = Color3.fromRGB(220, 60, 60)
						local grit = ent.Player:GetAttribute('Grit') or 0
						ktLabel.Text = '【 ' .. tostring(grit) .. '/100】'
					else
						ktLabel.Text = ''
					end
				end

				updateKtLabel()

				if ent.Character then
					if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
					table.insert(kitTrackerConnections[ent], ent.Character.AttributeChanged:Connect(function(attr)
						if attr == 'BlockKickerKit_BlockCount' or attr == 'StatusEffect_powdered_stacks' then
							updateKtLabel()
						end
					end))
					table.insert(kitTrackerConnections[ent], ent.Player.AttributeChanged:Connect(function(attr)
						if attr == 'DisruptorTarget' or attr == 'DisruptorActivation'
						or attr == 'AeryStacks' or attr == 'VoidKnightTier'
						or attr == 'PaladinStartTime' or attr == 'Summoner_ClawLevel'
						or attr == 'Grit' then
							updateKtLabel()
						end
					end))
					table.insert(kitTrackerConnections[ent], ent.Character.ChildAdded:Connect(function(child)
						if child.Name == 'elk' or string.find(child.Name, "wizard_staff") or string.find(child.Name, "frost_staff") then
							updateKtLabel()
						end
					end))
					table.insert(kitTrackerConnections[ent], ent.Character.ChildRemoved:Connect(function(child)
						if child and (child.Name == 'elk' or string.find(child.Name, "wizard_staff") or string.find(child.Name, "frost_staff")) then
							updateKtLabel()
						end
					end))
					table.insert(kitTrackerConnections[ent], workspace.ChildAdded:Connect(function(child)
						if child and child.Name:sub(1, 20) == 'DisguisedPlayerBlock' then
							updateKtLabel()
						end
					end))
					table.insert(kitTrackerConnections[ent], workspace.ChildRemoved:Connect(function(child)
						if child and child.Name:sub(1, 20) == 'DisguisedPlayerBlock' then
							updateKtLabel()
						end
					end))
				end
				if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
				table.insert(kitTrackerConnections[ent], ent.Player:GetAttributeChangedSignal('PlayingAsKits'):Connect(updateKtLabel))
			  end)
			end

			if Potions.Enabled then
				local baseX = Loot.Enabled and 45 or -39
				for i, def in potionDefs do
					local iconSc = Scale.Value
					local Icon = Instance.new('ImageLabel')
					Icon.Name = def.name
					Icon.Size = udim2fromOffset(26 * iconSc, 26 * iconSc)
					Icon.Position = udim2fromOffset((baseX + ((i - 1) * 28)) * iconSc, (Equipment.Enabled and -58 or -30) * iconSc)
					Icon.BackgroundTransparency = 1
					Icon.Image = ''
					Icon.Parent = nametag
				end
			end

			if Loot.Enabled then
				local lootDefs = { LootIron = 'iron', LootDiamond = 'diamond', LootEmerald = 'emerald' }
				for i, v in { 'LootIron', 'LootDiamond', 'LootEmerald' } do
					local iconSc = Scale.Value
					local Icon = Instance.new('ImageLabel')
					Icon.Name = v
					Icon.Size = udim2fromOffset(26 * iconSc, 26 * iconSc)
					Icon.Position = udim2fromOffset((-39 + ((i - 1) * 28)) * iconSc, (Equipment.Enabled and -58 or -30) * iconSc)
					Icon.BackgroundTransparency = 1
					Icon.Image = ''
					Icon.Parent = nametag
					local amt = Instance.new('TextLabel')
					amt.Name = 'Amt'
					amt.AnchorPoint = Vector2.new(0, 1)
					amt.Position = UDim2.new(0, 0, 1, 0)
					amt.Size = UDim2.new(0, 26 * iconSc, 0, 10 * iconSc)
					amt.BackgroundTransparency = 1
					amt.Text = ''
					amt.TextColor3 = Color3.fromRGB(255, 255, 255)
					amt.TextStrokeTransparency = 0.4
					amt.TextSize = 9 * iconSc
					amt.Font = Enum.Font.GothamBold
					amt.TextXAlignment = Enum.TextXAlignment.Center
					amt.TextYAlignment = Enum.TextYAlignment.Bottom
					amt.Parent = Icon
				end

				local function applyLootIcons()
					if not (NameTags.Enabled and Loot.Enabled and nametag and nametag.Parent and ent.Player) then return end
					local inventory = store.inventories[ent.Player]
					if not inventory and bedwars.getInventory then
						inventory = bedwars.getInventory(ent.Player)
						if inventory then store.inventories[ent.Player] = inventory end
					end
					if not inventory then return end
					local counts = { iron = 0, diamond = 0, emerald = 0 }
					for _, it in inventory.items or {} do
						if counts[it.itemType] ~= nil then
							counts[it.itemType] = counts[it.itemType] + (it.amount or 0)
						end
					end
					for slot, nm in lootDefs do
						local ic = nametag:FindFirstChild(slot)
						if ic then
							local c = counts[nm]
							if c > 0 then
								ic.Image = bedwars.getIcon({ itemType = nm }, true)
								if ic.Amt then ic.Amt.Text = tostring(c) end
							else
								ic.Image = ''
								if ic.Amt then ic.Amt.Text = '' end
							end
						end
					end
				end

				applyLootIcons()
				if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
				table.insert(kitTrackerConnections[ent], vapeEvents.InventoryChanged.Event:Connect(function()
					if nametag and nametag.Parent then applyLootIcons() end
				end))
			end

			if Equipment.Enabled then
				for i, v in { 'Hand', 'Helmet', 'Chestplate', 'Boots' } do
					local Icon = Instance.new('ImageLabel')
					Icon.Name = v
					local iconSc = Scale.Value
					Icon.Size = udim2fromOffset(30 * iconSc, 30 * iconSc)
					Icon.Position = udim2fromOffset((-60 + (i * 30)) * iconSc, -30 * iconSc)
					Icon.BackgroundTransparency = 1
					Icon.Image = ''
					Icon.Parent = nametag
					if v == 'Hand' then
						local amt = Instance.new('TextLabel')
						amt.Name = 'Amt'
						amt.AnchorPoint = Vector2.new(0, 1)
						amt.Position = UDim2.new(0, 0, 1, 0)
						amt.Size = UDim2.new(0, 14 * iconSc, 0, 10 * iconSc)
						amt.BackgroundTransparency = 1
						amt.Text = ''
						amt.TextColor3 = Color3.fromRGB(255, 255, 255)
						amt.TextStrokeTransparency = 0.4
						amt.TextSize = 10 * iconSc
						amt.Font = Enum.Font.GothamBold
						amt.TextXAlignment = Enum.TextXAlignment.Left
						amt.TextYAlignment = Enum.TextYAlignment.Bottom
						amt.Parent = Icon
					end
				end

				local equipRetry = nil
				local function applyEquipmentIcons(attempt)
					if not ent.Player then return end
					if not (NameTags.Enabled and Equipment.Enabled and nametag and nametag.Parent) then return end
					local inventory = store.inventories[ent.Player]
					if not inventory and bedwars.getInventory then
						inventory = bedwars.getInventory(ent.Player)
						if inventory then store.inventories[ent.Player] = inventory end
					end
					if not inventory then
						if equipRetry then task.cancel(equipRetry) end
						local wait = math.min(0.1 * (attempt or 1), 1)
						equipRetry = task.delay(wait, function()
							equipRetry = nil
							applyEquipmentIcons((attempt or 1) + 1)
						end)
						return
					end
					local handItem = inventory.hand
					local kit = ent.Player:GetAttribute('PlayingAsKits')
					local handImage = bedwars.getIcon(handItem or { itemType = '' }, true)
					if nametag.Hand then
						nametag.Hand.Image = handImage
						if nametag.Hand.Amt then
							local a = handItem and handItem.amount
							nametag.Hand.Amt.Text = (a and a > 1) and tostring(a) or ''
						end
					end
					if nametag.Helmet then nametag.Helmet.Image = bedwars.getIcon(inventory.armor and inventory.armor[4] or { itemType = '' }, true) end
					local chestImage = bedwars.getIcon(inventory.armor and inventory.armor[5] or { itemType = '' }, true)
					if kit == 'tinker' then
						local level = ent.Player:GetAttribute('TinkerMachineLevel')
						if level and level >= 1 and level <= 5 then
							local mechImg = getChainsawImage(level)
							if mechImg and mechImg ~= '' then
								chestImage = mechImg
							end
						end
					end
					if nametag.Chestplate then nametag.Chestplate.Image = chestImage end
					if nametag.Boots then nametag.Boots.Image = bedwars.getIcon(inventory.armor and inventory.armor[6] or { itemType = '' }, true) end
				end
				applyEquipmentIcons()
				if not kitTrackerConnections[ent] then kitTrackerConnections[ent] = {} end
				table.insert(kitTrackerConnections[ent], vapeEvents.InventoryChanged.Event:Connect(function()
					if nametag and nametag.Parent then
						applyEquipmentIcons()
					end
				end))

				if ent.Player then
					local attrConn = ent.Player:GetAttributeChangedSignal('TinkerMachineLevel'):Connect(function()
						if Equipment.Enabled and nametag and nametag.Parent then
							applyEquipmentIcons()
						end
					end)
					if not kitTrackerConnections[ent] then
						kitTrackerConnections[ent] = {}
					end
					table.insert(kitTrackerConnections[ent], attrConn)
				end
			end

			if ShowKits.Enabled and ent.Player then
				local kitIcon = Instance.new('ImageLabel')
				kitIcon.Name = 'KitIcon'
				kitIcon.Size = udim2fromOffset(30, 30)
				kitIcon.AnchorPoint = vector2new(0.5, 0)
				kitIcon.BackgroundTransparency = 1
				kitIcon.Image = ''

				if Equipment.Enabled then
					kitIcon.Position = udim2fromOffset(110, -30)
				else
					kitIcon.Position = UDim2.new(0.5, 0, 0, -35)
				end

				kitIcon.Parent = nametag

				local kit = ent.Player:GetAttribute('PlayingAsKits')
				if kit then
					local kitImage = kitImageIds[kit:lower()]
					kitIcon.Image = kitImage or kitImageIds["none"]
					kitCache[ent] = kitImage or kitImageIds["none"]
				else
					kitIcon.Image = kitImageIds["none"]
					kitCache[ent] = kitImageIds["none"]
				end
			end

			if DeviceIcon and DeviceIcon.Enabled and ent.Player then
				local function getPlayerDevice(plr)
					local val = plr:GetAttribute('UserInputType') or 'Unknown'
					if not val then return 'Unknown' end
					val = val:upper()
					if val == 'MOBILE' then return 'Mobile'
					elseif val == 'GAMEPAD' or val == 'CONTROLLER' then return 'Controller'
					else return 'PC' end
				end
				local deviceType = getPlayerDevice(ent.Player)
				if deviceType then
					local deviceEmoji = {Mobile = '📱', PC = '🖥', Controller = '🎮', Unknown = '❔'}
					local deviceLabel = Instance.new('TextLabel')
					deviceLabel.Name = 'DeviceIcon'
					deviceLabel.Size = udim2fromOffset(22, 22)
					deviceLabel.AnchorPoint = vector2new(0, 0)
					deviceLabel.Position = UDim2.new(1, 10, 0, -1)
					deviceLabel.BackgroundTransparency = 1
					deviceLabel.BorderSizePixel = 0
					deviceLabel.Text = deviceEmoji[deviceType] or ''
					deviceLabel.RichText = false
					deviceLabel.TextScaled = false
					deviceLabel.TextSize = 16
					deviceLabel.FontFace = Font.fromEnum(Enum.Font.Arial)
					deviceLabel.TextColor3 = Color3.new(1, 1, 1)
					deviceLabel.Parent = nametag
				end
			end

			if Rank.Enabled and ent.Player then
				local rankIcon = Instance.new('ImageLabel')
				rankIcon.Name = 'RankIcon'
				rankIcon.Size = udim2fromOffset(30, 30)
				rankIcon.Position = UDim2.new(1, (DeviceIcon and DeviceIcon.Enabled and 42 or 10), 0, -4)
				rankIcon.BackgroundTransparency = 1
				rankIcon.Image = ''
				rankIcon.Parent = nametag

				task.spawn(function()
					task.wait(math.random() * 0.5)
					if not NameTags.Enabled then return end
					if vape.ThreadFix then setthreadidentity(8) end
					local plr = playersService:GetPlayerFromCharacter(ent.Character)
					if not plr then return end
					if not rankIcon or not rankIcon.Parent then return end

					local ok, success, data = pcall(function()
						return bedwars.Client:Get(remotes.Ranks):CallServerAsync({ plr.UserId }):await()
					end)

					if vape.ThreadFix then setthreadidentity(8) end

					if ok and success and type(data) == "table" then
						local division = data[1] and data[1].rankDivision
						if division and bedwars.RankMeta and bedwars.RankMeta[division] then
							if rankIcon and rankIcon.Parent then
								rankIcon.Image = bedwars.RankMeta[division].image
							end
						end
					end
				end)
			end

			if GloopIndicator and GloopIndicator.Enabled and ent.Character then
				local gloopIcon = Instance.new('ImageLabel')
				gloopIcon.Name = 'GloopIcon'
				gloopIcon.Size = udim2fromOffset(24, 24)
				gloopIcon.BackgroundTransparency = 1
				gloopIcon.Image = bedwars.getIcon({itemType = 'glue_projectile'}, true)
				gloopIcon.Visible = false
				if Rank.Enabled and DeviceIcon and DeviceIcon.Enabled then
					gloopIcon.Position = UDim2.new(1, 74, 0, -2)
				elseif Rank.Enabled or (DeviceIcon and DeviceIcon.Enabled) then
					gloopIcon.Position = UDim2.new(1, 42, 0, -2)
				else
					gloopIcon.Position = UDim2.new(1, 10, 0, -2)
				end
				gloopIcon.Parent = nametag
				local gloopTimer = nil
				if gloopConnections[ent] then gloopConnections[ent]:Disconnect() end
				gloopConnections[ent] = ent.Character.AttributeChanged:Connect(function(attr)
					if attr ~= 'GlueSlow' then return end
					local val = ent.Character:GetAttribute('GlueSlow')
					if val ~= nil and val ~= 0 then
						gloopIcon.Visible = true
						if gloopTimer then task.cancel(gloopTimer) end
						gloopTimer = task.delay(10, function()
							gloopIcon.Visible = false
							gloopTimer = nil
						end)
					end
				end)
			end

			if Enchant.Enabled and ent.Player and ent.Character then
				local Icon = Instance.new('ImageLabel')
				Icon.Name = 'EnchantIcon'
				Icon.Size = udim2fromOffset(30, 30)
				Icon.Position = udim2fromOffset(-30, -4)
				Icon.BackgroundTransparency = 1
				Icon.Image = getActiveEnchantImage(ent.Character)
				Icon.Parent = nametag
				enchantCache[ent] = Icon.Image
				if enchantConnections[ent] then enchantConnections[ent]:Disconnect() end
				enchantConnections[ent] = ent.Character.AttributeChanged:Connect(function(attr)
					if attr:sub(1, 13) ~= 'StatusEffect_' then return end
					local val = ent.Character:GetAttribute(attr)
					if type(val) ~= 'number' then return end
					local newImage = getActiveEnchantImage(ent.Character)
					if enchantCache[ent] ~= newImage then
						Icon.Image = newImage
						enchantCache[ent] = newImage
					end
				end)
			end

			Reference[ent] = nametag
			charCache[ent] = ent.Character
			lastUpdate[ent] = 0
		end,

		Drawing = function(ent)
			if not shouldShow(ent) then return end
			if Reference[ent] then return end

			local bg = Drawing.new('Square')
			bg.Filled = true
			bg.Thickness = 0
			bg.Color = color3new(0, 0, 0)
			bg.Transparency = 1 - Background.Value
			bg.ZIndex = 1
			bg.Visible = false

			local text = Drawing.new('Text')
			text.Center = false
			text.Outline = true
			text.OutlineColor = color3new(0, 0, 0)
			text.Size = math_round(14 * Scale.Value)
			text.Font = 2
			text.Color = getTeamColor(ent) or color3fromHSV(Color.Hue, Color.Sat, Color.Value)
			text.ZIndex = 2
			text.Visible = false

			local baseName = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or (getBossDisplayName(ent) or (ent.Character and ent.Character.Name)) or ''
			local built = baseName
			if Health.Enabled then built = built .. ' ' .. healthPlain(ent) end
			if ShowKits.Enabled and ent.Player then
				local kit = ent.Player:GetAttribute('PlayingAsKits')
				if kit then
					built = built .. ' (' .. (kit:gsub('_', ' '):gsub('^%l', string.upper)) .. ')'
				end
			end
			if Distance.Enabled then
				Strings[ent] = '[%s] ' .. built
			else
				Strings[ent] = built
				text.Text = built
				bg.Size = vector2new(text.TextBounds.X + 8, text.TextBounds.Y + 7)
			end

			Reference[ent] = {Text = text, BG = bg}
			charCache[ent] = ent.Character
		end
	}

	Removed = {
		Normal = function(ent)
			local v = Reference[ent]
			if v then
				Reference[ent] = nil
				Strings[ent] = nil
				Sizes[ent] = nil
				lastUpdate[ent] = nil
				kitCache = {}
				equipmentCache = {}
				lootCache = {}
				enchantCache = {}
				healthCache[ent] = nil
				charCache[ent] = nil
				if enchantConnections[ent] then
					enchantConnections[ent]:Disconnect()
					enchantConnections[ent] = nil
				end
				if gloopConnections[ent] then
					gloopConnections[ent]:Disconnect()
					gloopConnections[ent] = nil
				end
				if kitTrackerConnections[ent] then
					for _, c in ipairs(kitTrackerConnections[ent]) do
						pcall(function() c:Disconnect() end)
					end
					kitTrackerConnections[ent] = nil
				end
				if billboardCache[ent] then
					for _, b in ipairs(billboardCache[ent]) do
						pcall(function() b:Destroy() end)
					end
					billboardCache[ent] = nil
				end
				v:Destroy()
			end
		end,
		Drawing = function(ent)
			local v = Reference[ent]
			if v then
				Reference[ent] = nil
				Strings[ent] = nil
				Sizes[ent] = nil
				lastUpdate[ent] = nil
				kitCache[ent] = nil
				healthCache[ent] = nil
				if enchantConnections[ent] then
					enchantConnections[ent]:Disconnect()
					enchantConnections[ent] = nil
				end
				if gloopConnections[ent] then
					gloopConnections[ent]:Disconnect()
					gloopConnections[ent] = nil
				end
				if billboardCache[ent] then
					for _, b in ipairs(billboardCache[ent]) do
						pcall(function() b:Destroy() end)
					end
					billboardCache[ent] = nil
				end
				for _, obj in v do
					pcall(function()
						obj.Visible = false
						obj:Remove()
					end)
				end
			end
		end
	}

	local Updated = {
		Normal = function(ent)
			local nametag = Reference[ent]
			if not nametag then return end

			local now = tick()
			if lastUpdate[ent] and (now - lastUpdate[ent]) < 0.2 then return end
			lastUpdate[ent] = now

			Sizes[ent] = nil
			local bossDisplayName = ent.NPC and ent.Character and getBossDisplayName(ent) or nil
			local entityName = bossDisplayName or (ent.Player and nil) or ent.Character.Name
			Strings[ent] = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or entityName

			if Health.Enabled then
				Strings[ent] = Strings[ent]..' '..healthRich(ent)
			end

			if Distance.Enabled then
				Strings[ent] = '[%s] ' .. Strings[ent]
			end

			if Equipment.Enabled and ent.Player then
				if not store.inventories[ent.Player] and bedwars.getInventory then
					local fetched = bedwars.getInventory(ent.Player)
					if fetched then store.inventories[ent.Player] = fetched end
				end
				local inventory = store.inventories[ent.Player] or {hand = nil, armor = {}}
				local handItem = inventory.hand
				local kit = ent.Player:GetAttribute('PlayingAsKits')
				local handImage = bedwars.getIcon(handItem or { itemType = '' }, true)
				local chestImage = bedwars.getIcon(inventory.armor and inventory.armor[5] or { itemType = '' }, true)
				if kit == 'tinker' then
					local level = ent.Player:GetAttribute('TinkerMachineLevel')
					if level and level >= 1 and level <= 5 then
						local mechImg = getChainsawImage(level)
						if mechImg and mechImg ~= '' then
							chestImage = mechImg
						end
					end
				end
				local currentEquip = {
					tostring(handItem and handItem.itemType or ''),
					tostring((inventory.armor and inventory.armor[4] and inventory.armor[4].itemType) or ''),
					tostring((inventory.armor and inventory.armor[5] and inventory.armor[5].itemType) or ''),
					tostring((inventory.armor and inventory.armor[6] and inventory.armor[6].itemType) or '')
				}
				local equipKey = table.concat(currentEquip, "|")
				if equipmentCache[ent] ~= equipKey then
					equipmentCache[ent] = equipKey
					if nametag.Hand then
						nametag.Hand.Image = handImage
						if nametag.Hand.Amt then
							local a = handItem and handItem.amount
							nametag.Hand.Amt.Text = (a and a > 1) and tostring(a) or ''
						end
					end
					if nametag.Helmet then
						nametag.Helmet.Image = bedwars.getIcon(inventory.armor and inventory.armor[4] or { itemType = '' }, true)
					end
					if nametag.Chestplate then
						nametag.Chestplate.Image = chestImage
					end
					if nametag.Boots then
						nametag.Boots.Image = bedwars.getIcon(inventory.armor and inventory.armor[6] or { itemType = '' }, true)
					end
				end
			end

			local size = getfontsize(removeTags(Strings[ent]), nametag.TextSize, nametag.FontFace, vector2new(100000, 100000))
			nametag.Size = udim2fromOffset(size.X + 8, size.Y + 7)
			nametag.Text = Strings[ent]
			nametag.TextColor3 = getTeamColor(ent) or color3fromHSV(Color.Hue, Color.Sat, Color.Value)
		end,

		Drawing = function(ent)
			local nametag = Reference[ent]
			if nametag then
				if vape.ThreadFix then setthreadidentity(8) end
				Sizes[ent] = nil
				local bossDisplayName = ent.NPC and ent.Character and getBossDisplayName(ent) or nil
				local entityName = bossDisplayName or (ent.Player and nil) or ent.Character.Name
				Strings[ent] = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or entityName

				if Health.Enabled then
					Strings[ent] = Strings[ent]..' '..healthPlain(ent)
					nametag.Text.Color = getHealthColor(ent)
				end

				if Distance.Enabled then
					Strings[ent] = '[%s] ' .. Strings[ent]
					nametag.Text.Text = entitylib.isAlive and string_format(Strings[ent], math_floor((entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude)) or Strings[ent]
				else
					nametag.Text.Text = Strings[ent]
				end

				if ShowKits.Enabled and ent.Player then
					local kit = ent.Player:GetAttribute('PlayingAsKits')
					if kit then
						local kitName = kit:gsub("_", " "):gsub("^%l", string.upper)
						nametag.Text.Text = nametag.Text.Text .. ' (' .. kitName .. ')'
					end
				end

				nametag.BG.Size = vector2new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
				if not Health.Enabled then
					nametag.Text.Color = getTeamColor(ent) or color3fromHSV(Color.Hue, Color.Sat, Color.Value)
				end
			end
		end
	}

	local ColorFunc = {
		Normal = function(hue, sat, val)
			local color = color3fromHSV(hue, sat, val)
			for i, v in Reference do
				v.TextColor3 = getTeamColor(i) or color
			end
		end,
		Drawing = function(hue, sat, val)
			local color = color3fromHSV(hue, sat, val)
			for i, v in Reference do
				if not Health.Enabled then
					v.Text.Color = getTeamColor(i) or color
				end
			end
		end
	}

	local frameCounter = 0
	Loop = {
		Normal = function()
			frameCounter = frameCounter + 1
			local skipVisCheck = frameCounter % 2 ~= 0
			local updateDistText = frameCounter % 3 == 0
			local updateEquipment = frameCounter % 30 == 0
			local forceEquip = frameCounter % 150 == 0
			local updateKit = frameCounter % 30 == 0
			local updateDistanceText = frameCounter % 6 == 0
			local myPos = entitylib.isAlive and entitylib.character.RootPart and entitylib.character.RootPart.Position

			for ent, nametag in Reference do
				if not ent.RootPart or not ent.Character or not ent.Character.Parent or (ent.Health ~= nil and ent.Health <= 0) then
					nametag.Visible = false
					continue
				end
				if DistanceCheck.Enabled then
					local distance = myPos and (myPos - ent.RootPart.Position).Magnitude or math_huge
					if distance < DistanceLimit.ValueMin or distance > DistanceLimit.ValueMax then
						nametag.Visible = false
						continue
					end
				end

				local headPos, headVis = gameCamera:WorldToViewportPoint(ent.RootPart.Position + vector3new(0, ent.HipHeight + 1, 0))
				if not skipVisCheck then
					nametag.Visible = headVis
				end
				if not nametag.Visible or not headVis then continue end
				nametag.Position = udim2fromOffset(headPos.X, headPos.Y)

				if Health.Enabled and (frameCounter % 2 == 0) then
					local hp = healthRich(ent)
					if healthCache[ent] ~= hp then
						healthCache[ent] = hp
						local baseName = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or (getBossDisplayName(ent) or (ent.Character and ent.Character.Name)) or ''
						Strings[ent] = baseName..' '..hp
						if Distance.Enabled then
							Strings[ent] = '[%s] ' .. Strings[ent]
						else
							nametag.Text = Strings[ent]
							local size = getfontsize(removeTags(nametag.Text), nametag.TextSize, nametag.FontFace, vector2new(100000, 100000))
							nametag.Size = udim2fromOffset(size.X + 8, size.Y + 7)
						end
						Sizes[ent] = nil
					end
				end

				if Distance.Enabled and updateDistText then
					local mag = myPos and math_floor((myPos - ent.RootPart.Position).Magnitude) or 0
					if Sizes[ent] ~= mag then
						nametag.Text = string_format(Strings[ent], mag)
						if updateDistanceText then
							local size = getfontsize(removeTags(nametag.Text), nametag.TextSize, nametag.FontFace, vector2new(100000, 100000))
							nametag.Size = udim2fromOffset(size.X + 8, size.Y + 7)
						end
						Sizes[ent] = mag
					end
				end

				if Equipment.Enabled and (updateEquipment or forceEquip) then
					if ent.Player and not store.inventories[ent.Player] and bedwars.getInventory then
						local fetched = bedwars.getInventory(ent.Player)
						if fetched then store.inventories[ent.Player] = fetched end
					end
					if ent.Player and store.inventories[ent.Player] then
						local inventory = store.inventories[ent.Player]
						local handItem = inventory.hand
						local currentEquip = {
							(handItem and handItem.itemType) or '',
							(inventory.armor and inventory.armor[4] and inventory.armor[4].itemType) or '',
							(inventory.armor and inventory.armor[5] and inventory.armor[5].itemType) or '',
							(inventory.armor and inventory.armor[6] and inventory.armor[6].itemType) or ''
						}
						local equipKey = table.concat(currentEquip, "|")
						local iconsBlank = nametag.Hand and (nametag.Hand.Image == '' or nametag.Hand.Image == nil)
						if equipmentCache[ent] ~= equipKey or forceEquip or (iconsBlank and equipKey ~= "|||") then
							local kit = ent.Player:GetAttribute('PlayingAsKits')
							local handImage = bedwars.getIcon(handItem or { itemType = '' }, true)
							local chestImage = bedwars.getIcon(inventory.armor and inventory.armor[5] or { itemType = '' }, true)
							if kit == 'tinker' then
								local level = ent.Player:GetAttribute('TinkerMachineLevel')
								if level and level >= 1 and level <= 5 then
									local mechImg = getChainsawImage(level)
									if mechImg and mechImg ~= '' then
										chestImage = mechImg
									end
								end
							end
							equipmentCache[ent] = equipKey
							if nametag.Hand then
								nametag.Hand.Image = handImage
								if nametag.Hand.Amt then
									local a = handItem and handItem.amount
									nametag.Hand.Amt.Text = (a and a > 1) and tostring(a) or ''
								end
							end
							if nametag.Helmet then
								nametag.Helmet.Image = bedwars.getIcon(inventory.armor and inventory.armor[4] or { itemType = '' }, true)
							end
							if nametag.Chestplate then
								nametag.Chestplate.Image = chestImage
							end
							if nametag.Boots then
								nametag.Boots.Image = bedwars.getIcon(inventory.armor and inventory.armor[6] or { itemType = '' }, true)
							end
						end
					elseif ent.Player then
						equipmentCache[ent] = nil
					end
				end

				if Loot.Enabled and (updateEquipment or forceEquip) and ent.Player and nametag.LootIron then
					local inv = store.inventories[ent.Player]
					if not inv and bedwars.getInventory then
						inv = bedwars.getInventory(ent.Player)
						if inv then store.inventories[ent.Player] = inv end
					end
					if inv and inv.items then
						local counts = { iron = 0, diamond = 0, emerald = 0 }
						for _, it in inv.items do
							local c = counts[it.itemType]
							if c then
								counts[it.itemType] = c + (it.amount or 0)
							end
						end
						local lootKey = counts.iron .. '|' .. counts.diamond .. '|' .. counts.emerald
						if lootCache[ent] ~= lootKey or forceEquip then
							lootCache[ent] = lootKey
							for slot, nm in { LootIron = 'iron', LootDiamond = 'diamond', LootEmerald = 'emerald' } do
								local ic = nametag:FindFirstChild(slot)
								if ic then
									local c = counts[nm]
									if c > 0 then
										ic.Image = bedwars.getIcon({ itemType = nm }, true)
										if ic.Amt then ic.Amt.Text = tostring(c) end
									else
										ic.Image = ''
										if ic.Amt then ic.Amt.Text = '' end
									end
								end
							end
						end
					end
				end

				if Potions.Enabled and (updateEquipment or forceEquip) then
					local char = ent.Character
					for _, def in potionDefs do
						local ic = nametag:FindFirstChild(def.name)
						if ic then
							local want = potionActive(char, def) and bedwars.getIcon({itemType = def.item}, true) or ''
							if ic.Image ~= want then
								ic.Image = want
							end
						end
					end
				end

				if ShowKits.Enabled and updateKit then
					local kitIcon = nametag:FindFirstChild('KitIcon')
					if kitIcon and ent.Player then
						local kit = ent.Player:GetAttribute('PlayingAsKits')
						local meta = bedwars.BedwarsKitMeta and kit and bedwars.BedwarsKitMeta[kit]
						local newKitImage = (meta and meta.renderImage) or kitImageIds[kit] or kitImageIds['none']
						if kitCache[ent] ~= newKitImage then
							kitIcon.Image = newKitImage
							kitCache[ent] = newKitImage
						end
					end
				end
			end
		end,

		Drawing = function()
			frameCounter = frameCounter + 1
			local skipFrame = frameCounter % 2 ~= 0

			for ent, nametag in Reference do
				if not ent.RootPart or (ent.Health ~= nil and ent.Health <= 0) then
					if not nametag:GetAttribute('DeadHidden') then
						nametag:SetAttribute('DeadHidden', true)
						for _, child in nametag:GetChildren() do
							if child:IsA('GuiObject') then child.Visible = false end
						end
					end
					continue
				end
				if nametag:GetAttribute('DeadHidden') then
					nametag:SetAttribute('DeadHidden', nil)
					for _, child in nametag:GetChildren() do
						if child:IsA('GuiObject') then child.Visible = true end
					end
				end
				if DistanceCheck.Enabled then
					local distance = entitylib.isAlive and (entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude or math_huge
					if distance < DistanceLimit.ValueMin or distance > DistanceLimit.ValueMax then
						nametag.Text.Visible = false
						nametag.BG.Visible = false
						continue
					end
				end

				local headPos, headVis = gameCamera:WorldToViewportPoint(ent.RootPart.Position + vector3new(0, ent.HipHeight + 1, 0))
				nametag.Text.Visible = headVis
				nametag.BG.Visible = headVis
				if not headVis then continue end
				if skipFrame then continue end

				if Health.Enabled then
					nametag.Text.Color = getHealthColor(ent)
					local hp = healthPlain(ent)
					if healthCache[ent] ~= hp then
						healthCache[ent] = hp
						local baseName = ent.Player and (DisplayName.Enabled and ent.Player.DisplayName or ent.Player.Name) or (getBossDisplayName(ent) or (ent.Character and ent.Character.Name)) or ''
						local built = baseName..' '..hp
						if ShowKits.Enabled and ent.Player then
							local kit = ent.Player:GetAttribute('PlayingAsKits')
							if kit then
								built = built..' ('..(kit:gsub('_', ' '):gsub('^%l', string.upper))..')'
							end
						end
						if Distance.Enabled then
							Strings[ent] = '[%s] '..built
						else
							Strings[ent] = built
							nametag.Text.Text = built
							nametag.BG.Size = vector2new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
						end
						Sizes[ent] = nil
					end
				end

				if Distance.Enabled then
					local mag = entitylib.isAlive and math_floor((entitylib.character.RootPart.Position - ent.RootPart.Position).Magnitude) or 0
					if Sizes[ent] ~= mag then
						nametag.Text.Text = string_format(Strings[ent], mag)
						nametag.BG.Size = vector2new(nametag.Text.TextBounds.X + 8, nametag.Text.TextBounds.Y + 7)
						Sizes[ent] = mag
					end
				end

				nametag.BG.Position = vector2new(headPos.X - (nametag.BG.Size.X / 2), headPos.Y - nametag.BG.Size.Y)
				nametag.Text.Position = nametag.BG.Position + vector2new(4, 3)
			end
		end
	}

	NameTags = vape.Categories.Render:CreateModule({
		Name = 'NameTags',
		Function = function(callback)
			if callback then
				methodused = StreamProof.Enabled and 'Drawing' or 'Normal'
				frameCounter = 0

				if Removed[methodused] then
					NameTags:Clean(entitylib.Events.EntityRemoved:Connect(Removed[methodused]))
				end

				if Added[methodused] then
					for _, v in entitylib.List do
						if Reference[v] then Removed[methodused](v) end
						pcall(Added[methodused], v)
					end
					task.spawn(function()
						task.wait(1)
						if not NameTags.Enabled then return end
						for _, v in entitylib.List do
							if Reference[v] then Removed[methodused](v) end
							pcall(Added[methodused], v)
						end
					end)
					NameTags:Clean(entitylib.Events.EntityAdded:Connect(function(ent)
						task.spawn(function()
							task.wait(0.5)
							if not NameTags.Enabled then return end
							if not ent.Character or not ent.Character.Parent then
								if Reference[ent] then Removed[methodused](ent) end
								return
							end
							if Reference[ent] then Removed[methodused](ent) end
							pcall(Added[methodused], ent)
						end)
					end))
					NameTags:Clean(playersService.PlayerAdded:Connect(function(p)
						NameTags:Clean(p.CharacterAdded:Connect(function()
							task.delay(0.3, function()
								if not NameTags.Enabled then return end
								for _, v in entitylib.List do
									if v.Player == p and not Reference[v] then
										pcall(Added[methodused], v)
									end
								end
							end)
						end))
					end))
				end

				if Updated[methodused] then
					NameTags:Clean(entitylib.Events.EntityUpdated:Connect(function(ent)
						local show = shouldShow(ent)
						if show and not Reference[ent] then
							pcall(Added[methodused], ent)
							return
						elseif not show and Reference[ent] then
							Removed[methodused](ent)
							return
						end
						if Reference[ent] and charCache[ent] ~= ent.Character then
							Removed[methodused](ent)
							pcall(Added[methodused], ent)
							return
						end
						Updated[methodused](ent)
					end))
					for _, v in entitylib.List do
						pcall(Updated[methodused], v)
					end
				end

				if ColorFunc[methodused] then
					NameTags:Clean(vape.Categories.Friends.ColorUpdate.Event:Connect(function()
						ColorFunc[methodused](Color.Hue, Color.Sat, Color.Value)
					end))
				end

				if Loop[methodused] then
					NameTags:Clean(runService.RenderStepped:Connect(Loop[methodused]))
				end

				if Added[methodused] then
					task.spawn(function()
						while NameTags.Enabled do
							task.wait(0.5)
							if not NameTags.Enabled then break end
							for _, v in entitylib.List do
								if v.Character and v.Character.Parent and shouldShow(v) then
									if not Reference[v] then
										pcall(Added[methodused], v)
									elseif charCache[v] ~= v.Character then
										Removed[methodused](v)
										pcall(Added[methodused], v)
									end
								end
							end
						end
					end)
				end
			else
				if Removed[methodused] then
					for i in Reference do
						Removed[methodused](i)
					end
				end
				lastUpdate = {}
				kitCache = {}
				equipmentCache = {}
				enchantCache = {}
				healthCache = {}
				enchantConnections = {}
				gloopConnections = {}
				kitTrackerConnections = {}
				for _, list in pairs(billboardCache) do
					for _, b in ipairs(list) do
						pcall(function() b:Destroy() end)
					end
				end
				billboardCache = {}
			end
		end,
		Tooltip = 'renders nametags on entities through walls.'
	})

	Targets = NameTags:CreateTargets({
		Players = true,
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	FontOption = NameTags:CreateFont({
		Name = 'Font',
		Blacklist = 'Arial',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Color = NameTags:CreateColorSlider({
		Name = 'Player Color',
		Function = function(hue, sat, val)
			if NameTags.Enabled and ColorFunc[methodused] then
				ColorFunc[methodused](hue, sat, val)
			end
		end
	})

	Scale = NameTags:CreateSlider({
		Name = 'Scale',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end,
		Default = 1,
		Min = 0.1,
		Max = 1.5,
		Decimal = 10
	})

	Background = NameTags:CreateSlider({
		Name = 'Transparency',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end,
		Default = 0.5,
		Min = 0,
		Max = 1,
		Decimal = 10
	})

	Health = NameTags:CreateToggle({
		Name = 'Health',
		Function = function(callback)
			HealthColorToggle.Object.Visible = callback
			HealthColorFull.Object.Visible = callback and HealthColorToggle.Enabled
			HealthColorMid.Object.Visible = callback and HealthColorToggle.Enabled
			HealthColorLow.Object.Visible = callback and HealthColorToggle.Enabled
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	HealthColorToggle = NameTags:CreateToggle({
		Name = 'Custom Health Colors',
		Darker = true,
		Visible = false,
		Function = function(callback)
			HealthColorFull.Object.Visible = callback
			HealthColorMid.Object.Visible = callback
			HealthColorLow.Object.Visible = callback
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	HealthColorFull = NameTags:CreateColorSlider({
		Name = 'Full HP Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0.4,
		DefaultSat = 0.89,
		DefaultValue = 0.75,
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	HealthColorMid = NameTags:CreateColorSlider({
		Name = 'Mid HP Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0.15,
		DefaultSat = 0.89,
		DefaultValue = 0.75,
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	HealthColorLow = NameTags:CreateColorSlider({
		Name = 'Low HP Color',
		Darker = true,
		Visible = false,
		DefaultHue = 0,
		DefaultSat = 0.89,
		DefaultValue = 0.75,
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Distance = NameTags:CreateToggle({
		Name = 'Distance',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Loot = NameTags:CreateToggle({
		Name = 'Loot',
		Tooltip = 'shows how much iron/diamond/emerald they got',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})
	Potions = NameTags:CreateToggle({
		Name = 'Potions',
		Tooltip = 'shows if they popped serpent, fury, invis, jump or speed pie',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})
	Equipment = NameTags:CreateToggle({
		Name = 'Equipment',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	ShowKits = NameTags:CreateToggle({
		Name = 'Show Kits',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end,
	})

	KitTracker = NameTags:CreateToggle({
		Name = 'Kit Tracker',
		Tooltip = 'shows stats for certain kits on a player',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Rank = NameTags:CreateToggle({
		Name = 'Rank',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	DeviceIcon = NameTags:CreateToggle({
		Name = 'Device Icon',
		Tooltip = 'shows what device the player is using',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	GloopIndicator = NameTags:CreateToggle({
		Name = 'Gloop',
		Default = true,
		Tooltip = 'shows when a player is glooped and not glooped anymore',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Enchant = NameTags:CreateToggle({
		Name = 'Enchant',
		Tooltip = 'shows the player current enchant',
		Default = true,
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	DisplayName = NameTags:CreateToggle({
		Name = 'Use Displayname',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end,
		Default = true
	})

	Teammates = NameTags:CreateToggle({
		Name = 'Priority Only',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end,
		Default = true
	})

	StreamProof = NameTags:CreateToggle({
		Name = 'Stream Proof',
		Default = false,
		Tooltip = 'uses drawing api so its stream proof if u record within roblox (text only, no icons)',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	Boss = NameTags:CreateToggle({
		Name = 'Boss',
		Tooltip = 'nametags for titan and bhaa (really good if u use health too!!)',
		Function = function()
			if NameTags.Enabled then
				NameTags:Toggle()
				NameTags:Toggle()
			end
		end
	})

	DistanceCheck = NameTags:CreateToggle({
		Name = 'Distance Check',
		Function = function(callback)
			DistanceLimit.Object.Visible = callback
		end
	})

	DistanceLimit = NameTags:CreateTwoSlider({
		Name = 'Player Distance',
		Min = 0,
		Max = 256,
		DefaultMin = 0,
		DefaultMax = 64,
		Darker = true,
		Visible = false
	})

	task.defer(function()
		if DistanceLimit and DistanceLimit.Object then
			DistanceLimit.Object.Visible = false
		end
		if HealthColorToggle and HealthColorToggle.Object then
			HealthColorToggle.Object.Visible = false
		end
		if HealthColorFull and HealthColorFull.Object then
			HealthColorFull.Object.Visible = false
		end
		if HealthColorMid and HealthColorMid.Object then
			HealthColorMid.Object.Visible = false
		end
		if HealthColorLow and HealthColorLow.Object then
			HealthColorLow.Object.Visible = false
		end
	end)
end)

run(function()
    local anim
    local asset
    local trackingConnection
    local lastPosition
    local NightmareEmote
    local cachedRootPart
    local cachedHumanoid
    local lastValidationCheck = 0
    
    NightmareEmote = vape.Categories.World:CreateModule({
        Name = "NightmareEmote",
        Function = function(call)
            if call then
                local l__GameQueryUtil__8
                if (not shared.CheatEngineMode) then 
                    l__GameQueryUtil__8 = require(game:GetService("ReplicatedStorage")['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil 
                else
                    local backup = {}; function backup:setQueryIgnored() end; l__GameQueryUtil__8 = backup;
                end
                local l__TweenService__9 = tweenService
                local player = playersService.LocalPlayer
                local character = player.Character
                
                if not character then 
                    NightmareEmote:Toggle() 
                    return 
                end
                
                local humanoid = character:WaitForChild("Humanoid")
                local rootPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
                
                if not rootPart then 
                    NightmareEmote:Toggle() 
                    return 
                end
                
                cachedRootPart = rootPart
                cachedHumanoid = humanoid
                lastPosition = rootPart.Position
                lastValidationCheck = 0
                
                local v10 = game:GetService("ReplicatedStorage"):WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("NightmareEmote"):Clone()
                asset = v10
                v10.Parent = game.Workspace
                
                local descendants = v10:GetDescendants()
                for _, part in ipairs(descendants) do
                    if part:IsA("BasePart") then
                        l__GameQueryUtil__8:setQueryIgnored(part, true)
                        part.CanCollide = false
                        part.Anchored = true
                    end
                end
                
                local l__Outer__15 = v10:FindFirstChild("Outer")
                if l__Outer__15 then
                    l__TweenService__9:Create(l__Outer__15, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
                        Orientation = l__Outer__15.Orientation + Vector3.new(0, 360, 0)
                    }):Play()
                end
                
                local l__Middle__16 = v10:FindFirstChild("Middle")
                if l__Middle__16 then
                    l__TweenService__9:Create(l__Middle__16, TweenInfo.new(12.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {
                        Orientation = l__Middle__16.Orientation + Vector3.new(0, -360, 0)
                    }):Play()
                end
                
                anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://9191822700"
                anim = humanoid:LoadAnimation(anim)
                anim:Play()
                
                local movementThresholdSq = 0.1 * 0.1
                
                trackingConnection = runService.RenderStepped:Connect(function()
                    if not asset or not asset.Parent then 
                        if trackingConnection then
                            trackingConnection:Disconnect()
                        end
                        return 
                    end
                    
                    local currentTime = tick()
                    
                    if (currentTime - lastValidationCheck) > 0.5 then
                        if not character or not character.Parent then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        if not cachedRootPart or not cachedRootPart.Parent then
                            cachedRootPart = character.PrimaryPart or character:FindFirstChild("HumanoidRootPart")
                        end
                        
                        if not cachedHumanoid or not cachedHumanoid.Parent then
                            cachedHumanoid = character:FindFirstChildOfClass("Humanoid")
                        end
                        
                        if not cachedRootPart or not cachedHumanoid or cachedHumanoid.Health <= 0 then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        lastValidationCheck = currentTime
                    end
                    
                    if lastPosition and cachedRootPart then
                        local currentPosition = cachedRootPart.Position
                        local dx = currentPosition.X - lastPosition.X
                        local dy = currentPosition.Y - lastPosition.Y
                        local dz = currentPosition.Z - lastPosition.Z
                        local distanceMovedSq = dx * dx + dy * dy + dz * dz
                        
                        if distanceMovedSq > movementThresholdSq then
                            asset:Destroy()
                            asset = nil
                            if trackingConnection then
                                trackingConnection:Disconnect()
                            end
                            NightmareEmote:Toggle()
                            return
                        end
                        
                        lastPosition = currentPosition
                    end
                    
                    if cachedRootPart then
                        v10:SetPrimaryPartCFrame(cachedRootPart.CFrame * CFrame.new(0, -3, 0))
                    end
                end)
                
                NightmareEmote:Clean(trackingConnection)
                
            else 
                if trackingConnection then
                    trackingConnection:Disconnect()
                    trackingConnection = nil
                end
                
                if anim then 
                    anim:Stop()
                    anim = nil
                end
                
                if asset then
                    asset:Destroy() 
                    asset = nil
                end
                
                lastPosition = nil
                cachedRootPart = nil
                cachedHumanoid = nil
                lastValidationCheck = 0
            end
        end
    })
end)

run(function()
	local PlayerProfileSpoof
	local RankDrop
	local RPSlider
	local LBSlider
	local ImageId = require(game:GetService('ReplicatedStorage').TS.image['image-id']).BedwarsImageId

	local rankKeys = {
		['Bronze 1'] = 'BRONZE_RANK', ['Bronze 2'] = 'BRONZE_RANK', ['Bronze 3'] = 'BRONZE_RANK',
		['Silver 1'] = 'SILVER_RANK', ['Silver 2'] = 'SILVER_RANK', ['Silver 3'] = 'SILVER_RANK',
		['Gold 1'] = 'GOLD_RANK', ['Gold 2'] = 'GOLD_RANK', ['Gold 3'] = 'GOLD_RANK',
		['Platinum 1'] = 'PLATINUM_RANK', ['Platinum 2'] = 'PLATINUM_RANK', ['Platinum 3'] = 'PLATINUM_RANK',
		['Diamond 1'] = 'DIAMOND_RANK', ['Diamond 2'] = 'DIAMOND_RANK', ['Diamond 3'] = 'DIAMOND_RANK',
		['Emerald 1'] = 'EMERALD_RANK', ['Emerald 2'] = 'EMERALD_RANK', ['Emerald 3'] = 'EMERALD_RANK',
		Nightmare = 'NIGHTMARE_RANK'
	}

	local barColors = {
		Bronze = Color3.fromRGB(188, 110, 60),
		Silver = Color3.fromRGB(180, 180, 190),
		Gold = Color3.fromRGB(255, 200, 0),
		Platinum = Color3.fromRGB(60, 220, 255),
		Diamond = Color3.fromRGB(90, 150, 255),
		Emerald = Color3.fromRGB(0, 200, 100)
	}

	local rankImages = {}
	for _, key in {'BRONZE_RANK', 'SILVER_RANK', 'GOLD_RANK', 'PLATINUM_RANK', 'DIAMOND_RANK', 'EMERALD_RANK', 'NIGHTMARE_RANK'} do
		local img = ImageId[key]
		if img and img ~= '' then
			rankImages[img] = true
		end
	end

	local hooked = setmetatable({}, {__mode = 'k'})
	local addedConn
	local scanThread
	local busy = false

	local function fix(obj)
		if not PlayerProfileSpoof.Enabled then return end
		local rank = RankDrop.Value
		local rp = RPSlider.Value
		local nightmare = rank == 'Nightmare'

		busy = true
		if obj:IsA('ImageLabel') then
			local img = ImageId[rankKeys[rank]]
			if rankImages[obj.Image] and obj.Image ~= img then
				obj.Image = img
			end
		elseif obj:IsA('TextLabel') then
			if obj.Name == 'CurrentRP' then
				obj.Visible = not nightmare
				if not nightmare then
					obj.Text = rp .. ' RP / 100'
				end
			elseif obj.Name == 'RankName' then
				obj.Text = rank
			elseif obj.Text:find('Leaderboard Rank:') then
				local txt = 'Leaderboard Rank: ' .. LBSlider.Value
				if obj.Text ~= txt then
					obj.Text = txt
				end
			end
		elseif obj.Name == 'ProgressBar' then
			obj.Visible = not nightmare
			if not nightmare then
				local col = barColors[rank:match('^(%a+)')]
				if col then
					obj.BackgroundColor3 = col
				end
				obj.Size = UDim2.new(math.clamp(rp / 100, 0, 1), 0, obj.Size.Y.Scale, obj.Size.Y.Offset)
			end
		elseif obj.Name == 'ProgressBarContainer' then
			obj.Visible = not nightmare
		end
		busy = false
	end

	local function wanted(obj)
		if obj:IsA('ImageLabel') then
			return rankImages[obj.Image] == true
		elseif obj:IsA('TextLabel') then
			return obj.Name == 'CurrentRP' or obj.Name == 'RankName' or obj.Text:find('Leaderboard Rank:') ~= nil
		elseif obj:IsA('Frame') then
			return obj.Name == 'ProgressBar' or obj.Name == 'ProgressBarContainer'
		end
		return false
	end

	local function hook(obj)
		if hooked[obj] or not wanted(obj) then return end
		local props = {'Visible', 'Size', 'BackgroundColor3'}
		if obj:IsA('ImageLabel') then
			props = {'Image'}
		elseif obj:IsA('TextLabel') then
			props = {'Text', 'Visible'}
		end
		local real = {}
		local conns = {}
		for _, prop in props do
			real[prop] = obj[prop]
			table.insert(conns, obj:GetPropertyChangedSignal(prop):Connect(function()
				if not busy then
					real[prop] = obj[prop]
					fix(obj)
				end
			end))
		end
		hooked[obj] = {conns = conns, real = real}
		fix(obj)
	end

	local function scan()
		local gui = lplr:FindFirstChild('PlayerGui')
		if not gui then return end
		for _, obj in gui:GetDescendants() do
			if hooked[obj] then
				fix(obj)
			else
				hook(obj)
			end
		end
	end

	local function unhook()
		if scanThread then
			task.cancel(scanThread)
			scanThread = nil
		end
		if addedConn then
			addedConn:Disconnect()
			addedConn = nil
		end
		for obj, data in hooked do
			for _, c in data.conns do
				c:Disconnect()
			end
			if obj.Parent then
				busy = true
				for prop, value in data.real do
					pcall(function()
						obj[prop] = value
					end)
				end
				busy = false
			end
			hooked[obj] = nil
		end
	end

	PlayerProfileSpoof = vape.Categories.Minigames:CreateModule({
		Name = 'PlayerProfileSpoof',
		Function = function(callback)
			unhook()
			if callback then
				local gui = lplr:FindFirstChild('PlayerGui') or lplr:WaitForChild('PlayerGui')
				addedConn = gui.DescendantAdded:Connect(function(obj)
					if PlayerProfileSpoof.Enabled then
						hook(obj)
					end
				end)
				scan()
				scanThread = task.spawn(function()
					while PlayerProfileSpoof.Enabled do
						task.wait(0.5)
						scan()
					end
				end)
			end
		end,
		Tooltip = 'fakes ur rank, rp bar n leaderboard spot on ur profile (only u see it)'
	})

	RankDrop = PlayerProfileSpoof:CreateDropdown({
		Name = 'Rank',
		List = {
			'Bronze 1', 'Bronze 2', 'Bronze 3',
			'Silver 1', 'Silver 2', 'Silver 3',
			'Gold 1', 'Gold 2', 'Gold 3',
			'Platinum 1', 'Platinum 2', 'Platinum 3',
			'Diamond 1', 'Diamond 2', 'Diamond 3',
			'Emerald 1', 'Emerald 2', 'Emerald 3',
			'Nightmare'
		},
		Default = 'Nightmare',
		Function = function()
			if PlayerProfileSpoof.Enabled then scan() end
		end
	})

	RPSlider = PlayerProfileSpoof:CreateSlider({
		Name = 'RP',
		Min = 0,
		Max = 100,
		Default = 50,
		Function = function()
			if PlayerProfileSpoof.Enabled then scan() end
		end
	})

	LBSlider = PlayerProfileSpoof:CreateSlider({
		Name = 'Leaderboard Rank',
		Min = 1,
		Max = 10000,
		Default = 1,
		Function = function()
			if PlayerProfileSpoof.Enabled then scan() end
		end
	})
end)

run(function()
    local SetPlayerLevel
    local originalLevel = nil
    local customLevel = 1

    SetPlayerLevel = vape.Categories.Render:CreateModule({
        Name = "SetPlayerLevel",
        Function = function(state)
            if state then
                originalLevel = lplr:GetAttribute("PlayerLevel")
                lplr:SetAttribute("PlayerLevel", customLevel)
            else
                lplr:SetAttribute("PlayerLevel", originalLevel)
                originalLevel = nil
            end
        end,
        Tooltip = "Spoof your player level (client-sided)"
    })

    SetPlayerLevel:CreateSlider({
        Name = "Level",
        Min = 1,
        Max = 1000,
        Default = 1,
        Decimal = 1,
        Function = function(val)
            customLevel = math.floor(val)
            if SetPlayerLevel.Enabled then
                lplr:SetAttribute("PlayerLevel", customLevel)
            end
        end
    })
end)

run(function()
    local SetPlayerWins
    local originalWins = nil
    local customWins = 0
    local winsValue = nil 

    local function findWinsValue()
        local leaderstats = lplr:FindFirstChild("leaderstats")
        if leaderstats then
            return leaderstats:FindFirstChild("Wins") or leaderstats:FindFirstChild("OverallWins")
        end
        return nil
    end

    local function applyWinsOverride()
        winsValue = findWinsValue()
        if winsValue and winsValue:IsA("IntValue") then
            if originalWins == nil then
                originalWins = winsValue.Value
            end
            winsValue.Value = customWins
        else
            notif("SetPlayerWins", "Could not find Wins value", 3)
        end
    end

    local function restoreWins()
        if winsValue and winsValue:IsA("IntValue") and originalWins ~= nil then
            winsValue.Value = originalWins
        end
        winsValue = nil
        originalWins = nil
    end

    SetPlayerWins = vape.Categories.Minigames:CreateModule({
        Name = "SetPlayerWins",
        Function = function(state)
            if state then
                applyWinsOverride()
                SetPlayerWins:Clean(lplr.ChildAdded:Connect(function(child)
                    if child.Name == "leaderstats" and SetPlayerWins.Enabled then
                        applyWinsOverride()
                    end
                end))
            else
                restoreWins()
            end
        end,
        Tooltip = "Modify your wins in leaderstats (client‑sided)"
    })

    SetPlayerWins:CreateSlider({
        Name = "Wins",
        Min = 0,
        Max = 10000,
        Default = 0,
        Decimal = 1,
        Function = function(val)
            customWins = math.floor(val)
            if SetPlayerWins.Enabled and winsValue then
                winsValue.Value = customWins
            end
        end
    })
end)

run(function()
    local WinstreakSpoofer
    local Wins

    local oldSets = {
        Wins = nil,
        DoesExist = nil,
    }

    WinstreakSpoofer = vape.Categories.Minigames:CreateModule({
        Name = 'WinstreakSpoofer',
        Tooltip = 'Modifies/Adds your winstreak (client‑sided)',
        Function = function(callback)
            if callback then
                if not entitylib.isAlive then return end
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
                    if not winStreakCounter then
                        local main = Instance.new('Frame')
                        main.AnchorPoint = Vector2.new(1, 0.5)
                        main.Name = 'WinStreakCounter'
                        main.Size = UDim2.new(0.100000001, 0, 0.75, 0)
                        main.Position = UDim2.new(1.04999995, 0, 0.600000024, 0)
                        main.BackgroundTransparency = 1
                        main.Parent = lplr.Character.Head.Nametag
						main.LayoutOrder = 3
						main.BorderSizePixel =0
                        local icon = Instance.new('ImageLabel')
                        icon.BackgroundTransparency = 1
                        icon.Name = 'WinStreakFire'
                        icon.Size = UDim2.fromScale(1, 1)
                        icon.Image = 'rbxassetid://7101948108'
                        icon.ScaleType = Enum.ScaleType.Fit
						icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        icon.Parent = main
                        local value = Instance.new("TextLabel")
                        value.BackgroundTransparency = 1
                        value.Name = 'WinStreakValue'
                        value.Position = UDim2.fromScale(0.5, 0.375)
                        value.Size = UDim2.fromScale(0.8, 0.9)
                        value.FontFace = Font.new("Roboto", Enum.FontWeight.Bold)
                        value.TextSize = 8
                        oldSets.Wins = 0
                        value.Text = tostring(Wins.Value)
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                        value.TextScaled = true
                        value.TextStrokeTransparency = 0.5
                        value.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        value.Parent = main
						value.AutoLocalize = false
						value.TextXAlignment = Enum.TextXAlignment.Center
						value.AnchorPoint = Vector2.new(0.5,0)
                        oldSets.DoesExist = false
                    else
                        oldSets.DoesExist = true
                        oldSets.Wins = winStreakCounter.WinStreakValue.Text
                        winStreakCounter.WinStreakValue.Text = tostring(Wins.Value)
                    end
                end
            else
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
                    if winStreakCounter then
                        if oldSets.DoesExist then
                            winStreakCounter.WinStreakValue.Text = oldSets.Wins
                        else
                            winStreakCounter:Destroy()
                        end
                    end
                end
                oldSets.Wins = nil
                oldSets.DoesExist = nil
            end
        end
    })

    Wins = WinstreakSpoofer:CreateSlider({
        Name = "Wins",
        Min = 0,
        Max = 1000,
        Default = 0,
        Decimal = 1,
        Function = function(val)
            if WinstreakSpoofer.Enabled then
                if lplr.Character.Head.Nametag then
                    local winStreakCounter = lplr.Character.Head.Nametag:FindFirstChild("WinStreakCounter")
	                if not winStreakCounter then
                        local main = Instance.new('Frame')
                        main.AnchorPoint = Vector2.new(1, 0.5)
                        main.Name = 'WinStreakCounter'
                        main.Size = UDim2.new(0.100000001, 0, 0.75, 0)
                        main.Position = UDim2.new(1.04999995, 0, 0.600000024, 0)
                        main.BackgroundTransparency = 1
                        main.Parent = lplr.Character.Head.Nametag
						main.LayoutOrder = 3
						main.BorderSizePixel =0
                        local icon = Instance.new('ImageLabel')
                        icon.BackgroundTransparency = 1
                        icon.Name = 'WinStreakFire'
                        icon.Size = UDim2.fromScale(1, 1)
                        icon.Image = 'rbxassetid://7101948108'
                        icon.ScaleType = Enum.ScaleType.Fit
						icon.SizeConstraint = Enum.SizeConstraint.RelativeYY
                        icon.Parent = main
                        local value = Instance.new("TextLabel")
                        value.BackgroundTransparency = 1
                        value.Name = 'WinStreakValue'
                        value.Position = UDim2.fromScale(0.5, 0.375)
                        value.Size = UDim2.fromScale(0.8, 0.9)
                        value.FontFace = Font.new("Roboto", Enum.FontWeight.Bold)
                        value.TextSize = 8
                        oldSets.Wins = 0
                        value.Text = tostring(Wins.Value)
                        value.TextColor3 = Color3.fromRGB(255, 255, 255)
                        value.TextScaled = true
                        value.TextStrokeTransparency = 0.5
                        value.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
                        value.Parent = main
						value.AutoLocalize = false
						value.TextXAlignment = Enum.TextXAlignment.Center
						value.AnchorPoint = Vector2.new(0.5,0)
                        oldSets.DoesExist = false
                    else
                        winStreakCounter.WinStreakValue.Text = tostring(val)
                    end
                end
            end
        end
    })
end)

run(function()
	local Headless
	local headlessLoop = nil

	local headAttachments = {HatAttachment=true,HairAttachment=true,FaceFrontAttachment=true,FaceCenterAttachment=true,FaceBackAttachment=true}
	local removeAccs = false
	local bodyTransparency = 0
	local originalBody = setmetatable({}, {__mode = 'k'})

	local function restoreBody()
		for part, transparency in originalBody do
			if part.Parent then part.Transparency = transparency end
		end
		table.clear(originalBody)
	end

	local function applyHeadless(char)
		if not char then return end
		for _, part in char:GetChildren() do
			if part:IsA('BasePart') and part.Name ~= 'Head' and part.Name ~= 'HumanoidRootPart' then
				if originalBody[part] == nil then originalBody[part] = part.Transparency end
				part.Transparency = math.max(originalBody[part], bodyTransparency)
			end
		end
		local head = char:FindFirstChild("Head")
		if not head then return end
		head.Transparency = 1
		local face = head:FindFirstChild('face')
		if face and face:IsA("Decal") then
			face.Transparency = 1
		end
		if removeAccs then
			for _, acc in ipairs(char:GetChildren()) do
				if acc:IsA("Accessory") then
					local handle = acc:FindFirstChild("Handle")
					if handle then
						for _, att in ipairs(handle:GetChildren()) do
							if att:IsA("Attachment") and headAttachments[att.Name] then
								handle.Transparency = 1
								for _, d in ipairs(handle:GetChildren()) do
									if d:IsA("Decal") or d:IsA("Texture") then d.Transparency = 1 end
								end
								break
							end
						end
					end
				end
			end
		end
	end

	Headless = vape.Categories.Utility:CreateModule({
		PerformanceModeBlacklisted = true,
		Name = 'Headless',
		Tooltip = 'free headless 2026',
		Function = function(callback)
			if callback then
				if headlessLoop then task.cancel(headlessLoop) end
				headlessLoop = task.spawn(function()
					while Headless.Enabled do
						applyHeadless(lplr.Character)
						task.wait(0.1)
					end
				end)
				Headless:Clean(lplr.CharacterAdded:Connect(function(char)
					applyHeadless(char)
				end))
			else
				if headlessLoop then
					task.cancel(headlessLoop)
					headlessLoop = nil
				end
				restoreBody()
				local char = lplr.Character
				if char then
					local head = char:FindFirstChild("Head")
					if head then
						head.Transparency = 0
						local face = head:FindFirstChild('face')
						if face and face:IsA("Decal") then
							face.Transparency = 0
						end
					end
					for _, acc in ipairs(char:GetChildren()) do
						if acc:IsA("Accessory") then
							local handle = acc:FindFirstChild("Handle")
							if handle then
								handle.Transparency = 0
								for _, d in ipairs(handle:GetChildren()) do
									if d:IsA("Decal") or d:IsA("Texture") then d.Transparency = 0 end
								end
							end
						end
					end
				end
			end
		end,
		Default = false
	})

	Headless:CreateSlider({
		Name = 'Body Transparency',
		Min = 0,
		Max = 100,
		Default = 0,
		Suffix = '%',
		Tooltip = '0% keeps your body visible, 100% hides it locally',
		Function = function(value)
			bodyTransparency = value / 100
			if Headless.Enabled then applyHeadless(lplr.Character) end
		end
	})

	Headless:CreateToggle({
		Name = "Remove Accessories",
		Default = false,
		Function = function(state)
			removeAccs = state
			if Headless.Enabled then
				applyHeadless(lplr.Character)
			end
		end
	})
end)

run(function()
	local StatsBoardSpoof
	local RankDrop, LBSlider, RPSlider, LevelSlider, WinsSlider, BedsSlider, KillsSlider, HonorSlider
	local ImageId = require(game:GetService('ReplicatedStorage').TS.image['image-id']).BedwarsImageId
	local rankList = {}
	local rankImageKey = {}
	for _, tier in {'Bronze', 'Silver', 'Gold', 'Platinum', 'Diamond', 'Emerald'} do
		for i = 1, 4 do
			local name = tier .. ' ' .. i
			table.insert(rankList, name)
			rankImageKey[name] = tier:upper() .. '_RANK'
		end
	end
	table.insert(rankList, 'Nightmare')
	rankImageKey.Nightmare = 'NIGHTMARE_RANK'

	local barColors = {
		Bronze = Color3.fromRGB(188, 110, 60),
		Silver = Color3.fromRGB(180, 180, 190),
		Gold = Color3.fromRGB(255, 200, 0),
		Platinum = Color3.fromRGB(60, 220, 255),
		Diamond = Color3.fromRGB(90, 150, 255),
		Emerald = Color3.fromRGB(0, 200, 100)
	}

	local watchProps = {
		rankImage = {'Image'},
		levelLabel = {'Text'},
		rankName = {'Text'},
		lbRank = {'Text'},
		currentRP = {'Text', 'Visible'},
		rpHolder = {'Visible'},
		rpBar = {'Size', 'BackgroundColor3'},
		honorVal = {'Text'},
		winsVal = {'Text'},
		bedVal = {'Text'},
		killsVal = {'Text'}
	}

	local hooked = setmetatable({}, {__mode = 'k'})
	local scanThread
	local busy = false

	local function commas(n)
		local s = tostring(math.floor(n))
		local out = ''
		for i = 1, #s do
			out = out .. s:sub(i, i)
			if (#s - i) % 3 == 0 and i ~= #s then
				out = out .. ','
			end
		end
		return out
	end

	local function getBoard()
		local lobby = workspace:FindFirstChild('Lobby')
		local boards = lobby and lobby:FindFirstChild('Boards')
		local sb = boards and boards:FindFirstChild('StatsBoard')
		local board = sb and sb:FindFirstChild('Board')
		return board and board:FindFirstChild('StatsBoard')
	end

	local function child(obj, ...)
		for _, name in {...} do
			obj = obj and obj:FindFirstChild(name)
		end
		return obj
	end

	local function getElements(gui)
		local inner = child(gui, '1', '1')
		local scroll = inner and inner:FindFirstChild('AutoCanvasScrollingFrame')
		if not scroll then return nil end
		local level = scroll:FindFirstChild('3')
		local rankDisplay = child(scroll, '4', '3')
		local rankInfo = rankDisplay and rankDisplay:FindFirstChild('3')
		local nameFrame = rankInfo and rankInfo:FindFirstChild('2')
		local rpFrame = rankInfo and rankInfo:FindFirstChild('3')
		local holder = rpFrame and rpFrame:FindFirstChild('ProgressBarContainer')
		local stats = child(scroll, '5', '3', '2')
		return {
			rankImage = rankDisplay and rankDisplay:FindFirstChild('2'),
			levelLabel = level and level:FindFirstChild('2'),
			rankName = nameFrame and nameFrame:FindFirstChild('RankName'),
			lbRank = nameFrame and nameFrame:FindFirstChild('LeaderboardRank'),
			currentRP = rpFrame and rpFrame:FindFirstChild('CurrentRP'),
			rpHolder = holder,
			rpBar = holder and holder:FindFirstChild('ProgressBar'),
			honorVal = child(stats, '2', '5'),
			winsVal = child(stats, '3', '5'),
			bedVal = child(stats, '4', '5'),
			killsVal = child(stats, '5', '5')
		}
	end

	local function wanted(key)
		local rank = RankDrop.Value
		local nightmare = rank == 'Nightmare'
		local rp = math.floor(RPSlider.Value)
		if key == 'rankImage' then
			local img = ImageId[rankImageKey[rank]]
			return img and {Image = img} or {}
		elseif key == 'levelLabel' then
			return {Text = 'Player Level ' .. math.floor(LevelSlider.Value)}
		elseif key == 'rankName' then
			return {Text = rank}
		elseif key == 'lbRank' then
			return {Text = 'Leaderboard Rank: <b><font color="rgb(185,188,255)">' .. commas(LBSlider.Value) .. '</font></b>'}
		elseif key == 'currentRP' then
			if nightmare then
				return {Visible = false}
			end
			return {Visible = true, Text = '<b><font color="#ffffff">' .. rp .. ' RP</font></b> / 100'}
		elseif key == 'rpHolder' then
			return {Visible = not nightmare}
		elseif key == 'rpBar' then
			if nightmare then return {} end
			return {Size = UDim2.new(rp / 100, 0, 1, 0), BackgroundColor3 = barColors[rank:match('^(%a+)')]}
		elseif key == 'honorVal' then
			return {Text = tostring(math.floor(HonorSlider.Value))}
		elseif key == 'winsVal' then
			return {Text = tostring(math.floor(WinsSlider.Value))}
		elseif key == 'bedVal' then
			return {Text = tostring(math.floor(BedsSlider.Value))}
		elseif key == 'killsVal' then
			return {Text = tostring(math.floor(KillsSlider.Value))}
		end
		return {}
	end

	local function fix(obj)
		local data = hooked[obj]
		if not data or not StatsBoardSpoof.Enabled then return end
		busy = true
		for prop, value in wanted(data.key) do
			if obj[prop] ~= value then
				obj[prop] = value
			end
		end
		busy = false
	end

	local function hook(obj, key)
		if hooked[obj] then return end
		local data = {key = key, real = {}, conns = {}}
		hooked[obj] = data
		for _, prop in watchProps[key] do
			data.real[prop] = obj[prop]
			table.insert(data.conns, obj:GetPropertyChangedSignal(prop):Connect(function()
				if not busy then
					data.real[prop] = obj[prop]
					fix(obj)
				end
			end))
		end
		fix(obj)
	end

	local function scan()
		local gui = getBoard()
		local parts = gui and getElements(gui)
		if not parts then return false end
		for key, obj in parts do
			if hooked[obj] then
				fix(obj)
			else
				hook(obj, key)
			end
		end
		return true
	end

	local function unhook()
		if scanThread then
			task.cancel(scanThread)
			scanThread = nil
		end
		for obj, data in hooked do
			for _, c in data.conns do
				c:Disconnect()
			end
			if obj.Parent then
				busy = true
				for prop, value in data.real do
					pcall(function()
						obj[prop] = value
					end)
				end
				busy = false
			end
			hooked[obj] = nil
		end
	end

	local function refresh()
		if StatsBoardSpoof.Enabled then
			scan()
		end
	end

	StatsBoardSpoof = vape.Categories.Minigames:CreateModule({
		Name = 'StatsBoardSpoof',
		Function = function(callback)
			unhook()
			if callback then
				if not scan() then
					notif('StatsBoardSpoof', 'cant find the stats board, u gotta be in the lobby', 3)
				end
				scanThread = task.spawn(function()
					while StatsBoardSpoof.Enabled do
						task.wait(0.5)
						scan()
					end
				end)
			end
		end,
		Tooltip = 'fakes ur stats on the lobby stats board (only u see it)'
	})

	RankDrop = StatsBoardSpoof:CreateDropdown({
		Name = 'Rank',
		List = rankList,
		Default = 'Silver 3',
		Function = refresh
	})
	LBSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Leaderboard Rank',
		Min = 1,
		Max = 100000,
		Default = 11469,
		Decimal = 1,
		Function = refresh
	})
	RPSlider = StatsBoardSpoof:CreateSlider({
		Name = 'RP',
		Min = 0,
		Max = 100,
		Default = 26,
		Decimal = 1,
		Function = refresh
	})
	LevelSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Player Level',
		Min = 1,
		Max = 200,
		Default = 40,
		Decimal = 1,
		Function = refresh
	})
	WinsSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Wins',
		Min = 0,
		Max = 50000,
		Default = 621,
		Decimal = 1,
		Function = refresh
	})
	BedsSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Bed Breaks',
		Min = 0,
		Max = 50000,
		Default = 269,
		Decimal = 1,
		Function = refresh
	})
	KillsSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Final Kills',
		Min = 0,
		Max = 100000,
		Default = 457,
		Decimal = 1,
		Function = refresh
	})
	HonorSlider = StatsBoardSpoof:CreateSlider({
		Name = 'Honor',
		Min = 0,
		Max = 10000,
		Default = 2,
		Decimal = 1,
		Function = refresh
	})
end)

run(function()
    local LARPKits
    local KITS_TO_OWN = {}
    local active = false
    local connection = nil

    local function getKitName(btn)
        local tag = btn:FindFirstChild("KitNameTag")
        if not tag then return nil end
        local lbl = tag:FindFirstChild("5") or tag:FindFirstChild("4")
        if lbl and lbl:IsA("TextLabel") then
            return lbl.Text
        end
        return nil
    end

    local function moveOwnedKits(notOwned, owned)
        if not notOwned or not owned then return 0 end
        local moved = 0
        for _, btn in ipairs(notOwned:GetChildren()) do
            if btn:IsA("ImageButton") then
                local name = getKitName(btn)
                if name then
                    for _, wantedKit in ipairs(KITS_TO_OWN) do
                        if string.lower(name) == string.lower(wantedKit) then
                            btn.Parent = owned
                            moved = moved + 1
                            break
                        end
                    end
                end
            end
        end
        return moved
    end

    local function applyKits()
        local pg = game.Players.LocalPlayer:FindFirstChild("PlayerGui")
        if not pg then return end
        local app = pg:FindFirstChild("KitShopApp")
        if not app then return end
        local list = app:FindFirstChild("LobbyKitShopItemList", true)
        if not list then return end
        local notOwned = list:FindFirstChild("NotUnlockedKits")
        local owned = list:FindFirstChild("UnlockedKits")
        if notOwned and owned then
            moveOwnedKits(notOwned, owned)
        end
    end

    local addedConn = nil

    local function isWanted(name)
        if not name then return false end
        local lower = string.lower(name)
        for _, wantedKit in ipairs(KITS_TO_OWN) do
            if lower == string.lower(wantedKit) then return true end
        end
        return false
    end

    local function tryMove(obj)
        if not active or not obj then return end
        local btn = obj:IsA("ImageButton") and obj or obj:FindFirstAncestorWhichIsA("ImageButton")
        if not btn then return end
        local parent = btn.Parent
        if not parent or parent.Name ~= "NotUnlockedKits" then return end
        local owned = parent.Parent and parent.Parent:FindFirstChild("UnlockedKits")
        if owned and isWanted(getKitName(btn)) then
            btn.Parent = owned
        end
    end

    local function startAutoMove()
        if connection then return end
        local pg = game.Players.LocalPlayer:FindFirstChild("PlayerGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
        addedConn = pg.DescendantAdded:Connect(function(obj)
            if not active then return end
            if obj:IsA("ImageButton") or (obj:IsA("TextLabel") and (obj.Name == "5" or obj.Name == "4")) then
                tryMove(obj)
            end
        end)
        local last = 0
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not active then return end
            local now = os.clock()
            if now - last < 0.25 then return end
            last = now
            applyKits()
        end)
    end

    local function stopAutoMove()
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if addedConn then
            addedConn:Disconnect()
            addedConn = nil
        end
    end

    LARPKits = vape.Categories.Minigames:CreateModule({
        Name = "LARPKits",
        Tooltip = "do u own it or not !!! (client-sided)",
        Function = function(callback)
            active = callback
            if callback then
                startAutoMove()
                applyKits() 
            else
                stopAutoMove()
            end
        end
    })

    LARPKits:CreateTextList({
        Name = "Kits To Own",
        Placeholder = "Type kit names here e.g. Ragnar",
        Function = function(list)
            KITS_TO_OWN = {}
            for _, name in ipairs(list) do
                if name and name ~= "" then
                    table.insert(KITS_TO_OWN, name)
                end
            end
            if active then
                applyKits()
            end
        end
    })
end)

run(function()
    local AutoQueue
    local QueueType
    local Leave
    
    local Categories = {}
    
    AutoQueue = vape.Categories.Utility:CreateModule({
        Name = 'Auto Queue',
        Function = function(call)
            if call then
                repeat
                    local partyData = bedwars.Store:getState().Party
                    if partyData.leader.userId == lplr.UserId then
                        if partyData.queueState == 3 and partyData.queueState ~= Categories[QueueType.Value] then
                            replicatedStorage['events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events'].leaveQueue:FireServer()
                        elseif partyData.queueState < 2 then
                            replicatedStorage['events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events'].joinQueue:FireServer({
                                queueType = Categories[QueueType.Value]
                            })
                            task.wait(1)
                        end
                    elseif Leave.Enabled then
                        replicatedStorage['events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events'].leaveParty:FireServer()
                    end
                    task.wait(0.1)
                until not AutoQueue.Enabled
    
            else
                replicatedStorage['events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events'].leaveQueue:FireServer()
            end
        end
    })
    
    local list = {}
    for i,v in bedwars.QueueMeta do
        if not v.disabled then
            Categories[v.title] = i
            table.insert(list, v.title)
        end
    end
    QueueType = AutoQueue:CreateDropdown({
        Name = 'Queue Type',
        List = list,
        Default = 'Duels (2v2)'
    })
    Leave = AutoQueue:CreateToggle({
        Name = 'Leave Party',
        Default = true
    })
end)

run(function()
    local LARPBedCoins
    local customAmount = 0
    local cachedLabel = nil
    local hookedLabel = nil
    local realText = nil
    local textConn = nil
    local applying = false

    local function findLabel()
        if cachedLabel and cachedLabel.Parent then
            return cachedLabel
        end
        local pg = lplr:FindFirstChild("PlayerGui")
        if not pg then return nil end
        local sideGui = pg:FindFirstChild("LobbyHudSideGui")
        if not sideGui then return nil end
        local side = sideGui:FindFirstChild("LobbyHudSide")
        if not side then return nil end
        local currency = side:FindFirstChild("LobbyHudCurrency")
        if not currency then return nil end
        local inner = currency:FindFirstChild("LobbyHudCurrency")
        if not inner then return nil end
        local container = inner:FindFirstChild("Container")
        if not container then return nil end
        local amount = container:FindFirstChild("CurrencyAmount")
        if not amount then return nil end
        if not amount:IsA("TextLabel") then return nil end
        cachedLabel = amount
        return amount
    end

    local function formatNumber(n)
        local s = tostring(math.floor(n))
        local res = ""
        for i = 1, #s do
            res = res .. s:sub(i, i)
            if (#s - i) % 3 == 0 and i ~= #s then
                res = res .. ","
            end
        end
        return res
    end

    local function updateCoins()
        if not LARPBedCoins or not LARPBedCoins.Enabled then return end
        local label = findLabel()
        if not label then return end
        if label ~= hookedLabel then
            if textConn then textConn:Disconnect() end
            hookedLabel = label
            realText = label.Text
            textConn = label:GetPropertyChangedSignal("Text"):Connect(function()
                if applying then return end
                realText = label.Text
                updateCoins()
            end)
        end
        local want = formatNumber(customAmount)
        if label.Text ~= want then
            applying = true
            label.Text = want
            applying = false
        end
    end

    LARPBedCoins = vape.Categories.Minigames:CreateModule({
        Name = "LARPBedCoins",
        Tooltip = "larp ur bed coins",
        Function = function(callback)
            if callback then
                LARPBedCoins:Clean(runService.RenderStepped:Connect(function()
                    updateCoins()
                end))
                updateCoins()
            else
                if textConn then
                    textConn:Disconnect()
                    textConn = nil
                end
                if hookedLabel and hookedLabel.Parent and realText then
                    applying = true
                    hookedLabel.Text = realText
                    applying = false
                end
                hookedLabel = nil
                realText = nil
                cachedLabel = nil
            end
        end
    })

    LARPBedCoins:CreateSlider({
        Name = "Coin Amount",
        Min = 0,
        Max = 1000000,
        Default = 0,
        Decimal = 1,
        Function = function(val)
            customAmount = math.floor(val)
            if LARPBedCoins.Enabled then updateCoins() end
        end
    })
end)

run(function()
	local RegionLock
	local AllowedRegions
	local readyGate = getgenv().aeroReadyGate or {Release = function() end}
	local lockLabel = 'next match'
	local knownRegion
	local fetchBusy = false
	local nextFetch = 0
	local warnedUnknown = false
	local shorthand = {
		AU = 'SEA', AUS = 'SEA', AUSTRALIA = 'SEA', NZ = 'SEA', OCE = 'SEA', OCEANIA = 'SEA',
		AS = 'SEA', ASIA = 'SEA', SG = 'SEA', SGP = 'SEA',
		US = 'NA', USA = 'NA', AMERICA = 'NA',
		EUROPE = 'EU', GB = 'EU', UK = 'EU'
	}

	local function normalize(text)
		text = tostring(text):gsub('%s+', ''):upper()
		return shorthand[text] or text
	end

	local function currentRegion()
		local okState, gameState = pcall(function()
			return bedwars.Store:getState().Game
		end)
		local fromStore = okState and type(gameState) == 'table' and gameState.serverRegion or nil
		if type(fromStore) == 'string' and fromStore ~= '' then
			knownRegion = fromStore
			return fromStore
		end
		if not knownRegion and not fetchBusy and os.clock() >= nextFetch then
			fetchBusy = true
			task.spawn(function()
				local okFetch, reply = pcall(function()
					return bedwars.Client:Get('FetchServerRegion'):CallServer()
				end)
				nextFetch = os.clock() + 5
				fetchBusy = false
				if okFetch and type(reply) == 'string' and reply ~= '' then
					knownRegion = reply
				end
			end)
		end
		return knownRegion
	end

	local function regionOk()
		if #AllowedRegions.ListEnabled == 0 then
			return true
		end
		local region = currentRegion()
		if not region then
			return false
		end
		region = normalize(region)
		for _, want in AllowedRegions.ListEnabled do
			want = normalize(want)
			if want ~= '' and region:sub(1, #want) == want then
				return true
			end
		end
		return false
	end

	RegionLock = vape.Categories.Utility:CreateModule({
		Name = 'RegionLock',
		Function = function(callback)
			if callback then
				readyGate.Claimed = true
				warnedUnknown = false
				repeat
					if not readyGate.Held then
						lockLabel = lplr:GetAttribute('PlayerConnected') and 'loaded' or 'next match'
					else
						local heldSince = readyGate.Started or os.clock()
						if regionOk() then
							lockLabel = knownRegion or 'any region'
							readyGate.Release()
						elseif knownRegion then
							lockLabel = 'wrong region ('..knownRegion..')'
						elseif os.clock() - heldSince >= 20 then
							if not warnedUnknown then
								warnedUnknown = true
								notif('RegionLock', 'couldnt read this server region so ur loadin in anyway', 8, 'warning')
							end
							lockLabel = 'unknown region'
							readyGate.Release()
						else
							lockLabel = 'finding region'
						end
					end
					task.wait(0.5)
				until not RegionLock.Enabled
			else
				readyGate.Release()
				lockLabel = 'loaded'
				readyGate.Claimed = false
			end
		end,
		ExtraText = function()
			return lockLabel
		end,
		Tooltip = 'keeps u outta matches that aint in the regions u picked bedwars only has NA,EU adn SEA n picks urs from ur account country so this only skips the odd server in another region'
	})

	AllowedRegions = RegionLock:CreateTextList({
		Name = 'Regions',
		Placeholder = 'NA / EU / SEA',
		Default = {'NA', 'EU', 'SEA'},
		Function = function()
			if not AllowedRegions then
				return
			end
			for i, v in AllowedRegions.List do
				AllowedRegions.List[i] = v:gsub('%s+', ''):upper()
			end
			for i, v in AllowedRegions.ListEnabled do
				AllowedRegions.ListEnabled[i] = v:gsub('%s+', ''):upper()
			end
		end,
		Tooltip = 'turn off the regions u dont want. AUS OCE AU n NZ count as SEA n US counts as NA. leavin them all on lets anything in'
	})

	task.spawn(function()
		repeat
			task.wait()
		until vape.Loaded ~= false
		if vape.Loaded and not readyGate.Claimed then
			readyGate.Release()
		end
	end)
end)

run(function()
	local StreamerMode
	local NameBox
	local restored = setmetatable({}, {__mode = 'k'})
	local hooked = setmetatable({}, {__mode = 'k'})
	local textClasses = {TextLabel = true, TextButton = true, TextBox = true}
	local needles = {}
	local minLength = math.huge
	local alias = 'hidden'
	local writing
	local playerClass
	local savedUsername, savedDisplay, savedTag, savedLevel
	local queued = false

	local function readAlias()
		local value = NameBox and NameBox.Value
		if type(value) == 'string' and value ~= '' then
			return value
		end
		return 'hidden'
	end

	local function buildNeedles()
		table.clear(needles)
		minLength = math.huge
		local seen = {}
		for _, name in {lplr.Name, lplr.DisplayName} do
			if type(name) == 'string' and name ~= '' and not seen[name] then
				seen[name] = true
				minLength = math.min(minLength, #name)
				table.insert(needles, {
					plain = name:lower(),
					forms = {name, name:lower(), name:upper()}
				})
			end
		end
	end

	local function maskText(text)
		local out = text
		for _, needle in needles do
			for _, form in needle.forms do
				if form ~= '' and out:find(form, 1, true) then
					out = out:gsub((form:gsub('%W', '%%%0')), alias)
				end
			end
		end
		return out
	end

	local function keepText(object, value)
		writing = object
		object.Text = value
		writing = nil
	end

	local function watchText(object, apply)
		if hooked[object] then return end
		hooked[object] = object:GetPropertyChangedSignal('Text'):Connect(apply)
	end

	local function nearbyName(object)
		local parent = object.Parent
		for _ = 1, 3 do
			if not parent then return nil end
			local label = parent:FindFirstChild('PlayerName', true)
			if label then return label end
			parent = parent.Parent
		end
		return nil
	end

	local function blankLevel(object)
		if writing == object or not textClasses[object.ClassName] then return end
		if not object.Name:lower():find('level', 1, true) then return end
		local owner = nearbyName(object)
		if not owner or not owner.Text:find(alias, 1, true) then return end

		local function apply()
			if writing == object or not object.Parent then return end
			local text = object.Text
			if type(text) ~= 'string' or text == '' then return end
			if restored[object] == nil then
				restored[object] = text
			end
			keepText(object, '')
		end

		apply()
		watchText(object, apply)
	end

	local function sweepLevels(object)
		if not object then return end
		for _, child in object:GetDescendants() do
			blankLevel(child)
		end
	end

	local function maskObject(object)
		if not textClasses[object.ClassName] then return end

		local function apply()
			if writing == object or not object.Parent then return end
			local text = object.Text
			if type(text) ~= 'string' or #text < minLength then return end

			local lower = text:lower()
			local found = false
			for _, needle in needles do
				if lower:find(needle.plain, 1, true) then
					found = true
					break
				end
			end
			if not found then return end

			local masked = maskText(text)
			if masked == text then return end

			if restored[object] == nil then
				restored[object] = text
			end
			keepText(object, masked)
			watchText(object, apply)
			sweepLevels(object.Parent)
		end

		apply()
	end

	local function sweep(root)
		if not root then return end
		if vape.ThreadFix and setthreadidentity then
			pcall(setthreadidentity, 8)
		end

		StreamerMode:Clean(root.DescendantAdded:Connect(function(object)
			if not StreamerMode.Enabled then return end
			maskObject(object)
			blankLevel(object)
		end))

		local clock = os.clock()
		for _, object in root:GetDescendants() do
			maskObject(object)
			blankLevel(object)
			if os.clock() - clock > 0.002 then
				task.wait()
				if not StreamerMode.Enabled then return end
				clock = os.clock()
				if vape.ThreadFix and setthreadidentity then
					pcall(setthreadidentity, 8)
				end
			end
		end
	end

	local function findPlayerClass()
		if playerClass then return playerClass end
		pcall(function()
			local util = bedwars.GamePlayerUtil
			if not util then
				for _, module in replicatedStorage.TS:GetDescendants() do
					if module:IsA('ModuleScript') and module.Name:lower():find('game%-player%-util') then
						local ok, res = pcall(require, module)
						if ok and type(res) == 'table' and type(res.GamePlayerUtil) == 'table' then
							util = res.GamePlayerUtil
							break
						end
					end
				end
			end
			local holder = util and util.getGamePlayer and util.getGamePlayer(lplr)
			local meta = holder and getmetatable(holder)
			playerClass = meta and meta.__index or nil
		end)
		return playerClass
	end

	local function isMe(holder)
		local ok, player = pcall(function()
			return holder:getPlayer()
		end)
		return ok and player ~= nil and player.UserId == lplr.UserId
	end

	local function hookClass()
		local class = findPlayerClass()
		if not class or savedUsername then return end

		savedUsername, savedDisplay = class.getUsername, class.getDisplayName
		savedTag, savedLevel = class.getClanTag, class.getLevel

		class.getUsername = function(self, ...)
			return isMe(self) and alias or savedUsername(self, ...)
		end
		class.getDisplayName = function(self, ...)
			return isMe(self) and alias or savedDisplay(self, ...)
		end
		class.getClanTag = function(self, ...)
			return isMe(self) and '' or savedTag(self, ...)
		end
		class.getLevel = function(self, ...)
			return isMe(self) and -1 or savedLevel(self, ...)
		end
	end

	local function unhookClass()
		local class = playerClass
		if not class or not savedUsername then return end
		class.getUsername, class.getDisplayName = savedUsername, savedDisplay
		class.getClanTag, class.getLevel = savedTag, savedLevel
		savedUsername, savedDisplay, savedTag, savedLevel = nil, nil, nil, nil
	end

	local function reload()
		if queued or not StreamerMode or not StreamerMode.Enabled then return end
		queued = true
		task.delay(0.3, function()
			queued = false
			if StreamerMode.Enabled then
				StreamerMode:Toggle()
				StreamerMode:Toggle()
			end
		end)
	end

	StreamerMode = vape.Categories.Render:CreateModule({
		Name = 'StreamerMode',
		Function = function(callback)
			if callback then
				buildNeedles()
				alias = readAlias()
				for _, needle in needles do
					for _, form in needle.forms do
						if form ~= '' and alias:find(form, 1, true) then
							alias = 'hidden'
						end
					end
				end

				hookClass()

				for _, root in {lplr:FindFirstChildOfClass('PlayerGui'), cloneref(game:GetService('CoreGui')), gethui and gethui() or nil, lplr.Character} do
					sweep(root)
				end

				StreamerMode:Clean(lplr.CharacterAdded:Connect(function(char)
					if StreamerMode.Enabled then
						sweep(char)
					end
				end))
			else
				unhookClass()

				if vape.ThreadFix and setthreadidentity then
					pcall(setthreadidentity, 8)
				end

				for object, conn in hooked do
					pcall(function()
						conn:Disconnect()
					end)
				end
				table.clear(hooked)

				for object, text in restored do
					if object.Parent then
						keepText(object, text)
					end
				end
				writing = nil
				table.clear(restored)
			end
		end,
		Tooltip = 'changes ur name everywhere on ur screen so u can screenshare and etc without leaking it',
		ExtraText = function()
			return readAlias()
		end
	})

	NameBox = StreamerMode:CreateTextBox({
		Name = 'name',
		Default = 'motion is some ass gng',
		Placeholder = 'type a name...',
		Function = reload
	})
end)

run(function()
	local Speed
	local Mode
	local Value
	local WallCheck
	local AutoJump
	local wallParams = RaycastParams.new()
	wallParams.FilterType = Enum.RaycastFilterType.Exclude
	wallParams.RespectCanCollide = true

	local function setWalk(speed)
		local ok = pcall(function()
			bedwars.SprintController:setSpeed(speed)
		end)
		if not ok and entitylib.isAlive then
			entitylib.character.Humanoid.WalkSpeed = speed
		end
	end

	local function resetWalk()
		local sprinting = false
		pcall(function()
			sprinting = bedwars.SprintController:isSprinting()
		end)
		setWalk(sprinting and 20 or 16)
	end

	Speed = vape.Categories.Blatant:CreateModule({
		Name = 'Speed',
		Function = function(callback)
			if callback then
				Speed:Clean(runService.PreSimulation:Connect(function(dt)
					if not entitylib.isAlive then return end
					local hum = entitylib.character.Humanoid
					local root = entitylib.character.RootPart
					local state = hum:GetState()
					if state == Enum.HumanoidStateType.Climbing then return end
					local dir = hum.MoveDirection

					if Mode.Value == 'CFrame' then
						local vel = root.AssemblyLinearVelocity
						local flat = Vector3.new(vel.X, 0, vel.Z).Magnitude
						local step = dir * math.max(Value.Value - flat, 0) * dt
						if WallCheck.Enabled and step.Magnitude > 0 then
							wallParams.FilterDescendantsInstances = {lplr.Character, workspace.CurrentCamera}
							wallParams.CollisionGroup = root.CollisionGroup
							local hit = workspace:Raycast(root.Position, step, wallParams)
							if hit then
								step = (hit.Position + hit.Normal) - root.Position
							end
						end
						root.CFrame += step
					else
						setWalk(Value.Value)
					end

					if AutoJump.Enabled and dir ~= Vector3.zero and (state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed) then
						hum:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end))
			else
				resetWalk()
			end
		end,
		ExtraText = function()
			return Mode.Value
		end,
		Tooltip = 'makes u walk faster in the lobby'
	})
	Mode = Speed:CreateDropdown({
		Name = 'Method',
		List = {'Bedwars', 'CFrame'},
		Default = 'CFrame'
	})
	Value = Speed:CreateSlider({
		Name = 'Speed',
		Min = 1,
		Max = 23,
		Default = 23,
		Suffix = function(val)
			return val == 1 and 'stud' or 'studs'
		end
	})
	WallCheck = Speed:CreateToggle({
		Name = 'Wall Check',
		Default = true
	})
	AutoJump = Speed:CreateToggle({
		Name = 'AutoJump',
		Tooltip = 'jumps for u while ur moving'
	})
end)
