--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.
--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.
local mainapi = {
	Categories = {},
	GUIColor = {
		Hue = 0.46,
		Sat = 0.96,
		Value = 0.52
	},
	HeldKeybinds = {},
	Keybind = {'RightShift'},
	Loaded = false,
	Libraries = {},
	Modules = {},
    Place = game.PlaceId == 6872265039 and game.PlaceId or game.GameId,
	Profile = 'default',
	Profiles = {},
	RainbowSpeed = {Value = 1},
	RainbowUpdateSpeed = {Value = 40},
	RainbowTable = setmetatable({}, {__mode = "v"}),
	Scale = {Value = 1},
	ThreadFix = setthreadidentity and true or false,
	ToggleNotifications = {},
	Version = '4.18',	
	Windows = {}
}

local cloneref = cloneref or function(obj)
	return obj
end
local tweenService = cloneref(game:GetService('TweenService'))
local inputService = cloneref(game:GetService('UserInputService'))
local textService = cloneref(game:GetService('TextService'))
local guiService = cloneref(game:GetService('GuiService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))

local fontsize = Instance.new('GetTextBoundsParams')
fontsize.Width = math.huge
local notifications
local assetfunction = getcustomasset
local getcustomasset
local clickgui
local scaledgui
local toolblur
local tooltip
local scale
local gui

local color = {}
local tween = {
	tweens = {},
	tweenstwo = {}
}
local uipallet = {
	Main = Color3.fromRGB(26, 25, 26),
	Text = Color3.fromRGB(200, 200, 200),
	Font = Font.fromEnum(Enum.Font.Arial),
	FontSemiBold = Font.fromEnum(Enum.Font.Arial, Enum.FontWeight.SemiBold),
	Tween = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
}

local getcustomassets = {
	['aerov4/assets/new/add.png'] = 'rbxassetid://14368300605',
	['aerov4/assets/new/alert.png'] = 'rbxassetid://14368301329',
	['aerov4/assets/new/allowedicon.png'] = 'rbxassetid://14368302000',
	['aerov4/assets/new/allowedtab.png'] = 'rbxassetid://14368302875',
	['aerov4/assets/new/arrowmodule.png'] = 'rbxassetid://14473354880',
	['aerov4/assets/new/back.png'] = 'rbxassetid://14368303894',
	['aerov4/assets/new/bind.png'] = 'rbxassetid://14368304734',
	['aerov4/assets/new/bindbkg.png'] = 'rbxassetid://14368305655',
	['aerov4/assets/new/blatanticon.png'] = 'rbxassetid://14368306745',
	['aerov4/assets/new/blockedicon.png'] = 'rbxassetid://14385669108',
	['aerov4/assets/new/blockedtab.png'] = 'rbxassetid://14385672881',
	['aerov4/assets/new/blur.png'] = 'rbxassetid://14898786664',
	['aerov4/assets/new/blurnotif.png'] = 'rbxassetid://16738720137',
	['aerov4/assets/new/close.png'] = 'rbxassetid://14368309446',
	['aerov4/assets/new/closemini.png'] = 'rbxassetid://14368310467',
	['aerov4/assets/new/colorpreview.png'] = 'rbxassetid://14368311578',
	['aerov4/assets/new/combaticon.png'] = 'rbxassetid://14368312652',
	['aerov4/assets/new/customsettings.png'] = 'rbxassetid://14403726449',
	['aerov4/assets/new/discord.png'] = '',
	['aerov4/assets/new/dots.png'] = 'rbxassetid://14368314459',
	['aerov4/assets/new/edit.png'] = 'rbxassetid://14368315443',
	['aerov4/assets/new/expandicon.png'] = 'rbxassetid://14368353032',
	['aerov4/assets/new/expandright.png'] = 'rbxassetid://14368316544',
	['aerov4/assets/new/expandup.png'] = 'rbxassetid://14368317595',
	['aerov4/assets/new/friendstab.png'] = 'rbxassetid://14397462778',
	['aerov4/assets/new/guisettings.png'] = 'rbxassetid://14368318994',
	['aerov4/assets/new/guislider.png'] = 'rbxassetid://14368320020',
	['aerov4/assets/new/guisliderrain.png'] = 'rbxassetid://14368321228',
	['aerov4/assets/new/guiv4.png'] = 'rbxassetid://14368322199',
	['aerov4/assets/new/guivape.png'] = 'rbxassetid://14657521312',
	['aerov4/assets/new/info.png'] = 'rbxassetid://14368324807',
	['aerov4/assets/new/inventoryicon.png'] = 'rbxassetid://14928011633',
	['aerov4/assets/new/legit.png'] = 'rbxassetid://14425650534',
	['aerov4/assets/new/legittab.png'] = 'rbxassetid://14426740825',
	['aerov4/assets/new/miniicon.png'] = 'rbxassetid://14368326029',
	['aerov4/assets/new/notification.png'] = 'rbxassetid://16738721069',
	['aerov4/assets/new/overlaysicon.png'] = 'rbxassetid://14368339581',
	['aerov4/assets/new/overlaystab.png'] = 'rbxassetid://14397380433',
	['aerov4/assets/new/pin.png'] = 'rbxassetid://14368342301',
	['aerov4/assets/new/star.png'] = 'rbxassetid://14368342301',
	['aerov4/assets/new/profilesicon.png'] = 'rbxassetid://14397465323',
	['aerov4/assets/new/radaricon.png'] = 'rbxassetid://14368343291',
	['aerov4/assets/new/rainbow_1.png'] = 'rbxassetid://14368344374',
	['aerov4/assets/new/rainbow_2.png'] = 'rbxassetid://14368345149',
	['aerov4/assets/new/rainbow_3.png'] = 'rbxassetid://14368345840',
	['aerov4/assets/new/rainbow_4.png'] = 'rbxassetid://14368346696',
	['aerov4/assets/new/range.png'] = 'rbxassetid://14368347435',
	['aerov4/assets/new/rangearrow.png'] = 'rbxassetid://14368348640',
	['aerov4/assets/new/rendericon.png'] = 'rbxassetid://14368350193',
	['aerov4/assets/new/rendertab.png'] = 'rbxassetid://14397373458',
	['aerov4/assets/new/search.png'] = 'rbxassetid://14425646684',
	['aerov4/assets/new/targetinfoicon.png'] = 'rbxassetid://14368354234',
	['aerov4/assets/new/targetnpc1.png'] = 'rbxassetid://14497400332',
	['aerov4/assets/new/targetnpc2.png'] = 'rbxassetid://14497402744',
	['aerov4/assets/new/targetplayers1.png'] = 'rbxassetid://14497396015',
	['aerov4/assets/new/targetplayers2.png'] = 'rbxassetid://14497397862',
	['aerov4/assets/new/targetstab.png'] = 'rbxassetid://14497393895',
	['aerov4/assets/new/textguiicon.png'] = 'rbxassetid://14368355456',
	['aerov4/assets/new/textv4.png'] = 'rbxassetid://14368357095',
	['aerov4/assets/new/textvape.png'] = 'rbxassetid://14368358200',
	['aerov4/assets/new/utilityicon.png'] = 'rbxassetid://14368359107',
	['aerov4/assets/new/vape.png'] = 'rbxassetid://14373395239',
	['aerov4/assets/new/warning.png'] = 'rbxassetid://14368361552',
	['aerov4/assets/new/worldicon.png'] = 'rbxassetid://14368362492'
}

local isfile = isfile or function(file)
	local suc, res = pcall(function()
		return readfile(file)
	end)
	return suc and res ~= nil and res ~= ''
end

local function safecall(func, ...)
	local args = {...}
	xpcall(function()
		func(unpack(args))
	end, function(err)
		warn("[tape v4] GUI Error: "..err)
	end)
end

local fontsizecache = {}
local fontsizecachecount = 0
local getfontsize = function(text, size, font)
	text = tostring(text or '')
	size = tonumber(size) or 14
	local key = text..'|'..size..'|'..tostring(font)
	local hit = fontsizecache[key]
	if hit then return hit end

	local fallback = Vector2.new(#text * size * 0.6, size)
	local out
	local ok, result = pcall(function()
		fontsize.Text = text
		fontsize.Size = size
		if typeof(font) == 'Font' then
			fontsize.Font = font
		end
		return textService:GetTextBoundsAsync(fontsize)
	end)
	if ok and typeof(result) == 'Vector2' then
		out = result
	else
		out = fallback
	end

	if fontsizecachecount > 4000 then
		table.clear(fontsizecache)
		fontsizecachecount = 0
	end
	fontsizecache[key] = out
	fontsizecachecount += 1
	return out
end

local function addBlur(parent, notif)
	local blur = Instance.new('ImageLabel')
	blur.Name = 'Blur'
	blur.Size = UDim2.new(1, 89, 1, 52)
	blur.Position = UDim2.fromOffset(-48, -31)
	blur.BackgroundTransparency = 1
	blur.Image = getcustomasset('aerov4/assets/new/'..(notif and 'blurnotif' or 'blur')..'.png')
	blur.ScaleType = Enum.ScaleType.Slice
	blur.SliceCenter = Rect.new(52, 31, 261, 502)
	blur.Parent = parent

	return blur
end

local function addCorner(parent, radius)
	local corner = Instance.new('UICorner')
	corner.CornerRadius = radius or UDim.new(0, 9)
	corner.Parent = parent

	return corner
end

local function addCloseButton(parent, offset)
	local close = Instance.new('ImageButton')
	close.Name = 'Close'
	close.Size = UDim2.fromOffset(24, 24)
	close.Position = UDim2.new(1, -35, 0, offset or 9)
	close.BackgroundColor3 = Color3.new(1, 1, 1)
	close.BackgroundTransparency = 1
	close.AutoButtonColor = false
	close.Image = getcustomasset('aerov4/assets/new/close.png')
	close.ImageColor3 = color.Light(uipallet.Text, 0.2)
	close.ImageTransparency = 0.5
	close.Parent = parent
	addCorner(close, UDim.new(1, 0))

	close.MouseEnter:Connect(function()
		close.ImageTransparency = 0.3
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 0.6
		})
	end)
	close.MouseLeave:Connect(function()
		close.ImageTransparency = 0.5
		tween:Tween(close, uipallet.Tween, {
			BackgroundTransparency = 1
		})
	end)

	return close
end

local function addMaid(object)
    object.Connections = {}
    function object:Clean(callback)
        if typeof(callback) == 'Instance' then
            table.insert(self.Connections, {
                Disconnect = function()
                    callback:ClearAllChildren()
                    callback:Destroy()
                end
            })
        elseif type(callback) == 'function' then
            table.insert(self.Connections, {
                Disconnect = callback
            })
        else
            table.insert(self.Connections, callback)
        end
    end
end
addMaid(mainapi)

local function addTooltip(gui, text)
	if not text then return end

	local function tooltipMoved(x, y)
		local right = x + 16 + tooltip.Size.X.Offset > (scale.Scale * 1920)
		tooltip.Position = UDim2.fromOffset(
			(right and x - (tooltip.Size.X.Offset * scale.Scale) - 16 or x + 16) / scale.Scale,
			((y + 11) - (tooltip.Size.Y.Offset / 2)) / scale.Scale
		)
		tooltip.Visible = toolblur.Visible
	end

	gui.MouseEnter:Connect(function(x, y)
		local tooltipSize = getfontsize(text, tooltip.TextSize, uipallet.Font)
		tooltip.Size = UDim2.fromOffset(tooltipSize.X + 10, tooltipSize.Y + 10)
		tooltip.Text = text
		tooltipMoved(x, y)
	end)
	gui.MouseMoved:Connect(tooltipMoved)
	gui.MouseLeave:Connect(function()
		tooltip.Visible = false
	end)
end

local function checkKeybinds(compare, target, key)
	if type(target) == 'table' then
		if table.find(target, key) then
			for i, v in target do
				if not table.find(compare, v) then
					return false
				end
			end
			return true
		end
	end

	return false
end

local function createDownloader(text)
	if mainapi.Loaded ~= true then
		local downloader = mainapi.Downloader
		if not downloader then
			downloader = Instance.new('TextLabel')
			downloader.Size = UDim2.new(1, 0, 0, 40)
			downloader.BackgroundTransparency = 1
			downloader.TextStrokeTransparency = 0
			downloader.TextSize = 20
			downloader.TextColor3 = Color3.new(1, 1, 1)
			downloader.FontFace = uipallet.Font
			local holder = Instance.new('ScreenGui')
			holder.Name = 'Loading'
			holder.DisplayOrder = 9999999
			holder.IgnoreGuiInset = true
			holder.ResetOnSpawn = false
			pcall(function() holder.Parent = mainapi.gui.Parent end)
			downloader.Parent = holder
			mainapi.Downloader = downloader
			mainapi.DownloaderGui = holder
		end
		downloader.Text = 'Downloading '..text
	end
end

local mobileEditorOpen = false
local mobileEditorBG = nil
local mobileButtons = {}
local mobileCloseBtn = nil
local mobileEditorLabels = {}
local addMobileButton 
local persistentRecentNames = {}
local activeRefreshResults = nil 
local mobileButtonTransparency = 0
local mobileButtonBgColor = nil
local mobileButtonActiveColor = nil
local mobileBtnTweens = {}

local function getMobileTextColor(bg)
	local lum = 0.299 * bg.R + 0.587 * bg.G + 0.114 * bg.B
	return lum > 0.5 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
end

local function formatModuleName(name)
	if #name <= 7 then return name end
	for i = math.ceil(#name / 2), 2, -1 do
		if name:sub(i, i):match('%u') then
			return name:sub(1, i - 1) .. '\n' .. name:sub(i)
		end
	end
	local m = math.ceil(#name / 2)
	return name:sub(1, m) .. '\n' .. name:sub(m + 1)
end

local function updateMobileButtonColor(btn, enabled, animate)
	local vapeColor = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	local bg = enabled and (mobileButtonActiveColor or vapeColor) or (mobileButtonBgColor or color.Dark(uipallet.Main, -0.08))
	local textCol = mobileButtonTransparency > 0.7 and Color3.new(1, 1, 1) or getMobileTextColor(bg)
	if animate and btn and btn.Parent then
		if mobileBtnTweens[btn] then
			mobileBtnTweens[btn]:Cancel()
			mobileBtnTweens[btn] = nil
		end
		mobileBtnTweens[btn] = tweenService:Create(btn, TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = bg,
			BackgroundTransparency = mobileButtonTransparency,
			TextColor3 = textCol
		})
		mobileBtnTweens[btn]:Play()
		mobileBtnTweens[btn].Completed:Once(function()
			mobileBtnTweens[btn] = nil
		end)
	else
		btn.BackgroundColor3 = bg
		btn.BackgroundTransparency = mobileButtonTransparency
		btn.TextColor3 = textCol
	end
end

local function setResizeHandlesVisible(data, visible)
	if data.resizeFrame then
		data.resizeFrame.Visible = visible
	end
end

local function closeMobileEditor()
	if mobileEditorBG then
		mobileEditorBG:Destroy()
		mobileEditorBG = nil
	end
	if mobileCloseBtn then
		mobileCloseBtn:Destroy()
		mobileCloseBtn = nil
	end
	for _, lbl in mobileEditorLabels do
		if lbl and lbl.Parent then lbl:Destroy() end
	end
	table.clear(mobileEditorLabels)
	for _, data in mobileButtons do
		data.editorMode = false
		setResizeHandlesVisible(data, false)
		if data.closePanel then
			data.closePanel()
		end
	end
	mobileEditorOpen = false
	activeRefreshResults = nil
	for _, data in mobileButtons do
		if data.button and data.button.Parent then
			data.button.Visible = not clickgui.Visible
		end
	end
end

local function openMobileEditor()
	if mobileEditorOpen then return end
	mobileEditorOpen = true
	clickgui.Visible = false
	for _, data in mobileButtons do
		if data.button and data.button.Parent then
			data.button.Visible = true
		end
	end
	mobileEditorBG = Instance.new('TextButton')
	mobileEditorBG.Name = 'MobileEditor'
	mobileEditorBG.Size = UDim2.fromScale(1, 1)
	mobileEditorBG.BackgroundColor3 = Color3.new(0, 0, 0)
	mobileEditorBG.BackgroundTransparency = 0.5
	mobileEditorBG.BorderSizePixel = 0
	mobileEditorBG.AutoButtonColor = false
	mobileEditorBG.Text = ''
	mobileEditorBG.ZIndex = 10
	mobileEditorBG.Parent = mainapi.gui
	local editorLabel = Instance.new('TextLabel')
	editorLabel.Size = UDim2.fromOffset(250, 20)
	editorLabel.Position = UDim2.fromOffset(14, 12)
	editorLabel.BackgroundTransparency = 1
	editorLabel.Text = 'MOBILE BIND EDITOR'
	editorLabel.TextColor3 = Color3.new(1, 1, 1)
	editorLabel.TextTransparency = 0.3
	editorLabel.TextSize = 12
	editorLabel.TextXAlignment = Enum.TextXAlignment.Left
	editorLabel.FontFace = uipallet.FontSemiBold
	editorLabel.ZIndex = 20
	editorLabel.Parent = mainapi.gui
	table.insert(mobileEditorLabels, editorLabel)
	local hintLabel = Instance.new('TextLabel')
	hintLabel.Size = UDim2.fromOffset(450, 16)
	hintLabel.Position = UDim2.fromOffset(14, 29)
	hintLabel.BackgroundTransparency = 1
	hintLabel.Text = 'Drag to move buttons  •  Corner handles to resize buttons •  Double tap for settings'
	hintLabel.TextColor3 = Color3.new(1, 1, 1)
	hintLabel.TextTransparency = 0.55
	hintLabel.TextSize = 10
	hintLabel.TextXAlignment = Enum.TextXAlignment.Left
	hintLabel.FontFace = uipallet.Font
	hintLabel.ZIndex = 20
	hintLabel.Parent = mainapi.gui
	table.insert(mobileEditorLabels, hintLabel)

	mobileCloseBtn = Instance.new('TextButton')
	mobileCloseBtn.Name = 'MobileEditorClose'
	mobileCloseBtn.Size = UDim2.fromOffset(44, 44)
	mobileCloseBtn.AnchorPoint = Vector2.new(1, 0)
	mobileCloseBtn.Position = UDim2.new(1, -12, 0, 12)
	mobileCloseBtn.BackgroundTransparency = 1
	mobileCloseBtn.BorderSizePixel = 0
	mobileCloseBtn.AutoButtonColor = false
	mobileCloseBtn.Text = ''
	mobileCloseBtn.ZIndex = 25
	mobileCloseBtn.Parent = mainapi.gui

	local xL1 = Instance.new('Frame')
	xL1.AnchorPoint = Vector2.new(0.5, 0.5)
	xL1.Size = UDim2.fromOffset(22, 3)
	xL1.Position = UDim2.fromScale(0.5, 0.5)
	xL1.BackgroundColor3 = Color3.new(1, 1, 1)
	xL1.BorderSizePixel = 0
	xL1.Rotation = 45
	xL1.ZIndex = 26
	xL1.Parent = mobileCloseBtn
	addCorner(xL1, UDim.new(1, 0))
	local xL2 = xL1:Clone()
	xL2.Rotation = -45
	xL2.Parent = mobileCloseBtn

	local function setXCol(c) xL1.BackgroundColor3 = c xL2.BackgroundColor3 = c end
	mobileCloseBtn.MouseEnter:Connect(function() setXCol(Color3.fromRGB(255, 80, 80)) end)
	mobileCloseBtn.MouseLeave:Connect(function() setXCol(Color3.new(1,1,1)) end)
	mobileCloseBtn.MouseButton1Click:Connect(function() closeMobileEditor() end)

	local PANEL_W = 224
	local MAX_RECENTS = 5
	local recentModules = {}
	local recentBtns = {}
	local searchPanelVisible = false
	local vapeCol = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)

	for _, name in persistentRecentNames do
		if mainapi.Modules[name] then
			table.insert(recentModules, mainapi.Modules[name])
		end
	end

	local plusBtn = Instance.new('TextButton')
	plusBtn.Name = 'MobileAddBtn'
	plusBtn.Size = UDim2.fromOffset(36, 36)
	plusBtn.AnchorPoint = Vector2.new(1, 0.5)
	plusBtn.Position = UDim2.new(1, -6, 0.5, -20)
	plusBtn.BackgroundTransparency = 1
	plusBtn.BorderSizePixel = 0
	plusBtn.AutoButtonColor = false
	plusBtn.Text = ''
	plusBtn.ZIndex = 25
	plusBtn.Parent = mainapi.gui
	table.insert(mobileEditorLabels, plusBtn)

	local plusH = Instance.new('Frame')
	plusH.AnchorPoint = Vector2.new(0.5, 0.5)
	plusH.Size = UDim2.fromOffset(14, 3)
	plusH.Position = UDim2.fromScale(0.5, 0.5)
	plusH.BackgroundColor3 = vapeCol
	plusH.BorderSizePixel = 0
	plusH.ZIndex = 26
	plusH.Parent = plusBtn
	addCorner(plusH, UDim.new(1, 0))

	local plusV = Instance.new('Frame')
	plusV.AnchorPoint = Vector2.new(0.5, 0.5)
	plusV.Size = UDim2.fromOffset(3, 14)
	plusV.Position = UDim2.fromScale(0.5, 0.5)
	plusV.BackgroundColor3 = vapeCol
	plusV.BorderSizePixel = 0
	plusV.ZIndex = 26
	plusV.Parent = plusBtn
	addCorner(plusV, UDim.new(1, 0))

	local function setPlusCol(c)
		plusH.BackgroundColor3 = c
		plusV.BackgroundColor3 = c
	end
	local function setPlusOpen(open)
		tween:Tween(plusH, uipallet.Tween, {Rotation = open and 45 or 0})
		tween:Tween(plusV, uipallet.Tween, {Rotation = open and 45 or 0})
	end

	local settingsBtn = Instance.new('TextButton')
	settingsBtn.Name = 'MobileSettingsBtn'
	settingsBtn.Size = UDim2.fromOffset(36, 36)
	settingsBtn.AnchorPoint = Vector2.new(1, 0.5)
	settingsBtn.Position = UDim2.new(1, -6, 0.5, 20)
	settingsBtn.BackgroundTransparency = 1
	settingsBtn.BorderSizePixel = 0
	settingsBtn.AutoButtonColor = false
	settingsBtn.Text = ''
	settingsBtn.ZIndex = 25
	settingsBtn.Parent = mainapi.gui
	table.insert(mobileEditorLabels, settingsBtn)

	local gearImg = Instance.new('ImageLabel')
	gearImg.AnchorPoint = Vector2.new(0.5, 0.5)
	gearImg.Size = UDim2.fromOffset(20, 20)
	gearImg.Position = UDim2.fromScale(0.5, 0.5)
	gearImg.BackgroundTransparency = 1
	gearImg.Image = getcustomasset('aerov4/assets/new/guisettings.png')
	gearImg.ImageColor3 = vapeCol
	gearImg.ZIndex = 26
	gearImg.Parent = settingsBtn

	local function setGearCol(c)
		gearImg.ImageColor3 = c
	end

	local settingsPanelVisible = false
	local SETTINGS_PANEL_W = 200
	local SETTINGS_PANEL_H = 200
	local settingsPanel = Instance.new('Frame')
	settingsPanel.Name = 'MobileEditorSettingsPanel'
	settingsPanel.Size = UDim2.fromOffset(SETTINGS_PANEL_W, SETTINGS_PANEL_H)
	settingsPanel.AnchorPoint = Vector2.new(1, 0.5)
	settingsPanel.Position = UDim2.new(1, SETTINGS_PANEL_W, 0.5, 20)
	settingsPanel.BackgroundColor3 = uipallet.Main
	settingsPanel.BackgroundTransparency = 0
	settingsPanel.BorderSizePixel = 0
	settingsPanel.ZIndex = 19
	settingsPanel.ClipsDescendants = true
	settingsPanel.Parent = mainapi.gui
	addCorner(settingsPanel, UDim.new(0, 8))
	addBlur(settingsPanel)
	local settingsPanelStroke = Instance.new('UIStroke')
	settingsPanelStroke.Color = color.Light(uipallet.Main, 0.10)
	settingsPanelStroke.Thickness = 1
	settingsPanelStroke.Parent = settingsPanel
	table.insert(mobileEditorLabels, settingsPanel)

	local settingsHeaderLabel = Instance.new('TextLabel')
	settingsHeaderLabel.Size = UDim2.new(1, -10, 0, 22)
	settingsHeaderLabel.Position = UDim2.fromOffset(10, 8)
	settingsHeaderLabel.BackgroundTransparency = 1
	settingsHeaderLabel.Text = 'BUTTON SETTINGS'
	settingsHeaderLabel.TextColor3 = vapeCol
	settingsHeaderLabel.TextSize = 12
	settingsHeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
	settingsHeaderLabel.FontFace = uipallet.FontSemiBold
	settingsHeaderLabel.ZIndex = 21
	settingsHeaderLabel.Parent = settingsPanel

	local settingsDiv = Instance.new('Frame')
	settingsDiv.Size = UDim2.new(1, -16, 0, 1)
	settingsDiv.Position = UDim2.fromOffset(8, 32)
	settingsDiv.BackgroundColor3 = color.Light(uipallet.Main, 0.10)
	settingsDiv.BorderSizePixel = 0
	settingsDiv.ZIndex = 21
	settingsDiv.Parent = settingsPanel

	local opacityLabel = Instance.new('TextLabel')
	opacityLabel.Size = UDim2.new(1, -16, 0, 18)
	opacityLabel.Position = UDim2.fromOffset(10, 40)
	opacityLabel.BackgroundTransparency = 1
	opacityLabel.Text = 'Opacity  ' .. math.floor((1 - mobileButtonTransparency) * 100) .. '%'
	opacityLabel.TextColor3 = uipallet.Text
	opacityLabel.TextSize = 12
	opacityLabel.TextXAlignment = Enum.TextXAlignment.Left
	opacityLabel.FontFace = uipallet.FontSemiBold
	opacityLabel.ZIndex = 21
	opacityLabel.Parent = settingsPanel

	local sliderTrack = Instance.new('Frame')
	sliderTrack.Size = UDim2.new(1, -16, 0, 6)
	sliderTrack.Position = UDim2.fromOffset(8, 62)
	sliderTrack.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	sliderTrack.BorderSizePixel = 0
	sliderTrack.ZIndex = 21
	sliderTrack.Parent = settingsPanel
	addCorner(sliderTrack, UDim.new(1, 0))

	local sliderFill = Instance.new('Frame')
	sliderFill.Size = UDim2.new(1 - mobileButtonTransparency, 0, 1, 0)
	sliderFill.BackgroundColor3 = vapeCol
	sliderFill.BorderSizePixel = 0
	sliderFill.ZIndex = 22
	sliderFill.Parent = sliderTrack
	addCorner(sliderFill, UDim.new(1, 0))

	local sliderKnob = Instance.new('Frame')
	sliderKnob.Size = UDim2.fromOffset(14, 14)
	sliderKnob.AnchorPoint = Vector2.new(0.5, 0.5)
	sliderKnob.Position = UDim2.new(1 - mobileButtonTransparency, 0, 0.5, 0)
	sliderKnob.BackgroundColor3 = Color3.new(1, 1, 1)
	sliderKnob.BorderSizePixel = 0
	sliderKnob.ZIndex = 23
	sliderKnob.Parent = sliderTrack
	addCorner(sliderKnob, UDim.new(1, 0))

	local sliderDragging = false
	local function updateSlider(inputX)
		local trackPos = sliderTrack.AbsolutePosition.X
		local trackSize = sliderTrack.AbsoluteSize.X
		local ratio = math.clamp((inputX - trackPos) / trackSize, 0, 1)
		mobileButtonTransparency = 1 - ratio
		sliderFill.Size = UDim2.new(ratio, 0, 1, 0)
		sliderKnob.Position = UDim2.new(ratio, 0, 0.5, 0)
		opacityLabel.Text = 'Opacity  ' .. math.floor(ratio * 100) .. '%'
		for _, d in mobileButtons do
			if d.button and d.button.Parent then
				updateMobileButtonColor(d.button, d.module.Enabled)
			end
		end
	end

	sliderTrack.InputBegan:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = true
			updateSlider(inp.Position.X)
		end
	end)
	sliderTrack.InputEnded:Connect(function(inp)
		if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
			sliderDragging = false
		end
	end)
	inputService.InputChanged:Connect(function(inp)
		if not sliderDragging then return end
		if not sliderTrack.Parent then sliderDragging = false return end
		if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
			updateSlider(inp.Position.X)
		end
	end)

	local bgColorLabel = Instance.new('TextLabel')
	bgColorLabel.Size = UDim2.new(1, -16, 0, 16)
	bgColorLabel.Position = UDim2.fromOffset(10, 82)
	bgColorLabel.BackgroundTransparency = 1
	bgColorLabel.Text = 'Background'
	bgColorLabel.TextColor3 = color.Dark(uipallet.Text, 0.25)
	bgColorLabel.TextSize = 11
	bgColorLabel.TextXAlignment = Enum.TextXAlignment.Left
	bgColorLabel.FontFace = uipallet.FontSemiBold
	bgColorLabel.ZIndex = 21
	bgColorLabel.Parent = settingsPanel

	local activeColorLabel = Instance.new('TextLabel')
	activeColorLabel.Size = UDim2.new(1, -16, 0, 16)
	activeColorLabel.Position = UDim2.fromOffset(10, 140)
	activeColorLabel.BackgroundTransparency = 1
	activeColorLabel.Text = 'Active'
	activeColorLabel.TextColor3 = color.Dark(uipallet.Text, 0.25)
	activeColorLabel.TextSize = 11
	activeColorLabel.TextXAlignment = Enum.TextXAlignment.Left
	activeColorLabel.FontFace = uipallet.FontSemiBold
	activeColorLabel.ZIndex = 21
	activeColorLabel.Parent = settingsPanel

	local BG_SWATCHES = {
		{col = nil,                         label = 'Def'},
		{col = Color3.new(0, 0, 0),         label = ''},
		{col = Color3.fromRGB(28, 28, 36),  label = ''},
		{col = Color3.fromRGB(20, 38, 20),  label = ''},
		{col = Color3.fromRGB(38, 18, 18),  label = ''},
		{col = Color3.fromRGB(18, 18, 48),  label = ''},
	}
	local ACT_SWATCHES = {
		{col = nil,                          label = 'Def'},
		{col = Color3.fromRGB(255, 80, 80),  label = ''},
		{col = Color3.fromRGB(80, 220, 80),  label = ''},
		{col = Color3.fromRGB(80, 140, 255), label = ''},
		{col = Color3.fromRGB(255, 200, 60), label = ''},
		{col = Color3.fromRGB(220, 80, 220), label = ''},
	}

	local function makeSwatches(list, yPos, getCurrent, setCurrent)
		local sw_size = 22
		local sw_gap = 4
		local swatchEntries = {}

		local function colorsMatch(a, b)
			if a == nil and b == nil then return true end
			if a == nil or b == nil then return false end
			return math.abs(a.R - b.R) < 0.002 and math.abs(a.G - b.G) < 0.002 and math.abs(a.B - b.B) < 0.002
		end

		local function refreshBorders()
			local cur = getCurrent()
			for _, entry in swatchEntries do
				local selected = colorsMatch(cur, entry.col)
				entry.border.BackgroundColor3 = selected and Color3.new(1, 1, 1) or color.Light(uipallet.Main, 0.12)
			end
		end

		local borderPad = 3
		for idx, sw in list do
			local bgCol = sw.col or color.Dark(uipallet.Main, -0.08)
			local totalSize = sw_size + borderPad * 2
			local border = Instance.new('Frame')
			border.Size = UDim2.fromOffset(totalSize, totalSize)
			border.Position = UDim2.fromOffset(8 + (idx - 1) * (sw_size + sw_gap + borderPad * 2), yPos - borderPad)
			border.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
			border.BorderSizePixel = 0
			border.ZIndex = 22
			border.Parent = settingsPanel
			addCorner(border, UDim.new(0, 6))
			local s = Instance.new('TextButton')
			s.Size = UDim2.fromOffset(sw_size, sw_size)
			s.Position = UDim2.fromOffset(borderPad, borderPad)
			s.BackgroundColor3 = bgCol
			s.BorderSizePixel = 0
			s.AutoButtonColor = false
			s.Text = sw.label or ''
			s.TextColor3 = Color3.fromRGB(160, 160, 160)
			s.TextSize = 9
			s.FontFace = uipallet.FontSemiBold
			s.ZIndex = 23
			s.Parent = border
			addCorner(s, UDim.new(0, 4))
			table.insert(swatchEntries, {border = border, col = sw.col, btn = s})
			s.MouseButton1Click:Connect(function()
				setCurrent(sw.col)
				refreshBorders()
				for _, d in mobileButtons do
					if d.button and d.button.Parent then
						updateMobileButtonColor(d.button, d.module.Enabled)
					end
				end
			end)
			s.MouseEnter:Connect(function()
				if not colorsMatch(getCurrent(), sw.col) then
					tween:Tween(s, uipallet.Tween, {BackgroundColor3 = color.Light(bgCol, 0.1)})
				end
			end)
			s.MouseLeave:Connect(function()
				if not colorsMatch(getCurrent(), sw.col) then
					tween:Tween(s, uipallet.Tween, {BackgroundColor3 = bgCol})
				end
			end)
		end
		refreshBorders()
	end

	makeSwatches(BG_SWATCHES, 100,
		function() return mobileButtonBgColor end,
		function(c) mobileButtonBgColor = c end
	)
	makeSwatches(ACT_SWATCHES, 158,
		function() return mobileButtonActiveColor end,
		function(c) mobileButtonActiveColor = c end
	)

	local function hideSettingsPanel()
		if not settingsPanelVisible then return end
		settingsPanelVisible = false
		setGearCol(vapeCol)
		tween:Tween(settingsPanel, TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, SETTINGS_PANEL_W, 0.5, 20)
		})
	end
	local function showSettingsPanel()
		if settingsPanelVisible then return end
		settingsPanelVisible = true
		setGearCol(Color3.new(1, 1, 1))
		tween:Tween(settingsPanel, TweenInfo.new(0.32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -54, 0.5, 20)
		})
	end

	local function setArrowCol(c) setPlusCol(c) end
	local function setArrowOpen(open) setPlusOpen(open) end

	plusBtn.MouseEnter:Connect(function() setPlusCol(Color3.new(1, 1, 1)) end)
	plusBtn.MouseLeave:Connect(function() setPlusCol(searchPanelVisible and Color3.new(1, 1, 1) or vapeCol) end)
	settingsBtn.MouseEnter:Connect(function() setGearCol(Color3.new(1, 1, 1)) end)
	settingsBtn.MouseLeave:Connect(function() setGearCol(settingsPanelVisible and Color3.new(1, 1, 1) or vapeCol) end)
	local PANEL_H = 320
	local searchPanel = Instance.new('Frame')
	searchPanel.Name = 'MobileEditorSearchPanel'
	searchPanel.Size = UDim2.fromOffset(PANEL_W, PANEL_H)
	searchPanel.AnchorPoint = Vector2.new(1, 0.5)
	searchPanel.Position = UDim2.new(1, PANEL_W, 0.5, 0)
	searchPanel.BackgroundColor3 = uipallet.Main
	searchPanel.BackgroundTransparency = 0
	searchPanel.BorderSizePixel = 0
	searchPanel.ZIndex = 19
	searchPanel.ClipsDescendants = true
	searchPanel.Parent = mainapi.gui
	addCorner(searchPanel, UDim.new(0, 8))
	addBlur(searchPanel)
	local panelStroke = Instance.new('UIStroke')
	panelStroke.Color = color.Light(uipallet.Main, 0.10)
	panelStroke.Thickness = 1
	panelStroke.Parent = searchPanel
	table.insert(mobileEditorLabels, searchPanel)

	local function updateSidebarSize() end 

	local function rebuildRecents()
		table.clear(recentBtns)
	end

	local function addToRecents(mod)
		for i, m in recentModules do
			if m == mod then table.remove(recentModules, i) break end
		end
		table.insert(recentModules, 1, mod)
		if #recentModules > MAX_RECENTS then table.remove(recentModules) end
		table.clear(persistentRecentNames)
		for _, m in recentModules do
			table.insert(persistentRecentNames, m.Name)
		end
		rebuildRecents()
	end

	local function hideSearchPanel()
		if not searchPanelVisible then return end
		searchPanelVisible = false
		setArrowOpen(false)
		setArrowCol(vapeCol)
		tween:Tween(searchPanel, TweenInfo.new(0.28, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
			Position = UDim2.new(1, PANEL_W, 0.5, 0)
		})
	end

	local function showSearchPanel()
		if searchPanelVisible then return end
		searchPanelVisible = true
		setArrowOpen(true)
		setArrowCol(Color3.new(1,1,1))
		tween:Tween(searchPanel, TweenInfo.new(0.32, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
			Position = UDim2.new(1, -54, 0.5, 0)
		})
	end

	plusBtn.MouseButton1Click:Connect(function()
		if settingsPanelVisible then hideSettingsPanel() end
		if searchPanelVisible then hideSearchPanel() else showSearchPanel() end
	end)
	settingsBtn.MouseButton1Click:Connect(function()
		if searchPanelVisible then hideSearchPanel() end
		if settingsPanelVisible then hideSettingsPanel() else showSettingsPanel() end
	end)

	local searchLabel = Instance.new('TextLabel')
	searchLabel.Size = UDim2.new(1, -10, 0, 22)
	searchLabel.Position = UDim2.fromOffset(10, 8)
	searchLabel.BackgroundTransparency = 1
	searchLabel.Text = 'ADD FEATURE'
	searchLabel.TextColor3 = vapeCol
	searchLabel.TextTransparency = 0
	searchLabel.TextSize = 12
	searchLabel.TextXAlignment = Enum.TextXAlignment.Left
	searchLabel.FontFace = uipallet.FontSemiBold
	searchLabel.ZIndex = 21
	searchLabel.Parent = searchPanel
	local headerDiv = Instance.new('Frame')
	headerDiv.Size = UDim2.new(1, -16, 0, 1)
	headerDiv.Position = UDim2.fromOffset(8, 32)
	headerDiv.BackgroundColor3 = color.Light(uipallet.Main, 0.10)
	headerDiv.BorderSizePixel = 0
	headerDiv.ZIndex = 21
	headerDiv.Parent = searchPanel

	local searchBox = Instance.new('TextBox')
	searchBox.Size = UDim2.new(1, -16, 0, 34)
	searchBox.Position = UDim2.fromOffset(8, 40)
	searchBox.BackgroundColor3 = color.Light(uipallet.Main, 0.09)
	searchBox.BackgroundTransparency = 0
	searchBox.BorderSizePixel = 0
	searchBox.Text = ''
	searchBox.PlaceholderText = 'Search features...'
	searchBox.PlaceholderColor3 = color.Dark(uipallet.Text, 0.38)
	searchBox.TextColor3 = uipallet.Text
	searchBox.TextSize = 14
	searchBox.FontFace = uipallet.Font
	searchBox.ClearTextOnFocus = false
	searchBox.ZIndex = 21
	searchBox.Parent = searchPanel
	addCorner(searchBox, UDim.new(0, 6))
	local searchBoxStroke = Instance.new('UIStroke')
	searchBoxStroke.Color = color.Light(uipallet.Main, 0.14)
	searchBoxStroke.Thickness = 1
	searchBoxStroke.Parent = searchBox
	local sbIcon = Instance.new('ImageLabel')
	sbIcon.Size = UDim2.fromOffset(14, 14)
	sbIcon.Position = UDim2.new(1, -22, 0.5, -7)
	sbIcon.BackgroundTransparency = 1
	sbIcon.Image = getcustomasset('aerov4/assets/new/search.png')
	sbIcon.ImageColor3 = color.Dark(uipallet.Text, 0.35)
	sbIcon.ZIndex = 22
	sbIcon.Parent = searchPanel

	local searchResultsFrame = Instance.new('ScrollingFrame')
	searchResultsFrame.Size = UDim2.new(1, -16, 0, PANEL_H - 40 - 34 - 16)
	searchResultsFrame.Position = UDim2.fromOffset(8, 82)
	searchResultsFrame.BackgroundTransparency = 1
	searchResultsFrame.BorderSizePixel = 0
	searchResultsFrame.ScrollBarThickness = 3
	searchResultsFrame.ScrollBarImageTransparency = 0.5
	searchResultsFrame.CanvasSize = UDim2.new()
	searchResultsFrame.ZIndex = 21
	searchResultsFrame.Parent = searchPanel

	local resultsLayout = Instance.new('UIListLayout')
	resultsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	resultsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	resultsLayout.Padding = UDim.new(0, 4)
	resultsLayout.Parent = searchResultsFrame

	local function refreshResults(query)
		for _, child in searchResultsFrame:GetChildren() do
			if child:IsA('TextButton') then child:Destroy() end
		end
		local lower = (query or ''):lower()
		local count = 0
		for name, mod in mainapi.Modules do
			if lower == '' or name:lower():find(lower, 1, true) then
				local alreadyAdded = false
				for _, d in mobileButtons do
					if d.module == mod then alreadyAdded = true break end
				end
				local rb = Instance.new('TextButton')
				rb.Size = UDim2.new(1, 0, 0, 36)
				rb.BackgroundColor3 = alreadyAdded and color.Light(uipallet.Main, 0.06) or color.Light(uipallet.Main, 0.03)
				rb.BorderSizePixel = 0
				rb.AutoButtonColor = false
				rb.Text = ''
				rb.ZIndex = 22
				rb.LayoutOrder = count
				rb.Parent = searchResultsFrame
				addCorner(rb, UDim.new(0, 6))
				local rLabel = Instance.new('TextLabel')
				rLabel.Size = UDim2.new(1, alreadyAdded and -28 or -10, 1, 0)
				rLabel.Position = UDim2.fromOffset(10, 0)
				rLabel.BackgroundTransparency = 1
				rLabel.Text = name
				rLabel.TextColor3 = alreadyAdded and vapeCol or uipallet.Text
				rLabel.TextSize = 14
				rLabel.FontFace = alreadyAdded and uipallet.FontSemiBold or uipallet.Font
				rLabel.TextXAlignment = Enum.TextXAlignment.Left
				rLabel.ZIndex = 23
				rLabel.Parent = rb
				if alreadyAdded then
					local checkLabel = Instance.new('TextLabel')
					checkLabel.Size = UDim2.fromOffset(20, 36)
					checkLabel.Position = UDim2.new(1, -24, 0, 0)
					checkLabel.BackgroundTransparency = 1
					checkLabel.Text = '\u{2713}'
					checkLabel.TextColor3 = vapeCol
					checkLabel.TextSize = 14
					checkLabel.FontFace = uipallet.FontSemiBold
					checkLabel.ZIndex = 23
					checkLabel.Parent = rb
				end
				if not alreadyAdded then
					rb.MouseButton1Click:Connect(function()
						addMobileButton(mod)
						addToRecents(mod)
						hideSearchPanel()
						refreshResults(searchBox.Text)
					end)
					rb.MouseEnter:Connect(function()
						tween:Tween(rb, uipallet.Tween, {BackgroundColor3 = color.Light(uipallet.Main, 0.08)})
						rLabel.TextColor3 = color.Light(uipallet.Text, 0.1)
					end)
					rb.MouseLeave:Connect(function()
						tween:Tween(rb, uipallet.Tween, {BackgroundColor3 = color.Light(uipallet.Main, 0.03)})
						rLabel.TextColor3 = uipallet.Text
					end)
				end
				count += 1
			end
		end
		task.defer(function()
			searchResultsFrame.CanvasSize = UDim2.fromOffset(0, resultsLayout.AbsoluteContentSize.Y)
		end)
	end

	activeRefreshResults = refreshResults
	refreshResults('')
	rebuildRecents() 
	searchBox:GetPropertyChangedSignal('Text'):Connect(function()
		refreshResults(searchBox.Text)
	end)
	resultsLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		searchResultsFrame.CanvasSize = UDim2.fromOffset(0, resultsLayout.AbsoluteContentSize.Y)
	end)

	for _, data in mobileButtons do
		data.editorMode = true
		setResizeHandlesVisible(data, false)
		updateMobileButtonColor(data.button, data.module.Enabled)
	end
end

addMobileButton = function(moduleapi, savedX, savedY, savedW, savedH, silent)
	for _, data in mobileButtons do
		if data.module == moduleapi then return end
	end

	local vp = workspace.CurrentCamera.ViewportSize
	local initX = savedX or (vp.X / 2 - 35)
	local initY = savedY or (vp.Y / 2 - 35)
	local initW = savedW or 70
	local initH = savedH or 70

	local btn = Instance.new('TextButton')
	btn.Size = UDim2.fromOffset(initW, initH)
	btn.Position = UDim2.fromOffset(initX, initY)
	btn.BackgroundTransparency = 0
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Text = formatModuleName(moduleapi.Name)
	btn.TextScaled = true
	btn.FontFace = uipallet.FontSemiBold
	btn.ZIndex = 12
	btn.Parent = mainapi.gui
	addCorner(btn, UDim.new(1, 0))
	updateMobileButtonColor(btn, moduleapi.Enabled)

	local constraint = Instance.new('UITextSizeConstraint')
	constraint.MaxTextSize = 15
	constraint.MinTextSize = 7
	constraint.Parent = btn
	local resizeFrame = Instance.new('Frame')
	resizeFrame.Name = 'ResizeFrame'
	resizeFrame.BackgroundTransparency = 1
	resizeFrame.BorderSizePixel = 0
	resizeFrame.ZIndex = 14
	resizeFrame.Visible = false
	resizeFrame.Size = UDim2.new(1, 16, 1, 16)
	resizeFrame.Position = UDim2.fromOffset(-8, -8)
	resizeFrame.Parent = btn

	local rfStroke = Instance.new('UIStroke')
	rfStroke.Color = Color3.new(1, 1, 1)
	rfStroke.Thickness = 1.5
	rfStroke.Transparency = 0.2
	rfStroke.Parent = resizeFrame

	local handles = {}
	for _, ca in {{0,0},{1,0},{0,1},{1,1}} do
		local h = Instance.new('Frame')
		h.Size = UDim2.fromOffset(12, 12)
		h.AnchorPoint = Vector2.new(ca[1], ca[2])
		h.Position = UDim2.new(ca[1], 0, ca[2], 0)
		h.BackgroundColor3 = Color3.new(1, 1, 1)
		h.BorderSizePixel = 0
		h.ZIndex = 16
		h.Parent = resizeFrame
		addCorner(h, UDim.new(0, 2))
		table.insert(handles, {frame = h, ax = ca[1], ay = ca[2]})
	end

	local panel = Instance.new('Frame')
	panel.Name = 'MobileBindPanel'
	panel.BackgroundColor3 = uipallet.Main
	panel.BorderSizePixel = 0
	panel.Size = UDim2.fromOffset(0, 34)
	panel.AnchorPoint = Vector2.new(0, 0.5)
	panel.ClipsDescendants = true
	panel.ZIndex = 20
	panel.Visible = false
	panel.Parent = mainapi.gui
	addCorner(panel, UDim.new(0, 6))
	addBlur(panel)
	local connector = Instance.new('Frame')
	connector.Name = 'MobileBindConnector'
	connector.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	connector.BorderSizePixel = 0
	connector.Size = UDim2.fromOffset(0, 2)
	connector.ZIndex = 19
	connector.Visible = false
	connector.Parent = mainapi.gui
	local rowHolder = Instance.new('Frame')
	rowHolder.BackgroundTransparency = 1
	rowHolder.Size = UDim2.new(1, -12, 1, 0)
	rowHolder.Position = UDim2.fromOffset(8, 0)
	rowHolder.ZIndex = 21
	rowHolder.Parent = panel
	local rowList = Instance.new('UIListLayout')
	rowList.FillDirection = Enum.FillDirection.Horizontal
	rowList.VerticalAlignment = Enum.VerticalAlignment.Center
	rowList.HorizontalAlignment = Enum.HorizontalAlignment.Left
	rowList.Padding = UDim.new(0, 0)
	rowList.SortOrder = Enum.SortOrder.LayoutOrder
	rowList.Parent = rowHolder
	local nameLabel = Instance.new('TextLabel')
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = moduleapi.Name
	nameLabel.TextColor3 = uipallet.Text
	nameLabel.TextSize = 12
	nameLabel.FontFace = uipallet.FontSemiBold
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.ZIndex = 21
	nameLabel.LayoutOrder = 1
	nameLabel.Size = UDim2.fromOffset(0, 34) 
	nameLabel.Parent = rowHolder
	local div1 = Instance.new('Frame')
	div1.Size = UDim2.fromOffset(1, 20)
	div1.BackgroundColor3 = color.Light(uipallet.Main, 0.12)
	div1.BorderSizePixel = 0
	div1.ZIndex = 21
	div1.LayoutOrder = 2
	div1.Parent = rowHolder
	local modeBtn = Instance.new('TextButton')
	modeBtn.BackgroundTransparency = 1
	modeBtn.AutoButtonColor = false
	modeBtn.Text = moduleapi.KeybindMode
	modeBtn.TextColor3 = color.Dark(uipallet.Text, 0.16)
	modeBtn.TextSize = 11
	modeBtn.FontFace = uipallet.Font
	modeBtn.ZIndex = 21
	modeBtn.LayoutOrder = 3
	modeBtn.Size = UDim2.fromOffset(50, 34)
	modeBtn.Parent = rowHolder
	local div2 = div1:Clone()
	div2.LayoutOrder = 4
	div2.Parent = rowHolder
	local removeBtn = Instance.new('TextButton')
	removeBtn.BackgroundTransparency = 1
	removeBtn.AutoButtonColor = false
	removeBtn.Text = 'Remove'
	removeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
	removeBtn.TextSize = 11
	removeBtn.FontFace = uipallet.Font
	removeBtn.ZIndex = 21
	removeBtn.LayoutOrder = 5
	removeBtn.Size = UDim2.fromOffset(54, 34)
	removeBtn.Parent = rowHolder

	task.defer(function()
		local tw = math.ceil(getfontsize(moduleapi.Name, 12, uipallet.FontSemiBold).X) + 4
		nameLabel.Size = UDim2.fromOffset(tw, 34)
	end)

	local panelFullW = 54 + 1 + 50 + 1 + 8 
	local panelOpen = false

	local function repositionPanel()
		local bx = btn.AbsolutePosition.X
		local by = btn.AbsolutePosition.Y
		local bw = btn.AbsoluteSize.X
		local bh = btn.AbsoluteSize.Y
		local gap = 8

		local nw = nameLabel.AbsoluteSize.X > 0 and nameLabel.AbsoluteSize.X or (math.ceil(getfontsize(moduleapi.Name, 12, uipallet.FontSemiBold).X) + 4)
		panelFullW = nw + 1 + 50 + 1 + 54 + 16
		nameLabel.Size = UDim2.fromOffset(nw, 34)

		panel.Position = UDim2.fromOffset(bx + bw + gap, by + bh/2 - 17)
		panel.Size = UDim2.fromOffset(panelFullW, 34)

		connector.Size = UDim2.fromOffset(gap, 2)
		connector.Position = UDim2.fromOffset(bx + bw, by + bh/2 - 1)
	end

	local function openPanel()
		if panelOpen then return end
		panelOpen = true
		repositionPanel()
		panel.Size = UDim2.fromOffset(0, 34)
		panel.Visible = true
		connector.Visible = true
		tween:Tween(panel, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.fromOffset(panelFullW, 34)
		})
	end

	local function closePanel()
		if not panelOpen then return end
		panelOpen = false
		tween:Tween(panel, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.fromOffset(0, 34)
		})
		task.delay(0.15, function()
			if not panelOpen then
				panel.Visible = false
				connector.Visible = false
			end
		end)
	end

	local data = {
		module = moduleapi,
		button = btn,
		resizeFrame = resizeFrame,
		settingsPanel = panel,
		settingsOpen = false,
		editorMode = silent ~= true,
		closePanel = closePanel,
	}
	table.insert(mobileButtons, data)

	if mobileEditorOpen then
		for _, d in mobileButtons do
			d.editorMode = true
		end
	end

	modeBtn.MouseButton1Click:Connect(function()
		moduleapi.KeybindMode = (moduleapi.KeybindMode == 'Toggle') and 'Hold' or 'Toggle'
		moduleapi.HoldCount = 0
		modeBtn.Text = moduleapi.KeybindMode
	end)
	modeBtn.MouseEnter:Connect(function()
		modeBtn.TextColor3 = uipallet.Text
	end)
	modeBtn.MouseLeave:Connect(function()
		modeBtn.TextColor3 = color.Dark(uipallet.Text, 0.16)
	end)

	removeBtn.MouseButton1Click:Connect(function()
		closePanel()
		task.delay(0.15, function()
			for i, d in mobileButtons do
				if d.module == moduleapi then
					if d.resizeConn then d.resizeConn:Disconnect() end
					if d.resizeEndConn then d.resizeEndConn:Disconnect() end
					table.remove(mobileButtons, i)
					break
				end
			end
			panel:Destroy()
			connector:Destroy()
			btn:Destroy()
			if activeRefreshResults then
				activeRefreshResults('')
			end
		end)
	end)
	removeBtn.MouseEnter:Connect(function()
		removeBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
	end)
	removeBtn.MouseLeave:Connect(function()
		removeBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
	end)

	local resizing = false
	local resizeStartMouse, resizeStartSize, resizeStartPos = nil, nil, nil
	local resizeAnchorX, resizeAnchorY = 0, 0

	for _, h in handles do
		h.frame.InputBegan:Connect(function(input)
			if not data.editorMode then return end
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = true
				resizeStartMouse = Vector2.new(input.Position.X, input.Position.Y)
				resizeStartSize = Vector2.new(btn.AbsoluteSize.X, btn.AbsoluteSize.Y)
				resizeStartPos = Vector2.new(btn.AbsolutePosition.X, btn.AbsolutePosition.Y)
				resizeAnchorX = h.ax
				resizeAnchorY = h.ay
			end
		end)
	end

	local resizeConn = inputService.InputChanged:Connect(function(input)
		if not resizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
		local delta = Vector2.new(input.Position.X, input.Position.Y) - resizeStartMouse
		local dw = resizeAnchorX == 0 and -delta.X or delta.X
		local dh = resizeAnchorY == 0 and -delta.Y or delta.Y
		local newW = math.clamp(resizeStartSize.X + dw, 44, 220)
		local newH = math.clamp(resizeStartSize.Y + dh, 44, 220)
		local newX = resizeStartPos.X + (resizeAnchorX == 0 and (resizeStartSize.X - newW) or 0)
		local newY = resizeStartPos.Y + (resizeAnchorY == 0 and (resizeStartSize.Y - newH) or 0)
		btn.Size = UDim2.fromOffset(newW, newH)
		btn.Position = UDim2.fromOffset(newX, newY)
		if panelOpen then repositionPanel() end
	end)

	local resizeEndConn = inputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			resizing = false
		end
	end)

	local dragging = false
	local dragStart, startPos = nil, nil
	local dragMoveConn, dragEndConn = nil, nil

	btn.InputBegan:Connect(function(input)
		if not data.editorMode then return end
		if resizing then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = Vector2.new(input.Position.X, input.Position.Y)
			startPos = btn.Position
			if dragMoveConn then dragMoveConn:Disconnect() end
			if dragEndConn then dragEndConn:Disconnect() end
			dragMoveConn = inputService.InputChanged:Connect(function(inp)
				if not dragging or not data.editorMode or resizing then return end
				if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
					local delta = Vector2.new(inp.Position.X, inp.Position.Y) - dragStart
					btn.Position = UDim2.fromOffset(startPos.X.Offset + delta.X, startPos.Y.Offset + delta.Y)
					if panelOpen then repositionPanel() end
				end
			end)
			dragEndConn = inputService.InputEnded:Connect(function(inp)
				if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
					dragging = false
					if dragMoveConn then dragMoveConn:Disconnect(); dragMoveConn = nil end
					if dragEndConn then dragEndConn:Disconnect(); dragEndConn = nil end
				end
			end)
		end
	end)

	local lastClickTime = 0
	local holdActive = false

	btn.MouseButton1Click:Connect(function()
		if resizing then return end
		local now = tick()

		if data.editorMode then
			if now - lastClickTime < 0.4 then
				if panelOpen then
					closePanel()
					resizeFrame.Visible = false
				else
					for _, d in mobileButtons do
						if d ~= data and d.settingsPanel and d.settingsPanel.Visible then
							tween:Tween(d.settingsPanel, TweenInfo.new(0.14, Enum.EasingStyle.Quad), {Size = UDim2.fromOffset(0, 34)})
							task.delay(0.15, function() if d.settingsPanel then d.settingsPanel.Visible = false end end)
						end
					end
					openPanel()
					resizeFrame.Visible = true
				end
			end
			lastClickTime = now
		else
			if moduleapi.KeybindMode == 'Toggle' then
				moduleapi:Toggle()
				updateMobileButtonColor(btn, moduleapi.Enabled, true)
			end
		end
	end)

	btn.InputBegan:Connect(function(input)
		if data.editorMode then return end
		if resizing then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if moduleapi.KeybindMode ~= 'Hold' then return end
		holdActive = true
		moduleapi:SetEnabled(true)
		updateMobileButtonColor(btn, true)
	end)

	btn.InputEnded:Connect(function(input)
		if data.editorMode then return end
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
		if moduleapi.KeybindMode ~= 'Hold' then return end
		if holdActive then
			holdActive = false
			moduleapi:SetEnabled(false)
			updateMobileButtonColor(btn, false)
		end
	end)

	mainapi:Clean(inputService.InputBegan:Connect(function(inp)
		if resizing then return end
		if not panelOpen then return end
		if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then return end
		local pos = inp.Position
		local function inBounds(obj)
			if not obj or not obj.Parent then return false end
			local a = obj.AbsolutePosition
			local s = obj.AbsoluteSize
			return pos.X >= a.X and pos.X <= a.X + s.X and pos.Y >= a.Y and pos.Y <= a.Y + s.Y
		end
		if not inBounds(btn) and not inBounds(panel) then
			closePanel()
			resizeFrame.Visible = false
		end
	end))

	data.resizeConn = resizeConn
	data.resizeEndConn = resizeEndConn
end

local function createMobileButton(moduleapi, position, savedW, savedH)
	local sx = position and position.X or nil
	local sy = position and position.Y or nil
	addMobileButton(moduleapi, sx, sy, savedW, savedH, true) 
end

local function downloadFile(path, func)
	if not isfile(path) then
		createDownloader(path)
		local suc, res = pcall(function()
			return game:HttpGet('https://raw.githubusercontent.com/amack7002-code/tapev4/'..readfile('aerov4/profiles/commit.txt')..'/'..select(1, path:gsub('aerov4/', '')), true)
		end)
		if not suc or res == '404: Not Found' then
			error(res)
		end
		if path:find('.lua') then
			res = '--This watermark is used to delete the file if its cached, remove it to make the file persist after vape updates.\n'..res
		end
		writefile(path, res)
	end
	return (func or readfile)(path)
end

local customAssets = {
	['aerov4/assets/new/guivape.png'] = true,
	['aerov4/assets/new/guiv4.png'] = true,
	['aerov4/assets/new/textvape.png'] = true,
	['aerov4/assets/new/textv4.png'] = true,
	['aerov4/assets/new/vape.png'] = true,
	['aerov4/assets/new/kiticon.png'] = true,
	['aerov4/assets/new/legiticon.png'] = true
}

local customassetcache = {}
getcustomasset = function(path)
	local cached = customassetcache[path]
	if cached then return cached end
	local result = ''
	if not inputService.TouchEnabled and assetfunction then
		if isfile(path) or customAssets[path] then
			local ok, res = pcall(downloadFile, path, assetfunction)
			if ok and res and res ~= '' then result = res end
		end
	end
	if result == '' then
		local id = getcustomassets[path]
		if id and id ~= '' then
			result = id
		elseif not inputService.TouchEnabled and assetfunction then
			local ok, res = pcall(downloadFile, path, assetfunction)
			if ok and res then result = res end
		end
	end
	if result ~= '' then customassetcache[path] = result end
	return result
end

local function getTableSize(tab)
	local ind = 0
	for _ in tab do ind += 1 end
	return ind
end

local function loopClean(tab)
	for i, v in tab do
		if type(v) == 'table' then
			loopClean(v)
		end
		tab[i] = nil
	end
end

local function loadJson(path)
	local suc, res = pcall(function()
		return httpService:JSONDecode(readfile(path))
	end)
	return suc and type(res) == 'table' and res or nil
end
local draggableids = {}

local function removeDraggable(gui)
    if remove then
        if draggableids[gui] then
            draggableids[gui]:Disconnect()
            draggableids[gui] = nil
        end
        return
    end

end

local function isDraggable(gui)
	if draggableids[gui] then
		return true
	end
	return false
end

local function makeDraggable(gui, window,rmv)
	rmv = rmv or false
	if rmv then
		removeDraggable(gui)
	end
	if draggableids[gui] then return end
	draggableids[gui] = gui.InputBegan:Connect(function(inputObj)
		if window and not window.Visible then return end
		if
			(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
			and (inputObj.Position.Y - gui.AbsolutePosition.Y < 40 or window)
		then
			local dragPosition = Vector2.new(
				gui.AbsolutePosition.X - inputObj.Position.X,
				gui.AbsolutePosition.Y - inputObj.Position.Y + guiService:GetGuiInset().Y
			) / scale.Scale

			local changed = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
					local position = input.Position
					if inputService:IsKeyDown(Enum.KeyCode.LeftShift) then
						dragPosition = (dragPosition // 3) * 3
						position = (position // 3) * 3
					end
					gui.Position = UDim2.fromOffset((position.X / scale.Scale) + dragPosition.X, (position.Y / scale.Scale) + dragPosition.Y)
				end
			end)

			local ended
			ended = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if changed then
						changed:Disconnect()
					end
					if ended then
						ended:Disconnect()
					end
				end
			end)
		end
	end)
end

getgenv().DraggableFunc = makeDraggable
getgenv().IsDragFunc = isDraggable

local function randomString()
	local array = {}
	for i = 1, math.random(10, 100) do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

local function removeTags(str)
	str = str:gsub('<br%s*/>', '\n')
	return str:gsub('<[^<>]->', '')
end

do
	local res = isfile('aerov4/profiles/color.txt') and loadJson('aerov4/profiles/color.txt')
	if res then
		uipallet.Main = res.Main and Color3.fromRGB(unpack(res.Main)) or uipallet.Main
		uipallet.Text = res.Text and Color3.fromRGB(unpack(res.Text)) or uipallet.Text
		uipallet.Font = res.Font and Font.new(
			res.Font:find('rbxasset') and res.Font
			or string.format('rbxasset://fonts/families/%s.json', res.Font)
		) or uipallet.Font
		uipallet.FontSemiBold = Font.new(uipallet.Font.Family, Enum.FontWeight.SemiBold)
	end
	fontsize.Font = uipallet.Font
end

do
	function color.Dark(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v + num or v - num, 0, 1))
	end

	function color.Light(col, num)
		local h, s, v = col:ToHSV()
		return Color3.fromHSV(h, s, math.clamp(select(3, uipallet.Main:ToHSV()) > 0.5 and v - num or v + num, 0, 1))
	end

	function mainapi:Color(h)
		local s = 0.75 + (0.15 * math.min(h / 0.03, 1))
		if h > 0.57 then
			s = 0.9 - (0.4 * math.min((h - 0.57) / 0.09, 1))
		end
		if h > 0.66 then
			s = 0.5 + (0.4 * math.min((h - 0.66) / 0.16, 1))
		end
		if h > 0.87 then
			s = 0.9 - (0.15 * math.min((h - 0.87) / 0.13, 1))
		end
		return h, s, 1
	end

	function mainapi:TextColor(h, s, v)
		if v >= 0.7 and (s < 0.6 or h > 0.04 and h < 0.56) then
			return Color3.new(0.19, 0.19, 0.19)
		end
		return Color3.new(1, 1, 1)
	end
end

do
	function tween:Tween(obj, tweeninfo, goal, tab)
		tab = tab or self.tweens
		if tab[obj] then
			tab[obj]:Cancel()
			tab[obj] = nil
		end

		if obj.Parent and obj.Visible then
			tab[obj] = tweenService:Create(obj, tweeninfo, goal)
			tab[obj].Completed:Once(function()
				if tab then
					tab[obj] = nil
					tab = nil
				end
			end)
			tab[obj]:Play()
		else
			for i, v in goal do
				obj[i] = v
			end
		end
	end

	function tween:Cancel(obj)
		if self.tweens[obj] then
			self.tweens[obj]:Cancel()
			self.tweens[obj] = nil
		end
	end
end

mainapi.Libraries = {
	color = color,
	getcustomasset = getcustomasset,
	getfontsize = getfontsize,
	tween = tween,
	uipallet = uipallet,
}

mainapi.ModuleTags = {
    KitESP = {"alchemist", "beekeeper", "bigman", "ghost_catcher", "metal_detector", "sheep_herder", "sorcerer", "star_collector", "black_market_trader", "miner", "trapper", "necromancer", "battery", "metal", "eldertree", "gompy", "deathadder", "wren"},
}

mainapi.TagDisplay = {
    KitESP = {
        alchemist = "AlchemistESP",
        beekeeper = "BeekeeperESP",
        bigman = "EldertreeESP",
        ghost_catcher = "GompyESP",
        metal_detector = "MetalESP",
        metal = "MetalESP",
        sheep_herder = "SheepHerderESP",
        sorcerer = "DeathAdderESP",
        deathadder = "DeathAdderESP",
        star_collector = "StarCollectorESP",
        black_market_trader = "WrenESP",
        wren = "WrenESP",
        miner = "MinerESP",
        trapper = "TrapperESP",
        necromancer = "NecromancerESP",
        battery = "BatteryESP",
        eldertree = "EldertreeESP",
        gompy = "GompyESP",
    },
}

mainapi.ModuleAliases = {
    Wizard = {"Zeno"},
    Killaura = {"ka"},
    ProjectileAimAssist = {"pa"},
    Spider_Queen = {"arachne"},
    Necromancer = {"crypt"},
    Midnight = {"nyx"},
    Sorcerer = {"death"},
    Davey = {"Pirate"},
    Battery = {"Cobalt"},
    Defender = {"Marcel"},
    Block_Kicker = {"terra"},
    Dragon_Slayer = {"Kaliyah"},
    Ice_Queen = {"Freiya"},
    Jailor = {"Warden"},
    Mimic = {"Milo"},
    Pinata = {"Lucia"},
    spirit_assassin = {"Evelyn"},
    void_knight = {"vk"},
    void_dragon = {"Xu'rot"},
    cactus = {"Martin"},
    card = {"Fortuna"},
    black_market_trader = {"Wren"},
    summoner = {"Kaida"},
    bigman = {"Eldertree"},
    spirit_summoner = {"Uma"},
    mage = {"Whim"},
    warlock = {"Eldric"},
    Breaker = {"Nuker"},  
    KitESP = {"alchemist", "beekeeper", "bigman", "ghost_catcher", "metal_detector", "sheep_herder", "sorcerer", "star_collector", "black_market_trader", "miner", "trapper", "necromancer", "battery"}
}

local components
components = {
	Button = function(optionsettings, children, api)
		local button = Instance.new('TextButton')
		button.Name = optionsettings.Name..'Button'
		button.Size = UDim2.new(1, 0, 0, 35) 
		button.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Visible = optionsettings.Visible == nil or optionsettings.Visible
		button.Text = ''
		button.Parent = children
		addTooltip(button, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.fromOffset(200, 27)
		bkg.Position = UDim2.fromOffset(10, 2)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.05)
		bkg.Parent = button
		addCorner(bkg)
		local label = Instance.new('TextLabel')
		label.Size = UDim2.new(1, -4, 1, -4)
		label.Position = UDim2.fromOffset(2, 2)
		label.BackgroundColor3 = uipallet.Main
		label.Text = optionsettings.Name
		label.TextColor3 = color.Dark(uipallet.Text, 0.16)
		label.TextSize = 14
		label.FontFace = uipallet.Font
		label.Parent = bkg
		addCorner(label, UDim.new(0, 4))
		optionsettings.Function = optionsettings.Function or function() end
		
		button.MouseEnter:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.0875)
			})
		end)
		button.MouseLeave:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.05)
			})
		end)
		button.MouseButton1Click:Connect(optionsettings.Function)
	end,
	ColorSlider = function(optionsettings, children, api)
		local optionapi = {
			Type = 'ColorSlider',
			Hue = optionsettings.DefaultHue or 0.44,
			Sat = optionsettings.DefaultSat or 1,
			Value = optionsettings.DefaultValue or 1,
			Opacity = optionsettings.DefaultOpacity or 1,
			Rainbow = false,
			Default = {
				Hue = optionsettings.DefaultHue or 0.44,
				Sat = optionsettings.DefaultSat or 1,
				Value = optionsettings.DefaultValue or 1,
				Opacity = optionsettings.DefaultOpacity or 1
			},
			Index = 0
		}
		
		local function createSlider(name, gradientColor)
			local slider = Instance.new('TextButton')
			slider.Name = optionsettings.Name..'Slider'..name
			slider.Size = UDim2.new(1, 0, 0, 50)
			slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
			slider.BorderSizePixel = 0
			slider.AutoButtonColor = false
			slider.Visible = false
			slider.Text = ''
			slider.Parent = children
			local title = Instance.new('TextLabel')
			title.Name = 'Title'
			title.Size = UDim2.fromOffset(60, 30)
			title.Position = UDim2.fromOffset(10, 2)
			title.BackgroundTransparency = 1
			title.Text = name
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextColor3 = color.Dark(uipallet.Text, 0.16)
			title.TextSize = 11
			title.FontFace = uipallet.Font
			title.Parent = slider
			local bkg = Instance.new('Frame')
			bkg.Name = 'Slider'
			bkg.Size = UDim2.new(1, -20, 0, 2)
			bkg.Position = UDim2.fromOffset(10, 37)
			bkg.BackgroundColor3 = Color3.new(1, 1, 1)
			bkg.BorderSizePixel = 0
			bkg.Parent = slider
			local gradient = Instance.new('UIGradient')
			gradient.Color = gradientColor
			gradient.Parent = bkg
			local fill = bkg:Clone()
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(math.clamp(name == 'Saturation' and optionapi.Sat or name == 'Vibrance' and optionapi.Value or optionapi.Opacity, 0.04, 0.96), 1)
			fill.Position = UDim2.new()
			fill.BackgroundTransparency = 1
			fill.Parent = bkg
			local knobholder = Instance.new('Frame')
			knobholder.Name = 'Knob'
			knobholder.Size = UDim2.fromOffset(24, 4)
			knobholder.Position = UDim2.fromScale(1, 0.5)
			knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
			knobholder.BackgroundColor3 = slider.BackgroundColor3
			knobholder.BorderSizePixel = 0
			knobholder.Parent = fill
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(14, 14)
			knob.Position = UDim2.fromScale(0.5, 0.5)
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.BackgroundColor3 = uipallet.Text
			knob.Parent = knobholder
			addCorner(knob, UDim.new(1, 0))
		
			slider.InputBegan:Connect(function(inputObj)
				if
					(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
					and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
				then
					local changed = inputService.InputChanged:Connect(function(input)
						if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
							optionapi:SetValue(nil, name == 'Saturation' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Vibrance' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil, name == 'Opacity' and math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1) or nil)
						end
					end)
		
					local ended
					ended = inputObj.Changed:Connect(function()
						if inputObj.UserInputState == Enum.UserInputState.End then
							if changed then changed:Disconnect() end
							if ended then ended:Disconnect() end
						end
					end)
				end
			end)
			slider.MouseEnter:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(16, 16)
				})
			end)
			slider.MouseLeave:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(14, 14)
				})
			end)
		
			return slider
		end
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 50)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = UDim2.fromOffset(60, 15)
		valuebox.Position = UDim2.new(1, -69, 0, 9)
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = ''
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = true
		valuebox.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 2)
		bkg.Position = UDim2.fromOffset(10, 39)
		bkg.BackgroundColor3 = Color3.new(1, 1, 1)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local rainbowTable = {}
		for i = 0, 1, 0.1 do
			table.insert(rainbowTable, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
		end
		local gradient = Instance.new('UIGradient')
		gradient.Color = ColorSequence.new(rainbowTable)
		gradient.Parent = bkg
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Size = UDim2.fromScale(math.clamp(optionapi.Hue, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundTransparency = 1
		fill.Parent = bkg
		local preview = Instance.new('ImageButton')
		preview.Name = 'Preview'
		preview.Size = UDim2.fromOffset(12, 12)
		preview.Position = UDim2.new(1, -22, 0, 10)
		preview.BackgroundTransparency = 1
		preview.Image = getcustomasset('aerov4/assets/new/colorpreview.png')
		preview.ImageColor3 = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
		preview.ImageTransparency = 1 - optionapi.Opacity
		preview.Parent = slider
		local expandbutton = Instance.new('TextButton')
		expandbutton.Name = 'Expand'
		expandbutton.Size = UDim2.fromOffset(17, 13)
		expandbutton.Position = UDim2.new(0, textService:GetTextSize(title.Text, title.TextSize, title.Font, Vector2.new(1000, 1000)).X + 11, 0, 7)
		expandbutton.BackgroundTransparency = 1
		expandbutton.Text = ''
		expandbutton.Parent = slider
		local expand = Instance.new('ImageLabel')
		expand.Name = 'Expand'
		expand.Size = UDim2.fromOffset(9, 5)
		expand.Position = UDim2.fromOffset(4, 4)
		expand.BackgroundTransparency = 1
		expand.Image = getcustomasset('aerov4/assets/new/expandicon.png')
		expand.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		expand.Parent = expandbutton
		local rainbow = Instance.new('TextButton')
		rainbow.Name = 'Rainbow'
		rainbow.Size = UDim2.fromOffset(12, 12)
		rainbow.Position = UDim2.new(1, -42, 0, 10)
		rainbow.BackgroundTransparency = 1
		rainbow.Text = ''
		rainbow.Parent = slider
		local rainbow1 = Instance.new('ImageLabel')
		rainbow1.Size = UDim2.fromOffset(12, 12)
		rainbow1.BackgroundTransparency = 1
		rainbow1.Image = getcustomasset('aerov4/assets/new/rainbow_1.png')
		rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
		rainbow1.Parent = rainbow
		local rainbow2 = rainbow1:Clone()
		rainbow2.Image = getcustomasset('aerov4/assets/new/rainbow_2.png')
		rainbow2.Parent = rainbow
		local rainbow3 = rainbow1:Clone()
		rainbow3.Image = getcustomasset('aerov4/assets/new/rainbow_3.png')
		rainbow3.Parent = rainbow
		local rainbow4 = rainbow1:Clone()
		rainbow4.Image = getcustomasset('aerov4/assets/new/rainbow_4.png')
		rainbow4.Parent = rainbow
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(24, 4)
		knobholder.Position = UDim2.fromScale(1, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(14, 14)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundColor3 = uipallet.Text
		knob.Parent = knobholder
		addCorner(knob, UDim.new(1, 0))
		optionsettings.Function = optionsettings.Function or function() end
		local satSlider = createSlider('Saturation', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, optionapi.Value)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, 1, optionapi.Value))
		}))
		local vibSlider = createSlider('Vibrance', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, 1))
		}))
		local opSlider = createSlider('Opacity', ColorSequence.new({
			ColorSequenceKeypoint.new(0, color.Dark(uipallet.Main, 0.02)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value))
		}))
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Hue = self.Hue,
				Sat = self.Sat,
				Value = self.Value,
				Opacity = self.Opacity,
				Rainbow = self.Rainbow
			}
		end
		
		function optionapi:Load(tab)
			if tab.Rainbow ~= self.Rainbow then
				self:Toggle()
			end
			if self.Hue ~= tab.Hue or self.Sat ~= tab.Sat or self.Value ~= tab.Value or self.Opacity ~= tab.Opacity then
				self:SetValue(tab.Hue, tab.Sat, tab.Value, tab.Opacity)
			end
		end
		
		function optionapi:SetValue(h, s, v, o)
			self.Hue = h or self.Hue
			self.Sat = s or self.Sat
			self.Value = v or self.Value
			self.Opacity = o or self.Opacity
			preview.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
			preview.ImageTransparency = 1 - self.Opacity
			satSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, self.Value)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, 1, self.Value))
			})
			vibSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, 1))
			})
			opSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, color.Dark(uipallet.Main, 0.02)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, self.Value))
			})
		
			if self.Rainbow then
				fill.Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
			else
				tween:Tween(fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
				})
			end
		
			if s then
				tween:Tween(satSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
				})
			end
			if v then
				tween:Tween(vibSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
				})
			end
			if o then
				tween:Tween(opSlider.Slider.Fill, uipallet.Tween, {
					Size = UDim2.fromScale(math.clamp(self.Opacity, 0.04, 0.96), 1)
				})
			end
		
			safecall(optionsettings.Function, self.Hue, self.Sat, self.Value, self.Opacity)
		end
		
		function optionapi:Toggle()
			self.Rainbow = not self.Rainbow
			if self.Rainbow then
				table.insert(mainapi.RainbowTable, self)
				rainbow1.ImageColor3 = Color3.fromRGB(5, 127, 100)
				task.delay(0.1, function()
					if not self.Rainbow then return end
					rainbow2.ImageColor3 = Color3.fromRGB(228, 125, 43)
					task.delay(0.1, function()
						if not self.Rainbow then return end
						rainbow3.ImageColor3 = Color3.fromRGB(225, 46, 52)
					end)
				end)
			else
				local ind = table.find(mainapi.RainbowTable, self)
				if ind then
					table.remove(mainapi.RainbowTable, ind)
				end
				rainbow3.ImageColor3 = color.Light(uipallet.Main, 0.37)
				task.delay(0.1, function()
					if self.Rainbow then return end
					rainbow2.ImageColor3 = color.Light(uipallet.Main, 0.37)
					task.delay(0.1, function()
						if self.Rainbow then return end
						rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end)
				end)
			end
		end
		
		local doubleClick = tick()
		preview.MouseButton1Click:Connect(function()
			preview.Visible = false
			valuebox.Visible = true
			valuebox:CaptureFocus()
			local text = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
			valuebox.Text = math.round(text.R * 255)..', '..math.round(text.G * 255)..', '..math.round(text.B * 255)
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				if doubleClick > tick() then
					optionapi:Toggle()
				end
				doubleClick = tick() + 0.3
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						optionapi:SetValue(math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1))
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
			end
		end)
		slider.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(16, 16)
			})
		end)
		slider.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(14, 14)
			})
		end)
		slider:GetPropertyChangedSignal('Visible'):Connect(function()
			satSlider.Visible = expand.Rotation == 180 and slider.Visible
			vibSlider.Visible = satSlider.Visible
			opSlider.Visible = satSlider.Visible
		end)
		expandbutton.MouseEnter:Connect(function()
			expand.ImageColor3 = color.Dark(uipallet.Text, 0.16)
		end)
		expandbutton.MouseLeave:Connect(function()
			expand.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		end)
		expandbutton.MouseButton1Click:Connect(function()
			satSlider.Visible = not satSlider.Visible
			vibSlider.Visible = satSlider.Visible
			opSlider.Visible = satSlider.Visible
			expand.Rotation = satSlider.Visible and 180 or 0
		end)
		rainbow.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		valuebox.FocusLost:Connect(function(enter)
			preview.Visible = true
			valuebox.Visible = false
			if enter then
				local commas = valuebox.Text:split(',')
				local suc, res = pcall(function()
					return tonumber(commas[1]) and Color3.fromRGB(tonumber(commas[1]), tonumber(commas[2]), tonumber(commas[3])) or Color3.fromHex(valuebox.Text)
				end)
				if suc then
					if optionapi.Rainbow then
						optionapi:Toggle()
					end
					optionapi:SetValue(res:ToHSV())
				end
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	Dropdown = function(optionsettings, children, api)
		local optionapi = {
			Type = 'Dropdown',
			Value = optionsettings.List[1] or 'None',
			Index = 0
		}
		
		local dropdown = Instance.new('TextButton')
		dropdown.Name = optionsettings.Name..'Dropdown'
		dropdown.Size = UDim2.new(1, 0, 0, 40)
		dropdown.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		dropdown.BorderSizePixel = 0
		dropdown.AutoButtonColor = false
		dropdown.Visible = optionsettings.Visible == nil or optionsettings.Visible
		dropdown.Text = ''
		dropdown.Parent = children
		addTooltip(dropdown, optionsettings.Tooltip or optionsettings.Name)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -9)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.Parent = dropdown
		addCorner(bkg, UDim.new(0, 6))
		local button = Instance.new('TextButton')
		button.Name = 'Dropdown'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Main
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, 0, 0, 29)
		title.BackgroundTransparency = 1
		title.Text = '         '..optionsettings.Name..' - '..optionapi.Value
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 13
		title.TextTruncate = Enum.TextTruncate.AtEnd
		title.FontFace = uipallet.Font
		title.Parent = button
		addCorner(button, UDim.new(0, 6))
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow.Size = UDim2.fromOffset(4, 8)
		arrow.Position = UDim2.new(1, -17, 0, 11)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('aerov4/assets/new/expandright.png')
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
		arrow.Rotation = 90
		arrow.Parent = button
		optionsettings.Function = optionsettings.Function or function() end
		local dropdownchildren
		local ddSearchBar
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Value = self.Value}
		end
		
		function optionapi:Load(tab)
			if self.Value ~= tab.Value then
				self:SetValue(tab.Value)
			end
		end
		
		function optionapi:Change(list)
			optionsettings.List = list or {}
			if not table.find(optionsettings.List, self.Value) then
				self:SetValue(self.Value)
			end
		end

		function optionapi:SetList(list)
			self:Change(list)
		end
		
		function optionapi:SetValue(val, mouse)
			self.Value = table.find(optionsettings.List, val) and val or optionsettings.List[1] or 'None'
			title.Text = '         '..optionsettings.Name..' - '..self.Value
			if ddSearchBar then
				ddSearchBar:Destroy()
				ddSearchBar = nil
			end
			if dropdownchildren then
				arrow.Rotation = 90
				dropdownchildren:Destroy()
				dropdownchildren = nil
				dropdown.Size = UDim2.new(1, 0, 0, 40)
			end
			safecall(optionsettings.Function, self.Value, mouse)
		end
		
		button.MouseButton1Click:Connect(function()
			if not dropdownchildren then
				arrow.Rotation = 270
				ddSearchBar = Instance.new('Frame')
				ddSearchBar.Name = 'DDSearchBar'
				ddSearchBar.Size = UDim2.new(1, 0, 0, 28)
				ddSearchBar.Position = UDim2.fromOffset(0, 27)
				ddSearchBar.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				ddSearchBar.BorderSizePixel = 0
				ddSearchBar.Parent = button
				local ddSearchIcon = Instance.new('ImageLabel')
				ddSearchIcon.Size = UDim2.fromOffset(11, 11)
				ddSearchIcon.Position = UDim2.fromOffset(7, 8)
				ddSearchIcon.BackgroundTransparency = 1
				ddSearchIcon.Image = getcustomasset('aerov4/assets/new/search.png')
				ddSearchIcon.ImageColor3 = color.Light(uipallet.Main, 0.37)
				ddSearchIcon.Parent = ddSearchBar
				local ddSearchBox = Instance.new('TextBox')
				ddSearchBox.Size = UDim2.new(1, -24, 1, 0)
				ddSearchBox.Position = UDim2.fromOffset(22, 0)
				ddSearchBox.BackgroundTransparency = 1
				ddSearchBox.Text = ''
				ddSearchBox.PlaceholderText = 'Search...'
				ddSearchBox.PlaceholderColor3 = color.Light(uipallet.Main, 0.37)
				ddSearchBox.TextXAlignment = Enum.TextXAlignment.Left
				ddSearchBox.TextColor3 = uipallet.Text
				ddSearchBox.TextSize = 12
				ddSearchBox.FontFace = uipallet.Font
				ddSearchBox.ClearTextOnFocus = false
				ddSearchBox.Parent = ddSearchBar
				dropdownchildren = Instance.new('Frame')
				dropdownchildren.Name = 'Children'
				dropdownchildren.Position = UDim2.fromOffset(0, 55)
				dropdownchildren.BackgroundTransparency = 1
				dropdownchildren.Parent = button
				local ddList = Instance.new('UIListLayout')
				ddList.SortOrder = Enum.SortOrder.LayoutOrder
				ddList.Parent = dropdownchildren
				local ddItems = {}
				local ddInd = 0
				for _, v in optionsettings.List do
					if v == optionapi.Value then continue end
					local dropdownoption = Instance.new('TextButton')
					dropdownoption.Name = v..'Option'
					dropdownoption.Size = UDim2.new(1, 0, 0, 26)
					dropdownoption.BackgroundColor3 = uipallet.Main
					dropdownoption.BorderSizePixel = 0
					dropdownoption.AutoButtonColor = false
					dropdownoption.Text = '         '..v
					dropdownoption.TextXAlignment = Enum.TextXAlignment.Left
					dropdownoption.TextColor3 = color.Dark(uipallet.Text, 0.16)
					dropdownoption.TextSize = 13
					dropdownoption.TextTruncate = Enum.TextTruncate.AtEnd
					dropdownoption.FontFace = uipallet.Font
					dropdownoption.LayoutOrder = ddInd
					dropdownoption.Parent = dropdownchildren
					dropdownoption.MouseEnter:Connect(function()
						tween:Tween(dropdownoption, uipallet.Tween, {BackgroundColor3 = color.Light(uipallet.Main, 0.02)})
					end)
					dropdownoption.MouseLeave:Connect(function()
						tween:Tween(dropdownoption, uipallet.Tween, {BackgroundColor3 = uipallet.Main})
					end)
					dropdownoption.MouseButton1Click:Connect(function()
						optionapi:SetValue(v, true)
					end)
					table.insert(ddItems, {btn = dropdownoption, name = v:lower()})
					ddInd += 1
				end
				local function updateDDSize()
					local vis = 0
					for _, item in ddItems do
						if item.btn.Visible then vis += 1 end
					end
					dropdownchildren.Size = UDim2.new(1, 0, 0, vis * 26)
					dropdown.Size = UDim2.new(1, 0, 0, 40 + 28 + vis * 26)
				end
				updateDDSize()
				ddSearchBox:GetPropertyChangedSignal('Text'):Connect(function()
					local query = ddSearchBox.Text:lower()
					for _, item in ddItems do
						item.btn.Visible = query == '' or item.name:find(query, 1, true) ~= nil
					end
					updateDDSize()
					ddSearchIcon.ImageColor3 = query ~= '' and uipallet.Text or color.Light(uipallet.Main, 0.37)
				end)
			else
				optionapi:SetValue(optionapi.Value, true)
			end
		end)
		dropdown.MouseEnter:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.0875)
			})
		end)
		dropdown.MouseLeave:Connect(function()
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.034)
			})
		end)
		
		optionapi.Object = dropdown
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	Font = function(optionsettings, children, api)
		local fonts = {
			optionsettings.Blacklist,
			'Custom'
		}
		for _, v in Enum.Font:GetEnumItems() do
			if not table.find(fonts, v.Name) then
				table.insert(fonts, v.Name)
			end
		end
		
		local optionapi = {Value = Font.fromEnum(Enum.Font[fonts[1]])}
		local fontdropdown
		local fontbox
		optionsettings.Function = optionsettings.Function or function() end
		
		fontdropdown = components.Dropdown({
			Name = optionsettings.Name,
			List = fonts,
			Function = function(val)
				fontbox.Object.Visible = val == 'Custom' and fontdropdown.Object.Visible
				if val ~= 'Custom' then
					optionapi.Value = Font.fromEnum(Enum.Font[val])
					safecall(optionsettings.Function, optionapi.Value)
				else
					pcall(function()
						optionapi.Value = Font.fromId(tonumber(fontbox.Value))
					end)
					safecall(optionsettings.Function, optionapi.Value)
				end
			end,
			Darker = optionsettings.Darker,
			Visible = optionsettings.Visible
		}, children, api)
		optionapi.Object = fontdropdown.Object
		fontbox = components.TextBox({
			Name = optionsettings.Name..' Asset',
			Placeholder = 'font (rbxasset)',
			Function = function()
				if fontdropdown.Value == 'Custom' then
					pcall(function()
						optionapi.Value = Font.fromId(tonumber(fontbox.Value))
					end)
					safecall(optionsettings.Function, optionapi.Value)
				end
			end,
			Visible = false,
			Darker = true
		}, children, api)
		
		fontdropdown.Object:GetPropertyChangedSignal('Visible'):Connect(function()
			fontbox.Object.Visible = fontdropdown.Object.Visible and fontdropdown.Value == 'Custom'
		end)
		
		return optionapi
	end,
	Slider = function(optionsettings, children, api)
		local optionapi = {
			Type = 'Slider',
			Value = optionsettings.Default or optionsettings.Min,
			Max = optionsettings.Max,
			Default = optionsettings.Default or optionsettings.Min,
			Index = getTableSize(api.Options)
		}
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 50)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebutton = Instance.new('TextButton')
		valuebutton.Name = 'Value'
		valuebutton.Size = UDim2.fromOffset(60, 15)
		valuebutton.Position = UDim2.new(1, -69, 0, 9)
		valuebutton.BackgroundTransparency = 1
		valuebutton.Text = optionapi.Value..(optionsettings.Suffix and ' '..(type(optionsettings.Suffix) == 'function' and optionsettings.Suffix(optionapi.Value) or optionsettings.Suffix) or '')
		valuebutton.TextXAlignment = Enum.TextXAlignment.Right
		valuebutton.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebutton.TextSize = 11
		valuebutton.FontFace = uipallet.Font
		valuebutton.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = valuebutton.Size
		valuebox.Position = valuebutton.Position
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = optionapi.Value
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = false
		valuebox.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 2)
		bkg.Position = UDim2.fromOffset(10, 37)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Size = UDim2.fromScale(math.clamp((optionapi.Value - optionsettings.Min) / optionsettings.Max, 0.04, 0.96), 1)
		fill.Position = UDim2.new()
		fill.BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
		fill.Parent = bkg
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(24, 4)
		knobholder.Position = UDim2.fromScale(1, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(14, 14)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
		knob.Parent = knobholder
		addCorner(knob, UDim.new(1, 0))
		optionsettings.Function = optionsettings.Function or function() end
		optionsettings.Decimal = optionsettings.Decimal or 1
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Value = self.Value,
				Max = self.Max
			}
		end
		
		function optionapi:Load(tab)
			local newval = tab.Value == tab.Max and tab.Max ~= self.Max and self.Max or tab.Value
			if self.Value ~= newval then
				self:SetValue(newval, nil, true)
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			fill.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			knob.BackgroundColor3 = fill.BackgroundColor3
		end
		
		function optionapi:SetValue(value, pos, final)
			if tonumber(value) == math.huge or value ~= value then return end
			local check = self.Value ~= value
			self.Value = value
			tween:Tween(fill, uipallet.Tween, {
				Size = UDim2.fromScale(math.clamp(pos or math.clamp(value / optionsettings.Max, 0, 1), 0.04, 0.96), 1)
			})
			valuebutton.Text = self.Value..(optionsettings.Suffix and ' '..(type(optionsettings.Suffix) == 'function' and optionsettings.Suffix(self.Value) or optionsettings.Suffix) or '')
			if check or final then
				safecall(optionsettings.Function, value, final)
			end
		end
		
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local newPosition = math.clamp((inputObj.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
				optionapi:SetValue(math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
				local lastValue = optionapi.Value
				local lastPosition = newPosition
		
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						local newPosition = math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
						optionapi:SetValue(math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
						lastValue = optionapi.Value
						lastPosition = newPosition
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
						optionapi:SetValue(lastValue, lastPosition, true)
					end
				end)
		
			end
		end)
		slider.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(16, 16)
			})
		end)
		slider.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(14, 14)
			})
		end)
		valuebutton.MouseButton1Click:Connect(function()
			valuebutton.Visible = false
			valuebox.Visible = true
			valuebox.Text = optionapi.Value
			valuebox:CaptureFocus()
		end)
		valuebox.FocusLost:Connect(function(enter)
			valuebutton.Visible = true
			valuebox.Visible = false
			if enter and tonumber(valuebox.Text) then
				optionapi:SetValue(tonumber(valuebox.Text), nil, true)
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	Targets = function(optionsettings, children, api)
		local optionapi = {
			Type = 'Targets',
			Index = getTableSize(api.Options)
		}
		
		local textlist = Instance.new('TextButton')
		textlist.Name = 'Targets'
		textlist.Size = UDim2.new(1, 0, 0, 50)
		textlist.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textlist.BorderSizePixel = 0
		textlist.AutoButtonColor = false
		textlist.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textlist.Text = ''
		textlist.Parent = children
		addTooltip(textlist, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -9)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.Parent = textlist
		addCorner(bkg, UDim.new(0, 4))
		local button = Instance.new('TextButton')
		button.Name = 'TextList'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Main
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local buttontitle = Instance.new('TextLabel')
		buttontitle.Name = 'Title'
		buttontitle.Size = UDim2.new(1, -5, 0, 15)
		buttontitle.Position = UDim2.fromOffset(5, 6)
		buttontitle.BackgroundTransparency = 1
		buttontitle.Text = 'Target:'
		buttontitle.TextXAlignment = Enum.TextXAlignment.Left
		buttontitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
		buttontitle.TextSize = 15
		buttontitle.TextTruncate = Enum.TextTruncate.AtEnd
		buttontitle.FontFace = uipallet.Font
		buttontitle.Parent = button
		local items = buttontitle:Clone()
		items.Name = 'Items'
		items.Position = UDim2.fromOffset(5, 21)
		items.Text = 'Ignore none'
		items.TextColor3 = color.Dark(uipallet.Text, 0.16)
		items.TextSize = 11
		items.Parent = button
		addCorner(button, UDim.new(0, 4))
		local tool = Instance.new('Frame')
		tool.Size = UDim2.fromOffset(65, 12)
		tool.Position = UDim2.fromOffset(52, 8)
		tool.BackgroundTransparency = 1
		tool.Parent = button
		local toollist = Instance.new('UIListLayout')
		toollist.FillDirection = Enum.FillDirection.Horizontal
		toollist.Padding = UDim.new(0, 6)
		toollist.Parent = tool
		local window = Instance.new('TextButton')
		window.Name = 'TargetsTextWindow'
		window.Size = UDim2.fromOffset(220, 145)
		window.BackgroundColor3 = uipallet.Main
		window.BorderSizePixel = 0
		window.AutoButtonColor = false
		window.Visible = false
		window.Text = ''
		window.Parent = clickgui
		optionapi.Window = window
		addBlur(window)
		addCorner(window)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = UDim2.fromOffset(18, 12)
		icon.Position = UDim2.fromOffset(10, 15)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('aerov4/assets/new/targetstab.png')
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11)
		title.BackgroundTransparency = 1
		title.Text = 'Target settings'
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window)
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab.Targets = {
				Players  = self.Players  and self.Players.Enabled  or false,
				NPCs     = self.NPCs     and self.NPCs.Enabled     or false,
				Invisible= self.Invisible and self.Invisible.Enabled or false,
				Walls    = self.Walls    and self.Walls.Enabled    or false,
			}
		end
		
		function optionapi:Load(tab)
			if self.Players  and self.Players.Enabled  ~= tab.Players   then self.Players:Toggle()  end
			if self.NPCs     and self.NPCs.Enabled     ~= tab.NPCs      then self.NPCs:Toggle()     end
			if self.Invisible and self.Invisible.Enabled ~= tab.Invisible then self.Invisible:Toggle() end
			if self.Walls    and self.Walls.Enabled    ~= tab.Walls     then self.Walls:Toggle()    end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			bkg.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			if self.Players.Enabled then
				tween:Cancel(self.Players.Object.Frame)
				self.Players.Object.Frame.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.NPCs.Enabled then
				tween:Cancel(self.NPCs.Object.Frame)
				self.NPCs.Object.Frame.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.Invisible.Enabled then
				tween:Cancel(self.Invisible.Object.Knob)
				self.Invisible.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
			if self.Walls.Enabled then
				tween:Cancel(self.Walls.Object.Knob)
				self.Walls.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end
		end
		
		optionapi.Players = components.TargetsButton({
			Position = UDim2.fromOffset(11, 45),
			Icon = getcustomasset('aerov4/assets/new/targetplayers1.png'),
			IconSize = UDim2.fromOffset(15, 16),
			IconParent = tool,
			ToolIcon = getcustomasset('aerov4/assets/new/targetplayers2.png'),
			ToolSize = UDim2.fromOffset(11, 12),
			Tooltip = 'Players',
			Function = optionsettings.Function
		}, window, tool)
		optionapi.NPCs = components.TargetsButton({
			Position = UDim2.fromOffset(112, 45),
			Icon = getcustomasset('aerov4/assets/new/targetnpc1.png'),
			IconSize = UDim2.fromOffset(12, 16),
			IconParent = tool,
			ToolIcon = getcustomasset('aerov4/assets/new/targetnpc2.png'),
			ToolSize = UDim2.fromOffset(9, 12),
			Tooltip = 'NPCs',
			Function = optionsettings.Function
		}, window, tool)
		optionapi.Invisible = components.Toggle({
			Name = 'Ignore invisible',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				safecall(optionsettings.Function)
			end
		}, window, {Options = {}})
		optionapi.Invisible.Object.Position = UDim2.fromOffset(0, 81)
		optionapi.Walls = components.Toggle({
			Name = 'Ignore behind walls',
			Function = function()
				local text = 'none'
				if optionapi.Invisible.Enabled then
					text = 'invisible'
				end
				if optionapi.Walls.Enabled then
					text = text == 'none' and 'behind walls' or text..', behind walls'
				end
				items.Text = 'Ignore '..text
				safecall(optionsettings.Function)
			end
		}, window, {Options = {}})
		optionapi.Walls.Object.Position = UDim2.fromOffset(0, 111)
		if optionsettings.Players then
			optionapi.Players:Toggle()
		end
		if optionsettings.NPCs then
			optionapi.NPCs:Toggle()
		end
		if optionsettings.Invisible then
			optionapi.Invisible:Toggle()
		end
		if optionsettings.Walls then
			optionapi.Walls:Toggle()
		end
		
		close.MouseButton1Click:Connect(function()
			window.Visible = false
		end)
		button.MouseButton1Click:Connect(function()
			window.Visible = not window.Visible
			tween:Cancel(bkg)
			bkg.BackgroundColor3 = window.Visible and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.37)
		end)
		textlist.MouseEnter:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		textlist.MouseLeave:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.034)
				})
			end
		end)
		textlist:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			local actualPosition = (textlist.AbsolutePosition + Vector2.new(0, 60)) / scale.Scale
			window.Position = UDim2.fromOffset(actualPosition.X + 220, actualPosition.Y)
		end)
		
		optionapi.Object = textlist
		api.Options.Targets = optionapi
		
		return optionapi
	end,
	TargetsButton = function(optionsettings, children, api)
		local optionapi = {Enabled = false}
		
		local targetbutton = Instance.new('TextButton')
		targetbutton.Size = UDim2.fromOffset(98, 31)
		targetbutton.Position = optionsettings.Position
		targetbutton.BackgroundColor3 = color.Light(uipallet.Main, 0.05)
		targetbutton.AutoButtonColor = false
		targetbutton.Visible = optionsettings.Visible == nil or optionsettings.Visible
		targetbutton.Text = ''
		targetbutton.Parent = children
		addCorner(targetbutton)
		addTooltip(targetbutton, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Size = UDim2.new(1, -2, 1, -2)
		bkg.Position = UDim2.fromOffset(1, 1)
		bkg.BackgroundColor3 = uipallet.Main
		bkg.Parent = targetbutton
		addCorner(bkg)
		local icon = Instance.new('ImageLabel')
		icon.Size = optionsettings.IconSize
		icon.Position = UDim2.fromScale(0.5, 0.5)
		icon.AnchorPoint = Vector2.new(0.5, 0.5)
		icon.BackgroundTransparency = 1
		icon.Image = optionsettings.Icon
		icon.ImageColor3 = color.Light(uipallet.Main, 0.37)
		icon.Parent = bkg
		optionsettings.Function = optionsettings.Function or function() end
		local tooltipicon
		
		function optionapi:Toggle()
			self.Enabled = not self.Enabled
			tween:Tween(bkg, uipallet.Tween, {
				BackgroundColor3 = self.Enabled and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or uipallet.Main
			})
			tween:Tween(icon, uipallet.Tween, {
				ImageColor3 = self.Enabled and Color3.new(1, 1, 1) or color.Light(uipallet.Main, 0.37)
			})
			if tooltipicon then
				tooltipicon:Destroy()
			end
			if self.Enabled then
				tooltipicon = Instance.new('ImageLabel')
				tooltipicon.Size = optionsettings.ToolSize
				tooltipicon.BackgroundTransparency = 1
				tooltipicon.Image = optionsettings.ToolIcon
				tooltipicon.ImageColor3 = uipallet.Text
				tooltipicon.Parent = optionsettings.IconParent
			end
			safecall(optionsettings.Function, self.Enabled)
		end
		
		targetbutton.MouseEnter:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value - 0.25)
				})
				tween:Tween(icon, uipallet.Tween, {
					ImageColor3 = Color3.new(1, 1, 1)
				})
			end
		end)
		targetbutton.MouseLeave:Connect(function()
			if not optionapi.Enabled then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = uipallet.Main
				})
				tween:Tween(icon, uipallet.Tween, {
					ImageColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		targetbutton.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		
		optionapi.Object = targetbutton
		
		return optionapi
	end,
	TextBox = function(optionsettings, children, api)
		local optionapi = {
			Type = 'TextBox',
			Value = optionsettings.Default or '',
			Index = 0
		}
		
		local textbox = Instance.new('TextButton')
		textbox.Name = optionsettings.Name..'TextBox'
		textbox.Size = UDim2.new(1, 0, 0, 58)
		textbox.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textbox.BorderSizePixel = 0
		textbox.AutoButtonColor = false
		textbox.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textbox.Text = ''
		textbox.Parent = children
		addTooltip(textbox, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Size = UDim2.new(1, -10, 0, 20)
		title.Position = UDim2.fromOffset(10, 3)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 12
		title.FontFace = uipallet.Font
		title.Parent = textbox
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 0, 29)
		bkg.Position = UDim2.fromOffset(10, 23)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		bkg.Parent = textbox
		addCorner(bkg, UDim.new(0, 4))
		local box = Instance.new('TextBox')
		box.Size = UDim2.new(1, -8, 1, 0)
		box.Position = UDim2.fromOffset(8, 0)
		box.BackgroundTransparency = 1
		box.Text = optionsettings.Default or ''
		box.PlaceholderText = optionsettings.Placeholder or 'Click to set'
		box.TextXAlignment = Enum.TextXAlignment.Left
		box.TextColor3 = color.Dark(uipallet.Text, 0.16)
		box.PlaceholderColor3 = color.Dark(uipallet.Text, 0.31)
		box.TextSize = 12
		box.FontFace = uipallet.Font
		box.ClearTextOnFocus = false
		box.Parent = bkg
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Value = self.Value}
		end
		
		function optionapi:Load(tab)
			if tab.Value and self.Value ~= tab.Value then
				self:SetValue(tab.Value)
			end
		end
		
		function optionapi:SetValue(val, enter)
			self.Value = val
			box.Text = val
			safecall(optionsettings.Function, enter)
		end
		
		textbox.MouseButton1Click:Connect(function()
			box:CaptureFocus()
		end)
		box.FocusLost:Connect(function(enter)
			optionapi:SetValue(box.Text, enter)
		end)
		box:GetPropertyChangedSignal('Text'):Connect(function()
			optionapi:SetValue(box.Text)
		end)
		
		optionapi.Object = textbox
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	TextList = function(optionsettings, children, api)
		local optionapi = {
			Type = 'TextList',
			List = optionsettings.Default or {},
			ListEnabled = optionsettings.Default or {},
			Objects = {},
			Window = {Visible = false},
			Index = getTableSize(api.Options)
		}
		optionsettings.Color = optionsettings.Color or Color3.fromRGB(5, 134, 105)
		
		local textlist = Instance.new('TextButton')
		textlist.Name = optionsettings.Name..'TextList'
		textlist.Size = UDim2.new(1, 0, 0, 50)
		textlist.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		textlist.BorderSizePixel = 0
		textlist.AutoButtonColor = false
		textlist.Visible = optionsettings.Visible == nil or optionsettings.Visible
		textlist.Text = ''
		textlist.Parent = children
		addTooltip(textlist, optionsettings.Tooltip)
		local bkg = Instance.new('Frame')
		bkg.Name = 'BKG'
		bkg.Size = UDim2.new(1, -20, 1, -9)
		bkg.Position = UDim2.fromOffset(10, 4)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.Parent = textlist
		addCorner(bkg, UDim.new(0, 4))
		local button = Instance.new('TextButton')
		button.Name = 'TextList'
		button.Size = UDim2.new(1, -2, 1, -2)
		button.Position = UDim2.fromOffset(1, 1)
		button.BackgroundColor3 = uipallet.Main
		button.AutoButtonColor = false
		button.Text = ''
		button.Parent = bkg
		local buttonicon = Instance.new('ImageLabel')
		buttonicon.Name = 'Icon'
		buttonicon.Size = UDim2.fromOffset(14, 12)
		buttonicon.Position = UDim2.fromOffset(10, 14)
		buttonicon.BackgroundTransparency = 1
		buttonicon.Image = optionsettings.Icon or getcustomasset('aerov4/assets/new/allowedicon.png')
		buttonicon.Parent = button
		local buttontitle = Instance.new('TextLabel')
		buttontitle.Name = 'Title'
		buttontitle.Size = UDim2.new(1, -35, 0, 15)
		buttontitle.Position = UDim2.fromOffset(35, 6)
		buttontitle.BackgroundTransparency = 1
		buttontitle.Text = optionsettings.Name
		buttontitle.TextXAlignment = Enum.TextXAlignment.Left
		buttontitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
		buttontitle.TextSize = 15
		buttontitle.TextTruncate = Enum.TextTruncate.AtEnd
		buttontitle.FontFace = uipallet.Font
		buttontitle.Parent = button
		local amount = buttontitle:Clone()
		amount.Name = 'Amount'
		amount.Size = UDim2.new(1, -13, 0, 15)
		amount.Position = UDim2.fromOffset(0, 6)
		amount.Text = '0'
		amount.TextXAlignment = Enum.TextXAlignment.Right
		amount.Parent = button
		local items = buttontitle:Clone()
		items.Name = 'Items'
		items.Position = UDim2.fromOffset(35, 21)
		items.Text = 'None'
		items.TextColor3 = color.Dark(uipallet.Text, 0.43)
		items.TextSize = 11
		items.Parent = button
		addCorner(button, UDim.new(0, 4))
		local window = Instance.new('TextButton')
		window.Name = optionsettings.Name..'TextWindow'
		window.Size = UDim2.fromOffset(220, 85)
		window.BackgroundColor3 = uipallet.Main
		window.BorderSizePixel = 0
		window.AutoButtonColor = false
		window.Visible = false
		window.Text = ''
		window.Parent = api.Legit and mainapi.Legit.Window or clickgui
		optionapi.Window = window
		addBlur(window)
		addCorner(window)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = optionsettings.TabSize or UDim2.fromOffset(19, 16)
		icon.Position = UDim2.fromOffset(10, 13)
		icon.BackgroundTransparency = 1
		icon.Image = optionsettings.Tab or getcustomasset('aerov4/assets/new/allowedtab.png')
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window)
		local addbkg = Instance.new('Frame')
		addbkg.Name = 'Add'
		addbkg.Size = UDim2.fromOffset(200, 31)
		addbkg.Position = UDim2.fromOffset(10, 45)
		addbkg.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		addbkg.Parent = window
		addCorner(addbkg)
		local addbox = addbkg:Clone()
		addbox.Size = UDim2.new(1, -2, 1, -2)
		addbox.Position = UDim2.fromOffset(1, 1)
		addbox.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
		addbox.Parent = addbkg
		local addvalue = Instance.new('TextBox')
		addvalue.Size = UDim2.new(1, -35, 1, 0)
		addvalue.Position = UDim2.fromOffset(10, 0)
		addvalue.BackgroundTransparency = 1
		addvalue.Text = ''
		addvalue.PlaceholderText = optionsettings.Placeholder or 'Add entry...'
		addvalue.TextXAlignment = Enum.TextXAlignment.Left
		addvalue.TextColor3 = Color3.new(1, 1, 1)
		addvalue.TextSize = 15
		addvalue.FontFace = uipallet.Font
		addvalue.ClearTextOnFocus = false
		addvalue.Parent = addbkg
		local addbutton = Instance.new('ImageButton')
		addbutton.Name = 'AddButton'
		addbutton.Size = UDim2.fromOffset(16, 16)
		addbutton.Position = UDim2.new(1, -26, 0, 8)
		addbutton.BackgroundTransparency = 1
		addbutton.Image = getcustomasset('aerov4/assets/new/add.png')
		addbutton.ImageColor3 = optionsettings.Color
		addbutton.ImageTransparency = 0.3
		addbutton.Parent = addbkg
		local tlsearchbar = Instance.new('Frame')
		tlsearchbar.Name = 'SearchBar'
		tlsearchbar.Size = UDim2.fromOffset(200, 28)
		tlsearchbar.Position = UDim2.fromOffset(10, 80)
		tlsearchbar.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		tlsearchbar.BorderSizePixel = 0
		tlsearchbar.Parent = window
		addCorner(tlsearchbar)
		local tlsearchicon = Instance.new('ImageLabel')
		tlsearchicon.Size = UDim2.fromOffset(11, 11)
		tlsearchicon.Position = UDim2.fromOffset(7, 8)
		tlsearchicon.BackgroundTransparency = 1
		tlsearchicon.Image = getcustomasset('aerov4/assets/new/search.png')
		tlsearchicon.ImageColor3 = color.Light(uipallet.Main, 0.37)
		tlsearchicon.Parent = tlsearchbar
		local tlsearchbox = Instance.new('TextBox')
		tlsearchbox.Size = UDim2.new(1, -24, 1, 0)
		tlsearchbox.Position = UDim2.fromOffset(22, 0)
		tlsearchbox.BackgroundTransparency = 1
		tlsearchbox.Text = ''
		tlsearchbox.PlaceholderText = 'Search entries...'
		tlsearchbox.PlaceholderColor3 = color.Light(uipallet.Main, 0.37)
		tlsearchbox.TextXAlignment = Enum.TextXAlignment.Left
		tlsearchbox.TextColor3 = uipallet.Text
		tlsearchbox.TextSize = 12
		tlsearchbox.FontFace = uipallet.Font
		tlsearchbox.ClearTextOnFocus = false
		tlsearchbox.Parent = tlsearchbar
		local tlSearchQuery = ''
		local function applyTLFilter()
			local vis = 0
			for i, obj in optionapi.Objects do
				local name = optionapi.List[i] or ''
				local match = tlSearchQuery == '' or name:lower():find(tlSearchQuery, 1, true) ~= nil
				obj.Visible = match
				if match then
					vis += 1
					obj.Position = UDim2.fromOffset(10, 112 + (vis * 35))
				end
			end
			if tlSearchQuery ~= '' then
				window.Size = UDim2.fromOffset(220, 155 + (vis * 35))
			end
		end
		tlsearchbox:GetPropertyChangedSignal('Text'):Connect(function()
			tlSearchQuery = tlsearchbox.Text:lower()
			applyTLFilter()
			tlsearchicon.ImageColor3 = tlSearchQuery ~= '' and uipallet.Text or color.Light(uipallet.Main, 0.37)
		end)
		window:GetPropertyChangedSignal('Visible'):Connect(function()
			if not window.Visible then
				tlsearchbox.Text = ''
				tlSearchQuery = ''
			end
		end)
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				List = self.List,
				ListEnabled = self.ListEnabled
			}
		end
		
		function optionapi:Load(tab)
			self.List = tab.List or {}
			self.ListEnabled = tab.ListEnabled or {}
			self:ChangeValue()
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			if window.Visible then
				bkg.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			end
		end
		
		function optionapi:ChangeValue(val)
			if val then
				local ind = table.find(self.List, val)
				if ind then
					table.remove(self.List, ind)
					ind = table.find(self.ListEnabled, val)
					if ind then
						table.remove(self.ListEnabled, ind)
					end
				else
					table.insert(self.List, val)
					table.insert(self.ListEnabled, val)
				end
			end
		
			safecall(optionsettings.Function, self.List)
			for _, v in self.Objects do
				v:Destroy()
			end
			table.clear(self.Objects)
			window.Size = UDim2.fromOffset(220, 120 + (#self.List * 35))
			amount.Text = #self.List
		
			local enabledtext = 'None'
			for i, v in self.ListEnabled do
				if i == 1 then enabledtext = '' end
				enabledtext = enabledtext..(i == 1 and v or ', '..v)
			end
			items.Text = enabledtext
		
			for i, v in self.List do
				local enabled = table.find(self.ListEnabled, v)
				local object = Instance.new('TextButton')
				object.Name = v
				object.Size = UDim2.fromOffset(200, 32)
				object.Position = UDim2.fromOffset(10, 112 + (i * 35))
				object.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = window
				addCorner(object)
				local objectbkg = Instance.new('Frame')
				objectbkg.Name = 'BKG'
				objectbkg.Size = UDim2.new(1, -2, 1, -2)
				objectbkg.Position = UDim2.fromOffset(1, 1)
				objectbkg.BackgroundColor3 = uipallet.Main
				objectbkg.Visible = false
				objectbkg.Parent = object
				addCorner(objectbkg)
				local objectdot = Instance.new('Frame')
				objectdot.Name = 'Dot'
				objectdot.Size = UDim2.fromOffset(10, 11)
				objectdot.Position = UDim2.fromOffset(10, 12)
				objectdot.BackgroundColor3 = enabled and optionsettings.Color or color.Light(uipallet.Main, 0.37)
				objectdot.Parent = object
				addCorner(objectdot, UDim.new(1, 0))
				local objectdotin = objectdot:Clone()
				objectdotin.Size = UDim2.fromOffset(8, 9)
				objectdotin.Position = UDim2.fromOffset(1, 1)
				objectdotin.BackgroundColor3 = enabled and optionsettings.Color or color.Light(uipallet.Main, 0.02)
				objectdotin.Parent = objectdot
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -30, 1, 0)
				objecttitle.Position = UDim2.fromOffset(30, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				local close = Instance.new('ImageButton')
				close.Name = 'Close'
				close.Size = UDim2.fromOffset(16, 16)
				close.Position = UDim2.new(1, -26, 0, 8)
				close.BackgroundColor3 = Color3.new(1, 1, 1)
				close.BackgroundTransparency = 1
				close.AutoButtonColor = false
				close.Image = getcustomasset('aerov4/assets/new/closemini.png')
				close.ImageColor3 = color.Light(uipallet.Text, 0.2)
				close.ImageTransparency = 0.5
				close.Parent = object
				addCorner(close, UDim.new(1, 0))
		
				close.MouseEnter:Connect(function()
					close.ImageTransparency = 0.3
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.6
					})
				end)
				close.MouseLeave:Connect(function()
					close.ImageTransparency = 0.5
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 1
					})
				end)
				close.MouseButton1Click:Connect(function()
					self:ChangeValue(v)
				end)
				object.MouseEnter:Connect(function()
					objectbkg.Visible = true
				end)
				object.MouseLeave:Connect(function()
					objectbkg.Visible = false
				end)
				object.MouseButton1Click:Connect(function()
					local ind = table.find(self.ListEnabled, v)
					if ind then
						table.remove(self.ListEnabled, ind)
						objectdot.BackgroundColor3 = color.Light(uipallet.Main, 0.37)
						objectdotin.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
					else
						table.insert(self.ListEnabled, v)
						objectdot.BackgroundColor3 = optionsettings.Color
						objectdotin.BackgroundColor3 = optionsettings.Color
					end
		
					local enabledtext = 'None'
					for i, v in self.ListEnabled do
						if i == 1 then enabledtext = '' end
						enabledtext = enabledtext..(i == 1 and v or ', '..v)
					end
		
					items.Text = enabledtext
					safecall(optionsettings.Function)
				end)
		
				table.insert(self.Objects, object)
			end
			applyTLFilter()
		end
		
		addbutton.MouseEnter:Connect(function()
			addbutton.ImageTransparency = 0
		end)
		addbutton.MouseLeave:Connect(function()
			addbutton.ImageTransparency = 0.3
		end)
		addbutton.MouseButton1Click:Connect(function()
			if not table.find(optionapi.List, addvalue.Text) then
				optionapi:ChangeValue(addvalue.Text)
				addvalue.Text = ''
			end
		end)
		addvalue.FocusLost:Connect(function(enter)
			if enter and not table.find(optionapi.List, addvalue.Text) then
				optionapi:ChangeValue(addvalue.Text)
				addvalue.Text = ''
			end
		end)
		addvalue.MouseEnter:Connect(function()
			tween:Tween(addbkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.14)
			})
		end)
		addvalue.MouseLeave:Connect(function()
			tween:Tween(addbkg, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			})
		end)
		close.MouseButton1Click:Connect(function()
			window.Visible = false
		end)
		button.MouseButton1Click:Connect(function()
			window.Visible = not window.Visible
			tween:Cancel(bkg)
			bkg.BackgroundColor3 = window.Visible and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.37)
		end)
		textlist.MouseEnter:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		textlist.MouseLeave:Connect(function()
			if not optionapi.Window.Visible then
				tween:Tween(bkg, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.034)
				})
			end
		end)
		textlist:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			local actualPosition = (textlist.AbsolutePosition - (api.Legit and mainapi.Legit.Window.AbsolutePosition or -guiService:GetGuiInset())) / scale.Scale
			window.Position = UDim2.fromOffset(actualPosition.X + 220, actualPosition.Y)
		end)
		
		if optionsettings.Default then
			optionapi:ChangeValue()
		end
		optionapi.Object = textlist
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	Toggle = function(optionsettings, children, api)
		local optionapi = {
			Type = 'Toggle',
			Enabled = false,
			Default = optionsettings.Default or false,
			Index = getTableSize(api.Options)
		}
		
		local hovered = false
		local toggle = Instance.new('TextButton')
		toggle.Name = optionsettings.Name..'Toggle'
		toggle.Size = UDim2.new(1, 0, 0, 30)
		toggle.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		toggle.BorderSizePixel = 0
		toggle.AutoButtonColor = false
		toggle.Visible = optionsettings.Visible == nil or optionsettings.Visible
		toggle.Text = '          '..optionsettings.Name
		toggle.TextXAlignment = Enum.TextXAlignment.Left
		toggle.TextColor3 = color.Dark(uipallet.Text, 0.16)
		toggle.TextSize = 14
		toggle.FontFace = uipallet.Font
		toggle.Parent = children
		addTooltip(toggle, optionsettings.Tooltip)
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(22, 12)
		knobholder.Position = UDim2.new(1, -30, 0, 9)
		knobholder.BackgroundColor3 = color.Light(uipallet.Main, 0.14)
		knobholder.Parent = toggle
		addCorner(knobholder, UDim.new(1, 0))
		local knob = knobholder:Clone()
		knob.Size = UDim2.fromOffset(8, 8)
		knob.Position = UDim2.fromOffset(2, 2)
		knob.BackgroundColor3 = uipallet.Main
		knob.Parent = knobholder
		optionsettings.Function = optionsettings.Function or function() end
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {Enabled = self.Enabled}
		end
		
		function optionapi:Load(tab)
			if self.Enabled ~= tab.Enabled then
				self:Toggle()
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			if self.Enabled then
				tween:Cancel(knobholder)
				knobholder.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			end
		end
		
		function optionapi:Toggle()
			self.Enabled = not self.Enabled
			local rainbowcheck = mainapi.GUIColor.Rainbow and mainapi.RainbowMode.Value ~= 'Retro'
			tween:Tween(knobholder, uipallet.Tween, {
				BackgroundColor3 = self.Enabled and (rainbowcheck and Color3.fromHSV(mainapi:Color((mainapi.GUIColor.Hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)) or (hovered and color.Light(uipallet.Main, 0.37) or color.Light(uipallet.Main, 0.14))
			})
			tween:Tween(knob, uipallet.Tween, {
				Position = UDim2.fromOffset(self.Enabled and 12 or 2, 2)
			})
			safecall(optionsettings.Function, self.Enabled)
		end
		
		toggle.MouseEnter:Connect(function()
			hovered = true
			if not optionapi.Enabled then
				tween:Tween(knobholder, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.37)
				})
			end
		end)
		toggle.MouseLeave:Connect(function()
			hovered = false
			if not optionapi.Enabled then
				tween:Tween(knobholder, uipallet.Tween, {
					BackgroundColor3 = color.Light(uipallet.Main, 0.14)
				})
			end
		end)
		toggle.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		
		if optionsettings.Default then
			optionapi:Toggle()
		end
		optionapi.Object = toggle
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	TwoSlider = function(optionsettings, children, api)
		local optionapi = {
			Type = 'TwoSlider',
			ValueMin = optionsettings.DefaultMin or optionsettings.Min,
			ValueMax = optionsettings.DefaultMax or 10,
			Max = optionsettings.Max,
			Default = {
				Min = optionsettings.DefaultMin or optionsettings.Min,
				Max = optionsettings.DefaultMax or 10
			},
			Index = getTableSize(api.Options)
		}
		
		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.new(1, 0, 0, 50)
		slider.BackgroundColor3 = color.Dark(children.BackgroundColor3, optionsettings.Darker and 0.02 or 0)
		slider.BorderSizePixel = 0
		slider.AutoButtonColor = false
		slider.Visible = optionsettings.Visible == nil or optionsettings.Visible
		slider.Text = ''
		slider.Parent = children
		addTooltip(slider, optionsettings.Tooltip)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local valuebutton = Instance.new('TextButton')
		valuebutton.Name = 'Value'
		valuebutton.Size = UDim2.fromOffset(60, 15)
		valuebutton.Position = UDim2.new(1, -69, 0, 9)
		valuebutton.BackgroundTransparency = 1
		valuebutton.Text = optionapi.ValueMax
		valuebutton.TextXAlignment = Enum.TextXAlignment.Right
		valuebutton.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebutton.TextSize = 11
		valuebutton.FontFace = uipallet.Font
		valuebutton.Parent = slider
		local valuebutton2 = valuebutton:Clone()
		valuebutton2.Position = UDim2.new(1, -125, 0, 9)
		valuebutton2.Text = optionapi.ValueMin
		valuebutton2.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = valuebutton.Size
		valuebox.Position = valuebutton.Position
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = optionapi.ValueMin
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = false
		valuebox.Parent = slider
		local valuebox2 = valuebox:Clone()
		valuebox2.Position = valuebutton2.Position
		valuebox2.Parent = slider
		local bkg = Instance.new('Frame')
		bkg.Name = 'Slider'
		bkg.Size = UDim2.new(1, -20, 0, 2)
		bkg.Position = UDim2.fromOffset(10, 37)
		bkg.BackgroundColor3 = color.Light(uipallet.Main, 0.034)
		bkg.BorderSizePixel = 0
		bkg.Parent = slider
		local fill = bkg:Clone()
		fill.Name = 'Fill'
		fill.Position = UDim2.fromScale(math.clamp(optionapi.ValueMin / optionsettings.Max, 0.04, 0.96), 0)
		fill.Size = UDim2.fromScale(math.clamp(math.clamp(optionapi.ValueMax / optionsettings.Max, 0, 1), 0.04, 0.96) - fill.Position.X.Scale, 1)
		fill.BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
		fill.Parent = bkg
		local knobholder = Instance.new('Frame')
		knobholder.Name = 'Knob'
		knobholder.Size = UDim2.fromOffset(16, 4)
		knobholder.Position = UDim2.fromScale(0, 0.5)
		knobholder.AnchorPoint = Vector2.new(0.5, 0.5)
		knobholder.BackgroundColor3 = slider.BackgroundColor3
		knobholder.BorderSizePixel = 0
		knobholder.Parent = fill
		local knob = Instance.new('ImageLabel')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(9, 16)
		knob.Position = UDim2.fromScale(0.5, 0.5)
		knob.AnchorPoint = Vector2.new(0.5, 0.5)
		knob.BackgroundTransparency = 1
		knob.Image = getcustomasset('aerov4/assets/new/range.png')
		knob.ImageColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
		knob.Parent = knobholder
		local knobholdermax = knobholder:Clone()
		knobholdermax.Name = 'KnobMax'
		knobholdermax.Position = UDim2.fromScale(1, 0.5)
		knobholdermax.Parent = fill
		knobholdermax.Knob.Rotation = 180
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow.Size = UDim2.fromOffset(12, 6)
		arrow.Position = UDim2.new(1, -56, 0, 10)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('aerov4/assets/new/rangearrow.png')
		arrow.ImageColor3 = color.Light(uipallet.Main, 0.14)
		arrow.Parent = slider
		optionsettings.Function = optionsettings.Function or function() end
		optionsettings.Decimal = optionsettings.Decimal or 1
		local random = Random.new()
		
		function optionapi:Save(tab)
			tab[optionsettings.Name] = {ValueMin = self.ValueMin, ValueMax = self.ValueMax}
		end
		
		function optionapi:Load(tab)
			if self.ValueMin ~= tab.ValueMin then
				self:SetValue(false, tab.ValueMin)
			end
			if self.ValueMax ~= tab.ValueMax then
				self:SetValue(true, tab.ValueMax)
			end
		end
		
		function optionapi:Color(hue, sat, val, rainbowcheck)
			fill.BackgroundColor3 = rainbowcheck and Color3.fromHSV(mainapi:Color((hue - (self.Index * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
			knob.ImageColor3 = fill.BackgroundColor3
			knobholdermax.Knob.ImageColor3 = fill.BackgroundColor3
		end
		
		function optionapi:GetRandomValue()
			return random:NextNumber(optionapi.ValueMin, optionapi.ValueMax)
		end
		
		function optionapi:SetValue(max, value)
			if tonumber(value) == math.huge or value ~= value then return end
			self[max and 'ValueMax' or 'ValueMin'] = value
			valuebutton.Text = self.ValueMax
			valuebutton2.Text = self.ValueMin
			local size = math.clamp(math.clamp(self.ValueMin / optionsettings.Max, 0, 1), 0.04, 0.96)
			tween:Tween(fill, TweenInfo.new(0.1), {
				Position = UDim2.fromScale(size, 0),
				Size = UDim2.fromScale(math.clamp(math.clamp(math.clamp(self.ValueMax / optionsettings.Max, 0.04, 0.96), 0.04, 0.96) - size, 0, 1), 1)
			})
		end
		
		knobholder.MouseEnter:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(11, 18)
			})
		end)
		knobholder.MouseLeave:Connect(function()
			tween:Tween(knob, uipallet.Tween, {
				Size = UDim2.fromOffset(9, 16)
			})
		end)
		knobholdermax.MouseEnter:Connect(function()
			tween:Tween(knobholdermax.Knob, uipallet.Tween, {
				Size = UDim2.fromOffset(11, 18)
			})
		end)
		knobholdermax.MouseLeave:Connect(function()
			tween:Tween(knobholdermax.Knob, uipallet.Tween, {
				Size = UDim2.fromOffset(9, 16)
			})
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local maxCheck = (inputObj.Position.X - knobholdermax.AbsolutePosition.X) > -10
				local newPosition = math.clamp((inputObj.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
				optionapi:SetValue(maxCheck, math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
		
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						local newPosition = math.clamp((input.Position.X - bkg.AbsolutePosition.X) / bkg.AbsoluteSize.X, 0, 1)
						optionapi:SetValue(maxCheck, math.floor((optionsettings.Min + (optionsettings.Max - optionsettings.Min) * newPosition) * optionsettings.Decimal) / optionsettings.Decimal, newPosition)
					end
				end)
		
				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
			end
		end)
		valuebutton.MouseButton1Click:Connect(function()
			valuebutton.Visible = false
			valuebox.Visible = true
			valuebox.Text = optionapi.ValueMax
			valuebox:CaptureFocus()
		end)
		valuebutton2.MouseButton1Click:Connect(function()
			valuebutton2.Visible = false
			valuebox2.Visible = true
			valuebox2.Text = optionapi.ValueMin
			valuebox2:CaptureFocus()
		end)
		valuebox.FocusLost:Connect(function(enter)
			valuebutton.Visible = true
			valuebox.Visible = false
			if enter and tonumber(valuebox.Text) then
				optionapi:SetValue(true, tonumber(valuebox.Text))
			end
		end)
		valuebox2.FocusLost:Connect(function(enter)
			valuebutton2.Visible = true
			valuebox2.Visible = false
			if enter and tonumber(valuebox2.Text) then
				optionapi:SetValue(false, tonumber(valuebox2.Text))
			end
		end)
		
		optionapi.Object = slider
		api.Options[optionsettings.Name] = optionapi
		
		return optionapi
	end,
	Divider = function(children, text)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		divider.BorderSizePixel = 0
		divider.Parent = children
		if text then
			local label = Instance.new('TextLabel')
			label.Name = 'DividerLabel'
			label.Size = UDim2.fromOffset(218, 27)
			label.BackgroundTransparency = 1
			label.Text = '          '..text:upper()
			label.TextXAlignment = Enum.TextXAlignment.Left
			label.TextColor3 = color.Dark(uipallet.Text, 0.43)
			label.TextSize = 9
			label.FontFace = uipallet.Font
			label.Parent = children
			divider.Position = UDim2.fromOffset(0, 26)
			divider.Parent = label
		end
	end
}

mainapi.Components = setmetatable(components, {
	__newindex = function(self, ind, func)
		for _, v in mainapi.Modules do
			rawset(v, 'Create'..ind, function(_, settings)
				return func(settings, v.Children, v)
			end)
		end

		if mainapi.Legit then
			for _, v in mainapi.Legit.Modules do
				rawset(v, 'Create'..ind, function(_, settings)
					return func(settings, v.Children, v)
				end)
			end
		end

		rawset(self, ind, func)
	end
})

task.spawn(function()
	repeat
		local hue = tick() * (0.2 * mainapi.RainbowSpeed.Value) % 1
		for _, v in mainapi.RainbowTable do
			if v.Type == 'GUISlider' then
				v:SetValue(mainapi:Color(hue))
			else
				v:SetValue(hue)
			end
		end
		task.wait(1 / mainapi.RainbowUpdateSpeed.Value)
	until mainapi.Loaded == nil
end)

function mainapi:BlurCheck()
	if self.ThreadFix then
		setthreadidentity(8)
		runService:SetRobloxGuiFocused((clickgui.Visible or guiService:GetErrorType() ~= Enum.ConnectionError.OK) and self.Blur.Enabled)
	end
end

addMaid(mainapi)

function mainapi:CreateGUI()
	local categoryapi = {
		Type = 'MainWindow',
		Buttons = {},
		Options = {}
	}

	local window = Instance.new('TextButton')
	window.Name = 'GUICategory'
	window.Position = UDim2.fromOffset(6, 60)
	window.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	window.AutoButtonColor = false
	window.Text = ''
	window.Parent = clickgui
	addBlur(window)
	addCorner(window)
	makeDraggable(window)
	local logo = Instance.new('ImageLabel')
	logo.Name = 'VapeLogo'
	logo.Size = UDim2.fromOffset(62, 18)
	logo.Position = UDim2.fromOffset(11, 10)
	logo.BackgroundTransparency = 1
	logo.Image = getcustomasset('aerov4/assets/new/guivape.png')
	logo.ImageColor3 = select(3, uipallet.Main:ToHSV()) > 0.5 and uipallet.Text or Color3.new(1, 1, 1)
	logo.Parent = window
	local logov4 = Instance.new('ImageLabel')
	logov4.Name = 'V4Logo'
	logov4.Size = UDim2.fromOffset(28, 16)
	logov4.Position = UDim2.new(1, 1, 0, 1)
	logov4.BackgroundTransparency = 1
	logov4.Image = getcustomasset('aerov4/assets/new/guiv4.png')
	logov4.Parent = logo
	local children = Instance.new('Frame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -33)
	children.Position = UDim2.fromOffset(0, 37)
	children.BackgroundTransparency = 1
	children.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	local settingsbutton = Instance.new('TextButton')
	settingsbutton.Name = 'Settings'
	settingsbutton.Size = UDim2.fromOffset(40, 40)
	settingsbutton.Position = UDim2.new(1, -40, 0, 0)
	settingsbutton.BackgroundTransparency = 1
	settingsbutton.Text = ''
	settingsbutton.Parent = window
	addTooltip(settingsbutton, 'Open settings')
	local settingsicon = Instance.new('ImageLabel')
	settingsicon.Size = UDim2.fromOffset(14, 14)
	settingsicon.Position = UDim2.fromOffset(15, 12)
	settingsicon.BackgroundTransparency = 1
	settingsicon.Image = getcustomasset('aerov4/assets/new/guisettings.png')
	settingsicon.ImageColor3 = color.Light(uipallet.Main, 0.37)
	settingsicon.Parent = settingsbutton
	local settingspane = Instance.new('TextButton')
	settingspane.Size = UDim2.fromScale(1, 1)
	settingspane.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	settingspane.AutoButtonColor = false
	settingspane.Visible = false
	settingspane.Text = ''
	settingspane.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -36, 0, 20)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11)
	title.BackgroundTransparency = 1
	title.Text = 'Settings'
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = settingspane
	local close = addCloseButton(settingspane)
	local back = Instance.new('ImageButton')
	back.Name = 'Back'
	back.Size = UDim2.fromOffset(16, 16)
	back.Position = UDim2.fromOffset(11, 13)
	back.BackgroundTransparency = 1
	back.Image = getcustomasset('aerov4/assets/new/back.png')
	back.ImageColor3 = color.Light(uipallet.Main, 0.37)
	back.Parent = settingspane
	local settingsversion = Instance.new('TextLabel')
	settingsversion.Name = 'Version'
	settingsversion.Size = UDim2.new(1, 0, 0, 16)
	settingsversion.Position = UDim2.new(0, 0, 1, -16)
	settingsversion.BackgroundTransparency = 1
	settingsversion.Text = 'Vape '..mainapi.Version..' '..(
		isfile('aerov4/profiles/commit.txt') and readfile('aerov4/profiles/commit.txt'):sub(1, 6) or ''
	)..' '
	settingsversion.TextColor3 = color.Dark(uipallet.Text, 0.43)
	settingsversion.TextXAlignment = Enum.TextXAlignment.Right
	settingsversion.TextSize = 10
	settingsversion.FontFace = uipallet.Font
	settingsversion.Parent = settingspane
	addCorner(settingspane)
	local settingschildren = Instance.new('Frame')
	settingschildren.Name = 'Children'
	settingschildren.Size = UDim2.new(1, 0, 1, -57)
	settingschildren.Position = UDim2.fromOffset(0, 41)
	settingschildren.BackgroundColor3 = uipallet.Main
	settingschildren.BorderSizePixel = 0
	settingschildren.Parent = settingspane
	local settingswindowlist = Instance.new('UIListLayout')
	settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
	settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	settingswindowlist.Parent = settingschildren
	categoryapi.Object = window

	function categoryapi:CreateBind()
		local optionapi = {Bind = {'RightShift'}}

		local button = Instance.new('TextButton')
		button.Size = UDim2.fromOffset(220, 40)
		button.BackgroundColor3 = uipallet.Main
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = '          Rebind GUI'
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.16)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = settingschildren
		addTooltip(button, 'Change the bind of the GUI')
		local bind = Instance.new('TextButton')
		bind.Name = 'Bind'
		bind.Size = UDim2.fromOffset(20, 21)
		bind.Position = UDim2.new(1, -10, 0, 9)
		bind.AnchorPoint = Vector2.new(1, 0)
		bind.BackgroundColor3 = Color3.new(1, 1, 1)
		bind.BackgroundTransparency = 0.92
		bind.BorderSizePixel = 0
		bind.AutoButtonColor = false
		bind.Text = ''
		bind.Parent = button
		addTooltip(bind, 'Click to bind')
		addCorner(bind, UDim.new(0, 4))
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = UDim2.fromOffset(12, 12)
		icon.Position = UDim2.new(0.5, -6, 0, 5)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('aerov4/assets/new/bind.png')
		icon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		icon.Parent = bind
		local label = Instance.new('TextLabel')
		label.Name = 'Text'
		label.Size = UDim2.fromScale(1, 1)
		label.Position = UDim2.fromOffset(0, 1)
		label.BackgroundTransparency = 1
		label.Visible = false
		label.Text = ''
		label.TextColor3 = color.Dark(uipallet.Text, 0.43)
		label.TextSize = 12
		label.FontFace = uipallet.Font
		label.Parent = bind

		function optionapi:SetBind(tab)
			if not tab then return end
			mainapi.Keybind = #tab <= 0 and mainapi.Keybind or table.clone(tab)
			self.Bind = mainapi.Keybind
			if mainapi.VapeButton then
				mainapi.VapeButton:Destroy()
				mainapi.VapeButton = nil
			end

			bind.Visible = true
			label.Visible = true
			icon.Visible = false
			label.Text = table.concat(mainapi.Keybind, ' + '):upper()
			bind.Size = UDim2.fromOffset(math.max(getfontsize(label.Text, label.TextSize, label.Font).X + 10, 20), 21)
		end

		bind.MouseEnter:Connect(function()
			label.Visible = false
			icon.Visible = not label.Visible
			icon.Image = getcustomasset('aerov4/assets/new/edit.png')
			icon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
		end)
		bind.MouseLeave:Connect(function()
			label.Visible = true
			icon.Visible = not label.Visible
			icon.Image = getcustomasset('aerov4/assets/new/bind.png')
			icon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		end)
		bind.MouseButton1Click:Connect(function()
			mainapi.Binding = optionapi
		end)

		categoryapi.Options.Bind = optionapi

		return optionapi
	end

	function categoryapi:CreateButton(categorysettings)
		local btnHovered = false
		local optionapi = {
			Enabled = false,
			Index = getTableSize(categoryapi.Buttons)
		}

		local button = Instance.new('TextButton')
		button.Name = categorysettings.Name
		button.Size = UDim2.fromOffset(220, 40)
		button.BackgroundColor3 = uipallet.Main
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = (categorysettings.Icon and '                                 ' or '             ')..categorysettings.Name
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.16)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = children
		local icon
		if categorysettings.Icon then
			icon = Instance.new('ImageLabel')
			icon.Name = 'Icon'
			icon.Size = categorysettings.Size
			icon.Position = UDim2.fromOffset(13, 13)
			icon.BackgroundTransparency = 1
			icon.Image = categorysettings.Icon
			icon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
			icon.Parent = button
		end
		if categorysettings.Name == 'Profiles' then
			local label = Instance.new('TextLabel')
			label.Name = 'ProfileLabel'
			label.Size = UDim2.fromOffset(53, 24)
			label.Position = UDim2.new(1, -36, 0, 8)
			label.AnchorPoint = Vector2.new(1, 0)
			label.BackgroundColor3 = color.Light(uipallet.Main, 0.04)
			label.Text = 'default'
			label.TextColor3 = color.Dark(uipallet.Text, 0.29)
			label.TextSize = 12
			label.FontFace = uipallet.Font
			label.Parent = button
			addCorner(label)
			mainapi.ProfileLabel = label
		end
		local accent
		if categorysettings.Icon then
			accent = Instance.new('Frame')
			accent.Name = 'Accent'
			accent.AnchorPoint = Vector2.new(0, 0.5)
			accent.Size = UDim2.fromOffset(3, 0)
			accent.Position = UDim2.new(0, 6, 0.5, 0)
			accent.BorderSizePixel = 0
			accent.Visible = true
			accent.BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
			accent.Parent = button
			local accentcorner = Instance.new('UICorner')
			accentcorner.CornerRadius = UDim.new(1, 0)
			accentcorner.Parent = accent
		end
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow.Size = UDim2.fromOffset(4, 8)
		arrow.Position = UDim2.new(1, -20, 0, 16)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('aerov4/assets/new/expandright.png')
		arrow.ImageColor3 = color.Light(uipallet.Main, 0.37)
		arrow.Parent = button
		optionapi.Name = categorysettings.Name
		optionapi.Icon = icon
		optionapi.Accent = accent
		optionapi.Object = button

		function optionapi:Toggle()
			self.Enabled = not self.Enabled
			tween:Tween(arrow, uipallet.Tween, {
				Position = UDim2.new(1, self.Enabled and -14 or -20, 0, 16)
			})
			button.TextColor3 = self.Enabled and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or (btnHovered and uipallet.Text or color.Dark(uipallet.Text, 0.16))
			if icon then
				icon.ImageColor3 = button.TextColor3
			end
			if accent then
				accent.BackgroundColor3 = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
				tween:Tween(accent, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.fromOffset(4, self.Enabled and 22 or (btnHovered and 10 or 0))
				})
			end
			button.BackgroundColor3 = (self.Enabled or btnHovered) and color.Light(uipallet.Main, 0.02) or uipallet.Main
			categorysettings.Window.Visible = self.Enabled
		end

		button.MouseEnter:Connect(function()
			btnHovered = true
			if not optionapi.Enabled then
				local guiColor = Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
				button.TextColor3 = guiColor:Lerp(uipallet.Text, 0.35)
				if icon then icon.ImageColor3 = button.TextColor3 end
				button.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				if accent then
					accent.BackgroundColor3 = guiColor
					tween:Tween(accent, uipallet.Tween, {Size = UDim2.fromOffset(4, 10)})
				end
			end
		end)
		button.MouseLeave:Connect(function()
			btnHovered = false
			if not optionapi.Enabled then
				button.TextColor3 = color.Dark(uipallet.Text, 0.16)
				if icon then icon.ImageColor3 = color.Dark(uipallet.Text, 0.16) end
				button.BackgroundColor3 = uipallet.Main
				if accent then
					tween:Tween(accent, uipallet.Tween, {Size = UDim2.fromOffset(4, 0)})
				end
			end
		end)
		button.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)

		categoryapi.Buttons[categorysettings.Name] = optionapi

		return optionapi
	end

	function categoryapi:CreateDivider(text)
		return components.Divider(children, text)
	end

	function categoryapi:CreateOverlayBar()
		local optionapi = {Toggles = {}}

		local bar = Instance.new('Frame')
		bar.Name = 'Overlays'
		bar.Size = UDim2.fromOffset(220, 36)
		bar.BackgroundColor3 = uipallet.Main
		bar.BorderSizePixel = 0
		bar.Parent = children
		components.Divider(bar)
		local button = Instance.new('ImageButton')
		button.Size = UDim2.fromOffset(24, 24)
		button.Position = UDim2.new(1, -29, 0, 7)
		button.BackgroundTransparency = 1
		button.AutoButtonColor = false
		button.Image = getcustomasset('aerov4/assets/new/overlaysicon.png')
		button.ImageColor3 = color.Light(uipallet.Main, 0.37)
		button.Parent = bar
		addCorner(button, UDim.new(1, 0))
		addTooltip(button, 'Open overlays menu')
		local shadow = Instance.new('TextButton')
		shadow.Name = 'Shadow'
		shadow.Size = UDim2.new(1, 0, 1, -5)
		shadow.BackgroundColor3 = Color3.new()
		shadow.BackgroundTransparency = 1
		shadow.AutoButtonColor = false
		shadow.ClipsDescendants = true
		shadow.Visible = false
		shadow.Text = ''
		shadow.Parent = window
		addCorner(shadow)
		local window = Instance.new('Frame')
		window.Size = UDim2.fromOffset(220, 42)
		window.Position = UDim2.fromScale(0, 1)
		window.BackgroundColor3 = uipallet.Main
		window.Parent = shadow
		addCorner(window)
		local icon = Instance.new('ImageLabel')
		icon.Name = 'Icon'
		icon.Size = UDim2.fromOffset(14, 12)
		icon.Position = UDim2.fromOffset(10, 13)
		icon.BackgroundTransparency = 1
		icon.Image = getcustomasset('aerov4/assets/new/overlaystab.png')
		icon.ImageColor3 = uipallet.Text
		icon.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 38)
		title.Position = UDim2.fromOffset(36, 0)
		title.BackgroundTransparency = 1
		title.Text = 'Overlays'
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 15
		title.FontFace = uipallet.Font
		title.Parent = window
		local close = addCloseButton(window, 7)
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.Position = UDim2.fromOffset(0, 37)
		divider.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		divider.BorderSizePixel = 0
		divider.Parent = window
		local childrentoggle = Instance.new('Frame')
		childrentoggle.Position = UDim2.fromOffset(0, 38)
		childrentoggle.BackgroundTransparency = 1
		childrentoggle.Parent = window
		local windowlist = Instance.new('UIListLayout')
		windowlist.SortOrder = Enum.SortOrder.LayoutOrder
		windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		windowlist.Parent = childrentoggle

		function optionapi:CreateToggle(togglesettings)
			local toggleapi = {
				Enabled = false,
				Index = getTableSize(optionapi.Toggles)
			}

			local hovered = false
			local toggle = Instance.new('TextButton')
			toggle.Name = togglesettings.Name..'Toggle'
			toggle.Size = UDim2.new(1, 0, 0, 40)
			toggle.BackgroundTransparency = 1
			toggle.AutoButtonColor = false
			toggle.Text = string.rep(' ', 33 * scale.Scale)..togglesettings.Name
			toggle.TextXAlignment = Enum.TextXAlignment.Left
			toggle.TextColor3 = color.Dark(uipallet.Text, 0.16)
			toggle.TextSize = 14
			toggle.FontFace = uipallet.Font
			toggle.Parent = childrentoggle
			local icon = Instance.new('ImageLabel')
			icon.Name = 'Icon'
			icon.Size = togglesettings.Size
			icon.Position = togglesettings.Position
			icon.BackgroundTransparency = 1
			icon.Image = togglesettings.Icon
			icon.ImageColor3 = uipallet.Text
			icon.Parent = toggle
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(22, 12)
			knob.Position = UDim2.new(1, -30, 0, 14)
			knob.BackgroundColor3 = color.Light(uipallet.Main, 0.14)
			knob.Parent = toggle
			addCorner(knob, UDim.new(1, 0))
			local knobmain = knob:Clone()
			knobmain.Size = UDim2.fromOffset(8, 8)
			knobmain.Position = UDim2.fromOffset(2, 2)
			knobmain.BackgroundColor3 = uipallet.Main
			knobmain.Parent = knob
			toggleapi.Object = toggle

			function toggleapi:Toggle()
				self.Enabled = not self.Enabled
				tween:Tween(knob, uipallet.Tween, {
					BackgroundColor3 = self.Enabled and Color3.fromHSV(
						mainapi.GUIColor.Hue,
						mainapi.GUIColor.Sat,
						mainapi.GUIColor.Value
					) or (hovered and color.Light(uipallet.Main, 0.37) or color.Light(uipallet.Main, 0.14))
				})
				tween:Tween(knobmain, uipallet.Tween, {
					Position = UDim2.fromOffset(self.Enabled and 12 or 2, 2)
				})
				togglesettings.Function(self.Enabled)
			end

			scale:GetPropertyChangedSignal('Scale'):Connect(function()
				toggle.Text = string.rep(' ', 33 * scale.Scale)..togglesettings.Name
			end)
			toggle.MouseEnter:Connect(function()
				hovered = true
				if not toggleapi.Enabled then
					tween:Tween(knob, uipallet.Tween, {
						BackgroundColor3 = color.Light(uipallet.Main, 0.37)
					})
				end
			end)
			toggle.MouseLeave:Connect(function()
				hovered = false
				if not toggleapi.Enabled then
					tween:Tween(knob, uipallet.Tween, {
						BackgroundColor3 = color.Light(uipallet.Main, 0.14)
					})
				end
			end)
			toggle.MouseButton1Click:Connect(function()
				toggleapi:Toggle()
			end)

			table.insert(optionapi.Toggles, toggleapi)

			return toggleapi
		end

		button.MouseEnter:Connect(function()
			button.ImageColor3 = uipallet.Text
			tween:Tween(button, uipallet.Tween, {
				BackgroundTransparency = 0.9
			})
		end)
		button.MouseLeave:Connect(function()
			button.ImageColor3 = color.Light(uipallet.Main, 0.37)
			tween:Tween(button, uipallet.Tween, {
				BackgroundTransparency = 1
			})
		end)
		button.MouseButton1Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.new(0, 0, 1, -(window.Size.Y.Offset))
			})
		end)
		close.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.fromScale(0, 1)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		shadow.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(window, uipallet.Tween, {
				Position = UDim2.fromScale(0, 1)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if setthreadidentity then setthreadidentity(8) end
			window.Size = UDim2.fromOffset(220, math.min(37 + windowlist.AbsoluteContentSize.Y / scale.Scale, 605))
			childrentoggle.Size = UDim2.fromOffset(220, window.Size.Y.Offset - 5)
		end)

		mainapi.Overlays = optionapi

		return optionapi
	end

	function categoryapi:CreateSettingsDivider()
		components.Divider(settingschildren)
	end

	function categoryapi:CreateSettingsPane(categorysettings)
		local optionapi = {}

		local button = Instance.new('TextButton')
		button.Name = categorysettings.Name
		button.Size = UDim2.fromOffset(220, 40)
		button.BackgroundColor3 = uipallet.Main
		button.BorderSizePixel = 0
		button.AutoButtonColor = false
		button.Text = '          '..categorysettings.Name
		button.TextXAlignment = Enum.TextXAlignment.Left
		button.TextColor3 = color.Dark(uipallet.Text, 0.16)
		button.TextSize = 14
		button.FontFace = uipallet.Font
		button.Parent = settingschildren
		local arrow = Instance.new('ImageLabel')
		arrow.Name = 'Arrow'
		arrow.Size = UDim2.fromOffset(4, 8)
		arrow.Position = UDim2.new(1, -20, 0, 16)
		arrow.BackgroundTransparency = 1
		arrow.Image = getcustomasset('aerov4/assets/new/expandright.png')
		arrow.ImageColor3 = color.Light(uipallet.Main, 0.37)
		arrow.Parent = button
		local settingspane = Instance.new('TextButton')
		settingspane.Size = UDim2.fromScale(1, 1)
		settingspane.BackgroundColor3 = uipallet.Main
		settingspane.AutoButtonColor = false
		settingspane.Visible = false
		settingspane.Text = ''
		settingspane.Parent = window
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -36, 0, 20)
		title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 11)
		title.BackgroundTransparency = 1
		title.Text = categorysettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = uipallet.Text
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = settingspane
		local close = addCloseButton(settingspane)
		local back = Instance.new('ImageButton')
		back.Name = 'Back'
		back.Size = UDim2.fromOffset(16, 16)
		back.Position = UDim2.fromOffset(11, 13)
		back.BackgroundTransparency = 1
		back.Image = getcustomasset('aerov4/assets/new/back.png')
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		back.Parent = settingspane
		addCorner(settingspane)
		local settingschildren = Instance.new('Frame')
		settingschildren.Name = 'Children'
		settingschildren.Size = UDim2.new(1, 0, 1, -57)
		settingschildren.Position = UDim2.fromOffset(0, 41)
		settingschildren.BackgroundColor3 = uipallet.Main
		settingschildren.BorderSizePixel = 0
		settingschildren.Parent = settingspane
		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.BackgroundColor3 = Color3.new(1, 1, 1)
		divider.BackgroundTransparency = 0.928
		divider.BorderSizePixel = 0
		divider.Parent = settingschildren
		local settingswindowlist = Instance.new('UIListLayout')
		settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
		settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		settingswindowlist.Parent = settingschildren

		for i, v in components do
			optionapi['Create'..i] = function(_, settings)
				return v(settings, settingschildren, categoryapi)
			end
		end

		back.MouseEnter:Connect(function()
			back.ImageColor3 = uipallet.Text
		end)
		back.MouseLeave:Connect(function()
			back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end)
		back.MouseButton1Click:Connect(function()
			settingspane.Visible = false
		end)
		button.MouseEnter:Connect(function()
			button.TextColor3 = uipallet.Text
			button.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		end)
		button.MouseLeave:Connect(function()
			button.TextColor3 = color.Dark(uipallet.Text, 0.16)
			button.BackgroundColor3 = uipallet.Main
		end)
		button.MouseButton1Click:Connect(function()
			settingspane.Visible = true
		end)
		close.MouseButton1Click:Connect(function()
			settingspane.Visible = false
		end)
		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			window.Size = UDim2.fromOffset(220, 45 + windowlist.AbsoluteContentSize.Y / scale.Scale)
			for _, v in categoryapi.Buttons do
				if v.Icon then
					v.Object.Text = string.rep(' ', 33 * scale.Scale)..v.Name
				end
			end
		end)

		return optionapi
	end

	function categoryapi:CreateGUISlider(optionsettings)
		local optionapi = {
			Type = 'GUISlider',
			Notch = 4,
			Hue = 0.46,
			Sat = 0.96,
			Value = 0.52,
			Rainbow = false,
			CustomColor = false
		}
		local slidercolors = {
			Color3.fromRGB(250, 50, 56),
			Color3.fromRGB(242, 99, 33),
			Color3.fromRGB(252, 179, 22),
			Color3.fromRGB(5, 133, 104),
			Color3.fromRGB(47, 122, 229),
			Color3.fromRGB(126, 84, 217),
			Color3.fromRGB(255, 255, 255)
		}
		local slidercolorpos = {
			4,
			33,
			62,
			90,
			119,
			148,
			177
		}

		local function createSlider(name, gradientColor)
			local slider = Instance.new('TextButton')
			slider.Name = optionsettings.Name..'Slider'..name
			slider.Size = UDim2.fromOffset(220, 50)
			slider.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			slider.BorderSizePixel = 0
			slider.AutoButtonColor = false
			slider.Visible = false
			slider.Text = ''
			slider.Parent = settingschildren
			local title = Instance.new('TextLabel')
			title.Name = 'Title'
			title.Size = UDim2.fromOffset(60, 30)
			title.Position = UDim2.fromOffset(10, 2)
			title.BackgroundTransparency = 1
			title.Text = name
			title.TextXAlignment = Enum.TextXAlignment.Left
			title.TextColor3 = color.Dark(uipallet.Text, 0.16)
			title.TextSize = 11
			title.FontFace = uipallet.Font
			title.Parent = slider
			local holder = Instance.new('Frame')
			holder.Name = 'Slider'
			holder.Size = UDim2.fromOffset(200, 2)
			holder.Position = UDim2.fromOffset(10, 37)
			holder.BackgroundColor3 = Color3.new(1, 1, 1)
			holder.BorderSizePixel = 0
			holder.Parent = slider
			local uigradient = Instance.new('UIGradient')
			uigradient.Color = gradientColor
			uigradient.Parent = holder
			local fill = holder:Clone()
			fill.Name = 'Fill'
			fill.Size = UDim2.fromScale(math.clamp(1, 0.04, 0.96), 1)
			fill.Position = UDim2.new()
			fill.BackgroundTransparency = 1
			fill.Parent = holder
			local knobframe = Instance.new('Frame')
			knobframe.Name = 'Knob'
			knobframe.Size = UDim2.fromOffset(24, 4)
			knobframe.Position = UDim2.fromScale(1, 0.5)
			knobframe.AnchorPoint = Vector2.new(0.5, 0.5)
			knobframe.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			knobframe.BorderSizePixel = 0
			knobframe.Parent = fill
			local knob = Instance.new('Frame')
			knob.Name = 'Knob'
			knob.Size = UDim2.fromOffset(14, 14)
			knob.Position = UDim2.fromScale(0.5, 0.5)
			knob.AnchorPoint = Vector2.new(0.5, 0.5)
			knob.BackgroundColor3 = uipallet.Text
			knob.Parent = knobframe
			addCorner(knob, UDim.new(1, 0))
			if name == 'Custom color' then
				local reset = Instance.new('TextButton')
				reset.Size = UDim2.fromOffset(45, 20)
				reset.Position = UDim2.new(1, -52, 0, 5)
				reset.BackgroundTransparency = 1
				reset.Text = 'RESET'
				reset.TextColor3 = color.Dark(uipallet.Text, 0.16)
				reset.TextSize = 11
				reset.FontFace = uipallet.Font
				reset.Parent = slider
				reset.MouseButton1Click:Connect(function()
					optionapi:SetValue(nil, nil, nil, 4)
				end)
			end

			slider.InputBegan:Connect(function(inputObj)
				if
					(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
					and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
				then
					local changed = inputService.InputChanged:Connect(function(input)
						if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
							local value = math.clamp((input.Position.X - holder.AbsolutePosition.X) / holder.AbsoluteSize.X, 0, 1)
							optionapi:SetValue(
								name == 'Custom color' and value or nil,
								name == 'Saturation' and value or nil,
								name == 'Vibrance' and value or nil,
								name == 'Opacity' and value or nil
							)
						end
					end)

					local ended
					ended = inputObj.Changed:Connect(function()
						if inputObj.UserInputState == Enum.UserInputState.End then
							if changed then
								changed:Disconnect()
							end
							if ended then
								ended:Disconnect()
							end
						end
					end)
				end
			end)
			slider.MouseEnter:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(16, 16)
				})
			end)
			slider.MouseLeave:Connect(function()
				tween:Tween(knob, uipallet.Tween, {
					Size = UDim2.fromOffset(14, 14)
				})
			end)

			return slider
		end

		local slider = Instance.new('TextButton')
		slider.Name = optionsettings.Name..'Slider'
		slider.Size = UDim2.fromOffset(220, 50)
		slider.BackgroundTransparency = 1
		slider.AutoButtonColor = false
		slider.Text = ''
		slider.Parent = settingschildren
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.fromOffset(60, 30)
		title.Position = UDim2.fromOffset(10, 2)
		title.BackgroundTransparency = 1
		title.Text = optionsettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.16)
		title.TextSize = 11
		title.FontFace = uipallet.Font
		title.Parent = slider
		local holder = Instance.new('Frame')
		holder.Name = 'Slider'
		holder.Size = UDim2.fromOffset(200, 2)
		holder.Position = UDim2.fromOffset(10, 37)
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.Parent = slider
		local colornum = 0
		for i, color in slidercolors do
			local colorframe = Instance.new('Frame')
			colorframe.Size = UDim2.fromOffset(27 + (((i + 1) % 2) == 0 and 1 or 0), 2)
			colorframe.Position = UDim2.fromOffset(colornum, 0)
			colorframe.BackgroundColor3 = color
			colorframe.BorderSizePixel = 0
			colorframe.Parent = holder
			colornum += (colorframe.Size.X.Offset + 1)
		end
		local preview = Instance.new('ImageButton')
		preview.Name = 'Preview'
		preview.Size = UDim2.fromOffset(12, 12)
		preview.Position = UDim2.new(1, -22, 0, 10)
		preview.BackgroundTransparency = 1
		preview.Image = getcustomasset('aerov4/assets/new/colorpreview.png')
		preview.ImageColor3 = Color3.fromHSV(optionapi.Hue, 1, 1)
		preview.Parent = slider
		local valuebox = Instance.new('TextBox')
		valuebox.Name = 'Box'
		valuebox.Size = UDim2.fromOffset(60, 15)
		valuebox.Position = UDim2.new(1, -69, 0, 9)
		valuebox.BackgroundTransparency = 1
		valuebox.Visible = false
		valuebox.Text = ''
		valuebox.TextXAlignment = Enum.TextXAlignment.Right
		valuebox.TextColor3 = color.Dark(uipallet.Text, 0.16)
		valuebox.TextSize = 11
		valuebox.FontFace = uipallet.Font
		valuebox.ClearTextOnFocus = true
		valuebox.Parent = slider
		local expandbutton = Instance.new('TextButton')
		expandbutton.Name = 'Expand'
		expandbutton.Size = UDim2.fromOffset(17, 13)
		expandbutton.Position = UDim2.new(0, getfontsize(title.Text, title.TextSize, title.Font).X + 11, 0, 7)
		expandbutton.BackgroundTransparency = 1
		expandbutton.Text = ''
		expandbutton.Parent = slider
		local expandicon = Instance.new('ImageLabel')
		expandicon.Name = 'Expand'
		expandicon.Size = UDim2.fromOffset(9, 5)
		expandicon.Position = UDim2.fromOffset(4, 4)
		expandicon.BackgroundTransparency = 1
		expandicon.Image = getcustomasset('aerov4/assets/new/expandicon.png')
		expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		expandicon.Parent = expandbutton
		local rainbow = Instance.new('TextButton')
		rainbow.Name = 'Rainbow'
		rainbow.Size = UDim2.fromOffset(12, 12)
		rainbow.Position = UDim2.new(1, -42, 0, 10)
		rainbow.BackgroundTransparency = 1
		rainbow.Text = ''
		rainbow.Parent = slider
		local rainbow1 = Instance.new('ImageLabel')
		rainbow1.Size = UDim2.fromOffset(12, 12)
		rainbow1.BackgroundTransparency = 1
		rainbow1.Image = getcustomasset('aerov4/assets/new/rainbow_1.png')
		rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
		rainbow1.Parent = rainbow
		local rainbow2 = rainbow1:Clone()
		rainbow2.Image = getcustomasset('aerov4/assets/new/rainbow_2.png')
		rainbow2.Parent = rainbow
		local rainbow3 = rainbow1:Clone()
		rainbow3.Image = getcustomasset('aerov4/assets/new/rainbow_3.png')
		rainbow3.Parent = rainbow
		local rainbow4 = rainbow1:Clone()
		rainbow4.Image = getcustomasset('aerov4/assets/new/rainbow_4.png')
		rainbow4.Parent = rainbow
		local knob = Instance.new('ImageLabel')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(26, 12)
		knob.Position = UDim2.fromOffset(slidercolorpos[4] - 3, -5)
		knob.BackgroundTransparency = 1
		knob.Image = getcustomasset('aerov4/assets/new/guislider.png')
		knob.ImageColor3 = slidercolors[4]
		knob.Parent = holder
		optionsettings.Function = optionsettings.Function or function() end
		local rainbowTable = {}
		for i = 0, 1, 0.1 do
			table.insert(rainbowTable, ColorSequenceKeypoint.new(i, Color3.fromHSV(i, 1, 1)))
		end
		local colorSlider = createSlider('Custom color', ColorSequence.new(rainbowTable))
		local satSlider = createSlider('Saturation', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, optionapi.Value)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, 1, optionapi.Value))
		}))
		local vibSlider = createSlider('Vibrance', ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromHSV(optionapi.Hue, optionapi.Sat, 1))
		}))
		local normalknob = getcustomasset('aerov4/assets/new/guislider.png')
		local rainbowknob = getcustomasset('aerov4/assets/new/guisliderrain.png')
		local rainbowthread

		function optionapi:Save(tab)
			tab[optionsettings.Name] = {
				Hue = self.Hue,
				Sat = self.Sat,
				Value = self.Value,
				Notch = self.Notch,
				CustomColor = self.CustomColor,
				Rainbow = self.Rainbow
			}
		end

		function optionapi:Load(tab)
			if tab.Rainbow then
				self:Toggle()
			end
			if self.Rainbow or tab.CustomColor then
				self:SetValue(tab.Hue, tab.Sat, tab.Value)
			else
				self:SetValue(nil, nil, nil, tab.Notch)
			end
		end

		function optionapi:SetValue(h, s, v, n)
			if n then
				if self.Rainbow then
					self:Toggle()
				end
				self.CustomColor = false
				h, s, v = slidercolors[n]:ToHSV()
			else
				self.CustomColor = true
			end

			self.Hue = h or self.Hue
			self.Sat = s or self.Sat
			self.Value = v or self.Value
			self.Notch = n
			preview.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
			satSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, self.Value)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, 1, self.Value))
			})
			vibSlider.Slider.UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromHSV(self.Hue, self.Sat, 1))
			})

			if self.Rainbow or self.CustomColor then
				knob.Image = rainbowknob
				knob.ImageColor3 = Color3.new(1, 1, 1)
				tween:Tween(knob, uipallet.Tween, {
					Position = UDim2.fromOffset(slidercolorpos[4] - 3, -5)
				})
			else
				knob.Image = normalknob
				knob.ImageColor3 = Color3.fromHSV(self.Hue, self.Sat, self.Value)
				tween:Tween(knob, uipallet.Tween, {
					Position = UDim2.fromOffset(slidercolorpos[n or 4] - 3, -5)
				})
			end

			if self.Rainbow then
				if h then
					colorSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
				end
				if s then
					satSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
				end
				if v then
					vibSlider.Slider.Fill.Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
				end
			else
				if h then
					tween:Tween(colorSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Hue, 0.04, 0.96), 1)
					})
				end
				if s then
					tween:Tween(satSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Sat, 0.04, 0.96), 1)
					})
				end
				if v then
					tween:Tween(vibSlider.Slider.Fill, uipallet.Tween, {
						Size = UDim2.fromScale(math.clamp(self.Value, 0.04, 0.96), 1)
					})
				end
			end
			safecall(optionsettings.Function, self.Hue, self.Sat, self.Value)
		end

		function optionapi:Toggle()
			self.Rainbow = not self.Rainbow
			if rainbowthread then
				task.cancel(rainbowthread)
			end

			if self.Rainbow then
				knob.Image = rainbowknob
				table.insert(mainapi.RainbowTable, self)

				rainbow1.ImageColor3 = Color3.fromRGB(5, 127, 100)
				rainbowthread = task.delay(0.1, function()
					rainbow2.ImageColor3 = Color3.fromRGB(228, 125, 43)
					rainbowthread = task.delay(0.1, function()
						rainbow3.ImageColor3 = Color3.fromRGB(225, 46, 52)
						rainbowthread = nil
					end)
				end)
			else
				self:SetValue(nil, nil, nil, 4)
				knob.Image = normalknob
				local ind = table.find(mainapi.RainbowTable, self)
				if ind then
					table.remove(mainapi.RainbowTable, ind)
				end

				rainbow3.ImageColor3 = color.Light(uipallet.Main, 0.37)
				rainbowthread = task.delay(0.1, function()
					rainbow2.ImageColor3 = color.Light(uipallet.Main, 0.37)
					rainbowthread = task.delay(0.1, function()
						rainbow1.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end)
				end)
			end
		end

		expandbutton.MouseEnter:Connect(function()
			expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
		end)
		expandbutton.MouseLeave:Connect(function()
			expandicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		end)
		expandbutton.MouseButton1Click:Connect(function()
			colorSlider.Visible = not colorSlider.Visible
			satSlider.Visible = colorSlider.Visible
			vibSlider.Visible = satSlider.Visible
			expandicon.Rotation = satSlider.Visible and 180 or 0
		end)
		preview.MouseButton1Click:Connect(function()
			preview.Visible = false
			valuebox.Visible = true
			valuebox:CaptureFocus()
			local text = Color3.fromHSV(optionapi.Hue, optionapi.Sat, optionapi.Value)
			valuebox.Text = math.round(text.R * 255)..', '..math.round(text.G * 255)..', '..math.round(text.B * 255)
		end)
		slider.InputBegan:Connect(function(inputObj)
			if
				(inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
				and (inputObj.Position.Y - slider.AbsolutePosition.Y) > (20 * scale.Scale)
			then
				local changed = inputService.InputChanged:Connect(function(input)
					if input.UserInputType == (inputObj.UserInputType == Enum.UserInputType.MouseButton1 and Enum.UserInputType.MouseMovement or Enum.UserInputType.Touch) then
						optionapi:SetValue(nil, nil, nil, math.clamp(math.round((input.Position.X - holder.AbsolutePosition.X) / scale.Scale / 27), 1, 7))
					end
				end)

				local ended
				ended = inputObj.Changed:Connect(function()
					if inputObj.UserInputState == Enum.UserInputState.End then
						if changed then
							changed:Disconnect()
						end
						if ended then
							ended:Disconnect()
						end
					end
				end)
				optionapi:SetValue(nil, nil, nil, math.clamp(math.round((inputObj.Position.X - holder.AbsolutePosition.X) / scale.Scale / 27), 1, 7))
			end
		end)
		rainbow.MouseButton1Click:Connect(function()
			optionapi:Toggle()
		end)
		valuebox.FocusLost:Connect(function(enter)
			preview.Visible = true
			valuebox.Visible = false
			if enter then
				local commas = valuebox.Text:split(',')
				local suc, res = pcall(function()
					return tonumber(commas[1]) and Color3.fromRGB(
						tonumber(commas[1]),
						tonumber(commas[2]),
						tonumber(commas[3])
					) or Color3.fromHex(valuebox.Text)
				end)

				if suc then
					if optionapi.Rainbow then
						optionapi:Toggle()
					end
					optionapi:SetValue(res:ToHSV())
				end
			end
		end)

		optionapi.Object = slider
		categoryapi.Options[optionsettings.Name] = optionapi

		return optionapi
	end

	back.MouseEnter:Connect(function()
		back.ImageColor3 = uipallet.Text
	end)
	back.MouseLeave:Connect(function()
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
	end)
	back.MouseButton1Click:Connect(function()
		settingspane.Visible = false
	end)
	close.MouseButton1Click:Connect(function()
		settingspane.Visible = false
	end)
	settingsbutton.MouseEnter:Connect(function()
		settingsicon.ImageColor3 = uipallet.Text
	end)
	settingsbutton.MouseLeave:Connect(function()
		settingsicon.ImageColor3 = color.Light(uipallet.Main, 0.37)
	end)
	settingsbutton.MouseButton1Click:Connect(function()
		settingspane.Visible = true
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		window.Size = UDim2.fromOffset(220, 42 + windowlist.AbsoluteContentSize.Y / scale.Scale)
		for _, v in categoryapi.Buttons do
			if v.Icon then
				v.Object.Text = string.rep(' ', 36 * scale.Scale)..v.Name
			end
		end
	end)

	self.Categories.Main = categoryapi

	return categoryapi
end

function mainapi:CreateCategory(categorysettings)
	local categoryapi = {
		Type = 'Category',
		Expanded = false
	}

	local window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'Category'
	window.Size = UDim2.fromOffset(220, 41)
	window.Position = UDim2.fromOffset(236, 60)
	window.BackgroundColor3 = uipallet.Main
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.Parent = clickgui
	addBlur(window)
	addCorner(window)
	makeDraggable(window)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 20 and 14 or 13))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -(categorysettings.Size.X.Offset > 18 and 40 or 33), 0, 41)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local arrowbutton = Instance.new('TextButton')
	arrowbutton.Name = 'Arrow'
	arrowbutton.Size = UDim2.fromOffset(40, 40)
	arrowbutton.Position = UDim2.new(1, -40, 0, 0)
	arrowbutton.BackgroundTransparency = 1
	arrowbutton.Text = ''
	arrowbutton.Parent = window
	local arrow = Instance.new('ImageLabel')
	arrow.Name = 'Arrow'
	arrow.Size = UDim2.fromOffset(9, 4)
	arrow.Position = UDim2.fromOffset(20, 18)
	arrow.BackgroundTransparency = 1
	arrow.Image = getcustomasset('aerov4/assets/new/expandup.png')
	arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	arrow.Rotation = 180
	arrow.Parent = arrowbutton
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -41)
	children.Position = UDim2.fromOffset(0, 37)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 2
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 37)
	divider.BackgroundColor3 = Color3.new(1, 1, 1)
	divider.BackgroundTransparency = 0.928
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children

	function categoryapi:CreateModule(modulesettings)
		mainapi:Remove(modulesettings.Name)
		if mainapi.ThreadFix then
			setthreadidentity(8)
		end

		local moduleapi = {
			Enabled = false,
			Options = {},
			Bind = {},
			Index = getTableSize(mainapi.Modules),
			ExtraText = modulesettings.ExtraText,
			Name = modulesettings.Name,
			Category = categorysettings.Name,
			KeybindMode = "Toggle", 
			HoldCount = 0       
		}

		local hovered = false
		local modulebutton = Instance.new('TextButton')
		modulebutton.Name = modulesettings.Name
		modulebutton.Size = UDim2.fromOffset(220, 40)
		modulebutton.BackgroundColor3 = uipallet.Main
		modulebutton.BorderSizePixel = 0
		modulebutton.AutoButtonColor = false
		modulebutton.Text = '            '..modulesettings.Name
		modulebutton.TextXAlignment = Enum.TextXAlignment.Left
		modulebutton.TextColor3 = color.Dark(uipallet.Text, 0.16)
		modulebutton.TextSize = 14
		modulebutton.FontFace = uipallet.Font
		modulebutton.Parent = children
		addTooltip(modulebutton, modulesettings.Tooltip or modulesettings.Name)

		local gradient = Instance.new('UIGradient')
		gradient.Rotation = 90
		gradient.Enabled = false
		gradient.Parent = modulebutton
		local modulechildren = Instance.new('Frame')
		local bind = Instance.new('TextButton')
		bind.Name = 'Bind'
		bind.Size = UDim2.fromOffset(20, 21)
		bind.Position = UDim2.new(1, -36, 0, 9)
		bind.AnchorPoint = Vector2.new(1, 0)
		bind.BackgroundColor3 = Color3.new(1, 1, 1)
		bind.BackgroundTransparency = 0.92
		bind.BorderSizePixel = 0
		bind.AutoButtonColor = false
		bind.Visible = false
		bind.Text = ''
		addCorner(bind, UDim.new(0, 4))
		local bindicon = Instance.new('ImageLabel')
		bindicon.Name = 'Icon'
		bindicon.Size = UDim2.fromOffset(12, 12)
		bindicon.Position = UDim2.new(0.5, -6, 0, 5)
		bindicon.BackgroundTransparency = 1
		bindicon.Image = getcustomasset('aerov4/assets/new/bind.png')
		bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		bindicon.Parent = bind
		local bindtext = Instance.new('TextLabel')
		bindtext.Size = UDim2.fromScale(1, 1)
		bindtext.Position = UDim2.fromOffset(0, 1)
		bindtext.BackgroundTransparency = 1
		bindtext.Visible = false
		bindtext.Text = ''
		bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)
		bindtext.TextSize = 12
		bindtext.FontFace = uipallet.Font
		bindtext.Parent = bind
		local bindcover = Instance.new('ImageLabel')
		bindcover.Name = 'Cover'
		bindcover.Size = UDim2.fromOffset(154, 40)
		bindcover.BackgroundTransparency = 1
		bindcover.Visible = false
		bindcover.Image = getcustomasset('aerov4/assets/new/bindbkg.png')
		bindcover.ScaleType = Enum.ScaleType.Slice
		bindcover.SliceCenter = Rect.new(0, 0, 141, 40)
		bindcover.Parent = modulebutton
		local bindcovertext = Instance.new('TextLabel')
		bindcovertext.Name = 'Text'
		bindcovertext.Size = UDim2.new(1, -10, 1, -3)
		bindcovertext.BackgroundTransparency = 1
		bindcovertext.Text = 'PRESS A KEY TO BIND'
		bindcovertext.TextColor3 = uipallet.Text
		bindcovertext.TextSize = 11
		bindcovertext.FontFace = uipallet.Font
		bindcovertext.Parent = bindcover
		bind.Parent = modulebutton
		local tooltipValue = Instance.new('StringValue')
		tooltipValue.Name = 'TooltipText'
		tooltipValue.Value = 'Click to bind | Right‑click to change mode (currently Toggle)'
		tooltipValue.Parent = bind
		bind.MouseEnter:Connect(function()
			tooltip.Text = tooltipValue.Value
			tooltip.Visible = true
			bindtext.Visible = false
			bindicon.Visible = true
			bindicon.Image = getcustomasset('aerov4/assets/new/edit.png')
			if not moduleapi.Enabled then bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.16) end
		end)
		bind.MouseLeave:Connect(function()
			tooltip.Visible = false
			bindtext.Visible = #moduleapi.Bind > 0
			bindicon.Visible = not bindtext.Visible
			bindicon.Image = getcustomasset('aerov4/assets/new/bind.png')
			if not moduleapi.Enabled then
				bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
			end
		end)

		local pinbutton = Instance.new('TextButton')
		pinbutton.Name = 'Favorite'
		pinbutton.Size = UDim2.fromOffset(20, 21)
		pinbutton.Position = UDim2.new(1, -60, 0, 9)
		pinbutton.AnchorPoint = Vector2.new(1, 0)
		pinbutton.BackgroundColor3 = Color3.new(1, 1, 1)
		pinbutton.BackgroundTransparency = 0.92
		pinbutton.BorderSizePixel = 0
		pinbutton.AutoButtonColor = false
		pinbutton.Visible = false
		pinbutton.Text = ''
		addCorner(pinbutton, UDim.new(0, 4))
		addTooltip(pinbutton, 'Add to Favorites')

		local pinicon = Instance.new('ImageLabel')
		pinicon.Name = 'Icon'
		pinicon.Size = UDim2.fromOffset(12, 12)
		pinicon.Position = UDim2.new(0.5, -6, 0, 5)
		pinicon.BackgroundTransparency = 1
		pinicon.Image = getcustomasset('aerov4/assets/new/star.png')
		pinicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
		pinicon.Parent = pinbutton
		pinbutton.Parent = modulebutton

		moduleapi.Pinned = false
		moduleapi.FavoriteButton = nil

		local favbutton
		local favchildren
		local favconns = {}
		local favpairs = {}
		local optionLog = {}
		local togglePin

		local function childrenHome()
			if modulechildren.Parent ~= children then
				modulechildren.Visible = false
				modulechildren.Parent = children
				modulechildren.LayoutOrder = modulebutton.LayoutOrder
			end
		end

		local function toggleHomeChildren()
			if modulechildren.Parent ~= children then
				childrenHome()
				modulechildren.Visible = true
				return
			end
			modulechildren.Visible = not modulechildren.Visible
		end

		local function sortFavorites()
			local favs = {}
			for _, v in mainapi.Modules do
				if v.Pinned and v.FavoriteButton then
					table.insert(favs, v)
				end
			end
			table.sort(favs, function(x, y)
				return x.Name < y.Name
			end)
			for i, v in favs do
				v.FavoriteButton.LayoutOrder = i * 2
				if v.FavoriteChildren then
					v.FavoriteChildren.LayoutOrder = i * 2 + 1
				end
			end
		end

		local function snapshot(option)
			local tab = {}
			local ok = pcall(function()
				option:Save(tab)
			end)
			if not ok then return nil, nil end
			local _, value = next(tab)
			local encoded
			local okEncode = pcall(function()
				encoded = httpService:JSONEncode(value)
			end)
			if not okEncode then
				encoded = tostring(value)
			end
			return value, encoded
		end

		local function syncPairs()
			for _, pair in favpairs do
				local primary, copy = pair.Primary, pair.Copy
				if primary.Object and copy.Object then
					copy.Object.Visible = primary.Object.Visible
				end
				if primary.Save and copy.Save and primary.Load and copy.Load then
					local pValue, pKey = snapshot(primary)
					local cValue, cKey = snapshot(copy)
					if pKey and cKey then
						if pKey ~= pair.Last then
							pcall(function() copy:Load(pValue) end)
							pair.Last = pKey
						elseif cKey ~= pair.Last then
							pcall(function() primary:Load(cValue) end)
							pair.Last = cKey
						end
					end
				end
			end
		end

		local function buildFavChildren(favcat)
			favchildren = Instance.new('Frame')
			favchildren.Name = modulesettings.Name..'FavChildren'
			favchildren.Size = UDim2.new(1, 0, 0, 0)
			favchildren.BackgroundColor3 = modulechildren.BackgroundColor3
			favchildren.BorderSizePixel = 0
			favchildren.Visible = false
			favchildren.LayoutOrder = favbutton.LayoutOrder + 1
			favchildren.Parent = favcat.Children
			moduleapi.FavoriteChildren = favchildren
			local favlist = Instance.new('UIListLayout')
			favlist.SortOrder = Enum.SortOrder.LayoutOrder
			favlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
			favlist.Parent = favchildren
			table.insert(favconns, favlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				if mainapi.ThreadFix then
					setthreadidentity(8)
				end
				favchildren.Size = UDim2.new(1, 0, 0, favlist.AbsoluteContentSize.Y / scale.Scale)
			end))

			local proxy = setmetatable({Options = {}}, {__index = moduleapi})
			for _, entry in optionLog do
				local kind, settings, primary = entry[1], entry[2], entry[3]
				local copySettings = type(settings) == 'table' and table.clone(settings) or settings
				if type(copySettings) == 'table' and kind ~= 'Button' then
					copySettings.Function = function() end
				end
				local ok, copy = pcall(components[kind], copySettings, favchildren, proxy)
				if ok and type(copy) == 'table' and type(primary) == 'table' then
					table.insert(favpairs, {Primary = primary, Copy = copy})
				end
			end
			syncPairs()

			task.spawn(function()
				while favchildren and favchildren.Parent do
					if favchildren.Visible then
						syncPairs()
					end
					task.wait(0.1)
				end
			end)
		end

		local function removeFavorite()
			for _, conn in favconns do
				pcall(function() conn:Disconnect() end)
			end
			table.clear(favconns)
			table.clear(favpairs)
			childrenHome()
			if favchildren then
				favchildren:Destroy()
				favchildren = nil
			end
			if favbutton then
				favbutton:Destroy()
				favbutton = nil
			end
			moduleapi.FavoriteButton = nil
			moduleapi.FavoriteChildren = nil
		end

		local function makeFavorite()
			local favcat = mainapi.Categories.Favorites
			if not favcat or not favcat.Children then return end
			removeFavorite()

			favbutton = modulebutton:Clone()
			for _, name in {'Bind', 'Cover', 'ResetCover'} do
				local obj = favbutton:FindFirstChild(name)
				if obj then obj:Destroy() end
			end
			favbutton.Parent = favcat.Children
			moduleapi.FavoriteButton = favbutton
			addTooltip(favbutton, modulesettings.Tooltip or modulesettings.Name)

			local favgradient = favbutton:FindFirstChildOfClass('UIGradient')
			local favdivider = favbutton:FindFirstChild('Divider')
			local favdotsbutton = favbutton:FindFirstChild('Dots')
			local favdots = favdotsbutton and favdotsbutton:FindFirstChild('Dots')
			local favpin = favbutton:FindFirstChild('Favorite')
			local favpinicon = favpin and favpin:FindFirstChild('Icon')
			local favhover = false
			local homedivider = modulebutton:FindFirstChild('Divider')
			local homedotsbutton = modulebutton:FindFirstChild('Dots')
			local homedots = homedotsbutton and homedotsbutton:FindFirstChild('Dots')

			local function sync()
				if not favbutton then return end
				if favgradient then
					favgradient.Enabled = gradient.Enabled
					favgradient.Color = gradient.Color
				end
				if favdivider and homedivider then
					favdivider.Visible = homedivider.Visible
				end
				if moduleapi.Enabled then
					favbutton.TextColor3 = modulebutton.TextColor3
					favbutton.BackgroundColor3 = modulebutton.BackgroundColor3
					if favdots and homedots then
						favdots.ImageColor3 = homedots.ImageColor3
					end
				else
					local lit = favhover or (favchildren and favchildren.Visible)
					favbutton.TextColor3 = lit and uipallet.Text or color.Dark(uipallet.Text, 0.16)
					favbutton.BackgroundColor3 = lit and color.Light(uipallet.Main, 0.02) or uipallet.Main
					if favdots then
						favdots.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end
				end
				if favpin then
					favpin.Visible = true
				end
				if favpinicon then
					favpinicon.ImageColor3 = moduleapi.Enabled and favbutton.TextColor3 or uipallet.Text
				end
			end

			local function toggleFavChildren()
				if not favchildren then
					buildFavChildren(favcat)
				end
				favchildren.LayoutOrder = favbutton.LayoutOrder + 1
				if not favchildren.Visible then
					syncPairs()
				end
				favchildren.Visible = not favchildren.Visible
				sync()
			end

			table.insert(favconns, gradient:GetPropertyChangedSignal('Enabled'):Connect(sync))
			table.insert(favconns, gradient:GetPropertyChangedSignal('Color'):Connect(sync))
			table.insert(favconns, modulebutton:GetPropertyChangedSignal('BackgroundColor3'):Connect(sync))
			table.insert(favconns, modulebutton:GetPropertyChangedSignal('TextColor3'):Connect(sync))
			if homedivider then
				table.insert(favconns, homedivider:GetPropertyChangedSignal('Visible'):Connect(sync))
			end
			if homedots then
				table.insert(favconns, homedots:GetPropertyChangedSignal('ImageColor3'):Connect(sync))
			end

			favbutton.MouseEnter:Connect(function()
				favhover = true
				sync()
			end)
			favbutton.MouseLeave:Connect(function()
				favhover = false
				sync()
			end)
			favbutton.MouseButton1Click:Connect(function()
				if not mobileEditorOpen then
					moduleapi:Toggle()
				end
				task.defer(sync)
			end)
			favbutton.MouseButton2Click:Connect(toggleFavChildren)
			if favdotsbutton then
				favdotsbutton.MouseButton1Click:Connect(toggleFavChildren)
			end
			if favpin then
				addTooltip(favpin, 'take it outta favorites')
				favpin.MouseButton1Click:Connect(function()
					togglePin()
				end)
			end

			sync()
		end

		togglePin = function()
			moduleapi.Pinned = not moduleapi.Pinned
			pinicon.ImageColor3 = moduleapi.Pinned and uipallet.Text or color.Dark(uipallet.Text, 0.43)
			if moduleapi.Pinned then
				makeFavorite()
			else
				removeFavorite()
			end
			sortFavorites()
		end

		pinbutton.MouseEnter:Connect(function()
			pinicon.ImageColor3 = moduleapi.Pinned and uipallet.Text or color.Dark(uipallet.Text, 0.16)
		end)
		pinbutton.MouseLeave:Connect(function()
			pinicon.ImageColor3 = moduleapi.Pinned and uipallet.Text or color.Dark(uipallet.Text, 0.43)
		end)
		pinbutton.MouseButton1Click:Connect(function()
			togglePin()
		end)

		local dotsbutton = Instance.new('TextButton')
		dotsbutton.Name = 'Dots'
		dotsbutton.Size = UDim2.fromOffset(25, 40)
		dotsbutton.Position = UDim2.new(1, -25, 0, 0)
		dotsbutton.BackgroundTransparency = 1
		dotsbutton.Text = ''
		dotsbutton.Parent = modulebutton
		local dots = Instance.new('ImageLabel')
		dots.Name = 'Dots'
		dots.Size = UDim2.fromOffset(3, 16)
		dots.Position = UDim2.fromOffset(4, 12)
		dots.BackgroundTransparency = 1
		dots.Image = getcustomasset('aerov4/assets/new/dots.png')
		dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
		dots.Parent = dotsbutton
		modulechildren.Name = modulesettings.Name..'Children'
		modulechildren.Size = UDim2.new(1, 0, 0, 0)
		modulechildren.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
		modulechildren.BorderSizePixel = 0
		modulechildren.Visible = false
		modulechildren.Parent = children
		moduleapi.Children = modulechildren
		local windowlist = Instance.new('UIListLayout')
		windowlist.SortOrder = Enum.SortOrder.LayoutOrder
		windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		windowlist.Parent = modulechildren

		local searchBarFrame = Instance.new('Frame')
		searchBarFrame.Name = 'SearchBar'
		searchBarFrame.Size = UDim2.new(1, 0, 0, 30)
		searchBarFrame.BackgroundColor3 = color.Dark(modulechildren.BackgroundColor3, 0.01)
		searchBarFrame.BorderSizePixel = 0
		searchBarFrame.LayoutOrder = 0
		searchBarFrame.Parent = modulechildren
		local searchIcon = Instance.new('ImageLabel')
		searchIcon.Size = UDim2.fromOffset(12, 12)
		searchIcon.Position = UDim2.fromOffset(8, 9)
		searchIcon.BackgroundTransparency = 1
		searchIcon.Image = getcustomasset('aerov4/assets/new/search.png')
		searchIcon.ImageColor3 = color.Light(uipallet.Main, 0.37)
		searchIcon.Parent = searchBarFrame
		local searchBox = Instance.new('TextBox')
		searchBox.Size = UDim2.new(1, -28, 1, 0)
		searchBox.Position = UDim2.fromOffset(24, 0)
		searchBox.BackgroundTransparency = 1
		searchBox.Text = ''
		searchBox.PlaceholderText = 'Search settings...'
		searchBox.PlaceholderColor3 = color.Light(uipallet.Main, 0.37)
		searchBox.TextXAlignment = Enum.TextXAlignment.Left
		searchBox.TextColor3 = uipallet.Text
		searchBox.TextSize = 12
		searchBox.FontFace = uipallet.Font
		searchBox.ClearTextOnFocus = false
		searchBox.Parent = searchBarFrame
		local searchOrigVis = {}
		searchBox:GetPropertyChangedSignal('Text'):Connect(function()
			local query = searchBox.Text:lower()
			if query == '' then
				for name, option in moduleapi.Options do
					if searchOrigVis[name] ~= nil then
						option.Object.Visible = searchOrigVis[name]
					end
				end
				table.clear(searchOrigVis)
				searchIcon.ImageColor3 = color.Light(uipallet.Main, 0.37)
			else
				searchIcon.ImageColor3 = uipallet.Text
				for name, option in moduleapi.Options do
					if searchOrigVis[name] == nil then
						searchOrigVis[name] = option.Object.Visible
					end
					if searchOrigVis[name] then
						option.Object.Visible = name:lower():find(query, 1, true) ~= nil
					end
				end
			end
		end)
		modulechildren:GetPropertyChangedSignal('Visible'):Connect(function()
			if not modulechildren.Visible then
				searchBox.Text = ''
			end
		end)

		local divider = Instance.new('Frame')
		divider.Name = 'Divider'
		divider.Size = UDim2.new(1, 0, 0, 1)
		divider.Position = UDim2.new(0, 0, 1, -1)
		divider.BackgroundColor3 = Color3.new(0.19, 0.19, 0.19)
		divider.BackgroundTransparency = 0.52
		divider.BorderSizePixel = 0
		divider.Visible = false
		divider.Parent = modulebutton
		modulesettings.Function = modulesettings.Function or function() end
		addMaid(moduleapi)
		local function updateUI(state, multiple)
			divider.Visible = state
			gradient.Enabled = state
			modulebutton.TextColor3 = (hovered or modulechildren.Visible) and uipallet.Text or color.Dark(uipallet.Text, 0.16)
			modulebutton.BackgroundColor3 = (hovered or modulechildren.Visible) and color.Light(uipallet.Main, 0.02) or uipallet.Main
			dots.ImageColor3 = state and Color3.fromRGB(50, 50, 50) or color.Light(uipallet.Main, 0.37)
			bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
			bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)

			if not state then
				for _, v in moduleapi.Connections do
					pcall(function() v:Disconnect() end)
				end
				table.clear(moduleapi.Connections)
			end
			if not multiple then
				mainapi:UpdateTextGUI()
			end
			task.spawn(modulesettings.Function, state)
		end

		function moduleapi:SetEnabled(state, multiple)
			if self.Enabled == state then return end
			self.Enabled = state
			updateUI(self.Enabled, multiple)
		end

		function moduleapi:Toggle(multiple)
			self.Enabled = not self.Enabled
			updateUI(self.Enabled, multiple)
		end

		local function updateTooltipText()
			tooltipValue.Value = 'Click to bind | Right‑click to change mode (currently ' .. moduleapi.KeybindMode .. ')'
		end

		function moduleapi:SetBind(tab, mouse)
			if tab.Mobile then
				if inputService.TouchEnabled then
					createMobileButton(moduleapi, Vector2.new(tab.X, tab.Y), tab.W, tab.H)
				end
				return
			end

			self.Bind = table.clone(tab)
			if mouse then
				bindcovertext.Text = #tab <= 0 and 'BIND REMOVED' or 'BOUND TO'
				bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
				task.delay(1, function()
					bindcover.Visible = false
				end)
			end

			if #tab <= 0 then
				bindtext.Visible = false
				bindicon.Visible = true
				bind.Size = UDim2.fromOffset(20, 21)
			else
				bind.Visible = true
				bindtext.Visible = true
				bindicon.Visible = false
				bindtext.Text = table.concat(tab, ' + '):upper()
				bind.Size = UDim2.fromOffset(math.max(getfontsize(bindtext.Text, bindtext.TextSize, bindtext.Font).X + 10, 20), 21)
			end
			pinbutton.Position = UDim2.new(1, -(bind.Size.X.Offset + 28 + 13), 0, 9)
		end

		for i, v in components do
			moduleapi['Create'..i] = function(_, optionsettings)
				local created = v(optionsettings, modulechildren, moduleapi)
				table.insert(optionLog, {i, optionsettings, created})
				return created
			end
		end

		bind.MouseButton2Click:Connect(function()
			moduleapi.KeybindMode = (moduleapi.KeybindMode == "Toggle") and "Hold" or "Toggle"
			moduleapi.HoldCount = 0   
			updateTooltipText()
		end)

		bind.MouseButton1Click:Connect(function()
			bindcovertext.Text = 'PRESS A KEY TO BIND'
			bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
			bindcover.Visible = true
			mainapi.Binding = moduleapi
		end)

		dotsbutton.MouseEnter:Connect(function()
			if not moduleapi.Enabled then
				dots.ImageColor3 = uipallet.Text
			end
		end)
		dotsbutton.MouseLeave:Connect(function()
			if not moduleapi.Enabled then
				dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
			end
		end)
		dotsbutton.MouseButton1Click:Connect(toggleHomeChildren)
		dotsbutton.MouseButton2Click:Connect(function()
			local existingReset = modulebutton:FindFirstChild('ResetCover')
			if existingReset then
				for _, option in moduleapi.Options do
					if option.Default ~= nil then
						if option.Type == 'Slider' then
							option:SetValue(option.Default, nil, true)
						elseif option.Type == 'ColorSlider' then
							option:SetColor(option.Default.Hue, option.Default.Sat, option.Default.Value, option.Default.Opacity)
						elseif option.Type == 'Toggle' then
							if option.Enabled ~= option.Default then
								option:Toggle()
							end
						elseif option.Type == 'TwoSlider' then
							option:SetValue(false, option.Default.Min)
							option:SetValue(true, option.Default.Max)
						end
					end
				end
				existingReset:Destroy()
				return
			end

			local resetCover = Instance.new('ImageLabel')
			resetCover.Name = 'ResetCover'
			resetCover.Size = UDim2.fromOffset(180, 40)
			resetCover.BackgroundTransparency = 1
			resetCover.Image = getcustomasset('aerov4/assets/new/bindbkg.png')
			resetCover.ScaleType = Enum.ScaleType.Slice
			resetCover.SliceCenter = Rect.new(0, 0, 141, 40)
			resetCover.Parent = modulebutton

			local resetText = Instance.new('TextLabel')
			resetText.Name = 'Text'
			resetText.Size = UDim2.new(1, -10, 1, -3)
			resetText.BackgroundTransparency = 1
			resetText.Text = 'RIGHT CLICK AGAIN TO RESET'
			resetText.TextColor3 = uipallet.Text
			resetText.TextSize = 11
			resetText.FontFace = uipallet.Font
			resetText.Parent = resetCover

			task.delay(3, function()
				if resetCover and resetCover.Parent then
					resetCover:Destroy()
				end
			end)
		end)
		modulebutton.MouseEnter:Connect(function()
			hovered = true
			if not moduleapi.Enabled and not modulechildren.Visible then
				modulebutton.TextColor3 = uipallet.Text
				modulebutton.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			end
			bind.Visible = #moduleapi.Bind > 0 or hovered or modulechildren.Visible
			pinbutton.Visible = hovered or modulechildren.Visible or moduleapi.Pinned
		end)
		modulebutton.MouseLeave:Connect(function()
			hovered = false
			if not moduleapi.Enabled and not modulechildren.Visible then
				modulebutton.TextColor3 = color.Dark(uipallet.Text, 0.16)
				modulebutton.BackgroundColor3 = uipallet.Main
			end
			bind.Visible = #moduleapi.Bind > 0 or hovered or modulechildren.Visible
			pinbutton.Visible = hovered or modulechildren.Visible or moduleapi.Pinned
		end)
		modulebutton.MouseButton1Click:Connect(function()
			if not mobileEditorOpen then
				moduleapi:Toggle()
			end
		end)
		modulebutton.MouseButton2Click:Connect(toggleHomeChildren)
		windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			modulechildren.Size = UDim2.new(1, 0, 0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		end)

		moduleapi.Object = modulebutton
		mainapi.Modules[modulesettings.Name] = moduleapi

		local sorting = {}
		for _, v in mainapi.Modules do
			sorting[v.Category] = sorting[v.Category] or {}
			table.insert(sorting[v.Category], v.Name)
		end

		for _, sort in sorting do
			table.sort(sort)
			for i, v in sort do
				mainapi.Modules[v].Index = i
				mainapi.Modules[v].Object.LayoutOrder = i
				mainapi.Modules[v].Children.LayoutOrder = i
			end
		end
		updateTooltipText()

		return moduleapi
	end

	function categoryapi:Expand()
		self.Expanded = not self.Expanded
		local expandTween = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
		if self.Expanded then
			children.Visible = true
			tween:Tween(arrow, expandTween, {Rotation = 0})
			tween:Tween(window, expandTween, {
				Size = UDim2.fromOffset(220, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
			})
			divider.Visible = children.CanvasPosition.Y > 10
		else
			tween:Tween(arrow, expandTween, {Rotation = 180})
			tween:Tween(window, expandTween, {
				Size = UDim2.fromOffset(220, 41)
			})
			task.delay(0.25, function()
				if not categoryapi.Expanded then
					children.Visible = false
					divider.Visible = false
				end
			end)
		end
	end

	local headerDragMoved = false

	window.InputBegan:Connect(function(inputObj)
		if inputObj.UserInputType == Enum.UserInputType.MouseButton2
			and inputObj.Position.Y < window.AbsolutePosition.Y + (41 * scale.Scale) then
			categoryapi:Expand()
			return
		end
		if (inputObj.UserInputType == Enum.UserInputType.MouseButton1 or inputObj.UserInputType == Enum.UserInputType.Touch)
			and inputObj.Position.Y < window.AbsolutePosition.Y + (41 * scale.Scale) then
			headerDragMoved = false
			local startPos = Vector2.new(inputObj.Position.X, inputObj.Position.Y)
			local movedConn, endedConn
			movedConn = inputService.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					if (Vector2.new(input.Position.X, input.Position.Y) - startPos).Magnitude > 6 then
						headerDragMoved = true
					end
				end
			end)
			endedConn = inputObj.Changed:Connect(function()
				if inputObj.UserInputState == Enum.UserInputState.End then
					if movedConn then movedConn:Disconnect() end
					if endedConn then endedConn:Disconnect() end
					if not headerDragMoved then
						categoryapi:Expand()
					end
					headerDragMoved = false
				end
			end)
		end
	end)

	arrowbutton.MouseEnter:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
	end)
	arrowbutton.MouseLeave:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	end)
	arrowbutton.MouseButton1Click:Connect(function()
		categoryapi.Expanded = not categoryapi.Expanded
		children.Visible = categoryapi.Expanded
		tween:Tween(arrow, uipallet.Tween, {
			Rotation = categoryapi.Expanded and 0 or 180
		})
		local targetSize = categoryapi.Expanded and UDim2.fromOffset(220, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601)) or UDim2.fromOffset(220, 41)
		tween:Tween(window, uipallet.Tween, {
			Size = targetSize
		})
	end)
	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(220, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
		end
	end)

	categoryapi.Button = self.Categories.Main:CreateButton({
		Name = categorysettings.Name,
		Icon = categorysettings.Icon,
		Size = categorysettings.Size,
		Window = window
	})

	categoryapi.Object = window
	categoryapi.Children = children 
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

function mainapi:CreateOverlay(categorysettings)
	local window
	local categoryapi
	categoryapi = {
		Type = 'Overlay',
		Expanded = false,
		Button = self.Overlays:CreateToggle({
			Name = categorysettings.Name,
			Function = function(callback)
				window.Visible = callback and (clickgui.Visible or categoryapi.Pinned)
				if not callback then
					for _, v in categoryapi.Connections do
						v:Disconnect()
					end
					table.clear(categoryapi.Connections)
				end

				if categorysettings.Function then
					task.spawn(categorysettings.Function, callback)
				end
			end,
			Icon = categorysettings.Icon,
			Size = categorysettings.Size,
			Position = categorysettings.Position
		}),
		Pinned = false,
		Options = {}
	}

	window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'Overlay'
	window.Size = UDim2.fromOffset(categorysettings.CategorySize or 220, 41)
	window.Position = UDim2.fromOffset(240, 46)
	window.BackgroundColor3 = uipallet.Main
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.Parent = scaledgui
	local blur = addBlur(window)
	addCorner(window)
	makeDraggable(window)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = UDim2.fromOffset(12, (icon.Size.X.Offset > 14 and 14 or 13))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -32, 0, 41)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 0)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local pin = Instance.new('ImageButton')
	pin.Name = 'Pin'
	pin.Size = UDim2.fromOffset(16, 16)
	pin.Position = UDim2.new(1, -47, 0, 12)
	pin.BackgroundTransparency = 1
	pin.AutoButtonColor = false
	pin.Image = getcustomasset('aerov4/assets/new/pin.png')
	pin.ImageColor3 = color.Dark(uipallet.Text, 0.43)
	pin.Parent = window
	local dotsbutton = Instance.new('TextButton')
	dotsbutton.Name = 'Dots'
	dotsbutton.Size = UDim2.fromOffset(17, 40)
	dotsbutton.Position = UDim2.new(1, -17, 0, 0)
	dotsbutton.BackgroundTransparency = 1
	dotsbutton.Text = ''
	dotsbutton.Parent = window
	local dots = Instance.new('ImageLabel')
	dots.Name = 'Dots'
	dots.Size = UDim2.fromOffset(3, 16)
	dots.Position = UDim2.fromOffset(4, 12)
	dots.BackgroundTransparency = 1
	dots.Image = getcustomasset('aerov4/assets/new/dots.png')
	dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
	dots.Parent = dotsbutton
	local customchildren = Instance.new('Frame')
	customchildren.Name = 'CustomChildren'
	customchildren.Size = UDim2.new(1, 0, 0, 200)
	customchildren.Position = UDim2.fromScale(0, 1)
	customchildren.BackgroundTransparency = 1
	customchildren.Parent = window
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -41)
	children.Position = UDim2.fromOffset(0, 37)
	children.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 2
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children
	addMaid(categoryapi)

	function categoryapi:Expand(check)
		if check and not blur.Visible then return end
		self.Expanded = not self.Expanded
		children.Visible = self.Expanded
		dots.ImageColor3 = self.Expanded and uipallet.Text or color.Light(uipallet.Main, 0.37)
		if self.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41)
		end
	end

	function categoryapi:Pin()
		self.Pinned = not self.Pinned
		pin.ImageColor3 = self.Pinned and uipallet.Text or color.Dark(uipallet.Text, 0.43)
	end

	function categoryapi:Update()
		window.Visible = self.Button.Enabled and (clickgui.Visible or self.Pinned)
		if self.Expanded then
			self:Expand()
		end
		if clickgui.Visible then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 41)
			window.BackgroundTransparency = 0
			blur.Visible = true
			icon.Visible = true
			title.Visible = true
			pin.Visible = true
			dotsbutton.Visible = true
		else
			window.Size = UDim2.fromOffset(window.Size.X.Offset, 0)
			window.BackgroundTransparency = 1
			blur.Visible = false
			icon.Visible = false
			title.Visible = false
			pin.Visible = false
			dotsbutton.Visible = false
		end
	end

	for i, v in components do
		categoryapi['Create'..i] = function(self, optionsettings)
			return v(optionsettings, children, categoryapi)
		end
	end

	dotsbutton.MouseEnter:Connect(function()
		if not children.Visible then
			dots.ImageColor3 = uipallet.Text
		end
	end)
	dotsbutton.MouseLeave:Connect(function()
		if not children.Visible then
			dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end
	end)
	dotsbutton.MouseButton1Click:Connect(function()
		categoryapi:Expand(true)
	end)
	dotsbutton.MouseButton2Click:Connect(function()
		categoryapi:Expand(true)
	end)
	pin.MouseButton1Click:Connect(function()
		categoryapi:Pin()
	end)
	window.MouseButton2Click:Connect(function()
		categoryapi:Expand(true)
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(window.Size.X.Offset, math.min(41 + windowlist.AbsoluteContentSize.Y / scale.Scale, 601))
		end
	end)
	self:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(function()
		categoryapi:Update()
	end))

	categoryapi:Update()
	categoryapi.Object = window
	categoryapi.Children = customchildren
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

function mainapi:CreateCategoryList(categorysettings)
	local categoryapi = {
		Type = 'CategoryList',
		Expanded = false,
		List = {},
		ListEnabled = {},
		Objects = {},
		Options = {}
	}
	categorysettings.Color = categorysettings.Color or Color3.fromRGB(5, 134, 105)

	local window = Instance.new('TextButton')
	window.Name = categorysettings.Name..'CategoryList'
	window.Size = UDim2.fromOffset(220, 45)
	window.Position = UDim2.fromOffset(240, 46)
	window.BackgroundColor3 = uipallet.Main
	window.AutoButtonColor = false
	window.Visible = false
	window.Text = ''
	window.Parent = clickgui
	addBlur(window)
	addCorner(window)
	makeDraggable(window)
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = categorysettings.Size
	icon.Position = categorysettings.Position or UDim2.fromOffset(12, (categorysettings.Size.X.Offset > 20 and 13 or 12))
	icon.BackgroundTransparency = 1
	icon.Image = categorysettings.Icon
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local title = Instance.new('TextLabel')
	title.Name = 'Title'
	title.Size = UDim2.new(1, -(categorysettings.Size.X.Offset > 20 and 44 or 36), 0, 20)
	title.Position = UDim2.fromOffset(math.abs(title.Size.X.Offset), 12)
	title.BackgroundTransparency = 1
	title.Text = categorysettings.Name
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.TextColor3 = uipallet.Text
	title.TextSize = 13
	title.FontFace = uipallet.Font
	title.Parent = window
	local arrowbutton = Instance.new('TextButton')
	arrowbutton.Name = 'Arrow'
	arrowbutton.Size = UDim2.fromOffset(40, 40)
	arrowbutton.Position = UDim2.new(1, -40, 0, 0)
	arrowbutton.BackgroundTransparency = 1
	arrowbutton.Text = ''
	arrowbutton.Parent = window
	local arrow = Instance.new('ImageLabel')
	arrow.Name = 'Arrow'
	arrow.Size = UDim2.fromOffset(9, 4)
	arrow.Position = UDim2.fromOffset(20, 19)
	arrow.BackgroundTransparency = 1
	arrow.Image = getcustomasset('aerov4/assets/new/expandup.png')
	arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	arrow.Rotation = 180
	arrow.Parent = arrowbutton
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -45)
	children.Position = UDim2.fromOffset(0, 45)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.Visible = false
	children.ScrollBarThickness = 2
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local childrentwo = Instance.new('Frame')
	childrentwo.BackgroundTransparency = 1
	childrentwo.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	childrentwo.Visible = false
	childrentwo.Position = UDim2.fromOffset(0, 35)
	childrentwo.Parent = window
	local settings = Instance.new('ImageButton')
	settings.Name = 'Settings'
	settings.Size = UDim2.fromOffset(16, 16)
	settings.Position = UDim2.new(1, -52, 0, 13)
	settings.BackgroundTransparency = 1
	settings.AutoButtonColor = false
	settings.Image = getcustomasset('aerov4/assets/new/customsettings.png')
	settings.ImageColor3 = color.Dark(uipallet.Text, 0.43)
	settings.Parent = window
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 41)
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.BackgroundColor3 = Color3.new(1, 1, 1)
	divider.BackgroundTransparency = 0.928
	divider.Parent = window
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Padding = UDim.new(0, 6)
	windowlist.Parent = children
	local windowlisttwo = Instance.new('UIListLayout')
	windowlisttwo.SortOrder = Enum.SortOrder.LayoutOrder
	windowlisttwo.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlisttwo.Padding = UDim.new(0, 2)
	windowlisttwo.Parent = childrentwo
	local childrentwopadding = Instance.new('UIPadding')
	childrentwopadding.PaddingTop = UDim.new(0, 4)
	childrentwopadding.PaddingBottom = UDim.new(0, 4)
	childrentwopadding.Parent = childrentwo
	local addbkg = Instance.new('Frame')
	addbkg.Name = 'Add'
	addbkg.Size = UDim2.fromOffset(200, 35)
	addbkg.Position = UDim2.fromOffset(10, 50)
	addbkg.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
	addbkg.Parent = children
	addCorner(addbkg)
	local addbox = addbkg:Clone()
	addbox.Size = UDim2.new(1, -2, 1, -2)
	addbox.Position = UDim2.fromOffset(1, 1)
	addbox.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	addbox.Parent = addbkg
	local addvalue = Instance.new('TextBox')
	addvalue.Size = UDim2.new(1, -35, 1, 0)
	addvalue.Position = UDim2.fromOffset(10, 0)
	addvalue.BackgroundTransparency = 1
	addvalue.Text = ''
	addvalue.PlaceholderText = categorysettings.Placeholder or 'Add entry...'
	addvalue.TextXAlignment = Enum.TextXAlignment.Left
	addvalue.TextColor3 = Color3.new(1, 1, 1)
	addvalue.TextSize = 15
	addvalue.FontFace = uipallet.Font
	addvalue.ClearTextOnFocus = false
	addvalue.Parent = addbkg
	local addbutton = Instance.new('ImageButton')
	addbutton.Name = 'AddButton'
	addbutton.Size = UDim2.fromOffset(16, 16)
	addbutton.Position = UDim2.new(1, -26, 0, 8)
	addbutton.BackgroundTransparency = 1
	addbutton.Image = getcustomasset('aerov4/assets/new/add.png')
	addbutton.ImageColor3 = categorysettings.Color
	addbutton.ImageTransparency = 0.3
	addbutton.Parent = addbkg
	local cursedpadding = Instance.new('Frame')
	cursedpadding.Size = UDim2.fromOffset(0, 2)
	cursedpadding.BackgroundTransparency = 1
	cursedpadding.Parent = children
	cursedpadding.LayoutOrder = -1
	categorysettings.Function = categorysettings.Function or function() end

	function categoryapi:ChangeValue(val)
		if val then
			if categorysettings.Profiles then
				local ind = self:GetValue(val)
				if ind then
					if val ~= 'default' then
						table.remove(mainapi.Profiles, ind)
						if isfile('aerov4/profiles/'..val..mainapi.Place..'.txt') and delfile then
							delfile('aerov4/profiles/'..val..mainapi.Place..'.txt')
						end
					end
				else
					table.insert(mainapi.Profiles, {Name = val, Bind = {}})
				end
			else
				local ind = table.find(self.List, val)
				if ind then
					table.remove(self.List, ind)
					ind = table.find(self.ListEnabled, val)
					if ind then
						table.remove(self.ListEnabled, ind)
					end
				else
					table.insert(self.List, val)
					table.insert(self.ListEnabled, val)
				end
			end
		end

		categorysettings.Function()
		for _, v in self.Objects do
			v:Destroy()
		end
		table.clear(self.Objects)
		self.Selected = nil

		for i, v in (categorysettings.Profiles and mainapi.Profiles or self.List) do
			if categorysettings.Profiles then
				local object = Instance.new('TextButton')
				object.Name = v.Name
				object.Size = UDim2.fromOffset(200, 38)
				object.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = children
				addCorner(object)
				local objectstroke = Instance.new('UIStroke')
				objectstroke.Color = color.Light(uipallet.Main, 0.1)
				objectstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				objectstroke.Enabled = false
				objectstroke.Parent = object
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -10, 1, 0)
				objecttitle.Position = UDim2.fromOffset(10, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v.Name
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.4)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				local dotsbutton = Instance.new('TextButton')
				dotsbutton.Name = 'Dots'
				dotsbutton.Size = UDim2.fromOffset(25, 38)
				dotsbutton.Position = UDim2.new(1, -25, 0, 0)
				dotsbutton.BackgroundTransparency = 1
				dotsbutton.Text = ''
				dotsbutton.Parent = object
				local dots = Instance.new('ImageLabel')
				dots.Name = 'Dots'
				dots.Size = UDim2.fromOffset(3, 16)
				dots.Position = UDim2.fromOffset(10, 11)
				dots.BackgroundTransparency = 1
				dots.Image = getcustomasset('aerov4/assets/new/dots.png')
				dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
				dots.Parent = dotsbutton
				local bind = Instance.new('TextButton')
				addTooltip(bind, 'Click to bind')
				bind.Name = 'Bind'
				bind.Size = UDim2.fromOffset(20, 21)
				bind.Position = UDim2.new(1, -30, 0, 9)
				bind.AnchorPoint = Vector2.new(1, 0)
				bind.BackgroundColor3 = Color3.new(1, 1, 1)
				bind.BackgroundTransparency = 0.92
				bind.BorderSizePixel = 0
				bind.AutoButtonColor = false
				bind.Visible = false
				bind.Text = ''
				addCorner(bind, UDim.new(0, 4))
				local bindicon = Instance.new('ImageLabel')
				bindicon.Name = 'Icon'
				bindicon.Size = UDim2.fromOffset(12, 12)
				bindicon.Position = UDim2.new(0.5, -6, 0, 5)
				bindicon.BackgroundTransparency = 1
				bindicon.Image = getcustomasset('aerov4/assets/new/bind.png')
				bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
				bindicon.Parent = bind
				local bindtext = Instance.new('TextLabel')
				bindtext.Size = UDim2.fromScale(1, 1)
				bindtext.Position = UDim2.fromOffset(0, 1)
				bindtext.BackgroundTransparency = 1
				bindtext.Visible = false
				bindtext.Text = ''
				bindtext.TextColor3 = color.Dark(uipallet.Text, 0.43)
				bindtext.TextSize = 12
				bindtext.FontFace = uipallet.Font
				bindtext.Parent = bind
				bind.MouseEnter:Connect(function()
					bindtext.Visible = false
					bindicon.Visible = not bindtext.Visible
					bindicon.Image = getcustomasset('aerov4/assets/new/edit.png')
					if v.Name ~= mainapi.Profile then
						bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.16)
					end
				end)
				bind.MouseLeave:Connect(function()
					bindtext.Visible = #v.Bind > 0
					bindicon.Visible = not bindtext.Visible
					bindicon.Image = getcustomasset('aerov4/assets/new/bind.png')
					if v.Name ~= mainapi.Profile then
						bindicon.ImageColor3 = color.Dark(uipallet.Text, 0.43)
					end
				end)
				local bindcover = Instance.new('ImageLabel')
				bindcover.Name = 'Cover'
				bindcover.Size = UDim2.fromOffset(154, 38)
				bindcover.BackgroundTransparency = 1
				bindcover.Visible = false
				bindcover.Image = getcustomasset('aerov4/assets/new/bindbkg.png')
				bindcover.ScaleType = Enum.ScaleType.Slice
				bindcover.SliceCenter = Rect.new(0, 0, 141, 40)
				bindcover.Parent = object
				local bindcovertext = Instance.new('TextLabel')
				bindcovertext.Name = 'Text'
				bindcovertext.Size = UDim2.new(1, -10, 1, -3)
				bindcovertext.BackgroundTransparency = 1
				bindcovertext.Text = 'PRESS A KEY TO BIND'
				bindcovertext.TextColor3 = uipallet.Text
				bindcovertext.TextSize = 11
				bindcovertext.FontFace = uipallet.Font
				bindcovertext.Parent = bindcover
				bind.Parent = object
				dotsbutton.MouseEnter:Connect(function()
					if v.Name ~= mainapi.Profile then
						dots.ImageColor3 = uipallet.Text
					end
				end)
				dotsbutton.MouseLeave:Connect(function()
					if v.Name ~= mainapi.Profile then
						dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
					end
				end)
				dotsbutton.MouseButton1Click:Connect(function()
					if v.Name ~= mainapi.Profile then
						categoryapi:ChangeValue(v.Name)
					end
				end)
				object.MouseButton1Click:Connect(function()
						if mainapi.ThreadFix then
							setthreadidentity(8)
						end
						mainapi:Save(v.Name)
						mainapi:Load(true)
					end)
				object.MouseEnter:Connect(function()
					bind.Visible = true
					if v.Name ~= mainapi.Profile then
						objectstroke.Enabled = true
						objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
					end
				end)
				object.MouseLeave:Connect(function()
					bind.Visible = #v.Bind > 0
					if v.Name ~= mainapi.Profile then
						objectstroke.Enabled = false
						objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.4)
					end
				end)

				local function bindFunction(self, tab, mouse)
					v.Bind = table.clone(tab)
					if mouse then
						bindcovertext.Text = #tab <= 0 and 'BIND REMOVED' or 'BOUND TO '..table.concat(tab, ' + '):upper()
						bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
						task.delay(1, function()
							bindcover.Visible = false
						end)
					end

					if #tab <= 0 then
						bindtext.Visible = false
						bindicon.Visible = true
						bind.Size = UDim2.fromOffset(20, 21)
					else
						bind.Visible = true
						bindtext.Visible = true
						bindicon.Visible = false
						bindtext.Text = table.concat(tab, ' + '):upper()
						bind.Size = UDim2.fromOffset(math.max(getfontsize(bindtext.Text, bindtext.TextSize, bindtext.Font).X + 10, 20), 21)
					end
				end

				bindFunction({}, v.Bind)
				bind.MouseButton1Click:Connect(function()
					bindcovertext.Text = 'PRESS A KEY TO BIND'
					bindcover.Size = UDim2.fromOffset(getfontsize(bindcovertext.Text, bindcovertext.TextSize).X + 20, 40)
					bindcover.Visible = true
					mainapi.Binding = {SetBind = bindFunction, Bind = v.Bind}
				end)
				if v.Name == mainapi.Profile then
					self.Selected = object
				end
				table.insert(self.Objects, object)
			else
				local enabled = table.find(self.ListEnabled, v)
				local object = Instance.new('TextButton')
				object.Name = v
				object.Size = UDim2.fromOffset(200, 32)
				object.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
				object.AutoButtonColor = false
				object.Text = ''
				object.Parent = children
				addCorner(object)
				local objectbkg = Instance.new('Frame')
				objectbkg.Name = 'BKG'
				objectbkg.Size = UDim2.new(1, -2, 1, -2)
				objectbkg.Position = UDim2.fromOffset(1, 1)
				objectbkg.BackgroundColor3 = uipallet.Main
				objectbkg.Visible = false
				objectbkg.Parent = object
				addCorner(objectbkg)
				local objectdot = Instance.new('Frame')
				objectdot.Name = 'Dot'
				objectdot.Size = UDim2.fromOffset(10, 11)
				objectdot.Position = UDim2.fromOffset(10, 12)
				objectdot.BackgroundColor3 = enabled and categorysettings.Color or color.Light(uipallet.Main, 0.37)
				objectdot.Parent = object
				addCorner(objectdot, UDim.new(1, 0))
				local objectdotin = objectdot:Clone()
				objectdotin.Size = UDim2.fromOffset(8, 9)
				objectdotin.Position = UDim2.fromOffset(1, 1)
				objectdotin.BackgroundColor3 = enabled and categorysettings.Color or color.Light(uipallet.Main, 0.02)
				objectdotin.Parent = objectdot
				local objecttitle = Instance.new('TextLabel')
				objecttitle.Name = 'Title'
				objecttitle.Size = UDim2.new(1, -30, 1, 0)
				objecttitle.Position = UDim2.fromOffset(30, 0)
				objecttitle.BackgroundTransparency = 1
				objecttitle.Text = v
				objecttitle.TextXAlignment = Enum.TextXAlignment.Left
				objecttitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
				objecttitle.TextSize = 15
				objecttitle.FontFace = uipallet.Font
				objecttitle.Parent = object
				if mainapi.ThreadFix then
					setthreadidentity(8)
				end
				local close = Instance.new('ImageButton')
				close.Name = 'Close'
				close.Size = UDim2.fromOffset(16, 16)
				close.Position = UDim2.new(1, -23, 0, 8)
				close.BackgroundColor3 = Color3.new(1, 1, 1)
				close.BackgroundTransparency = 1
				close.AutoButtonColor = false
				close.Image = getcustomasset('aerov4/assets/new/closemini.png')
				close.ImageColor3 = color.Light(uipallet.Text, 0.2)
				close.ImageTransparency = 0.5
				close.Parent = object
				addCorner(close, UDim.new(1, 0))
				close.MouseEnter:Connect(function()
					close.ImageTransparency = 0.3
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 0.6
					})
				end)
				close.MouseLeave:Connect(function()
					close.ImageTransparency = 0.5
					tween:Tween(close, uipallet.Tween, {
						BackgroundTransparency = 1
					})
				end)
				close.MouseButton1Click:Connect(function()
					categoryapi:ChangeValue(v)
				end)
				object.MouseEnter:Connect(function()
					objectbkg.Visible = true
				end)
				object.MouseLeave:Connect(function()
					objectbkg.Visible = false
				end)
				object.MouseButton1Click:Connect(function()
					local ind = table.find(self.ListEnabled, v)
					if ind then
						table.remove(self.ListEnabled, ind)
						objectdot.BackgroundColor3 = color.Light(uipallet.Main, 0.37)
						objectdotin.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
					else
						table.insert(self.ListEnabled, v)
						objectdot.BackgroundColor3 = categorysettings.Color
						objectdotin.BackgroundColor3 = categorysettings.Color
					end
					categorysettings.Function()
				end)
				table.insert(self.Objects, object)
			end
		end
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end

	function categoryapi:Expand()
		self.Expanded = not self.Expanded
		children.Visible = self.Expanded
		arrow.Rotation = self.Expanded and 0 or 180
		window.Size = UDim2.fromOffset(220, self.Expanded and math.min(51 + windowlist.AbsoluteContentSize.Y / scale.Scale, 611) or 45)
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
		if not self.Expanded then
			childrentwo.Visible = false
			cursedpadding.Size = UDim2.fromOffset(0, 2)
		end
		settings.Visible = self.Expanded
	end

	function categoryapi:GetValue(name)
		for i, v in mainapi.Profiles do
			if v.Name == name then
				return i
			end
		end
	end

	for i, v in components do
		categoryapi['Create'..i] = function(self, optionsettings)
			return v(optionsettings, childrentwo, categoryapi)
		end
	end

	addbutton.MouseEnter:Connect(function()
		addbutton.ImageTransparency = 0
	end)
	addbutton.MouseLeave:Connect(function()
		addbutton.ImageTransparency = 0.3
	end)
	addbutton.MouseButton1Click:Connect(function()
		if not table.find(categoryapi.List, addvalue.Text) then
			categoryapi:ChangeValue(addvalue.Text)
			addvalue.Text = ''
		end
	end)
	arrowbutton.MouseEnter:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(220, 220, 220)
	end)
	arrowbutton.MouseLeave:Connect(function()
		arrow.ImageColor3 = Color3.fromRGB(140, 140, 140)
	end)
	arrowbutton.MouseButton1Click:Connect(function()
		categoryapi:Expand()
	end)
	arrowbutton.MouseButton2Click:Connect(function()
		categoryapi:Expand()
	end)
	addvalue.FocusLost:Connect(function(enter)
		if enter and not table.find(categoryapi.List, addvalue.Text) then
			categoryapi:ChangeValue(addvalue.Text)
			addvalue.Text = ''
		end
	end)
	addvalue.MouseEnter:Connect(function()
		tween:Tween(addbkg, uipallet.Tween, {
			BackgroundColor3 = color.Light(uipallet.Main, 0.14)
		})
	end)
	addvalue.MouseLeave:Connect(function()
		tween:Tween(addbkg, uipallet.Tween, {
			BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		})
	end)
	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	settings.MouseEnter:Connect(function()
		settings.ImageColor3 = uipallet.Text
	end)
	settings.MouseLeave:Connect(function()
		settings.ImageColor3 = color.Light(uipallet.Main, 0.37)
	end)
	settings.MouseButton1Click:Connect(function()
		childrentwo.Visible = not childrentwo.Visible
		cursedpadding.Size = childrentwo.Visible and UDim2.fromOffset(0, 65) or UDim2.fromOffset(0, 2)
	end)
	window.InputBegan:Connect(function(inputObj)
		if inputObj.Position.Y < window.AbsolutePosition.Y + 41 and inputObj.UserInputType == Enum.UserInputType.MouseButton2 then
			categoryapi:Expand()
		end
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		if categoryapi.Expanded then
			window.Size = UDim2.fromOffset(220, math.min(51 + windowlist.AbsoluteContentSize.Y / scale.Scale, 611))
		end
	end)
	windowlisttwo:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		childrentwo.Size = UDim2.fromOffset(220, windowlisttwo.AbsoluteContentSize.Y)
	end)

	categoryapi.Button = self.Categories.Main:CreateButton({
		Name = categorysettings.Name,
		Icon = categorysettings.CategoryIcon,
		Size = categorysettings.CategorySize,
		Window = window
	})

	categoryapi.Object = window
	self.Categories[categorysettings.Name] = categoryapi

	return categoryapi
end

function mainapi:CreateSearch()
	local searchbkg = Instance.new('Frame')
	searchbkg.Name = 'Search'
	searchbkg.Size = UDim2.fromOffset(220, 37)
	searchbkg.Position = UDim2.new(0.5, 0, 0, 13)
	searchbkg.AnchorPoint = Vector2.new(0.5, 0)
	searchbkg.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	searchbkg.Parent = clickgui
	local searchicon = Instance.new('ImageLabel')
	searchicon.Name = 'Icon'
	searchicon.Size = UDim2.fromOffset(14, 14)
	searchicon.Position = UDim2.new(1, -23, 0, 11)
	searchicon.BackgroundTransparency = 1
	searchicon.Image = getcustomasset('aerov4/assets/new/search.png')
	searchicon.ImageColor3 = color.Light(uipallet.Main, 0.37)
	searchicon.Parent = searchbkg
	addBlur(searchbkg)
	addCorner(searchbkg)
	local search = Instance.new('TextBox')
	search.Size = UDim2.new(1, -10, 0, 37)
	search.Position = UDim2.fromOffset(10, 0)
	search.BackgroundTransparency = 1
	search.Text = ''
	search.PlaceholderText = ''
	search.TextXAlignment = Enum.TextXAlignment.Left
	search.TextColor3 = uipallet.Text
	search.TextSize = 12
	search.FontFace = uipallet.Font
	search.ClearTextOnFocus = false
	search.Parent = searchbkg
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.new(1, 0, 1, -37)
	children.Position = UDim2.fromOffset(0, 34)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.ScrollBarThickness = 2
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = searchbkg
	local divider = Instance.new('Frame')
	divider.Name = 'Divider'
	divider.Size = UDim2.new(1, 0, 0, 1)
	divider.Position = UDim2.fromOffset(0, 33)
	divider.BackgroundColor3 = Color3.new(1, 1, 1)
	divider.BackgroundTransparency = 0.928
	divider.BorderSizePixel = 0
	divider.Visible = false
	divider.Parent = searchbkg
	local windowlist = Instance.new('UIListLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
	windowlist.Parent = children

	children:GetPropertyChangedSignal('CanvasPosition'):Connect(function()
		divider.Visible = children.CanvasPosition.Y > 10 and children.Visible
	end)
	search:GetPropertyChangedSignal('Text'):Connect(function()
		for _, v in children:GetChildren() do
			if v:IsA('TextButton') then
				v:Destroy()
			end
		end
		if search.Text == '' then return end

		local lowerSearch = search.Text:lower()
		local added = {}
			
		local orderCounter = 0
		for i, v in self.Modules do
			if not v then continue end
			local matchType = nil
			local matchKeyword = nil

			if i:lower():find(lowerSearch) then
				matchType = "name"
			end

			if not matchType and self.ModuleAliases and self.ModuleAliases[i] then
				for _, alias in ipairs(self.ModuleAliases[i]) do
					if alias:lower():find(lowerSearch) then
						matchType = "alias"
						matchKeyword = alias
						break
					end
				end
			end

			if not matchType and self.ModuleTags and self.ModuleTags[i] then
				for _, tag in ipairs(self.ModuleTags[i]) do
					if tag:lower():find(lowerSearch) then
						matchType = "tag"
						matchKeyword = tag
						break
					end
				end
			end

			if not matchType then
				for optName, opt in pairs(v.Options) do
					if optName:lower():find(lowerSearch) then
						matchType = "option"
						matchKeyword = optName
						break
					end
				end
			end

			if matchType and not added[i] then
				added[i] = true
				orderCounter = orderCounter + 1
				local button = v.Object:Clone()
				button.LayoutOrder = orderCounter * 2
				if button.Bind then button.Bind:Destroy() end
				if button.Favorite then button.Favorite:Destroy() end

				button.MouseButton1Click:Connect(function()
					v:Toggle()
				end)

				local lastRightClick = 0
				local homeParent, homeLayoutOrder
				if v.Children then
					homeParent = v.Children.Parent
					homeLayoutOrder = v.Children.LayoutOrder
				end

				local function restoreChildren()
					if v.Children and homeParent then
						v.Children.Parent = homeParent
						v.Children.LayoutOrder = homeLayoutOrder
						v.Children.Visible = false
					end
				end

				button.Destroying:Connect(restoreChildren)

				button.MouseButton2Click:Connect(function()
					local now = tick()
					if (now - lastRightClick) < 0.35 then
						lastRightClick = 0
						restoreChildren()

						v.Object.Parent.Parent.Visible = true
						local frame = v.Object.Parent
						local highlight = Instance.new('Frame')
						highlight.Size = UDim2.fromScale(1, 1)
						highlight.BackgroundColor3 = Color3.new(1, 1, 1)
						highlight.BackgroundTransparency = 0.3
						highlight.BorderSizePixel = 0
						highlight.Parent = v.Object
						tween:Tween(highlight, TweenInfo.new(0.5), {
							BackgroundTransparency = 1
						})
						task.delay(0.5, highlight.Destroy, highlight)

						local cat = mainapi.Categories[v.Category]
						if cat and not cat.Expanded then
							task.wait(0.05) 
							cat:Expand()
						end

						frame.CanvasPosition = Vector2.new(0, (v.Object.LayoutOrder * 40) - (math.min(frame.CanvasSize.Y.Offset, 600) / 2))
					else
						lastRightClick = now
						if v.Children then
							v.Children.Parent = button.Parent
							v.Children.LayoutOrder = button.LayoutOrder + 1
							v.Children.Visible = not v.Children.Visible
						end
					end
				end)

				if matchType == "name" or matchType == "option" or matchType == "alias" or matchType == "tag" then
					local displayText

					if matchType == "name" then
						if i:lower() == lowerSearch then
							displayText = "MATCHED"
						else
							displayText = i:sub(1,1):upper() .. i:sub(2)
						end
					elseif (matchType == "tag" or matchType == "alias") and self.TagDisplay and self.TagDisplay[i] and self.TagDisplay[i][matchKeyword] then
						displayText = self.TagDisplay[i][matchKeyword]
					elseif matchKeyword then
						if matchKeyword:lower() == lowerSearch then
							displayText = "MATCHED"
						else
							displayText = matchKeyword:sub(1,1):upper() .. matchKeyword:sub(2)
						end
					else
						displayText = "MATCHED"
					end

					local textWidth = getfontsize(displayText, 11, uipallet.FontSemiBold).X
					local badgeWidth = math.max(50, textWidth + 12)

					local badge = Instance.new('Frame')
					badge.Name = 'SearchBadge'
					badge.Size = UDim2.fromOffset(badgeWidth, 20) 
					badge.Position = UDim2.new(1, -(badgeWidth + 5), 0, 10) 
					badge.BackgroundColor3 = Color3.fromHSV(self.GUIColor.Hue, self.GUIColor.Sat, self.GUIColor.Value)
					badge.BackgroundTransparency = 0
					badge.BorderSizePixel = 0
					badge.Parent = button

					local badgeCorner = Instance.new('UICorner')
					badgeCorner.CornerRadius = UDim.new(0, 4)
					badgeCorner.Parent = badge

					local badgeText = Instance.new('TextLabel')
					badgeText.Size = UDim2.fromScale(1, 1)
					badgeText.BackgroundTransparency = 1
					badgeText.Text = displayText
					badgeText.TextSize = 11
					badgeText.FontFace = uipallet.FontSemiBold
					badgeText.Parent = badge

					local _, _, v = self.GUIColor.Hue, self.GUIColor.Sat, self.GUIColor.Value
					if v > 0.7 then
						badgeText.TextColor3 = Color3.new(0.1, 0.1, 0.1)
					else
						badgeText.TextColor3 = Color3.new(1, 1, 1)
					end

					local tooltipKeyword = matchKeyword or matchType
					local formattedKeyword = tooltipKeyword:gsub("_", " "):gsub("(%l)(%w*)", function(a,b) return a:upper()..b end)
					addTooltip(button, "Matched: " .. formattedKeyword)
				end

				button.Parent = children
				task.spawn(function()
					repeat
						for _, v2 in {'Text', 'TextColor3', 'BackgroundColor3'} do
							button[v2] = v.Object[v2]
						end
						button.UIGradient.Color = v.Object.UIGradient.Color
						button.UIGradient.Enabled = v.Object.UIGradient.Enabled
						button.Dots.Dots.ImageColor3 = v.Object.Dots.Dots.ImageColor3
						task.wait()
					until not button.Parent
				end)
			end
		end
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
		searchbkg.Size = UDim2.fromOffset(220, math.min(37 + windowlist.AbsoluteContentSize.Y / scale.Scale, 437))
	end)

	self.Legit.Icon = legiticon
end

function mainapi:CreateLegit()
	local legitapi = {Modules = {}}

	local window = Instance.new('Frame')
	window.Name = 'LegitGUI'
	window.Size = UDim2.fromOffset(700, 389)
	window.Position = UDim2.new(0.5, -350, 0.5, -194)
	window.BackgroundColor3 = uipallet.Main
	window.Visible = false
	window.Parent = scaledgui
	addBlur(window)
	addCorner(window)
	makeDraggable(window)
	local modal = Instance.new('TextButton')
	modal.BackgroundTransparency = 1
	modal.Text = ''
	modal.Modal = true
	modal.Parent = window
	local icon = Instance.new('ImageLabel')
	icon.Name = 'Icon'
	icon.Size = UDim2.fromOffset(16, 16)
	icon.Position = UDim2.fromOffset(18, 13)
	icon.BackgroundTransparency = 1
	icon.Image = getcustomasset('aerov4/assets/new/legittab.png')
	icon.ImageColor3 = uipallet.Text
	icon.Parent = window
	local close = addCloseButton(window)
	local children = Instance.new('ScrollingFrame')
	children.Name = 'Children'
	children.Size = UDim2.fromOffset(684, 340)
	children.Position = UDim2.fromOffset(14, 41)
	children.BackgroundTransparency = 1
	children.BorderSizePixel = 0
	children.ScrollBarThickness = 2
	children.ScrollBarImageTransparency = 0.75
	children.CanvasSize = UDim2.new()
	children.Parent = window
	local windowlist = Instance.new('UIGridLayout')
	windowlist.SortOrder = Enum.SortOrder.LayoutOrder
	windowlist.FillDirectionMaxCells = 4
	windowlist.CellSize = UDim2.fromOffset(163, 114)
	windowlist.CellPadding = UDim2.fromOffset(6, 5)
	windowlist.Parent = children
	legitapi.Window = window
	table.insert(mainapi.Windows, window)

	function legitapi:CreateModule(modulesettings)
		mainapi:Remove(modulesettings.Name)
		local moduleapi = {
			Enabled = false,
			Options = {},
			Name = modulesettings.Name,
			Legit = true
		}

		local module = Instance.new('TextButton')
		module.Name = modulesettings.Name
		module.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		module.Text = ''
		module.AutoButtonColor = false
		module.Parent = children
		addTooltip(module, modulesettings.Tooltip)
		addCorner(module)
		local title = Instance.new('TextLabel')
		title.Name = 'Title'
		title.Size = UDim2.new(1, -16, 0, 20)
		title.Position = UDim2.fromOffset(16, 81)
		title.BackgroundTransparency = 1
		title.Text = modulesettings.Name
		title.TextXAlignment = Enum.TextXAlignment.Left
		title.TextColor3 = color.Dark(uipallet.Text, 0.31)
		title.TextSize = 13
		title.FontFace = uipallet.Font
		title.Parent = module
		local knob = Instance.new('Frame')
		knob.Name = 'Knob'
		knob.Size = UDim2.fromOffset(22, 12)
		knob.Position = UDim2.new(1, -57, 0, 14)
		knob.BackgroundColor3 = color.Light(uipallet.Main, 0.14)
		knob.Parent = module
		addCorner(knob, UDim.new(1, 0))
		local knobmain = knob:Clone()
		knobmain.Size = UDim2.fromOffset(8, 8)
		knobmain.Position = UDim2.fromOffset(2, 2)
		knobmain.BackgroundColor3 = uipallet.Main
		knobmain.Parent = knob
		local dotsbutton = Instance.new('TextButton')
		dotsbutton.Name = 'Dots'
		dotsbutton.Size = UDim2.fromOffset(14, 24)
		dotsbutton.Position = UDim2.new(1, -27, 0, 8)
		dotsbutton.BackgroundTransparency = 1
		dotsbutton.Text = ''
		dotsbutton.Parent = module
		local dots = Instance.new('ImageLabel')
		dots.Name = 'Dots'
		dots.Size = UDim2.fromOffset(2, 12)
		dots.Position = UDim2.fromOffset(6, 6)
		dots.BackgroundTransparency = 1
		dots.Image = getcustomasset('aerov4/assets/new/dots.png')
		dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
		dots.Parent = dotsbutton
		local shadow = Instance.new('TextButton')
		shadow.Name = 'Shadow'
		shadow.Size = UDim2.new(1, 0, 1, -5)
		shadow.BackgroundColor3 = Color3.new()
		shadow.BackgroundTransparency = 1
		shadow.AutoButtonColor = false
		shadow.ClipsDescendants = true
		shadow.Visible = false
		shadow.Text = ''
		shadow.Parent = window
		addCorner(shadow)
		local settingspane = Instance.new('TextButton')
		settingspane.Size = UDim2.new(0, 220, 1, 0)
		settingspane.Position = UDim2.fromScale(1, 0)
		settingspane.BackgroundColor3 = uipallet.Main
		settingspane.AutoButtonColor = false
		settingspane.Text = ''
		settingspane.Parent = shadow
		local settingstitle = Instance.new('TextLabel')
		settingstitle.Name = 'Title'
		settingstitle.Size = UDim2.new(1, -36, 0, 20)
		settingstitle.Position = UDim2.fromOffset(36, 12)
		settingstitle.BackgroundTransparency = 1
		settingstitle.Text = modulesettings.Name
		settingstitle.TextXAlignment = Enum.TextXAlignment.Left
		settingstitle.TextColor3 = color.Dark(uipallet.Text, 0.16)
		settingstitle.TextSize = 13
		settingstitle.FontFace = uipallet.Font
		settingstitle.Parent = settingspane
		local back = Instance.new('ImageButton')
		back.Name = 'Back'
		back.Size = UDim2.fromOffset(16, 16)
		back.Position = UDim2.fromOffset(11, 13)
		back.BackgroundTransparency = 1
		back.Image = getcustomasset('aerov4/assets/new/back.png')
		back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		back.Parent = settingspane
		addCorner(settingspane)
		local settingschildren = Instance.new('ScrollingFrame')
		settingschildren.Name = 'Children'
		settingschildren.Size = UDim2.new(1, 0, 1, -45)
		settingschildren.Position = UDim2.fromOffset(0, 41)
		settingschildren.BackgroundColor3 = uipallet.Main
		settingschildren.BorderSizePixel = 0
		settingschildren.ScrollBarThickness = 2
		settingschildren.ScrollBarImageTransparency = 0.75
		settingschildren.CanvasSize = UDim2.new()
		settingschildren.Parent = settingspane
		local settingswindowlist = Instance.new('UIListLayout')
		settingswindowlist.SortOrder = Enum.SortOrder.LayoutOrder
		settingswindowlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		settingswindowlist.Parent = settingschildren
		if modulesettings.Size then
			local modulechildren = Instance.new('Frame')
			modulechildren.Size = modulesettings.Size
			modulechildren.BackgroundTransparency = 1
			modulechildren.Visible = false
			modulechildren.Parent = scaledgui
			makeDraggable(modulechildren, window)
			local objectstroke = Instance.new('UIStroke')
			objectstroke.Color = Color3.fromRGB(5, 134, 105)
			objectstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			objectstroke.Thickness = 0
			objectstroke.Parent = modulechildren
			moduleapi.Children = modulechildren
		end
		modulesettings.Function = modulesettings.Function or function() end
		addMaid(moduleapi)

		function moduleapi:Toggle()
			moduleapi.Enabled = not moduleapi.Enabled
			if moduleapi.Children then
				moduleapi.Children.Visible = moduleapi.Enabled
			end
			title.TextColor3 = moduleapi.Enabled and color.Light(uipallet.Text, 0.2) or color.Dark(uipallet.Text, 0.31)
			module.BackgroundColor3 = moduleapi.Enabled and color.Light(uipallet.Main, 0.05) or module.BackgroundColor3
			tween:Tween(knob, uipallet.Tween, {
				BackgroundColor3 = moduleapi.Enabled and Color3.fromHSV(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value) or color.Light(uipallet.Main, 0.14)
			})
			tween:Tween(knobmain, uipallet.Tween, {
				Position = UDim2.fromOffset(moduleapi.Enabled and 12 or 2, 2)
			})
			if not moduleapi.Enabled then
				for _, v in moduleapi.Connections do
					v:Disconnect()
				end
				table.clear(moduleapi.Connections)
			end
			task.spawn(modulesettings.Function, moduleapi.Enabled)
		end

		back.MouseEnter:Connect(function()
			back.ImageColor3 = uipallet.Text
		end)
		back.MouseLeave:Connect(function()
			back.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end)
		back.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.fromScale(1, 0)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		dotsbutton.MouseButton1Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.new(1, -220, 0, 0)
			})
		end)
		dotsbutton.MouseEnter:Connect(function()
			dots.ImageColor3 = uipallet.Text
		end)
		dotsbutton.MouseLeave:Connect(function()
			dots.ImageColor3 = color.Light(uipallet.Main, 0.37)
		end)
		module.MouseEnter:Connect(function()
			if not moduleapi.Enabled then
				module.BackgroundColor3 = color.Light(uipallet.Main, 0.05)
			end
		end)
		module.MouseLeave:Connect(function()
			if not moduleapi.Enabled then
				module.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			end
		end)
		module.MouseButton1Click:Connect(function()
			moduleapi:Toggle()
		end)
		module.MouseButton2Click:Connect(function()
			shadow.Visible = true
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 0.5
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.new(1, -220, 0, 0)
			})
		end)
		shadow.MouseButton1Click:Connect(function()
			tween:Tween(shadow, uipallet.Tween, {
				BackgroundTransparency = 1
			})
			tween:Tween(settingspane, uipallet.Tween, {
				Position = UDim2.fromScale(1, 0)
			})
			task.wait(0.2)
			shadow.Visible = false
		end)
		settingswindowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			settingschildren.CanvasSize = UDim2.fromOffset(0, settingswindowlist.AbsoluteContentSize.Y / scale.Scale)
		end)

		for i, v in components do
			moduleapi['Create'..i] = function(_, optionsettings)
				return v(optionsettings, settingschildren, moduleapi)
			end
		end

		moduleapi.Object = module
		legitapi.Modules[modulesettings.Name] = moduleapi

		local sorting = {}
		for _, v in legitapi.Modules do
			table.insert(sorting, v.Name)
		end
		table.sort(sorting)

		for i, v in sorting do
			legitapi.Modules[v].Object.LayoutOrder = i
		end

		return moduleapi
	end

	local function visibleCheck()
		for _, v in legitapi.Modules do
			if v.Children then
				local visible = clickgui.Visible
				for _, v2 in self.Windows do
					visible = visible or v2.Visible
				end
				v.Children.Visible = (not visible or window.Visible) and v.Enabled
			end
		end
	end

	close.MouseButton1Click:Connect(function()
		window.Visible = false
		clickgui.Visible = true
	end)
	self:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(visibleCheck))
	window:GetPropertyChangedSignal('Visible'):Connect(function()
		self:UpdateGUI(self.GUIColor.Hue, self.GUIColor.Sat, self.GUIColor.Value)
		visibleCheck()
	end)
	windowlist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		children.CanvasSize = UDim2.fromOffset(0, windowlist.AbsoluteContentSize.Y / scale.Scale)
	end)

	self.Legit = legitapi

	return legitapi
end

function mainapi:CreateNotification(title, text, duration, type)
	if getgenv().Closet then return end
	if not self.Notifications.Enabled then return end
	task.delay(0, function()
		if self.ThreadFix then
			setthreadidentity(8)
		end
		local i = #notifications:GetChildren() + 1
		local notification = Instance.new('ImageLabel')
		notification.Name = 'Notification'
		notification.Size = UDim2.fromOffset(math.max(getfontsize(removeTags(text), 14, uipallet.Font).X + 80, 266), 75)
		notification.Position = UDim2.new(1, 0, 1, -(29 + (78 * i)))
		notification.ZIndex = 5
		notification.BackgroundTransparency = 1
		notification.Image = getcustomasset('aerov4/assets/new/notification.png')
		notification.ScaleType = Enum.ScaleType.Slice
		notification.SliceCenter = Rect.new(7, 7, 9, 9)
		notification.Parent = notifications
		addBlur(notification, true)

		local useBg = self.NotificationColor and not (type == 'alert' or type == 'warning')
		local bgColor
		if useBg then
			bgColor = Color3.fromHSV(self.NotificationColor.Hue, self.NotificationColor.Sat, self.NotificationColor.Value)
		end

		local function autoText(col)
			local lum = 0.299*col.R + 0.587*col.G + 0.114*col.B
			return lum > 0.5 and Color3.new(0,0,0) or Color3.new(1,1,1)
		end
		local colorFrame
		if bgColor then
			colorFrame = Instance.new('Frame')
			colorFrame.Size = UDim2.new(1, 0, 1, 0)
			colorFrame.Position = UDim2.new(0, 0, 0, 0)
			colorFrame.BackgroundColor3 = bgColor
			colorFrame.BackgroundTransparency = 0.1
			colorFrame.BorderSizePixel = 0
			colorFrame.ZIndex = 4
			local corner = Instance.new('UICorner')
			corner.CornerRadius = UDim.new(0, 6)
			corner.Parent = colorFrame
			colorFrame.Parent = notification
		end

		local titleTextColor = bgColor and autoText(bgColor) or Color3.fromRGB(209, 209, 209)
		local bodyTextColor  = bgColor and autoText(bgColor) or Color3.fromRGB(170, 170, 170)
		local strokeHex      = (bgColor and (0.299*bgColor.R + 0.587*bgColor.G + 0.114*bgColor.B) > 0.5) and '000000' or 'FFFFFF'

		local iconshadow = Instance.new('ImageLabel')
		iconshadow.Name = 'Icon'
		iconshadow.Size = UDim2.fromOffset(60, 60)
		iconshadow.Position = UDim2.fromOffset(-5, -8)
		iconshadow.ZIndex = 5
		iconshadow.BackgroundTransparency = 1
		iconshadow.Image = getcustomasset('aerov4/assets/new/'..(type or 'info')..'.png')
		iconshadow.ImageColor3 = Color3.new()
		iconshadow.ImageTransparency = 0.5
		iconshadow.Parent = notification
		local icon = iconshadow:Clone()
		icon.Position = UDim2.fromOffset(-1, -1)
		icon.ImageColor3 = Color3.new(1, 1, 1)
		icon.ImageTransparency = 0
		icon.Parent = iconshadow

		local titlelabel = Instance.new('TextLabel')
		titlelabel.Name = 'Title'
		titlelabel.Size = UDim2.new(1, -56, 0, 20)
		titlelabel.Position = UDim2.fromOffset(46, 16)
		titlelabel.ZIndex = 5
		titlelabel.BackgroundTransparency = 1
		titlelabel.Text = "<stroke color='#"..strokeHex.."' joins='round' thickness='0.3' transparency='0.5'>"..title..'</stroke>'
		titlelabel.TextXAlignment = Enum.TextXAlignment.Left
		titlelabel.TextYAlignment = Enum.TextYAlignment.Top
		titlelabel.TextColor3 = titleTextColor
		titlelabel.TextSize = 14
		titlelabel.RichText = true
		titlelabel.FontFace = uipallet.FontSemiBold
		titlelabel.Parent = notification

		local textshadow = titlelabel:Clone()
		textshadow.Name = 'Text'
		textshadow.Position = UDim2.fromOffset(47, 44)
		textshadow.Text = removeTags(text)
		textshadow.TextColor3 = Color3.new()
		textshadow.TextTransparency = 0.5
		textshadow.RichText = false
		textshadow.FontFace = uipallet.Font
		textshadow.Parent = notification

		local textlabel = textshadow:Clone()
		textlabel.Position = UDim2.fromOffset(-1, -1)
		textlabel.Text = text
		textlabel.TextColor3 = bodyTextColor
		textlabel.TextTransparency = 0
		textlabel.RichText = true
		textlabel.Parent = textshadow

		local progress = Instance.new('Frame')
		progress.Name = 'Progress'
		progress.Size = UDim2.new(1, -13, 0, 2)
		progress.Position = UDim2.new(0, 3, 1, -4)
		progress.ZIndex = 5
		progress.BackgroundColor3 =
			type == 'alert' and Color3.fromRGB(250, 50, 56)
			or type == 'warning' and Color3.fromRGB(236, 129, 43)
			or (self.NotificationBarColor and Color3.fromHSV(self.NotificationBarColor.Hue, self.NotificationBarColor.Sat, self.NotificationBarColor.Value))
			or (self.NotificationColor and Color3.fromHSV(self.NotificationColor.Hue, self.NotificationColor.Sat, self.NotificationColor.Value))
			or Color3.fromRGB(220, 220, 220)
		progress.BorderSizePixel = 0
		progress.Parent = notification

		if tween.Tween then
			tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
				AnchorPoint = Vector2.new(1, 0)
			}, tween.tweenstwo)
			tween:Tween(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
				Size = UDim2.fromOffset(0, 2)
			})
		end
		task.delay(duration, function()
			if tween.Tween then
				tween:Tween(notification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
					AnchorPoint = Vector2.new(0, 0)
				}, tween.tweenstwo)
			end
			task.wait(0.2)
			notification:ClearAllChildren()
			notification:Destroy()
		end)
	end)
end

function mainapi:Load(skipgui, profile)
	if not skipgui then
		self.GUIColor:SetValue(nil, nil, nil, 4)
	end

	local guidata = {Categories = {}}
	local savecheck = true

	local guiFile = 'aerov4/profiles/'..game.GameId..'.gui.txt'

	if isfile(guiFile) then
		local success, result = pcall(loadJson, guiFile)
		if success and result then
			guidata = result
		else
			self:CreateNotification('Vape', 'Failed to load GUI settings. Using defaults.', 10, 'alert')
			savecheck = false
		end

		if guidata.MobileSettings then
			local ms = guidata.MobileSettings
			mobileButtonTransparency = ms.Transparency or 0
			if ms.BgColor then
				mobileButtonBgColor = Color3.new(ms.BgColor.R, ms.BgColor.G, ms.BgColor.B)
			end
			if ms.ActiveColor then
				mobileButtonActiveColor = Color3.new(ms.ActiveColor.R, ms.ActiveColor.G, ms.ActiveColor.B)
			end
		end

		if guidata.NotifBgColor and guidata.NotifBgEnabled then
			mainapi.NotificationColor = guidata.NotifBgColor
		end
		if guidata.NotifBarColor and guidata.NotifBarEnabled then
			mainapi.NotificationBarColor = guidata.NotifBarColor
		end
		if guidata.NotifBgEnabled and notifColorToggle and not notifColorToggle.Enabled then
			notifColorToggle:Toggle()
		end
		if guidata.NotifBarEnabled and notifBarColorToggle and not notifBarColorToggle.Enabled then
			notifBarColorToggle:Toggle()
		end

		if not skipgui then
			self.Keybind = guidata.Keybind or self.Keybind

			for i, v in guidata.Categories do
				local object = self.Categories[i]
				if not object then continue end

				if object.Options and v.Options then
					self:LoadOptions(object, v.Options)
				end
				if v.Enabled and object.Button then
					object.Button:Toggle()
				end
				if v.Pinned then 
					object:Pin() 
				end
				if v.Expanded and object.Expand then 
					object:Expand() 
				end
				if v.List then
					object.List = v.List or {}
					object.ListEnabled = v.ListEnabled or {}
					object:ChangeValue()
				end
				if v.Position then
					object.Object.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
				end
			end
		end
	end

	self.Profile = profile or guidata.Profile or 'default'
	self.Profiles = guidata.Profiles or {{Name = 'default', Bind = {}}}

	if not inputService.TouchEnabled then
		for _, p in ipairs(self.Profiles) do
			if type(p.Bind) == 'table' and p.Bind.Mobile then
				p.Bind = {}
			end
		end
	end

	self.Categories.Profiles:ChangeValue()

	if self.ProfileLabel then
		local displayName = #self.Profile > 10 and self.Profile:sub(1, 10) .. '...' or self.Profile
		self.ProfileLabel.Text = displayName
		self.ProfileLabel.Size = UDim2.fromOffset(getfontsize(displayName, self.ProfileLabel.TextSize, self.ProfileLabel.Font).X + 16, 24)
	end

	local profileFile = 'aerov4/profiles/'..self.Profile..self.Place..'.txt'
	local savedata = { Categories = {}, Modules = {}, Legit = {} }

	if isfile(profileFile) then
		local success, result = pcall(loadJson, profileFile)
		
		if success and result then
			savedata = result
		else
			self:CreateNotification('Vape', 'Failed to load '..self.Profile..' profile. Creating a new one.', 10, 'alert')
			savecheck = false
			self:Save()
		end
	else
		self:CreateNotification('Vape', 'No profile found. Creating new profile for '..self.Profile, 8, 'info')
		self:Save()
	end

	for i, v in savedata.Categories or {} do
		local object = self.Categories[i]
		if not object then continue end

		if object.Options and v.Options then
			self:LoadOptions(object, v.Options)
		end
		if v.Pinned ~= object.Pinned then object:Pin() end
		if v.Expanded ~= nil and v.Expanded ~= object.Expanded then object:Expand() end
		if object.Button and (v.Enabled or false) ~= object.Button.Enabled then
			object.Button:Toggle()
		end
		if v.List then
			object.List = v.List or {}
			object.ListEnabled = v.ListEnabled or {}
			object:ChangeValue()
		end
		if v.Position then
			object.Object.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
		end
	end

	local placed = {}
	local function applyPositions()
		for i, v in guidata.Positions or {} do
			local object = self.Categories[i]
			if object and object.Object and not placed[i] and type(v) == 'table' and v.X then
				placed[i] = true
				object.Object.Position = UDim2.fromOffset(v.X, v.Y)
			end
		end
	end
	applyPositions()
	task.delay(3, applyPositions)

	for i, v in savedata.Modules or {} do
		local object = self.Modules[i]
		if not object then continue end

		if object.Options and v.Options then
			self:LoadOptions(object, v.Options)
		end

		if v.Enabled ~= object.Enabled then
			if skipgui and self.ToggleNotifications.Enabled then
				self:CreateNotification('Module Toggled', i .. "<font color='#FFFFFF'> has been </font>" .. (v.Enabled and "<font color='#5AFF5A'>Enabled</font>" or "<font color='#FF5A5A'>Disabled</font>") .. "<font color='#FFFFFF'>!</font>", 0.75)
			end
			object:Toggle(true)
		end

		object.KeybindMode = v.KeybindMode or "Toggle"
		object.HoldCount = 0

		if inputService.TouchEnabled and type(v.Bind) == 'table' and v.Bind.Mobile then
			object:SetBind({})
			if object.Object and object.Object.Bind then
				object.Object.Bind.Visible = false
			end
		else
			object:SetBind(v.Bind or {})
			if object.Object and object.Object.Bind then
				object.Object.Bind.Visible = type(v.Bind) == 'table' and #v.Bind > 0
			end
		end

		if v.Pinned and not object.Pinned then
			pcall(function()
				local pinButton = object.Object:FindFirstChild('Favorite')
				if pinButton then
					for _, conn in getconnections(pinButton.MouseButton1Click) do
						conn:Fire()
					end
				end
			end)
		end
	end

	for _, data in mobileButtons do
		pcall(function()
			if data.button then data.button:Destroy() end
			if data.settingsPanel then data.settingsPanel:Destroy() end
		end)
	end
	table.clear(mobileButtons)

	for i, v in savedata.Modules or {} do
		local object = self.Modules[i]
		if object and inputService.TouchEnabled and type(v.Bind) == 'table' and v.Bind.Mobile then
			createMobileButton(object, Vector2.new(v.Bind.X or 0, v.Bind.Y or 0), v.Bind.W, v.Bind.H)
		end
	end

	for i, v in savedata.Legit or {} do
		local object = self.Legit.Modules[i]
		if not object then continue end
		if object.Options and v.Options then
			self:LoadOptions(object, v.Options)
		end
		if object.Enabled ~= (v.Enabled or false) then
			object:Toggle()
		end
		if v.Position and object.Children then
			object.Children.Position = UDim2.fromOffset(v.Position.X, v.Position.Y)
		end
	end

	self:UpdateTextGUI(true)
	gui.Enabled = true

	if self.Downloader then
		self.Downloader:Destroy()
		self.Downloader = nil
	end

	if self.DownloaderGui then
		self.DownloaderGui:Destroy()
		self.DownloaderGui = nil
	end

	if mainapi.ThreadFix then
		setthreadidentity(8)
	end

	self.Loaded = savecheck
	self.Categories.Main.Options.Bind:SetBind(self.Keybind)
	if inputService.TouchEnabled and #self.Keybind == 1 and self.Keybind[1] == 'RightShift' then
		local button = Instance.new('TextButton')
		button.Size = UDim2.fromOffset(32, 32)
		button.Position = UDim2.new(1, -210, 0, 4)
		button.BackgroundColor3 = Color3.new()
		button.BackgroundTransparency = 0.5
		button.Text = ''
		button.Parent = gui
		local image = Instance.new('ImageLabel')
		image.Size = UDim2.fromOffset(26, 26)
		image.Position = UDim2.fromOffset(3, 3)
		image.BackgroundTransparency = 1
		image.Image = getcustomasset('aerov4/assets/new/vape.png')
		image.Parent = button
		local buttoncorner = Instance.new('UICorner')
		buttoncorner.Parent = button
		self.VapeButton = button
		button.MouseButton1Click:Connect(function()
			if self.ThreadFix then
				setthreadidentity(8)
			end
			for _, v in self.Windows do
				v.Visible = false
			end
			for _, mobileButton in self.Modules do
				if mobileButton.Bind.Button then
					mobileButton.Bind.Button.Visible = clickgui.Visible
				end
			end
			clickgui.Visible = not clickgui.Visible
			tooltip.Visible = false
			self:BlurCheck()
			for _, data in mobileButtons do
				if data.button and data.button.Parent then
					data.button.Visible = not clickgui.Visible or mobileEditorOpen
				end
			end
		end)
	end
end

function mainapi:LoadOptions(object, savedoptions)
	if mainapi.ThreadFix then
		setthreadidentity(8)
	end
	for i, v in savedoptions do
		local option = object.Options[i]
		if not option then continue end
		pcall(function()
			option:Load(v)
		end)
	end
end

function mainapi:Remove(obj)
	local tab = (self.Modules[obj] and self.Modules or self.Legit.Modules[obj] and self.Legit.Modules or self.Categories)
	if tab and tab[obj] then
		local newobj = tab[obj]
		if self.ThreadFix then
			setthreadidentity(8)
		end

		for _, v in {'Object', 'Children', 'Toggle', 'Button'} do
			local childobj = typeof(newobj[v]) == 'table' and newobj[v].Object or newobj[v]
			if typeof(childobj) == 'Instance' then
				childobj:Destroy()
				childobj:ClearAllChildren()
			end
		end

		loopClean(newobj)
		tab[obj] = nil
	end
end

function mainapi:Save(newprofile)
	if mainapi.ThreadFix then setthreadidentity(8) end
	if not self.Loaded then return end

	local guidata = {
		Categories = {},
		Profile = newprofile or self.Profile,
		Profiles = self.Profiles,
		Keybind = self.Keybind,
		MobileSettings = {
			Transparency = mobileButtonTransparency,
			BgColor = mobileButtonBgColor and {R = mobileButtonBgColor.R, G = mobileButtonBgColor.G, B = mobileButtonBgColor.B} or nil,
			ActiveColor = mobileButtonActiveColor and {R = mobileButtonActiveColor.R, G = mobileButtonActiveColor.G, B = mobileButtonActiveColor.B} or nil,
		},
		NotifBgColor = self.NotificationColor and {Hue = self.NotificationColor.Hue, Sat = self.NotificationColor.Sat, Value = self.NotificationColor.Value} or nil,
		NotifBarColor = self.NotificationBarColor and {Hue = self.NotificationBarColor.Hue, Sat = self.NotificationBarColor.Sat, Value = self.NotificationBarColor.Value} or nil,
		NotifBgEnabled = notifColorToggle and notifColorToggle.Enabled or false,
		NotifBarEnabled = notifBarColorToggle and notifBarColorToggle.Enabled or false,
	}

	local savedata = {
		Modules = {},
		Categories = {},
		Legit = {}
	}

	for i, v in self.Categories do
		(v.Type ~= 'Category' and i ~= 'Main' and savedata or guidata).Categories[i] = {
			Enabled = i ~= 'Main' and v.Button.Enabled or nil,
			Expanded = v.Type ~= 'Overlay' and v.Expanded or nil,
			Pinned = v.Pinned,
			Position = {X = v.Object.Position.X.Offset, Y = v.Object.Position.Y.Offset},
			Options = mainapi:SaveOptions(v, v.Options),
			List = v.List,
			ListEnabled = v.ListEnabled
		}
	end

	guidata.Positions = {}
	local oldgui = isfile('aerov4/profiles/'..game.GameId..'.gui.txt') and loadJson('aerov4/profiles/'..game.GameId..'.gui.txt')
	if type(oldgui) == 'table' then
		for i, v in oldgui.Categories or {} do
			if not self.Categories[i] then
				guidata.Categories[i] = v
			end
		end
		for i, v in oldgui.Positions or {} do
			guidata.Positions[i] = v
		end
	end
	for i, v in self.Categories do
		if v.Object then
			guidata.Positions[i] = {X = v.Object.Position.X.Offset, Y = v.Object.Position.Y.Offset}
		end
	end

	for i, v in self.Modules do
		if not v then continue end
		local mobileSave = nil
		for _, mbData in mobileButtons do
			if mbData.module == v then
				local btn = mbData.button
				if btn and btn.Parent then
					mobileSave = {
						Mobile = true,
						X = btn.Position.X.Offset,
						Y = btn.Position.Y.Offset,
						W = btn.Size.X.Offset,
						H = btn.Size.Y.Offset,
					}
				end
				break
			end
		end

		savedata.Modules[i] = {
			Enabled = v.Enabled,
			Bind = mobileSave or (v.Bind.Button and {Mobile = true, X = v.Bind.Button.Position.X.Offset, Y = v.Bind.Button.Position.Y.Offset} or v.Bind),
			Options = mainapi:SaveOptions(v, true),
			Pinned = v.Pinned or false,
			KeybindMode = v.KeybindMode or "Toggle"
		}
	end

	for i, v in self.Legit.Modules do
		savedata.Legit[i] = {
			Enabled = v.Enabled,
			Position = v.Children and {X = v.Children.Position.X.Offset, Y = v.Children.Position.Y.Offset} or nil,
			Options = v.Options and mainapi:SaveOptions(v, v.Options) or nil
		}
	end

	writefile('aerov4/profiles/' .. game.GameId .. '.gui.txt', httpService:JSONEncode(guidata))
	writefile('aerov4/profiles/' .. self.Profile .. self.Place .. '.txt', httpService:JSONEncode(savedata))
end

function mainapi:SaveOptions(object, savedoptions)
    if not savedoptions then return end
    if not object or not object.Options then return end  
    savedoptions = {}
    for _, v in object.Options do
        if not v or not v.Save then continue end 
        pcall(function()                          
            v:Save(savedoptions)
        end)
    end
    return savedoptions
end

function mainapi:Uninject()
    if getgenv().Closet and getgenv()._vape_originals then
        for name, original in pairs(getgenv()._vape_originals) do
            hookfunction(getgenv()[name], original)
        end
        getgenv()._vape_originals = nil
    end
    if mainapi.ThreadFix then setthreadidentity(8) end
    mainapi:Save()
    mainapi.Loaded = nil
	for _, v in self.Modules do
		if v.Enabled then
			v:Toggle()
		end
	end
	for _, v in self.Legit.Modules do
		if v.Enabled then
			v:Toggle()
		end
	end
	for _, v in self.Categories do
		if v.Type == 'Overlay' and v.Button.Enabled then
			v.Button:Toggle()
		end
	end
	for _, v in mainapi.Connections do
		pcall(function()
			v:Disconnect()
		end)
	end
	if mainapi.ThreadFix then
		setthreadidentity(8)
		clickgui.Visible = false
		mainapi:BlurCheck()
	end
	mainapi.gui:ClearAllChildren()
	mainapi.gui:Destroy()
	table.clear(mainapi.Libraries)
	loopClean(mainapi)
	mainapi.Clean = function() end
	mainapi.Remove = function() end
	mainapi.Save = function() end
	shared.vape = nil
	shared.vapereload = nil
	shared.VapeIndependent = nil
	shared.vape_running = nil 
end

gui = Instance.new('ScreenGui')
gui.Name = randomString()
gui.DisplayOrder = 9999999
gui.ZIndexBehavior = Enum.ZIndexBehavior.Global
gui.IgnoreGuiInset = true
gui.OnTopOfCoreBlur = true
gui.Enabled = false
if mainapi.ThreadFix then
	gui.Parent = cloneref(game:GetService('CoreGui'))
else
	gui.Parent = cloneref(game:GetService('Players')).LocalPlayer.PlayerGui
	gui.ResetOnSpawn = false
end
mainapi.gui = gui
scaledgui = Instance.new('Frame')
scaledgui.Name = 'ScaledGui'
scaledgui.Size = UDim2.fromScale(1, 1)
scaledgui.BackgroundTransparency = 1
scaledgui.Parent = gui
clickgui = Instance.new('Frame')
clickgui.Name = 'ClickGui'
clickgui.Size = UDim2.fromScale(1, 1)
clickgui.BackgroundTransparency = 1
clickgui.Visible = false
clickgui.Parent = scaledgui
local scarcitybanner = Instance.new('TextLabel')
scarcitybanner.Size = UDim2.fromScale(1, 0.02)
scarcitybanner.Position = UDim2.fromScale(0, 0.97)
scarcitybanner.BackgroundTransparency = 1
scarcitybanner.Text = 'tape v4'
scarcitybanner.TextScaled = true
scarcitybanner.TextColor3 = Color3.new(1, 1, 1)
scarcitybanner.TextStrokeTransparency = 0.5
scarcitybanner.FontFace = uipallet.Font
scarcitybanner.Parent = clickgui
local modal = Instance.new('TextButton')
modal.BackgroundTransparency = 1
modal.Modal = true
modal.Text = ''
modal.Parent = clickgui
local cursor = Instance.new('ImageLabel')
cursor.Size = UDim2.fromOffset(64, 64)
cursor.BackgroundTransparency = 1
cursor.Visible = false
cursor.Image = 'rbxasset://textures/Cursors/KeyboardMouse/ArrowFarCursor.png'
cursor.Parent = gui
notifications = Instance.new('Folder')
notifications.Name = 'Notifications'
notifications.Parent = scaledgui
tooltip = Instance.new('TextLabel')
tooltip.Name = 'Tooltip'
tooltip.Position = UDim2.fromScale(-1, -1)
tooltip.ZIndex = 5
tooltip.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
tooltip.Visible = false
tooltip.Text = ''
tooltip.TextColor3 = color.Dark(uipallet.Text, 0.16)
tooltip.TextSize = 12
tooltip.FontFace = uipallet.Font
tooltip.Parent = scaledgui
toolblur = addBlur(tooltip)
addCorner(tooltip)
local toolstrokebkg = Instance.new('Frame')
toolstrokebkg.Size = UDim2.new(1, -2, 1, -2)
toolstrokebkg.Position = UDim2.fromOffset(1, 1)
toolstrokebkg.ZIndex = 6
toolstrokebkg.BackgroundTransparency = 1
toolstrokebkg.Parent = tooltip
local toolstroke = Instance.new('UIStroke')
toolstroke.Color = color.Light(uipallet.Main, 0.02)
toolstroke.Parent = toolstrokebkg
addCorner(toolstrokebkg, UDim.new(0, 4))
local function getAutoScale()
	local size = gui.AbsoluteSize
	if size.X <= 0 or size.Y <= 0 then return 1 end
	local fit = math.min(size.X / 1920, size.Y / 1080)
	if inputService.TouchEnabled and not inputService.KeyboardEnabled then
		return math.clamp(fit * 1.25, 0.45, 1)
	end
	return math.clamp(math.min(size.X / 1920, size.Y / 1080 * 1.35), 0.6, 2)
end

scale = Instance.new('UIScale')
scale.Scale = getAutoScale()
scale.Parent = scaledgui
mainapi.guiscale = scale
scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)

mainapi:Clean(gui:GetPropertyChangedSignal('AbsoluteSize'):Connect(function()
	if mainapi.Scale.Enabled then
		scale.Scale = getAutoScale()
	end
end))

mainapi:Clean(scale:GetPropertyChangedSignal('Scale'):Connect(function()
	scaledgui.Size = UDim2.fromScale(1 / scale.Scale, 1 / scale.Scale)
	for _, v in scaledgui:GetDescendants() do
		if v:IsA('GuiObject') and v.Visible then
			v.Visible = false
			v.Visible = true
		end
	end
end))

mainapi:Clean(clickgui:GetPropertyChangedSignal('Visible'):Connect(function()
	mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true)
	if clickgui.Visible and inputService.MouseEnabled then
		repeat
			local visibleCheck = clickgui.Visible
			for _, v in mainapi.Windows do
				visibleCheck = visibleCheck or v.Visible
			end
			if not visibleCheck then break end

			cursor.Visible = not inputService.MouseIconEnabled
			if cursor.Visible then
				local mouseLocation = inputService:GetMouseLocation()
				cursor.Position = UDim2.fromOffset(mouseLocation.X - 31, mouseLocation.Y - 32)
			end

			task.wait()
		until mainapi.Loaded == nil
		cursor.Visible = false
	end
end))

mainapi:CreateGUI()
mainapi.Categories.Main:CreateDivider()
mainapi:CreateCategory({
	Name = 'Favorites',
	Icon = getcustomasset('aerov4/assets/new/star.png'),
	Size = UDim2.fromOffset(15, 15)
})

mainapi:CreateCategory({
	Name = 'Combat',
	Icon = getcustomasset('aerov4/assets/new/combaticon.png'),
	Size = UDim2.fromOffset(13, 14)
})
mainapi:CreateCategory({
	Name = 'Blatant',
	Icon = getcustomasset('aerov4/assets/new/blatanticon.png'),
	Size = UDim2.fromOffset(14, 14)
})
mainapi:CreateCategory({
	Name = 'Render',
	Icon = getcustomasset('aerov4/assets/new/rendericon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'Utility',
	Icon = getcustomasset('aerov4/assets/new/utilityicon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'World',
	Icon = getcustomasset('aerov4/assets/new/worldicon.png'),
	Size = UDim2.fromOffset(14, 14)
})
mainapi:CreateCategory({
	Name = 'Inventory',
	Icon = getcustomasset('aerov4/assets/new/inventoryicon.png'),
	Size = UDim2.fromOffset(15, 14)
})
mainapi:CreateCategory({
	Name = 'Minigames',
	Icon = getcustomasset('aerov4/assets/new/miniicon.png'),
	Size = UDim2.fromOffset(19, 12)
})
mainapi:CreateCategory({
	Name = 'Legit',
	Icon = getcustomasset('aerov4/assets/new/legiticon.png'),
	Size = UDim2.fromOffset(15, 15)
})
if game.GameId == 2619619496 and game.PlaceId ~= 6872265039 then
	mainapi:CreateCategory({
		Name = 'Kits',
		Icon = getcustomasset('aerov4/assets/new/kiticon.png'),
		Size = UDim2.fromOffset(15, 15)
	})
end
mainapi.Categories.Main:CreateDivider('misc')

--[[
	Friends
]]
local friends
local friendscolor = {
	Hue = 1,
	Sat = 1,
	Value = 1
}
local friendssettings = {
	Name = 'Friends',
	Icon = getcustomasset('aerov4/assets/new/friendstab.png'),
	Size = UDim2.fromOffset(17, 16),
	Placeholder = 'Roblox username',
	Color = Color3.fromRGB(5, 134, 105),
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
}
friends = mainapi:CreateCategoryList(friendssettings)
friends.Update = Instance.new('BindableEvent')
friends.ColorUpdate = Instance.new('BindableEvent')
friends:CreateToggle({
	Name = 'Recolor visuals',
	Darker = true,
	Default = true,
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
})
friendscolor = friends:CreateColorSlider({
	Name = 'Friends color',
	Darker = true,
	Function = function(hue, sat, val)
		for _, v in friends.Object.Children:GetChildren() do
			local dot = v:FindFirstChild('Dot')
			if dot and dot.BackgroundColor3 ~= color.Light(uipallet.Main, 0.37) then
				dot.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
				dot.Dot.BackgroundColor3 = dot.BackgroundColor3
			end
		end
		friendssettings.Color = Color3.fromHSV(hue, sat, val)
		friends.ColorUpdate:Fire(hue, sat, val)
	end
})
friends:CreateToggle({
	Name = 'Use friends',
	Darker = true,
	Default = true,
	Function = function()
		friends.Update:Fire()
		friends.ColorUpdate:Fire(friendscolor.Hue, friendscolor.Sat, friendscolor.Value)
	end
})
mainapi:Clean(friends.Update)
mainapi:Clean(friends.ColorUpdate)

--[[
	Profiles 
]]
local profilesCategory = mainapi:CreateCategoryList({
	Name = 'Profiles',
	Icon = getcustomasset('aerov4/assets/new/profilesicon.png'),
	Size = UDim2.fromOffset(17, 10),
	Position = UDim2.fromOffset(12, 16),
	Placeholder = 'Type name',
	Profiles = true
})

local function getPremadeProfiles()
	local premades = {}
	local currentGame = tostring(mainapi.Place)
	
	if not isfolder('aerov4/profiles/premade') then
		makefolder('aerov4/profiles/premade')
	end
	
	for _, file in pairs(listfiles('aerov4/profiles/premade')) do
		local fileName = file:gsub('\\', '/'):match('.*/(.+)%.txt$')
		if fileName then
			local profileName = fileName:match('^(.+)'..currentGame..'$')
			if profileName and profileName ~= '' then
				table.insert(premades, profileName)
			end
		end
	end
	
	return premades
end

local premadeBlocker = Instance.new('TextButton')
premadeBlocker.Name = 'PremadeBlocker'
premadeBlocker.Size = UDim2.new(1, 0, 1, 0)
premadeBlocker.Position = UDim2.new(0, 0, 0, 0)
premadeBlocker.BackgroundColor3 = Color3.new(0, 0, 0)
premadeBlocker.BackgroundTransparency = 0.5
premadeBlocker.BorderSizePixel = 0
premadeBlocker.Text = ''
premadeBlocker.AutoButtonColor = false
premadeBlocker.Visible = false
premadeBlocker.Parent = scaledgui

local premadeWindow = Instance.new('Frame')
premadeWindow.Name = 'PremadeConfigsGUI'
premadeWindow.Size = UDim2.fromOffset(680, 480)
premadeWindow.Position = UDim2.new(0.5, -340, 0.5, -240)
premadeWindow.BackgroundColor3 = uipallet.Main
premadeWindow.Visible = false
premadeWindow.Parent = scaledgui
addBlur(premadeWindow)
addCorner(premadeWindow)
makeDraggable(premadeWindow)
local premadeModal = Instance.new('TextButton')
premadeModal.BackgroundTransparency = 1
premadeModal.Text = ''
premadeModal.Modal = true
premadeModal.Parent = premadeWindow
local premadeHeaderGradient = Instance.new('Frame')
premadeHeaderGradient.Name = 'HeaderGradient'
premadeHeaderGradient.Size = UDim2.new(1, 0, 0, 50)
premadeHeaderGradient.BackgroundColor3 = Color3.fromRGB(5, 134, 105)
premadeHeaderGradient.BackgroundTransparency = 0.92
premadeHeaderGradient.BorderSizePixel = 0
premadeHeaderGradient.Parent = premadeWindow
addCorner(premadeHeaderGradient)
local premadeIcon = Instance.new('ImageLabel')
premadeIcon.Name = 'Icon'
premadeIcon.Size = UDim2.fromOffset(20, 12)
premadeIcon.Position = UDim2.fromOffset(20, 19)
premadeIcon.BackgroundTransparency = 1
premadeIcon.Image = getcustomasset('aerov4/assets/new/profilesicon.png')
premadeIcon.ImageColor3 = Color3.fromRGB(5, 200, 160)
premadeIcon.Parent = premadeWindow
local premadeTitle = Instance.new('TextLabel')
premadeTitle.Name = 'Title'
premadeTitle.Size = UDim2.new(1, -100, 0, 22)
premadeTitle.Position = UDim2.fromOffset(50, 14)
premadeTitle.BackgroundTransparency = 1
premadeTitle.Text = 'Preset Configs'
premadeTitle.TextXAlignment = Enum.TextXAlignment.Left
premadeTitle.TextColor3 = Color3.new(1, 1, 1)
premadeTitle.TextSize = 15
premadeTitle.FontFace = uipallet.FontSemiBold
premadeTitle.Parent = premadeWindow
local premadeSubtitle = Instance.new('TextLabel')
premadeSubtitle.Name = 'Subtitle'
premadeSubtitle.Size = UDim2.new(1, -100, 0, 14)
premadeSubtitle.Position = UDim2.fromOffset(50, 32)
premadeSubtitle.BackgroundTransparency = 1
premadeSubtitle.Text = 'Curated configurations from known players'
premadeSubtitle.TextXAlignment = Enum.TextXAlignment.Left
premadeSubtitle.TextColor3 = color.Dark(uipallet.Text, 0.4)
premadeSubtitle.TextSize = 11
premadeSubtitle.FontFace = uipallet.Font
premadeSubtitle.Parent = premadeWindow
local premadeClose = addCloseButton(premadeWindow)
premadeClose.MouseButton1Click:Connect(function()
	tween:Tween(premadeWindow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
		Position = UDim2.new(0.5, -340, 0.5, -220),
		Size = UDim2.fromOffset(640, 440)
	})
	task.wait(0.15)
	premadeWindow.Visible = false
	premadeBlocker.Visible = false
end)

local premadeContentBg = Instance.new('Frame')
premadeContentBg.Size = UDim2.new(1, -28, 1, -78)
premadeContentBg.Position = UDim2.fromOffset(14, 58)
premadeContentBg.BackgroundColor3 = color.Dark(uipallet.Main, 0.03)
premadeContentBg.BorderSizePixel = 0
premadeContentBg.Parent = premadeWindow
addCorner(premadeContentBg, UDim.new(0, 6))
local premadeChildren = Instance.new('ScrollingFrame')
premadeChildren.Name = 'Children'
premadeChildren.Size = UDim2.fromOffset(380, 388)
premadeChildren.Position = UDim2.fromOffset(8, 8)
premadeChildren.BackgroundTransparency = 1
premadeChildren.BorderSizePixel = 0
premadeChildren.ScrollBarThickness = 3
premadeChildren.ScrollBarImageColor3 = Color3.fromRGB(5, 134, 105)
premadeChildren.ScrollBarImageTransparency = 0.5
premadeChildren.CanvasSize = UDim2.new()
premadeChildren.AutomaticCanvasSize = Enum.AutomaticSize.Y
premadeChildren.Parent = premadeContentBg
local premadeList = Instance.new('UIListLayout')
premadeList.SortOrder = Enum.SortOrder.LayoutOrder
premadeList.Padding = UDim.new(0, 6)
premadeList.Parent = premadeChildren
local previewPanel = Instance.new('Frame')
previewPanel.Name = 'PreviewPanel'
previewPanel.Size = UDim2.fromOffset(244, 388)
previewPanel.Position = UDim2.fromOffset(396, 8)
previewPanel.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
previewPanel.BorderSizePixel = 0
previewPanel.Parent = premadeContentBg
addCorner(previewPanel, UDim.new(0, 6))
local previewTitle = Instance.new('TextLabel')
previewTitle.Name = 'Title'
previewTitle.Size = UDim2.fromOffset(220, 20)
previewTitle.Position = UDim2.fromOffset(12, 12)
previewTitle.BackgroundTransparency = 1
previewTitle.Text = 'Preview'
previewTitle.TextXAlignment = Enum.TextXAlignment.Left
previewTitle.TextColor3 = uipallet.Text
previewTitle.TextSize = 13
previewTitle.FontFace = uipallet.FontSemiBold
previewTitle.Parent = previewPanel
local previewDivider = Instance.new('Frame')
previewDivider.Size = UDim2.new(1, -24, 0, 1)
previewDivider.Position = UDim2.fromOffset(12, 38)
previewDivider.BackgroundColor3 = Color3.new(1, 1, 1)
previewDivider.BackgroundTransparency = 0.93
previewDivider.BorderSizePixel = 0
previewDivider.Parent = previewPanel
local previewScroll = Instance.new('ScrollingFrame')
previewScroll.Name = 'PreviewScroll'
previewScroll.Size = UDim2.fromOffset(220, 330)
previewScroll.Position = UDim2.fromOffset(12, 46)
previewScroll.BackgroundTransparency = 1
previewScroll.BorderSizePixel = 0
previewScroll.ScrollBarThickness = 2
previewScroll.ScrollBarImageTransparency = 0.7
previewScroll.CanvasSize = UDim2.new()
previewScroll.Parent = previewPanel
local previewList = Instance.new('UIListLayout')
previewList.SortOrder = Enum.SortOrder.LayoutOrder
previewList.Padding = UDim.new(0, 4)
previewList.Parent = previewScroll
local previewPlaceholder = Instance.new('TextLabel')
previewPlaceholder.Size = UDim2.fromOffset(220, 100)
previewPlaceholder.Position = UDim2.fromOffset(0, 100)
previewPlaceholder.BackgroundTransparency = 1
previewPlaceholder.Text = 'Select a config\nto preview settings'
previewPlaceholder.TextColor3 = color.Dark(uipallet.Text, 0.6)
previewPlaceholder.TextSize = 12
previewPlaceholder.FontFace = uipallet.Font
previewPlaceholder.Parent = previewPanel

table.insert(mainapi.Windows, premadeWindow)

local configColors = {
	Color3.fromRGB(88, 101, 242),  
	Color3.fromRGB(235, 69, 158),  
	Color3.fromRGB(87, 242, 135),  
	Color3.fromRGB(254, 231, 92),  
	Color3.fromRGB(255, 115, 66),  
	Color3.fromRGB(94, 200, 248),  
}

local function showPreview(profileName)
	for _, child in pairs(previewScroll:GetChildren()) do
		if child:IsA('Frame') or child:IsA('TextLabel') then
			child:Destroy()
		end
	end
	previewPlaceholder.Visible = false
	
	local premadeFile = 'aerov4/profiles/premade/'..profileName..mainapi.Place..'.txt'
	
	if not isfile(premadeFile) then
		previewPlaceholder.Visible = true
		previewPlaceholder.Text = 'Config file not found'
		return
	end
	
	local success, configData = pcall(function()
		return httpService:JSONDecode(readfile(premadeFile))
	end)
	
	if not success or type(configData) ~= 'table' then
		previewPlaceholder.Visible = true
		previewPlaceholder.Text = 'Unable to load preview'
		return
	end
	
	local gameName = "BedWars"
	local placeNames = {
		['6872265039'] = 'Lobby ('..gameName..')',
		['6872274481'] = 'In-Game ('..gameName..')',
		['8444591321'] = 'Custom ('..gameName..')'
	}
	
	local modulesByPlace = {}
	local totalCount = 0
	local enabledCount = 0
	
	if configData.Modules and type(configData.Modules) == 'table' then
		for moduleName, moduleData in pairs(configData.Modules) do
			if type(moduleData) == 'table' then
				totalCount = totalCount + 1
				if moduleData.Enabled then
					enabledCount = enabledCount + 1
					
					local placeId = moduleData.PlaceId and tostring(moduleData.PlaceId)
					
					if placeId == '8444591321' then
						placeId = '6872274481'
					end
				
					if not placeId then
						placeId = '6872274481' 
					end
					
					if not modulesByPlace[placeId] then
						modulesByPlace[placeId] = {}
					end
					table.insert(modulesByPlace[placeId], {
						name = moduleName,
						data = moduleData
					})
				end
			end
		end
	end
	
	local statsFrame = Instance.new('Frame')
	statsFrame.Size = UDim2.fromOffset(220, 60)
	statsFrame.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
	statsFrame.Parent = previewScroll
	addCorner(statsFrame, UDim.new(0, 4))
	
	local statsText = Instance.new('TextLabel')
	statsText.Size = UDim2.fromOffset(200, 16)
	statsText.Position = UDim2.fromOffset(10, 10)
	statsText.BackgroundTransparency = 1
	statsText.Text = string.format('%d Total Modules', totalCount)
	statsText.TextXAlignment = Enum.TextXAlignment.Left
	statsText.TextColor3 = uipallet.Text
	statsText.TextSize = 12
	statsText.FontFace = uipallet.FontSemiBold
	statsText.Parent = statsFrame
	
	local enabledText = Instance.new('TextLabel')
	enabledText.Size = UDim2.fromOffset(200, 14)
	enabledText.Position = UDim2.fromOffset(10, 30)
	enabledText.BackgroundTransparency = 1
	enabledText.Text = string.format('%d Enabled', enabledCount)
	enabledText.TextXAlignment = Enum.TextXAlignment.Left
	enabledText.TextColor3 = Color3.fromRGB(87, 242, 135)
	enabledText.TextSize = 11
	enabledText.FontFace = uipallet.Font
	enabledText.Parent = statsFrame
	
	local function formatOptionValue(key, value)
		if key == 'Enabled' or key == 'PlaceId' or key == 'Bind' or key == 'Pinned' then
			return nil
		end
	
		if type(value) == 'boolean' then
			return value and 'ON' or 'OFF'
		elseif type(value) == 'number' then
			return string.format('%.2f', value):gsub('%.?0+$', '')
		elseif type(value) == 'string' then
			return value ~= '' and value or nil
		elseif type(value) == 'table' then
			if value.Enabled ~= nil then
				return value.Enabled and 'ON' or 'OFF'
			elseif value.Value ~= nil then
				return tostring(value.Value)
			elseif value.Hue ~= nil and value.Sat ~= nil and value.Value ~= nil then
				local color = Color3.fromHSV(value.Hue, value.Sat, value.Value)
				return string.format('RGB(%d,%d,%d)', 
					math.floor(color.R * 255), 
					math.floor(color.G * 255), 
					math.floor(color.B * 255))
			elseif value.Value ~= nil then
				return tostring(value.Value)
			elseif next(value) == nil then
				return nil
			end
		end
		return nil
	end
	
	local function createModuleItem(modName, moduleData)
		local moduleFrame = Instance.new('Frame')
		moduleFrame.Size = UDim2.fromOffset(220, 24)
		moduleFrame.BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
		moduleFrame.Parent = previewScroll
		addCorner(moduleFrame, UDim.new(0, 4))
		
		local moduleButton = Instance.new('TextButton')
		moduleButton.Size = UDim2.fromScale(1, 1)
		moduleButton.BackgroundTransparency = 1
		moduleButton.Text = ''
		moduleButton.Parent = moduleFrame
		
		local moduleIndicator = Instance.new('Frame')
		moduleIndicator.Size = UDim2.fromOffset(3, 16)
		moduleIndicator.Position = UDim2.fromOffset(8, 4)
		moduleIndicator.BackgroundColor3 = Color3.fromRGB(87, 242, 135)
		moduleIndicator.BorderSizePixel = 0
		moduleIndicator.Parent = moduleFrame
		addCorner(moduleIndicator, UDim.new(1, 0))
		
		local moduleNameLabel = Instance.new('TextLabel')
		moduleNameLabel.Size = UDim2.fromOffset(200, 24)
		moduleNameLabel.Position = UDim2.fromOffset(18, 0)
		moduleNameLabel.BackgroundTransparency = 1
		local displayName = tostring(modName):gsub('([A-Z])', ' %1'):gsub('^%s+', '')
		moduleNameLabel.Text = displayName
		moduleNameLabel.TextXAlignment = Enum.TextXAlignment.Left
		moduleNameLabel.TextColor3 = color.Dark(uipallet.Text, 0.2)
		moduleNameLabel.TextSize = 11
		moduleNameLabel.FontFace = uipallet.Font
		moduleNameLabel.Parent = moduleFrame
		
		local tooltipText = displayName .. '\n\n'
		local hasOptions = false
		local optionCount = 0
		
		if type(moduleData.Options) == 'table' then
			local formattedOptions = {}
			
			for optName, optValue in pairs(moduleData.Options) do
				local formatted = formatOptionValue(optName, optValue)
				if formatted then
					local optDisplay = tostring(optName):gsub('([A-Z])', ' %1'):gsub('^%s+', '')
					table.insert(formattedOptions, string.format('• %s: %s', optDisplay, formatted))
					optionCount = optionCount + 1
				end
			end
			
			table.sort(formattedOptions)
			
			if #formattedOptions > 0 then
				hasOptions = true
				tooltipText = tooltipText .. table.concat(formattedOptions, '\n')
			end
		end
		
		if not hasOptions then
			tooltipText = tooltipText .. 'No custom options configured'
		end
		
		addTooltip(moduleButton, tooltipText:gsub('\n$', ''))
		
		moduleButton.MouseEnter:Connect(function()
			tween:Tween(moduleFrame, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			})
			moduleNameLabel.TextColor3 = uipallet.Text
		end)
		
		moduleButton.MouseLeave:Connect(function()
			tween:Tween(moduleFrame, uipallet.Tween, {
				BackgroundColor3 = color.Dark(uipallet.Main, 0.02)
			})
			moduleNameLabel.TextColor3 = color.Dark(uipallet.Text, 0.2)
		end)
		
		return moduleFrame
	end
	
	local displayOrder = {
		{id = '6872265039', name = 'Lobby (BedWars)'},
		{id = '6872274481', name = 'In-Game (BedWars)'}
	}
	
	local hasAnyModules = false
	
	for _, place in ipairs(displayOrder) do
		local modules = modulesByPlace[place.id]
		if modules and #modules > 0 then
			hasAnyModules = true
			
			local categoryHeader = Instance.new('TextLabel')
			categoryHeader.Size = UDim2.fromOffset(220, 20)
			categoryHeader.BackgroundTransparency = 1
			categoryHeader.Text = string.format('%s (%d)', place.name, #modules)
			categoryHeader.TextXAlignment = Enum.TextXAlignment.Left
			categoryHeader.TextColor3 = Color3.fromRGB(87, 242, 135)
			categoryHeader.TextSize = 11
			categoryHeader.FontFace = uipallet.FontSemiBold
			categoryHeader.Parent = previewScroll
			
			for _, module in ipairs(modules) do
				createModuleItem(module.name, module.data)
			end
			
			local spacer = Instance.new('Frame')
			spacer.Size = UDim2.fromOffset(220, 8)
			spacer.BackgroundTransparency = 1
			spacer.Parent = previewScroll
		end
	end
	
	if not hasAnyModules then
		local noModulesText = Instance.new('TextLabel')
		noModulesText.Size = UDim2.fromOffset(220, 60)
		noModulesText.BackgroundTransparency = 1
		noModulesText.Text = 'No enabled modules found\nin this preset'
		noModulesText.TextColor3 = color.Dark(uipallet.Text, 0.5)
		noModulesText.TextSize = 11
		noModulesText.FontFace = uipallet.Font
		noModulesText.Parent = previewScroll
	end
	
	task.wait()
	previewScroll.CanvasSize = UDim2.fromOffset(220, previewList.AbsoluteContentSize.Y + 10)
end

local function refreshPremadeWindow()
	for _, child in pairs(premadeChildren:GetChildren()) do
		if child:IsA('Frame') then
			child:Destroy()
		end
	end
	
	for _, child in pairs(previewScroll:GetChildren()) do
		if child:IsA('Frame') then
			child:Destroy()
		end
	end
	previewPlaceholder.Visible = true
	previewPlaceholder.Text = 'Select a config\nto preview settings'
	
	local premades = getPremadeProfiles()
	
	if #premades == 0 then
		local emptyFrame = Instance.new('Frame')
		emptyFrame.Size = UDim2.fromOffset(380, 120)
		emptyFrame.BackgroundTransparency = 1
		emptyFrame.Parent = premadeChildren
		
		local emptyIcon = Instance.new('ImageLabel')
		emptyIcon.Size = UDim2.fromOffset(40, 24)
		emptyIcon.Position = UDim2.fromOffset(170, 30)
		emptyIcon.BackgroundTransparency = 1
		emptyIcon.Image = getcustomasset('aerov4/assets/new/profilesicon.png')
		emptyIcon.ImageColor3 = color.Dark(uipallet.Text, 0.7)
		emptyIcon.Parent = emptyFrame
		
		local emptyText = Instance.new('TextLabel')
		emptyText.Size = UDim2.fromOffset(380, 40)
		emptyText.Position = UDim2.fromOffset(0, 65)
		emptyText.BackgroundTransparency = 1
		emptyText.Text = 'No premade configs available\nConfigs will appear here after downloading'
		emptyText.TextColor3 = color.Dark(uipallet.Text, 0.5)
		emptyText.TextSize = 13
		emptyText.FontFace = uipallet.Font
		emptyText.Parent = emptyFrame
		
		premadeChildren.CanvasSize = UDim2.fromOffset(380, 120)
		return
	end
	
	for i, profileName in ipairs(premades) do
		local colorIndex = ((i - 1) % #configColors) + 1
		local accentColor = configColors[colorIndex]
		
		local configItem = Instance.new('Frame')
		configItem.Name = profileName
		configItem.Size = UDim2.fromOffset(380, 68)
		configItem.BackgroundColor3 = color.Light(uipallet.Main, 0.02)
		configItem.Parent = premadeChildren
		addCorner(configItem, UDim.new(0, 6))
		
		local configItemStroke = Instance.new('UIStroke')
		configItemStroke.Color = accentColor
		configItemStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		configItemStroke.Transparency = 0.85
		configItemStroke.Parent = configItem
		local accentBar = Instance.new('Frame')
		accentBar.Size = UDim2.fromOffset(4, 68)
		accentBar.BackgroundColor3 = accentColor
		accentBar.BorderSizePixel = 0
		accentBar.Parent = configItem
		local accentCorner = Instance.new('UICorner')
		accentCorner.CornerRadius = UDim.new(0, 6)
		accentCorner.Parent = accentBar
		
		local configIcon = Instance.new('ImageLabel')
		configIcon.Size = UDim2.fromOffset(22, 13)
		configIcon.Position = UDim2.fromOffset(20, 14)
		configIcon.BackgroundTransparency = 1
		configIcon.Image = getcustomasset('aerov4/assets/new/profilesicon.png')
		configIcon.ImageColor3 = accentColor
		configIcon.Parent = configItem
		
		local configName = Instance.new('TextLabel')
		configName.Name = 'ConfigName'
		configName.Size = UDim2.new(1, -140, 0, 20)
		configName.Position = UDim2.fromOffset(52, 12)
		configName.BackgroundTransparency = 1
		configName.Text = profileName
		configName.TextXAlignment = Enum.TextXAlignment.Left
		configName.TextColor3 = uipallet.Text
		configName.TextSize = 15
		configName.FontFace = uipallet.FontSemiBold
		configName.TextTruncate = Enum.TextTruncate.AtEnd
		configName.Parent = configItem
		
		local configDesc = Instance.new('TextLabel')
		configDesc.Name = 'ConfigDesc'
		configDesc.Size = UDim2.new(1, -140, 0, 14)
		configDesc.Position = UDim2.fromOffset(52, 34)
		configDesc.BackgroundTransparency = 1
		configDesc.Text = 'Curated preset • Hover to preview'
		configDesc.TextXAlignment = Enum.TextXAlignment.Left
		configDesc.TextColor3 = color.Dark(uipallet.Text, 0.5)
		configDesc.TextSize = 11
		configDesc.FontFace = uipallet.Font
		configDesc.Parent = configItem
		
		local loadButton = Instance.new('TextButton')
		loadButton.Name = 'LoadButton'
		loadButton.Size = UDim2.fromOffset(90, 36)
		loadButton.Position = UDim2.new(1, -100, 0, 16)
		loadButton.BackgroundColor3 = accentColor
		loadButton.AutoButtonColor = false
		loadButton.Text = 'Load'
		loadButton.TextColor3 = Color3.new(1, 1, 1)
		loadButton.TextSize = 13
		loadButton.FontFace = uipallet.FontSemiBold
		loadButton.Parent = configItem
		addCorner(loadButton, UDim.new(0, 6))
		
		configItem.MouseEnter:Connect(function()
			configItemStroke.Transparency = 0.6
			tween:Tween(configItem, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.04)
			})
			showPreview(profileName)
		end)
		
		configItem.MouseLeave:Connect(function()
			configItemStroke.Transparency = 0.85
			tween:Tween(configItem, uipallet.Tween, {
				BackgroundColor3 = color.Light(uipallet.Main, 0.02)
			})
		end)
		
		loadButton.MouseEnter:Connect(function()
			local brighterColor = Color3.new(
				math.min(accentColor.R * 1.15, 1),
				math.min(accentColor.G * 1.15, 1),
				math.min(accentColor.B * 1.15, 1)
			)
			tween:Tween(loadButton, uipallet.Tween, {
				BackgroundColor3 = brighterColor
			})
		end)
		
		loadButton.MouseLeave:Connect(function()
			tween:Tween(loadButton, uipallet.Tween, {
				BackgroundColor3 = accentColor
			})
		end)
		
		local confirmingDupe = false
			local confirmedOverwrite = false
		loadButton.MouseButton1Click:Connect(function()
			local premadeFile = 'aerov4/profiles/premade/'..profileName..mainapi.Place..'.txt'
			
			if isfile(premadeFile) then
				if profilesCategory:GetValue(profileName) and not confirmedOverwrite then
					if confirmingDupe then return end
					confirmingDupe = true
					loadButton.Text = 'Already exists!'
					loadButton.BackgroundColor3 = Color3.fromRGB(220, 120, 30)
					local stepped = false
					local conn
					conn = loadButton.MouseButton1Click:Connect(function()
						if not stepped then
							stepped = true
							loadButton.Text = 'Load Again?'
							loadButton.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
						else
							conn:Disconnect()
							confirmingDupe = false
							confirmedOverwrite = true
							for i, v in ipairs(mainapi.Profiles) do
								if v.Name == profileName then
									table.remove(mainapi.Profiles, i)
									break
								end
							end
							if isfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') and delfile then
								pcall(function() delfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') end)
							end
							local premadeData = readfile(premadeFile)
							writefile('aerov4/profiles/'..profileName..mainapi.Place..'.txt', premadeData)
							table.insert(mainapi.Profiles, {Name = profileName, Bind = {}})
							profilesCategory:ChangeValue()
							mainapi:Load(true)
							tween:Tween(premadeWindow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
								Position = UDim2.new(0.5, -340, 0.5, -220),
								Size = UDim2.fromOffset(640, 440)
							})
							task.wait(0.15)
							premadeWindow.Visible = false
							premadeBlocker.Visible = false
							mainapi:CreateNotification('config loaded', 'replaced \''..profileName..'\' with the preset ', 3, 'info')
						end
					end)
					task.wait(4)
					conn:Disconnect()
					confirmingDupe = false
					confirmedOverwrite = false
					loadButton.Text = 'Load'
					loadButton.BackgroundColor3 = accentColor
					return
				end

				loadButton.Text = 'Loading...'
				loadButton.BackgroundColor3 = color.Dark(accentColor, 0.3)
				
				task.wait(0.1) 
				
				for i, v in ipairs(mainapi.Profiles) do
					if v.Name == profileName then
						table.remove(mainapi.Profiles, i)
						break
					end
				end
				if isfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') and delfile then
					pcall(function() delfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') end)
				end
				local newProfileName = profileName
				
				if isfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') and delfile then
					pcall(function() delfile('aerov4/profiles/'..profileName..mainapi.Place..'.txt') end)
				end
				
				local premadeData = readfile(premadeFile)
				
				writefile('aerov4/profiles/'..newProfileName..mainapi.Place..'.txt', premadeData)
				table.insert(mainapi.Profiles, {Name = newProfileName, Bind = {}})
				profilesCategory:ChangeValue()
				mainapi:Save(newProfileName)
				mainapi:Load(true)
				
				tween:Tween(premadeWindow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
					Position = UDim2.new(0.5, -340, 0.5, -220),
					Size = UDim2.fromOffset(640, 440)
				})
				task.wait(0.15)
				premadeWindow.Visible = false
				premadeBlocker.Visible = false
				
				mainapi:CreateNotification('config Swapped', 'dropped the old \''..profileName..'\' and reloaded it ', 3, 'info')
			else
				loadButton.Text = 'Error!'
				loadButton.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
				task.wait(1)
				loadButton.Text = 'Load'
				loadButton.BackgroundColor3 = accentColor
				mainapi:CreateNotification('Error', 'config file not found!', 3, 'alert')
			end
		end)
	end
	
	task.spawn(function()
		runService.Heartbeat:Wait()
		runService.Heartbeat:Wait()
		task.wait(0.05)          
		premadeChildren.CanvasSize = UDim2.fromOffset(380, premadeList.AbsoluteContentSize.Y)
	end)
end

profilesCategory:CreateButton({
	Name = 'Reset Profile',
	Function = function()
		for _, v in mainapi.Modules do
			if v.Enabled then
				pcall(function() v:Toggle() end)
			end
			pcall(function() v:SetBind({}, true) end)
			v.Bind = {}
			if v.Object and v.Object:FindFirstChild('Bind') then
				local bindtext = v.Object.Bind:FindFirstChildOfClass('TextLabel')
				if bindtext then bindtext.Text = '' bindtext.Visible = false end
				local bindicon = v.Object.Bind:FindFirstChildOfClass('ImageLabel')
				if bindicon then bindicon.Visible = true end
				v.Object.Bind.Visible = false
			end
		end
		for _, v in mainapi.Legit.Modules do
			if v.Enabled then
				pcall(function() v:Toggle() end)
			end
		end
		for _, v in mainapi.Categories do
			if v.Type == 'Overlay' and v.Button and v.Button.Enabled then
				pcall(function() v.Button:Toggle() end)
			end
			if v.Options then
				for _, opt in v.Options do
					pcall(function()
						if opt.Load and opt.Default ~= nil then
							opt:Load(opt.Default)
						end
					end)
				end
			end
		end
		for _, v in mainapi.Modules do
			if v.Options then
				for _, opt in v.Options do
					pcall(function()
						if opt.Load and opt.Default ~= nil then
							opt:Load(opt.Default)
						end
					end)
				end
			end
		end
		mainapi:Save()
		mainapi:CreateNotification('Profile Reset', 'everything wiped', 3, 'alert')
	end,
	Tooltip = 'Wipes all module states and settings back to default'
})
profilesCategory:CreateButton({
	Name = 'Browse Preset Configs',
	Function = function()
		if premadeWindow.Visible then
			tween:Tween(premadeWindow, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Position = UDim2.new(0.5, -340, 0.5, -220),
				Size = UDim2.fromOffset(640, 440)
			})
			task.wait(0.15)
			premadeWindow.Visible = false
			premadeBlocker.Visible = false
		else
			refreshPremadeWindow()
			premadeWindow.Position = UDim2.new(0.5, -340, 0.5, -260)
			premadeWindow.Size = UDim2.fromOffset(640, 440)
			premadeBlocker.Visible = true
			premadeWindow.Visible = true
			tween:Tween(premadeWindow, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, -340, 0.5, -240),
				Size = UDim2.fromOffset(680, 480)
			})
		end
	end,
	Tooltip = 'Browse curated preset configurations'
})

--[[
	Targets
]]
local targets
targets = mainapi:CreateCategoryList({
	Name = 'Targets',
	Icon = getcustomasset('aerov4/assets/new/friendstab.png'),
	Size = UDim2.fromOffset(17, 16),
	Placeholder = 'Roblox username',
	Function = function()
		targets.Update:Fire()
	end
})
targets.Update = Instance.new('BindableEvent')
mainapi:Clean(targets.Update)

mainapi:CreateLegit()
mainapi:CreateSearch()
mainapi.Categories.Main:CreateOverlayBar()
mainapi.Categories.Main:CreateSettingsDivider()

--[[
	General Settings
]]

local general = mainapi.Categories.Main:CreateSettingsPane({Name = 'General'})
mainapi.MultiKeybind = general:CreateToggle({
	Name = 'Enable Multi-Keybinding',
	Tooltip = 'Allows multiple keys to be bound to a module (eg. G + H)'
})
general:CreateButton({
	Name = 'Reset current profile',
	Function = function()
	mainapi.Save = function() end
		if isfile('aerov4/profiles/'..mainapi.Profile..mainapi.Place..'.txt') and delfile then
			delfile('aerov4/profiles/'..mainapi.Profile..mainapi.Place..'.txt')
		end
		shared.vapereload = true
		if shared.VapeDeveloper then
			loadstring(readfile('aerov4/main.lua'), 'loader')()
		else
			loadstring(game:HttpGet('https://raw.githubusercontent.com/amack7002-code/tapev4/'..readfile('aerov4/profiles/commit.txt')..'/main.lua', true))()
		end
	end,
	Tooltip = 'This will set your profile to the default settings of Vape'
})
general:CreateButton({
	Name = 'Self destruct',
	Function = function()
		mainapi:Uninject()
	end,
	Tooltip = 'Removes vape from the current game'
})
general:CreateButton({
	Name = 'Reinject',
	Function = function()
		shared.vapereload = true
		if shared.VapeDeveloper then
			loadstring(readfile('aerov4/main.lua'), 'loader')()
		else
			loadstring(game:HttpGet('https://raw.githubusercontent.com/amack7002-code/tapev4/'..readfile('aerov4/profiles/commit.txt')..'/main.lua', true))()
		end
	end,
	Tooltip = 'Reloads vape for debugging purposes'
})

--[[
	Module Settings
]]

local modules = mainapi.Categories.Main:CreateSettingsPane({Name = 'Modules'})
modules:CreateToggle({
	Name = 'Teams by server',
	Tooltip = 'Ignore players on your team designated by the server',
	Default = true,
	Function = function()
		if mainapi.Libraries.entity and mainapi.Libraries.entity.Running then
			mainapi.Libraries.entity.refresh()
		end
	end
})
modules:CreateToggle({
	Name = 'Use team color',
	Tooltip = 'Uses the TeamColor property on players for render modules',
	Default = true,
	Function = function()
		if mainapi.Libraries.entity and mainapi.Libraries.entity.Running then
			mainapi.Libraries.entity.refresh()
		end
	end
})

--[[
	GUI Settings
]]

local guipane = mainapi.Categories.Main:CreateSettingsPane({Name = 'GUI'})
mainapi.Blur = guipane:CreateToggle({
	Name = 'Blur background',
	Function = function()
		mainapi:BlurCheck()
	end,
	Default = true,
	Tooltip = 'Blur the background of the GUI'
})
guipane:CreateToggle({
	Name = 'GUI bind indicator',
	Default = true,
	Tooltip = "Displays a message indicating your GUI upon injecting.\nI.E. 'Press RSHIFT to open GUI'"
})
guipane:CreateToggle({
	Name = 'Show tooltips',
	Function = function(enabled)
		tooltip.Visible = false
		toolblur.Visible = enabled
	end,
	Default = true,
	Tooltip = 'Toggles visibility of these'
})

if inputService.TouchEnabled then
	guipane:CreateToggle({
		Name = 'Show Mobile Button',
		Function = function(callback)
			if mainapi.VapeButton then
				mainapi.VapeButton.BackgroundTransparency = callback and 0.5 or 1
				for _, child in mainapi.VapeButton:GetChildren() do
					if child:IsA('ImageLabel') then
						child.ImageTransparency = callback and 0 or 1
					end
				end
			end
			
			if mainapi.Modules then
				for _, mobileButton in pairs(mainapi.Modules) do
					if mobileButton.Bind and mobileButton.Bind.Button then
						mobileButton.Bind.Button.BackgroundTransparency = callback and 0.5 or 1
						mobileButton.Bind.Button.TextTransparency = callback and 0 or 1
					end
				end
			end
		end,
		Default = true,
		Tooltip = 'Shows or hides mobile button (remains clickable when hidden)'
	})
end

guipane:CreateToggle({
    Name = 'Auto Reinject',
    Function = function(callback)
        shared.VapeIndependent = not callback
    end,
    Default = true, 
    Tooltip = 'keeps u injected when u teleport c:'
})

local notifColorToggle = guipane:CreateToggle({
	Name = 'Custom Background Color',
	Function = function(callback)
		if not callback then
			mainapi.NotificationColor = nil
		end
	end,
	Default = false,
	Tooltip = 'Custom color for the notification background'
})

local notifColorPicker = guipane:CreateColorSlider({
	Name = 'Background Color',
	Function = function(h, s, v)
		if notifColorToggle.Enabled then
			mainapi.NotificationColor = {Hue = h, Sat = s, Value = v}
		end
	end,
	Visible = false,
	Darker = true
})

local notifBarColorToggle = guipane:CreateToggle({
	Name = 'Custom Bar Color',
	Function = function(callback)
		if not callback then
			mainapi.NotificationBarColor = nil
		end
	end,
	Default = false,
	Tooltip = 'Custom color for the notification progress bar'
})

local notifBarColorPicker = guipane:CreateColorSlider({
	Name = 'Bar Color',
	Function = function(h, s, v)
		if notifBarColorToggle.Enabled then
			mainapi.NotificationBarColor = {Hue = h, Sat = s, Value = v}
		end
	end,
	Visible = false,
	Darker = true
})

task.spawn(function()
	while task.wait(0.1) do
		if notifColorPicker and notifColorPicker.Object then
			notifColorPicker.Object.Visible = notifColorToggle.Enabled
		end
		if notifBarColorPicker and notifBarColorPicker.Object then
			notifBarColorPicker.Object.Visible = notifBarColorToggle.Enabled
		end
	end
end)

local scaleslider = {Object = {}, Value = 1}
mainapi.Scale = guipane:CreateToggle({
	Name = 'Auto rescale',
	Default = true,
	Function = function(callback)
		scaleslider.Object.Visible = not callback
		if callback then
			scale.Scale = getAutoScale()
		else
			scale.Scale = scaleslider.Value
		end
	end,
	Tooltip = 'Automatically rescales the gui using the screens resolution'
})
scaleslider = guipane:CreateSlider({
	Name = 'Scale',
	Min = 0.1,
	Max = 2,
	Decimal = 10,
	Function = function(val, final)
		if final and not mainapi.Scale.Enabled then
			scale.Scale = val
		end
	end,
	Default = 1,
	Darker = true,
	Visible = false
})
guipane:CreateDropdown({
	Name = 'GUI Theme',
	List = inputService.TouchEnabled and {'new', 'old'} or {'new', 'old', 'rise'},
	Function = function(val, mouse)
		if mouse then
			writefile('aerov4/profiles/gui.txt', val)
			shared.vapereload = true
			if shared.VapeDeveloper then
				loadstring(readfile('aerov4/main.lua'), 'loader')()
			else
				loadstring(game:HttpGet('https://raw.githubusercontent.com/amack7002-code/tapev4/'..readfile('aerov4/profiles/commit.txt')..'/main.lua', true))()
			end
		end
	end,
	Tooltip = 'new - The newest vape theme to since v4.05\nold - The vape theme pre v4.05\nrise - Rise 6.0'
})
mainapi.RainbowMode = guipane:CreateDropdown({
	Name = 'Rainbow Mode',
	List = {'Normal', 'Gradient', 'Retro'},
	Tooltip = 'Normal - Smooth color fade\nGradient - Gradient color fade\nRetro - Static color'
})
mainapi.RainbowSpeed = guipane:CreateSlider({
	Name = 'Rainbow speed',
	Min = 0.1,
	Max = 10,
	Decimal = 10,
	Default = 1,
	Tooltip = 'Adjusts the speed of rainbow values'
})
mainapi.RainbowUpdateSpeed = guipane:CreateSlider({
	Name = 'Rainbow update rate',
	Min = 1,
	Max = 144,
	Default = 60,
	Tooltip = 'Adjusts the update rate of rainbow values',
	Suffix = 'hz'
})
guipane:CreateButton({
	Name = 'Reset GUI positions',
	Function = function()
		for _, v in mainapi.Categories do
			v.Object.Position = UDim2.fromOffset(6, 42)
		end
	end,
	Tooltip = 'This will reset your GUI back to default'
})
if inputService.TouchEnabled then
    guipane:CreateButton({
        Name = 'Mobile Editor',
        Function = function()
            openMobileEditor()
        end,
        Tooltip = 'Open the mobile bind editor'
    })
end
guipane:CreateButton({
	Name = 'Sort GUI',
	Function = function()
		local priority = {
			GUICategory = 1,
			CombatCategory = 2,
			BlatantCategory = 3,
			RenderCategory = 4,
			UtilityCategory = 5,
			WorldCategory = 6,
			InventoryCategory = 7,
			MinigamesCategory = 8,
			FriendsCategory = 9,
			ProfilesCategory = 10
		}
		local categories = {}
		for _, v in mainapi.Categories do
			if v.Type ~= 'Overlay' then
				table.insert(categories, v)
			end
		end
		table.sort(categories, function(a, b)
			return (priority[a.Object.Name] or 99) < (priority[b.Object.Name] or 99)
		end)

		local ind = 0
		for _, v in categories do
			if v.Object.Visible then
				v.Object.Position = UDim2.fromOffset(6 + (ind % 8 * 230), 60 + (ind > 7 and 360 or 0))
				ind += 1
			end
		end
	end,
	Tooltip = 'Sorts GUI'
})

--[[
	Notification Settings
]]

local notifpane = mainapi.Categories.Main:CreateSettingsPane({Name = 'Notifications'})
mainapi.Notifications = notifpane:CreateToggle({
	Name = 'Notifications',
	Function = function(enabled)
		if mainapi.ToggleNotifications.Object then
			mainapi.ToggleNotifications.Object.Visible = enabled
		end
	end,
	Tooltip = 'Shows notifications',
	Default = true
})
mainapi.ToggleNotifications = notifpane:CreateToggle({
	Name = 'Toggle alert',
	Tooltip = 'Notifies you if a module is enabled/disabled.',
	Default = true,
	Darker = true
})

mainapi.GUIColor = mainapi.Categories.Main:CreateGUISlider({
	Name = 'GUI Theme',
	Function = function(h, s, v)
		mainapi:UpdateGUI(h, s, v, true)
	end
})
mainapi.Categories.Main:CreateBind()

--[[
	Text GUI
]]

local textgui = mainapi:CreateOverlay({
	Name = 'Text GUI',
	Icon = getcustomasset('aerov4/assets/new/textguiicon.png'),
	Size = UDim2.fromOffset(16, 12),
	Position = UDim2.fromOffset(12, 14),
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguisort = textgui:CreateDropdown({
	Name = 'Sort',
	List = {'Alphabetical', 'Length'},
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguifont = textgui:CreateFont({
	Name = 'Font',
	Blacklist = 'Arial',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguicolor
local textguicolordrop = textgui:CreateDropdown({
	Name = 'Color Mode',
	List = {'Match GUI color', 'Custom color'},
	Function = function(val)
		textguicolor.Object.Visible = val == 'Custom color'
		mainapi:UpdateTextGUI()
	end
})
textguicolor = textgui:CreateColorSlider({
	Name = 'Text GUI color',
	Function = function()
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})
local VapeTextScale = Instance.new('UIScale')
VapeTextScale.Parent = textgui.Children
local textguiscale = textgui:CreateSlider({
	Name = 'Scale',
	Min = 0,
	Max = 2,
	Decimal = 10,
	Default = 1,
	Function = function(val)
		VapeTextScale.Scale = val
		mainapi:UpdateTextGUI()
	end
})
local textguishadow = textgui:CreateToggle({
	Name = 'Shadow',
	Tooltip = 'Renders shadowed text.',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguigradientv4
local textguigradient = textgui:CreateToggle({
	Name = 'Gradient',
	Tooltip = 'Renders a gradient',
	Function = function(callback)
		textguigradientv4.Object.Visible = callback
		mainapi:UpdateTextGUI()
	end
})
textguigradientv4 = textgui:CreateToggle({
	Name = 'V4 Gradient',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
local textguianimations = textgui:CreateToggle({
	Name = 'Animations',
	Tooltip = 'Use animations on text gui',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguiwatermark = textgui:CreateToggle({
	Name = 'Watermark',
	Tooltip = 'Renders a vape watermark',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguibackgroundtransparency = {
	Value = 0.5,
	Object = {Visible = {}}
}
local textguibackgroundtint = {Enabled = false}
local textguibackground = textgui:CreateToggle({
	Name = 'Render background',
	Function = function(callback)
		textguibackgroundtransparency.Object.Visible = callback
		textguibackgroundtint.Object.Visible = callback
		mainapi:UpdateTextGUI()
	end
})
textguibackgroundtransparency = textgui:CreateSlider({
	Name = 'Transparency',
	Min = 0,
	Max = 1,
	Default = 0.5,
	Decimal = 10,
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguibackgroundtint = textgui:CreateToggle({
	Name = 'Tint',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
local textguimoduleslist
local textguimodules = textgui:CreateToggle({
	Name = 'Hide modules',
	Tooltip = 'Allows you to blacklist certain modules from being shown.',
	Function = function(enabled)
		textguimoduleslist.Object.Visible = enabled
		mainapi:UpdateTextGUI()
	end
})
textguimoduleslist = textgui:CreateTextList({
	Name = 'Blacklist',
	Tooltip = 'Name of module to hide.',
	Icon = getcustomasset('aerov4/assets/new/blockedicon.png'),
	Tab = getcustomasset('aerov4/assets/new/blockedtab.png'),
	TabSize = UDim2.fromOffset(21, 16),
	Color = Color3.fromRGB(250, 50, 56),
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Visible = false,
	Darker = true
})
local textguirender = textgui:CreateToggle({
	Name = 'Hide render',
	Function = function()
		mainapi:UpdateTextGUI()
	end
})
local textguibox
local textguifontcustom
local textguicolorcustomtoggle
local textguicolorcustom
local textguitext = textgui:CreateToggle({
	Name = 'Add custom text',
	Function = function(enabled)
		textguibox.Object.Visible = enabled
		textguifontcustom.Object.Visible = enabled
		textguicolorcustomtoggle.Object.Visible = enabled
		textguicolorcustom.Object.Visible = textguicolorcustomtoggle.Enabled and enabled
		mainapi:UpdateTextGUI()
	end
})
textguibox = textgui:CreateTextBox({
	Name = 'Custom text',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguifontcustom = textgui:CreateFont({
	Name = 'Custom Font',
	Blacklist = 'Arial',
	Function = function()
		mainapi:UpdateTextGUI()
	end,
	Darker = true,
	Visible = false
})
textguicolorcustomtoggle = textgui:CreateToggle({
	Name = 'Set custom text color',
	Function = function(enabled)
		textguicolorcustom.Object.Visible = enabled
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})
textguicolorcustom = textgui:CreateColorSlider({
	Name = 'Color of custom text',
	Function = function()
		mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
	end,
	Darker = true,
	Visible = false
})

--[[
	Info HUD
]]

local hudPing, hudFPS, hudClock, hudKeystrokes
local hudPingLabel, hudFPSLabel, hudClockLabel, hudKeystrokesLabel
local hudOverlay
local hudLplr = cloneref(game:GetService('Players')).LocalPlayer

local hudFrame = Instance.new('Frame')
hudFrame.Name = 'InfoHUD'
hudFrame.Position = UDim2.fromOffset(10, 200)
hudFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
hudFrame.BackgroundTransparency = 0.3
hudFrame.BorderSizePixel = 0
hudFrame.Size = UDim2.fromOffset(130, 10)
hudFrame.Visible = false
hudFrame.Parent = scaledgui
addCorner(hudFrame)
makeDraggable(hudFrame)

local hudPad = Instance.new('UIPadding')
hudPad.PaddingLeft = UDim.new(0, 7)
hudPad.PaddingRight = UDim.new(0, 7)
hudPad.PaddingTop = UDim.new(0, 5)
hudPad.PaddingBottom = UDim.new(0, 5)
hudPad.Parent = hudFrame

local hudList = Instance.new('UIListLayout')
hudList.SortOrder = Enum.SortOrder.LayoutOrder
hudList.Padding = UDim.new(0, 3)
hudList.Parent = hudFrame

hudList:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
	hudFrame.Size = UDim2.fromOffset(130, hudList.AbsoluteContentSize.Y + 10)
end)

local function createHUDLabel(order)
	local label = Instance.new('TextLabel')
	label.Size = UDim2.new(1, 0, 0, 16)
	label.BackgroundTransparency = 1
	label.Text = ''
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.FontFace = uipallet.Font
	label.LayoutOrder = order
	label.Visible = false
	label.Parent = hudFrame
	return label
end

hudPingLabel = createHUDLabel(1)
hudFPSLabel = createHUDLabel(2)
hudClockLabel = createHUDLabel(3)
hudKeystrokesLabel = createHUDLabel(4)

local function refreshHUD()
	local anyOn = (hudPing and hudPing.Enabled)
		or (hudFPS and hudFPS.Enabled)
		or (hudClock and hudClock.Enabled)
		or (hudKeystrokes and hudKeystrokes.Enabled)
	hudFrame.Visible = hudOverlay and hudOverlay.Button.Enabled and anyOn or false
	if hudPingLabel then hudPingLabel.Visible = hudPing and hudPing.Enabled or false end
	if hudFPSLabel then hudFPSLabel.Visible = hudFPS and hudFPS.Enabled or false end
	if hudClockLabel then hudClockLabel.Visible = hudClock and hudClock.Enabled or false end
	if hudKeystrokesLabel then hudKeystrokesLabel.Visible = hudKeystrokes and hudKeystrokes.Enabled or false end
end

hudOverlay = mainapi:CreateOverlay({
	Name = 'Info HUD',
	Icon = getcustomasset('aerov4/assets/new/radaricon.png'),
	Size = UDim2.fromOffset(14, 14),
	Position = UDim2.fromOffset(13, 13),
	Function = function()
		refreshHUD()
	end
})

hudPing = hudOverlay:CreateToggle({
	Name = 'Ping',
	Tooltip = 'Shows your ping in ms',
	Function = function() refreshHUD() end
})
hudFPS = hudOverlay:CreateToggle({
	Name = 'FPS',
	Tooltip = 'Shows your current FPS',
	Function = function() refreshHUD() end
})
hudClock = hudOverlay:CreateToggle({
	Name = 'Clock',
	Tooltip = 'Shows the current time',
	Function = function() refreshHUD() end
})
hudKeystrokes = hudOverlay:CreateToggle({
	Name = 'Keystrokes',
	Tooltip = 'Shows keys you are currently holding',
	Function = function() refreshHUD() end
})

local fpsFrames, fpsCurrent, fpsElapsed = 0, 0, 0
mainapi:Clean(runService.RenderStepped:Connect(function(dt)
	fpsFrames += 1
	fpsElapsed += dt
	if fpsElapsed >= 1 then
		fpsCurrent = math.round(fpsFrames / fpsElapsed)
		fpsFrames, fpsElapsed = 0, 0
	end
end))
local activeKeys = {}

mainapi:Clean(inputService.InputBegan:Connect(function(inputObj, processed)
	if processed or inputService:GetFocusedTextBox() or not (hudKeystrokes and hudKeystrokes.Enabled) then return end
	if inputObj.UserInputType == Enum.UserInputType.Keyboard then
		local name = inputObj.KeyCode.Name
		if #name <= 10 then activeKeys[name] = true end
	elseif inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
		activeKeys['LMB'] = true
	elseif inputObj.UserInputType == Enum.UserInputType.MouseButton2 then
		activeKeys['RMB'] = true
	end
end))

mainapi:Clean(inputService.InputEnded:Connect(function(inputObj)
	if inputObj.UserInputType == Enum.UserInputType.Keyboard then
		activeKeys[inputObj.KeyCode.Name] = nil
	elseif inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
		activeKeys['LMB'] = nil
	elseif inputObj.UserInputType == Enum.UserInputType.MouseButton2 then
		activeKeys['RMB'] = nil
	end
end))

mainapi:Clean(inputService.WindowFocusReleased:Connect(function()
	table.clear(activeKeys)
end))

local hudSlowTimer = 0
local hudLastFPS, hudLastPing, hudLastClock, hudLastKeys
mainapi:Clean(runService.Heartbeat:Connect(function()
	local now = tick()
	if not (hudKeystrokes and hudKeystrokes.Enabled) or inputService:GetFocusedTextBox() then
		table.clear(activeKeys)
	end

	if not hudFrame.Visible then return end

	if hudFPS and hudFPS.Enabled and hudLastFPS ~= fpsCurrent then
		hudLastFPS = fpsCurrent
		hudFPSLabel.Text = 'FPS  '..fpsCurrent
	end
	if hudKeystrokes and hudKeystrokes.Enabled then
		local keys = {}
		for k in activeKeys do table.insert(keys, k) end
		table.sort(keys)
		local val = #keys > 0 and table.concat(keys, ' + ') or 'Keys  --'
		if hudLastKeys ~= val then
			hudLastKeys = val
			hudKeystrokesLabel.Text = val
		end
	end

	if now - hudSlowTimer < 0.5 then return end
	hudSlowTimer = now

	if hudPing and hudPing.Enabled then
		local ok, ping = pcall(function()
			local value = hudLplr:GetNetworkPing()
			if type(value) ~= 'number' or value ~= value or value < 0 or value == math.huge then return nil end
			return math.round(value * 1000)
		end)
		local val = ok and ping or '--'
		if hudLastPing ~= val then
			hudLastPing = val
			hudPingLabel.Text = 'Ping  '..val..'ms'
		end
	end
	if hudClock and hudClock.Enabled then
		local ok, t = pcall(function()
			return DateTime.now():FormatLocalTime('LT', 'en-us')
		end)
		local val = ok and t or '--:--'
		if hudLastClock ~= val then
			hudLastClock = val
			hudClockLabel.Text = 'Time  '..val
		end
	end
end))

--[[
	Text GUI Objects
]]

local VapeLabels = {}
local VapeLogo = Instance.new('ImageLabel')
VapeLogo.Name = 'Logo'
VapeLogo.Size = UDim2.fromOffset(80, 21)
VapeLogo.Position = UDim2.new(1, -142, 0, 3)
VapeLogo.BackgroundTransparency = 1
VapeLogo.BorderSizePixel = 0
VapeLogo.Visible = false
VapeLogo.BackgroundColor3 = Color3.new()
VapeLogo.Image = getcustomasset('aerov4/assets/new/textvape.png')
VapeLogo.Parent = textgui.Children

local lastside = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
mainapi:Clean(textgui.Children:GetPropertyChangedSignal('AbsolutePosition'):Connect(function()
	if mainapi.ThreadFix then
		setthreadidentity(8)
	end
	local newside = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
	if lastside ~= newside then
		lastside = newside
		mainapi:UpdateTextGUI()
	end
end))

local VapeLogoV4 = Instance.new('ImageLabel')
VapeLogoV4.Name = 'Logo2'
VapeLogoV4.Size = UDim2.fromOffset(33, 18)
VapeLogoV4.Position = UDim2.new(1, 1, 0, 1)
VapeLogoV4.BackgroundColor3 = Color3.new()
VapeLogoV4.BackgroundTransparency = 1
VapeLogoV4.BorderSizePixel = 0
VapeLogoV4.Image = getcustomasset('aerov4/assets/new/textv4.png')
VapeLogoV4.Parent = VapeLogo
local VapeLogoShadow = VapeLogo:Clone()
VapeLogoShadow.Position = UDim2.fromOffset(1, 1)
VapeLogoShadow.ZIndex = 0
VapeLogoShadow.Visible = true
VapeLogoShadow.ImageColor3 = Color3.new()
VapeLogoShadow.ImageTransparency = 0.65
VapeLogoShadow.Parent = VapeLogo
VapeLogoShadow.Logo2.ZIndex = 0
VapeLogoShadow.Logo2.ImageColor3 = Color3.new()
VapeLogoShadow.Logo2.ImageTransparency = 0.65
local VapeLogoGradient = Instance.new('UIGradient')
VapeLogoGradient.Rotation = 90
VapeLogoGradient.Parent = VapeLogo
local VapeLogoGradient2 = Instance.new('UIGradient')
VapeLogoGradient2.Rotation = 90
VapeLogoGradient2.Parent = VapeLogoV4
local VapeLabelCustom = Instance.new('TextLabel')
VapeLabelCustom.Position = UDim2.fromOffset(5, 2)
VapeLabelCustom.BackgroundTransparency = 1
VapeLabelCustom.BorderSizePixel = 0
VapeLabelCustom.Visible = false
VapeLabelCustom.Text = ''
VapeLabelCustom.TextSize = 25
VapeLabelCustom.FontFace = textguifontcustom.Value
VapeLabelCustom.RichText = true
local VapeLabelCustomShadow = VapeLabelCustom:Clone()
VapeLabelCustom:GetPropertyChangedSignal('Position'):Connect(function()
	VapeLabelCustomShadow.Position = UDim2.new(
		VapeLabelCustom.Position.X.Scale,
		VapeLabelCustom.Position.X.Offset + 1,
		0,
		VapeLabelCustom.Position.Y.Offset + 1
	)
end)
VapeLabelCustom:GetPropertyChangedSignal('FontFace'):Connect(function()
	VapeLabelCustomShadow.FontFace = VapeLabelCustom.FontFace
end)
VapeLabelCustom:GetPropertyChangedSignal('Text'):Connect(function()
	VapeLabelCustomShadow.Text = removeTags(VapeLabelCustom.Text)
end)
VapeLabelCustom:GetPropertyChangedSignal('Size'):Connect(function()
	VapeLabelCustomShadow.Size = VapeLabelCustom.Size
end)
VapeLabelCustomShadow.TextColor3 = Color3.new()
VapeLabelCustomShadow.TextTransparency = 0.65
VapeLabelCustomShadow.Parent = textgui.Children
VapeLabelCustom.Parent = textgui.Children
local VapeLabelHolder = Instance.new('Frame')
VapeLabelHolder.Name = 'Holder'
VapeLabelHolder.Size = UDim2.fromScale(1, 1)
VapeLabelHolder.Position = UDim2.fromOffset(5, 37)
VapeLabelHolder.BackgroundTransparency = 1
VapeLabelHolder.Parent = textgui.Children
local VapeLabelSorter = Instance.new('UIListLayout')
VapeLabelSorter.HorizontalAlignment = Enum.HorizontalAlignment.Right
VapeLabelSorter.VerticalAlignment = Enum.VerticalAlignment.Top
VapeLabelSorter.SortOrder = Enum.SortOrder.LayoutOrder
VapeLabelSorter.Parent = VapeLabelHolder

--[[
	Target Info
]]

local targetinfo
local targetinfoobj
local targetinfobcolor
targetinfoobj = mainapi:CreateOverlay({
	Name = 'Target Info',
	Icon = getcustomasset('aerov4/assets/new/targetinfoicon.png'),
	Size = UDim2.fromOffset(14, 14),
	Position = UDim2.fromOffset(12, 14),
	CategorySize = 240,
	Function = function(callback)
		if callback then
			task.spawn(function()
				repeat
					targetinfo:UpdateInfo()
					task.wait()
				until not targetinfoobj.Button or not targetinfoobj.Button.Enabled
			end)
		end
	end
})

local targetinfobkg = Instance.new('Frame')
targetinfobkg.Size = UDim2.fromOffset(240, 89)
targetinfobkg.BackgroundColor3 = color.Dark(uipallet.Main, 0.1)
targetinfobkg.BackgroundTransparency = 0.5
targetinfobkg.Parent = targetinfoobj.Children
local targetinfoblurobj = addBlur(targetinfobkg)
targetinfoblurobj.Visible = false
addCorner(targetinfobkg)
local targetinfoshot = Instance.new('ImageLabel')
targetinfoshot.Size = UDim2.fromOffset(26, 27)
targetinfoshot.Position = UDim2.fromOffset(19, 17)
targetinfoshot.BackgroundColor3 = uipallet.Main
targetinfoshot.Image = 'rbxthumb://type=AvatarHeadShot&id=1&w=420&h=420'
targetinfoshot.Parent = targetinfobkg
local targetinfoshotflash = Instance.new('Frame')
targetinfoshotflash.Size = UDim2.fromScale(1, 1)
targetinfoshotflash.BackgroundTransparency = 1
targetinfoshotflash.BackgroundColor3 = Color3.new(1, 0, 0)
targetinfoshotflash.Parent = targetinfoshot
addCorner(targetinfoshotflash)
local targetinfoshotblur = addBlur(targetinfoshot)
targetinfoshotblur.Visible = false
addCorner(targetinfoshot)
local targetinfoname = Instance.new('TextLabel')
targetinfoname.Size = UDim2.fromOffset(145, 20)
targetinfoname.Position = UDim2.fromOffset(54, 20)
targetinfoname.BackgroundTransparency = 1
targetinfoname.Text = 'Target name'
targetinfoname.TextXAlignment = Enum.TextXAlignment.Left
targetinfoname.TextYAlignment = Enum.TextYAlignment.Top
targetinfoname.TextScaled = true
targetinfoname.TextColor3 = color.Light(uipallet.Text, 0.4)
targetinfoname.TextStrokeTransparency = 1
targetinfoname.FontFace = uipallet.Font
local targetinfoshadow = targetinfoname:Clone()
targetinfoshadow.Position = UDim2.fromOffset(55, 21)
targetinfoshadow.TextColor3 = Color3.new()
targetinfoshadow.TextTransparency = 0.65
targetinfoshadow.Visible = false
targetinfoshadow.Parent = targetinfobkg
targetinfoname:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfoshadow.Size = targetinfoname.Size
end)
targetinfoname:GetPropertyChangedSignal('Text'):Connect(function()
	targetinfoshadow.Text = targetinfoname.Text
end)
targetinfoname:GetPropertyChangedSignal('FontFace'):Connect(function()
	targetinfoshadow.FontFace = targetinfoname.FontFace
end)
targetinfoname.Parent = targetinfobkg
local targetinfohealthbkg = Instance.new('Frame')
targetinfohealthbkg.Name = 'HealthBKG'
targetinfohealthbkg.Size = UDim2.fromOffset(200, 9)
targetinfohealthbkg.Position = UDim2.fromOffset(20, 56)
targetinfohealthbkg.BackgroundColor3 = uipallet.Main
targetinfohealthbkg.BorderSizePixel = 0
targetinfohealthbkg.Parent = targetinfobkg
addCorner(targetinfohealthbkg, UDim.new(1, 0))
local targetinfohealth = targetinfohealthbkg:Clone()
targetinfohealth.Size = UDim2.fromScale(0.8, 1)
targetinfohealth.Position = UDim2.new()
targetinfohealth.BackgroundColor3 = Color3.fromHSV(1 / 2.5, 0.89, 0.75)
targetinfohealth.Parent = targetinfohealthbkg
targetinfohealth:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfohealth.Visible = targetinfohealth.Size.X.Scale > 0.01
end)
local targetinfohealthextra = targetinfohealth:Clone()
targetinfohealthextra.Size = UDim2.new()
targetinfohealthextra.Position = UDim2.fromScale(1, 0)
targetinfohealthextra.AnchorPoint = Vector2.new(1, 0)
targetinfohealthextra.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
targetinfohealthextra.Visible = false
targetinfohealthextra.Parent = targetinfohealthbkg
targetinfohealthextra:GetPropertyChangedSignal('Size'):Connect(function()
	targetinfohealthextra.Visible = targetinfohealthextra.Size.X.Scale > 0.01
end)
local targetinfohealthblur = addBlur(targetinfohealthbkg)
targetinfohealthblur.SliceCenter = Rect.new(52, 31, 261, 510)
targetinfohealthblur.ImageColor3 = Color3.new()
targetinfohealthblur.Visible = false
local targetinfob = Instance.new('UIStroke')
targetinfob.Enabled = false
targetinfob.Color = Color3.fromHSV(0.44, 1, 1)
targetinfob.Parent = targetinfobkg

targetinfoobj:CreateFont({
	Name = 'Font',
	Blacklist = 'Arial',
	Function = function(val)
		targetinfoname.FontFace = val
	end
})
local targetinfobackgroundtransparency = {
	Value = 0.5,
	Object = {Visible = {}}
}
local targetinfodisplay = targetinfoobj:CreateToggle({
	Name = 'Use Displayname',
	Default = true
})
targetinfoobj:CreateToggle({
	Name = 'Render Background',
	Function = function(callback)
		targetinfobkg.BackgroundTransparency = callback and targetinfobackgroundtransparency.Value or 1
		targetinfoshadow.Visible = not callback
		targetinfoblurobj.Visible = callback
		targetinfohealthblur.Visible = not callback
		targetinfoshotblur.Visible = not callback
		targetinfobackgroundtransparency.Object.Visible = callback
	end,
	Default = true
})
targetinfobackgroundtransparency = targetinfoobj:CreateSlider({
	Name = 'Transparency',
	Min = 0,
	Max = 1,
	Default = 0.5,
	Decimal = 10,
	Function = function(val)
		targetinfobkg.BackgroundTransparency = val
	end,
	Darker = true
})
local targetinfocolor
local targetinfocolortoggle = targetinfoobj:CreateToggle({
	Name = 'Custom Color',
	Function = function(callback)
		targetinfocolor.Object.Visible = callback
		if callback then
			targetinfobkg.BackgroundColor3 = Color3.fromHSV(targetinfocolor.Hue, targetinfocolor.Sat, targetinfocolor.Value)
			targetinfoshot.BackgroundColor3 = Color3.fromHSV(targetinfocolor.Hue, targetinfocolor.Sat, math.max(targetinfocolor.Value - 0.1, 0.075))
			targetinfohealthbkg.BackgroundColor3 = targetinfoshot.BackgroundColor3
		else
			targetinfobkg.BackgroundColor3 = color.Dark(uipallet.Main, 0.1)
			targetinfoshot.BackgroundColor3 = uipallet.Main
			targetinfohealthbkg.BackgroundColor3 = uipallet.Main
		end
	end
})
targetinfocolor = targetinfoobj:CreateColorSlider({
	Name = 'Color',
	Function = function(hue, sat, val)
		if targetinfocolortoggle.Enabled then
			targetinfobkg.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			targetinfoshot.BackgroundColor3 = Color3.fromHSV(hue, sat, math.max(val - 0.1, 0))
			targetinfohealthbkg.BackgroundColor3 = targetinfoshot.BackgroundColor3
		end
	end,
	Darker = true,
	Visible = false
})
targetinfoobj:CreateToggle({
	Name = 'Border',
	Function = function(callback)
		targetinfob.Enabled = callback
		targetinfobcolor.Object.Visible = callback
	end
})
targetinfobcolor = targetinfoobj:CreateColorSlider({
	Name = 'Border Color',
	Function = function(hue, sat, val, opacity)
		targetinfob.Color = Color3.fromHSV(hue, sat, val)
		targetinfob.Transparency = 1 - opacity
	end,
	Darker = true,
	Visible = false
})

local lasthealth = 0
local lastmaxhealth = 0
targetinfo = {
	Targets = {},
	Object = targetinfobkg,
	UpdateInfo = function(self)
		local entitylib = mainapi.Libraries
		if not entitylib then return end

		for i, v in self.Targets do
			if v < tick() then
				self.Targets[i] = nil
			end
		end

		local v, highest = nil, tick()
		for i, check in self.Targets do
			if check > highest then
				v = i
				highest = check
			end
		end

		targetinfobkg.Visible = v ~= nil or mainapi.gui.ScaledGui.ClickGui.Visible
		if v then
			targetinfoname.Text = v.Player and (targetinfodisplay.Enabled and v.Player.DisplayName or v.Player.Name) or v.Character and v.Character.Name or targetinfoname.Text
			targetinfoshot.Image = 'rbxthumb://type=AvatarHeadShot&id='..(v.Player and v.Player.UserId or 1)..'&w=420&h=420'

			if not v.Character then
				v.Health = v.Health or 0
				v.MaxHealth = v.MaxHealth or 100
			end

			if v.Health ~= lasthealth or v.MaxHealth ~= lastmaxhealth then
				local percent = math.max(v.Health / v.MaxHealth, 0)
				tween:Tween(targetinfohealth, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.min(percent, 1), 1), BackgroundColor3 = Color3.fromHSV(math.clamp(percent / 2.5, 0, 1), 0.89, 0.75)
				})
				tween:Tween(targetinfohealthextra, TweenInfo.new(0.3), {
					Size = UDim2.fromScale(math.clamp(percent - 1, 0, 0.8), 1)
				})
				if lasthealth > v.Health and self.LastTarget == v then
					tween:Cancel(targetinfoshotflash)
					targetinfoshotflash.BackgroundTransparency = 0.3
					tween:Tween(targetinfoshotflash, TweenInfo.new(0.5), {
						BackgroundTransparency = 1
					})
				end
				lasthealth = v.Health
				lastmaxhealth = v.MaxHealth
			end

			if not v.Character then table.clear(v) end
			self.LastTarget = v
		end
		return v
	end
}
mainapi.Libraries.targetinfo = targetinfo

local textguiqueued = false
function mainapi:UpdateTextGUI(afterload)
	if not afterload and not mainapi.Loaded then return end
	if textguiqueued then return end
	textguiqueued = true
	task.defer(function()
		textguiqueued = false
		mainapi:RebuildTextGUI()
	end)
end

function mainapi:RebuildTextGUI()
	if textgui.Button.Enabled then
		local right = textgui.Children.AbsolutePosition.X > (gui.AbsoluteSize.X / 2)
		VapeLogo.Visible = textguiwatermark.Enabled
		VapeLogo.Position = right and UDim2.new(1 / VapeTextScale.Scale, -113, 0, 6) or UDim2.fromOffset(0, 6)
		VapeLogoShadow.Visible = textguishadow.Enabled
		VapeLabelCustom.Text = textguibox.Value
		VapeLabelCustom.FontFace = textguifontcustom.Value
		VapeLabelCustom.Visible = VapeLabelCustom.Text ~= '' and textguitext.Enabled
		VapeLabelCustomShadow.Visible = VapeLabelCustom.Visible and textguishadow.Enabled
		VapeLabelSorter.HorizontalAlignment = right and Enum.HorizontalAlignment.Right or Enum.HorizontalAlignment.Left
		VapeLabelHolder.Size = UDim2.fromScale(1 / VapeTextScale.Scale, 1)
		VapeLabelHolder.Position = UDim2.fromOffset(right and 3 or 0, 11 + (VapeLogo.Visible and VapeLogo.Size.Y.Offset or 0) + (VapeLabelCustom.Visible and 28 or 0) + (textguibackground.Enabled and 3 or 0))
		if VapeLabelCustom.Visible then
			local size = getfontsize(removeTags(VapeLabelCustom.Text), VapeLabelCustom.TextSize, VapeLabelCustom.FontFace)
			VapeLabelCustom.Size = UDim2.fromOffset(size.X, size.Y)
			VapeLabelCustom.Position = UDim2.new(right and 1 / VapeTextScale.Scale or 0, right and -size.X or 0, 0, (VapeLogo.Visible and 32 or 8))
		end

		local found = {}
		for _, v in VapeLabels do
			if v.Enabled then
				table.insert(found, v.Object.Name)
			end
			v.Object:Destroy()
		end
		table.clear(VapeLabels)

		local info = TweenInfo.new(0.3, Enum.EasingStyle.Exponential)
		for i, v in mainapi.Modules do
			if textguimodules.Enabled and table.find(textguimoduleslist.ListEnabled, i) then continue end
			if textguirender.Enabled and v.Category == 'Render' then continue end
			if v.Enabled or table.find(found, i) then
				local holder = Instance.new('Frame')
				holder.Name = i
				holder.Size = UDim2.fromOffset()
				holder.BackgroundTransparency = 1
				holder.ClipsDescendants = true
				holder.Parent = VapeLabelHolder
				local holderbackground
				local holdercolorline
				if textguibackground.Enabled then
					holderbackground = Instance.new('Frame')
					holderbackground.Size = UDim2.new(1, 3, 1, 0)
					holderbackground.BackgroundColor3 = color.Dark(uipallet.Main, 0.15)
					holderbackground.BackgroundTransparency = textguibackgroundtransparency.Value
					holderbackground.BorderSizePixel = 0
					holderbackground.Parent = holder
					local holderline = Instance.new('Frame')
					holderline.Size = UDim2.new(1, 0, 0, 1)
					holderline.Position = UDim2.new(0, 0, 1, -1)
					holderline.BackgroundColor3 = Color3.new()
					holderline.BackgroundTransparency = 0.928 + (0.072 * math.clamp((textguibackgroundtransparency.Value - 0.5) / 0.5, 0, 1))
					holderline.BorderSizePixel = 0
					holderline.Parent = holderbackground
					local holderline2 = holderline:Clone()
					holderline2.Name = 'Line'
					holderline2.Position = UDim2.new()
					holderline2.Parent = holderbackground
					holdercolorline = Instance.new('Frame')
					holdercolorline.Size = UDim2.new(0, 2, 1, 0)
					holdercolorline.Position = right and UDim2.new(1, -5, 0, 0) or UDim2.new()
					holdercolorline.BorderSizePixel = 0
					holdercolorline.Parent = holderbackground
				end
				local holdertext = Instance.new('TextLabel')
				holdertext.Position = UDim2.fromOffset(right and 3 or 6, 2)
				holdertext.BackgroundTransparency = 1
				holdertext.BorderSizePixel = 0
				holdertext.Text = i..(v.ExtraText and " <font color='#A8A8A8'>"..v.ExtraText()..'</font>' or '')
				holdertext.TextSize = 15
				holdertext.FontFace = textguifont.Value
				holdertext.RichText = true
				local size = getfontsize(removeTags(holdertext.Text), holdertext.TextSize, holdertext.FontFace)
				holdertext.Size = UDim2.fromOffset(size.X, size.Y)
				if textguishadow.Enabled then
					local holderdrop = holdertext:Clone()
					holderdrop.Position = UDim2.fromOffset(holdertext.Position.X.Offset + 1, holdertext.Position.Y.Offset + 1)
					holderdrop.Text = removeTags(holdertext.Text)
					holderdrop.TextColor3 = Color3.new()
					holderdrop.Parent = holder
				end
				holdertext.Parent = holder
				local holdersize = UDim2.fromOffset(size.X + 10, size.Y + (textguibackground.Enabled and 5 or 3))
				if textguianimations.Enabled then
					if not table.find(found, i) then
						tween:Tween(holder, info, {
							Size = holdersize
						})
					else
						holder.Size = holdersize
						if not v.Enabled then
							tween:Tween(holder, info, {
								Size = UDim2.fromOffset()
							})
						end
					end
				else
					holder.Size = v.Enabled and holdersize or UDim2.fromOffset()
				end
				table.insert(VapeLabels, {
					Object = holder,
					Text = holdertext,
					Background = holderbackground,
					Color = holdercolorline,
					Enabled = v.Enabled
				})
			end
		end

		if textguisort.Value == 'Alphabetical' then
			table.sort(VapeLabels, function(a, b)
				return a.Text.Text < b.Text.Text
			end)
		else
			table.sort(VapeLabels, function(a, b)
				return a.Text.Size.X.Offset > b.Text.Size.X.Offset
			end)
		end

		for i, v in VapeLabels do
			if v.Color then
				v.Color.Parent.Line.Visible = i ~= 1
			end
			v.Object.LayoutOrder = i
		end
	end

	mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value, true)
end

function mainapi:UpdateGUI(hue, sat, val, default)
	if mainapi.Loaded == nil then return end
	if not default and mainapi.GUIColor.Rainbow then return end
	if textgui.Button.Enabled then
		VapeLogoGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromHSV(hue, sat, val)),
			ColorSequenceKeypoint.new(1, textguigradient.Enabled and Color3.fromHSV(mainapi:Color((hue - 0.075) % 1)) or Color3.fromHSV(hue, sat, val))
		})
		VapeLogoGradient2.Color = textguigradient.Enabled and textguigradientv4.Enabled and VapeLogoGradient.Color or ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1))
		})
		VapeLabelCustom.TextColor3 = textguicolorcustomtoggle.Enabled and Color3.fromHSV(textguicolorcustom.Hue, textguicolorcustom.Sat, textguicolorcustom.Value) or VapeLogoGradient.Color.Keypoints[2].Value

		local customcolor = textguicolordrop.Value == 'Custom color' and Color3.fromHSV(textguicolor.Hue, textguicolor.Sat, textguicolor.Value) or nil
		for i, v in VapeLabels do
			v.Text.TextColor3 = customcolor or (mainapi.GUIColor.Rainbow and Color3.fromHSV(mainapi:Color((hue - ((textguigradient and i + 2 or i) * 0.025)) % 1)) or VapeLogoGradient.Color.Keypoints[2].Value)
			if v.Color then
				v.Color.BackgroundColor3 = v.Text.TextColor3
			end
			if textguibackgroundtint.Enabled and v.Background then
				v.Background.BackgroundColor3 = color.Dark(v.Text.TextColor3, 0.75)
			end
		end
	end

	if not clickgui.Visible and not mainapi.Legit.Window.Visible then return end
	local rainbow = mainapi.GUIColor.Rainbow and mainapi.RainbowMode.Value ~= 'Retro'

	for i, v in mainapi.Categories do
		if i == 'Main' then
			v.Object.VapeLogo.V4Logo.ImageColor3 = Color3.fromHSV(hue, sat, val)
			for _, button in v.Buttons do
				local basec = rainbow and Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1)) or Color3.fromHSV(hue, sat, val)
				if button.Enabled then
					button.Object.TextColor3 = basec
					if button.Icon then
						button.Icon.ImageColor3 = button.Object.TextColor3
					end
					if button.Accent then
						button.Accent.BackgroundColor3 = basec
					end
				end
			end
		end

		if v.Options then
			for _, option in v.Options do
				if option.Color then
					option:Color(hue, sat, val, rainbow)
				end
			end
		end

		if v.Type == 'CategoryList' then
			v.Object.Children.Add.AddButton.ImageColor3 = rainbow and Color3.fromHSV(mainapi:Color(hue % 1)) or Color3.fromHSV(hue, sat, val)
			if v.Selected then
				v.Selected.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color(hue % 1)) or Color3.fromHSV(hue, sat, val)
				v.Selected.Title.TextColor3 = mainapi.GUIColor.Rainbow and Color3.new(0.19, 0.19, 0.19) or mainapi:TextColor(hue, sat, val)
				v.Selected.Dots.Dots.ImageColor3 = v.Selected.Title.TextColor3
				v.Selected.Bind.Icon.ImageColor3 = v.Selected.Title.TextColor3
				v.Selected.Bind.TextLabel.TextColor3 = v.Selected.Title.TextColor3
			end
		end
	end

	for _, button in mainapi.Modules do
		if button.Enabled then
			button.Object.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1)) or Color3.fromHSV(hue, sat, val)
			button.Object.TextColor3 = mainapi.GUIColor.Rainbow and Color3.new(0.19, 0.19, 0.19) or mainapi:TextColor(hue, sat, val)
			button.Object.UIGradient.Enabled = rainbow and mainapi.RainbowMode.Value == 'Gradient'
			if button.Object.UIGradient.Enabled then
				button.Object.BackgroundColor3 = Color3.new(1, 1, 1)
				button.Object.UIGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromHSV(mainapi:Color((hue - (button.Index * 0.025)) % 1))),
					ColorSequenceKeypoint.new(1, Color3.fromHSV(mainapi:Color((hue - ((button.Index + 1) * 0.025)) % 1)))
				})
			end
			button.Object.Bind.Icon.ImageColor3 = button.Object.TextColor3
			button.Object.Bind.TextLabel.TextColor3 = button.Object.TextColor3
			button.Object.Dots.Dots.ImageColor3 = button.Object.TextColor3
		end

		for _, option in button.Options do
			if option.Color then
				option:Color(hue, sat, val, rainbow)
			end
		end
	end

	for i, v in mainapi.Overlays.Toggles do
		if v.Enabled then
			tween:Cancel(v.Object.Knob)
			v.Object.Knob.BackgroundColor3 = rainbow and Color3.fromHSV(mainapi:Color((hue - (i * 0.075)) % 1)) or Color3.fromHSV(hue, sat, val)
		end
	end

	if mainapi.Legit.Icon then
		mainapi.Legit.Icon.ImageColor3 = Color3.fromHSV(hue, sat, val)
	end

	if mainapi.Legit.Window.Visible then
		for _, v in mainapi.Legit.Modules do
			if v.Enabled then
				tween:Cancel(v.Object.Knob)
				v.Object.Knob.BackgroundColor3 = Color3.fromHSV(hue, sat, val)
			end

			for _, option in v.Options do
				if option.Color then
					option:Color(hue, sat, val, rainbow)
				end
			end
		end
	end

	for _, data in mobileButtons do
		if data.button and data.button.Parent then
			updateMobileButtonColor(data.button, data.module.Enabled)
		end
	end
end

mainapi:Clean(notifications.ChildRemoved:Connect(function()
	for i, v in notifications:GetChildren() do
		if tween.Tween then
			tween:Tween(v, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
				Position = UDim2.new(1, 0, 1, -(29 + (78 * i)))
			})
		end
	end
end))

mainapi:Clean(inputService.InputBegan:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		table.insert(mainapi.HeldKeybinds, inputObj.KeyCode.Name)
		if mainapi.Binding then return end

		if checkKeybinds(mainapi.HeldKeybinds, mainapi.Keybind, inputObj.KeyCode.Name) then
			if mainapi.ThreadFix then
				setthreadidentity(8)
			end
			for _, v in mainapi.Windows do
				v.Visible = false
			end
			premadeWindow.Visible = false
			premadeBlocker.Visible = false
			clickgui.Visible = not clickgui.Visible
			tooltip.Visible = false
			mainapi:BlurCheck()
			for _, data in mobileButtons do
				if data.button and data.button.Parent then
					data.button.Visible = not clickgui.Visible or mobileEditorOpen
				end
			end
		end

		local toggled = false
		for i, v in mainapi.Modules do
			if type(v.Bind) == 'table' and v.Bind.Mobile then
				-- skip 
			else
				if checkKeybinds(mainapi.HeldKeybinds, v.Bind, inputObj.KeyCode.Name) then
					if v.KeybindMode == "Hold" then
						v.HoldCount = v.HoldCount + 1
						if v.HoldCount == 1 then
							v:SetEnabled(true, true)
							mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
						end
					else
						toggled = true
						if mainapi.ToggleNotifications.Enabled then
							mainapi:CreateNotification('Module Toggled', i.."<font color='#FFFFFF'> has been </font>"..(not v.Enabled and "<font color='#5AFF5A'>Enabled</font>" or "<font color='#FF5A5A'>Disabled</font>").."<font color='#FFFFFF'>!</font>", 0.75)
						end
						v:Toggle(true)
					end
				end
			end
		end
		if toggled then
			mainapi:UpdateTextGUI()
		end

		for _, v in mainapi.Profiles do
			if type(v.Bind) == 'table' and v.Bind.Mobile then
				-- skip
			else
				if checkKeybinds(mainapi.HeldKeybinds, v.Bind, inputObj.KeyCode.Name) and v.Name ~= mainapi.Profile then
					mainapi:Save(v.Name)
					mainapi:Load(true)
					break
				end
			end
		end
	end
end))

mainapi:Clean(inputService.InputEnded:Connect(function(inputObj)
	if not inputService:GetFocusedTextBox() and inputObj.KeyCode ~= Enum.KeyCode.Unknown then
		if mainapi.Binding then
			if not mainapi.MultiKeybind.Enabled then
				mainapi.HeldKeybinds = {inputObj.KeyCode.Name}
			end
			mainapi.Binding:SetBind(checkKeybinds(mainapi.HeldKeybinds, mainapi.Binding.Bind, inputObj.KeyCode.Name) and {} or mainapi.HeldKeybinds, true)
			mainapi.Binding = nil
		end

		local ind = table.find(mainapi.HeldKeybinds, inputObj.KeyCode.Name)
		if ind then
			table.remove(mainapi.HeldKeybinds, ind)
		end
		for i, v in mainapi.Modules do
			if v.KeybindMode == "Hold" then
				if type(v.Bind) == 'table' and v.Bind.Mobile then
					-- skip
				else
					if table.find(v.Bind, inputObj.KeyCode.Name) then
						v.HoldCount = math.max(v.HoldCount - 1, 0)
						if v.HoldCount == 0 then
							v:SetEnabled(false, true)
							mainapi:UpdateGUI(mainapi.GUIColor.Hue, mainapi.GUIColor.Sat, mainapi.GUIColor.Value)
						end
					end
				end
			end
		end
	end
end))

return mainapi
