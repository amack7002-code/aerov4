-- RIDE A PET

local run = function(func) func() end
local cloneref = cloneref or function(obj) return obj end
local playersService = cloneref(game:GetService('Players'))
local replicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local inputService = cloneref(game:GetService('UserInputService'))
local tweenService = cloneref(game:GetService('TweenService'))
local runService = cloneref(game:GetService('RunService'))
local httpService = cloneref(game:GetService('HttpService'))
local virtualUser = cloneref(game:GetService('VirtualUser'))
local lplr = playersService.LocalPlayer
local vape = shared.vape
local entitylib = vape.Libraries.entity
local sessioninfo = vape.Libraries.sessioninfo
local gameapi = {}

local function notif(...) return
	vape:CreateNotification(...)
end

for _, v in {'PlayerModel','AimAssist', 'Search', 'Waypoints', 'StaffDetector', 'AutoClicker', 'Reach', 'Disabler', 'MurderMystery', 'Killaura', 'TriggerBot', 'SilentAim', 'Gravity', 'Parkour', 'LongJump', 'HitBoxes', 'TargetStrafe' } do
    vape:Remove(v)
end

local function parseLuck(text)
    text = tostring(text or ''):lower():gsub('%s+', ''):gsub(',', '')

    local number = tonumber(text:match('[%d%.]+'))

    if not number then
        return 0
    end

    local suffix = text:match('[kmbt]')

    if suffix == 'k' then
        number *= 1e3
    elseif suffix == 'm' then
        number *= 1e6
    elseif suffix == 'b' then
        number *= 1e9
    elseif suffix == 't' then
        number *= 1e12
    end

    return number
end

run(function()
    local EggESP
    local ShowName
    local ShowLuck
    local ShowDistance
    local Highlight
    local MaxDistance
    local MinLuck
    local renderedEggs = workspace:WaitForChild('RenderedEggs')
    local tracked = {}

    local function getPart(egg)
        local handle = egg:FindFirstChild('Handle', true)

        if handle and handle:IsA('BasePart') then
            return handle
        end

        return egg:FindFirstChildWhichIsA('BasePart', true)
    end

    local function getLuck(egg)
        local eggLuck = egg:FindFirstChild('EggLuck', true)
        local luck = eggLuck and eggLuck:FindFirstChild('Luck', true)

        if luck and luck:IsA('TextLabel') then
            return luck.Text
        end

        return '?'
    end

    local function getLuckValue(egg)
        local text = string.lower(getLuck(egg))
        local number = tonumber(text:match('[%d%.]+')) or 0
        local suffix = text:match('[kmbt]')

        if suffix == 'k' then
            number *= 1e3
        elseif suffix == 'm' then
            number *= 1e6
        elseif suffix == 'b' then
            number *= 1e9
        elseif suffix == 't' then
            number *= 1e12
        end

        return number
    end

    local function removeEgg(egg)
        local data = tracked[egg]

        if data then
            if data.Gui then
                data.Gui:Destroy()
            end

            if data.Highlight then
                data.Highlight:Destroy()
            end

            tracked[egg] = nil
        end
    end

    local function addEgg(egg)
        if tracked[egg] or not egg:IsA('Model') then
            return
        end

        local part = getPart(egg)

        if not part then
            return
        end

        local gui = Instance.new('BillboardGui')
        gui.Name = 'aeroeggesp'
        gui.Adornee = part
        gui.AlwaysOnTop = true
        gui.Size = UDim2.fromOffset(200, 50)
        gui.StudsOffset = Vector3.new(0, 3, 0)
        gui.Parent = part

        local text = Instance.new('TextLabel')
        text.Name = 'text'
        text.Size = UDim2.fromScale(1, 1)
        text.BackgroundTransparency = 1
        text.TextColor3 = Color3.new(1, 1, 1)
        text.RichText = true
        text.TextStrokeTransparency = 0
        text.TextSize = 14
        text.Font = Enum.Font.GothamMedium
        text.TextWrapped = true
        text.Parent = gui

        local highlight = Instance.new('Highlight')
        highlight.Name = 'aeroegghighlight'
        highlight.Adornee = egg
        highlight.FillTransparency = 0.75
        highlight.OutlineTransparency = 0
        highlight.Enabled = Highlight.Enabled
        highlight.Parent = egg

        tracked[egg] = {
            Gui = gui,
            Text = text,
            Highlight = highlight,
            Part = part
        }
    end

    local function updateEgg(egg, data)
        if not egg.Parent or not data.Part or not data.Part.Parent then
            removeEgg(egg)
            return
        end

        local root = lplr.Character and lplr.Character:FindFirstChild('HumanoidRootPart')

        if not root then
            data.Gui.Enabled = false
            data.Highlight.Enabled = false
            return
        end

        local distance = (root.Position - data.Part.Position).Magnitude
        local luckValue = getLuckValue(egg)
        local visible = distance <= MaxDistance.Value and luckValue >= parseLuck(MinLuck.Value)

        data.Gui.Enabled = visible
        data.Highlight.Enabled = visible and Highlight.Enabled

        if not visible then
            return
        end

        local lines = {}

        if ShowName.Enabled then
            lines[#lines + 1] = '<font color="#4DA6FF">' .. string.lower(egg.Name) .. '</font>'
        end

        if ShowLuck.Enabled then
            lines[#lines + 1] = '<font color="#4DFF88">luck ' .. getLuck(egg) .. '</font>'
        end

        if ShowDistance.Enabled then
            lines[#lines + 1] = '<font color="#FFFFFF">' .. math.floor(distance) .. ' studs</font>'
        end

        data.Text.Text = table.concat(lines, '\n')
    end

    EggESP = vape.Categories.Render:CreateModule({
        Name = 'EggESP',
        Function = function(callback)
            if callback then
                for _, egg in renderedEggs:GetChildren() do
                    addEgg(egg)
                end

                EggESP:Clean(renderedEggs.ChildAdded:Connect(function(egg)
                    task.wait()
                    addEgg(egg)
                end))

                EggESP:Clean(renderedEggs.ChildRemoved:Connect(function(egg)
                    removeEgg(egg)
                end))

                EggESP:Clean(runService.RenderStepped:Connect(function()
                    for egg, data in pairs(tracked) do
                        updateEgg(egg, data)
                    end
                end))
            else
                for egg in pairs(tracked) do
                    removeEgg(egg)
                end
            end
        end,
        Tooltip = 'shows egg info through the map gng'
    })

    ShowName = EggESP:CreateToggle({
        Name = 'show name',
        Default = true,
        Function = function() end,
        Tooltip = 'shows what egg it is'
    })

    ShowLuck = EggESP:CreateToggle({
        Name = 'show luck',
        Default = true,
        Function = function() end,
        Tooltip = 'shows the eggs luck'
    })

    ShowDistance = EggESP:CreateToggle({
        Name = 'show distance',
        Default = true,
        Function = function() end,
        Tooltip = 'shows how far the egg is'
    })

    Highlight = EggESP:CreateToggle({
        Name = 'highlight',
        Default = true,
        Function = function(callback)
            for _, data in pairs(tracked) do
                if data.Highlight then
                    data.Highlight.Enabled = callback
                end
            end
        end,
        Tooltip = 'makes eggs easier to see'
    })

    MaxDistance = EggESP:CreateSlider({
        Name = 'max distance',
        Min = 50,
        Max = 5000,
        Default = 1500,
        Function = function() end,
        Suffix = 'studs'
    })
    MinLuck = EggESP:CreateTextBox({
        Name = 'min luck',
        Default = '1',
        Function = function() end
    })
end)

run(function()
    local AutoCollectEgg
    local Priority
    local MaxDistance
    local renderedEggs = workspace:WaitForChild('RenderedEggs')

    local function getPart(egg)
        local handle = egg:FindFirstChild('Handle', true)

        if handle and handle:IsA('BasePart') then
            return handle
        end

        return egg:FindFirstChildWhichIsA('BasePart', true)
    end

    local function getPrompt(egg)
        for _, obj in egg:GetDescendants() do
            if obj:IsA('ProximityPrompt') and obj.Name == 'Pickup' then
                return obj
            end
        end
    end

    local function getLuck(egg)
        local eggLuck = egg:FindFirstChild('EggLuck', true)
        local luck = eggLuck and eggLuck:FindFirstChild('Luck', true)

        if not luck or not luck:IsA('TextLabel') then
            return 0
        end

        local text = string.lower(luck.Text)
        local number = tonumber(text:match('[%d%.]+')) or 0
        local suffix = text:match('[kmbt]')

        if suffix == 'k' then
            number *= 1e3
        elseif suffix == 'm' then
            number *= 1e6
        elseif suffix == 'b' then
            number *= 1e9
        elseif suffix == 't' then
            number *= 1e12
        end

        return number
    end

    local function isCarryingEgg()
        local playerGui = lplr:FindFirstChild('PlayerGui')
        local main = playerGui and playerGui:FindFirstChild('Main')
        local basketTracker = main and main:FindFirstChild('BasketTracker')
        local capacity = basketTracker and basketTracker:FindFirstChild('Capacity')

        if capacity and capacity:IsA('TextLabel') then
            local current, max = capacity.Text:match('(%d+)%s*/%s*(%d+)')

            current = tonumber(current)
            max = tonumber(max)

            if current and max then
                return current >= max
            end
        end

        return false
    end

    local function getTarget()
        if isCarryingEgg() then
            return
        end

        local char = lplr.Character
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            return
        end

        local best
        local bestValue

        for _, egg in renderedEggs:GetChildren() do
            if egg:IsA('Model') then
                local part = getPart(egg)
                local prompt = getPrompt(egg)

                if part and prompt and prompt.Enabled then
                    local distance = (root.Position - part.Position).Magnitude

                    if distance <= MaxDistance.Value then
                        if Priority.Value == 'best luck' then
                            local luck = getLuck(egg)

                            if not bestValue or luck > bestValue then
                                best = prompt
                                bestValue = luck
                            end
                        else
                            if not bestValue or distance < bestValue then
                                best = prompt
                                bestValue = distance
                            end
                        end
                    end
                end
            end
        end

        return best
    end

    AutoCollectEgg = vape.Categories.Blatant:CreateModule({
        Name = 'AutoCollectEgg',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat
                        local prompt = getTarget()

                        if prompt and fireproximityprompt then
                            fireproximityprompt(prompt)
                        end

                        task.wait(0.1)
                    until not AutoCollectEgg.Enabled
                end)
            end
        end,
        Tooltip = 'auto picks up eggs for u gng'
    })

    Priority = AutoCollectEgg:CreateDropdown({
        Name = 'priority',
        List = {'nearest', 'best luck'},
        Function = function() end,
        Tooltip = 'choose which egg gets picked first'
    })

    MaxDistance = AutoCollectEgg:CreateSlider({
        Name = 'max distance',
        Min = 15,
        Max = 100,
        Default = 100,
        Function = function() end,
        Suffix = 'studs'
    })
end)

run(function()
    local AutoPlaceEgg
    local eggPlaced = replicatedStorage.Remotes.Game.EggPlaced

    local function getPlot()
        local plots = workspace:FindFirstChild('Plots')

        if not plots then
            return
        end

        for _, plot in ipairs(plots:GetChildren()) do
            local data = plot:FindFirstChild('Data')
            local owner = data and data:FindFirstChild('Owner')

            if owner and owner:IsA('ObjectValue') and owner.Value == lplr then
                return plot
            end
        end
    end

    local function getPlacementPosition()
        local plot = getPlot()
        local baseplate = plot and plot:FindFirstChild('Baseplate')

        if not baseplate or not baseplate:IsA('BasePart') then
            return
        end

        return baseplate.CFrame:PointToWorldSpace(Vector3.new(
            0,
            baseplate.Size.Y / 2,
            0
        ))
    end

    local function getHeldEgg()
        local char = lplr.Character

        if not char then
            return
        end

        for _, tool in ipairs(char:GetChildren()) do
            if tool:IsA('Tool') and string.find(string.lower(tool.Name), 'egg', 1, true) then
                return tool
            end
        end
    end

    AutoPlaceEgg = vape.Categories.Blatant:CreateModule({
        Name = 'AutoPlaceEgg',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat
                        local egg = getHeldEgg()

                        if egg then
                            local position = getPlacementPosition()

                            if position then
                                eggPlaced:FireServer({
                                    PlantPosition = position
                                })

                                task.wait(0.5)
                            else
                                task.wait(0.1)
                            end
                        else
                            task.wait(0.1)
                        end
                    until not AutoPlaceEgg.Enabled
                end)
            end
        end,
        Tooltip = 'auto places ur egg'
    })
end)

run(function()
    local AutoHatch
    local eggPlaced = replicatedStorage.Remotes.Game.EggPlaced
    local requestPlotEggs = replicatedStorage.Remotes.Game.RequestPlotEggs
    local hatch = replicatedStorage.Remotes.Game.Hatch
    local eggs = {}

    local function addEgg(data)
        if typeof(data) ~= 'table' then
            return
        end

        if data.Snapshot and data.Owner == lplr then
            table.clear(eggs)

            for _, egg in pairs(data.Placements or {}) do
                if egg.EggKey then
                    eggs[egg.EggKey] = true
                end
            end

            return
        end

        if data.Owner == lplr and data.EggKey then
            eggs[data.EggKey] = true
        end
    end

    AutoHatch = vape.Categories.Blatant:CreateModule({
        Name = 'AutoHatch',
        Function = function(callback)
            if callback then
                AutoHatch:Clean(eggPlaced.OnClientEvent:Connect(addEgg))

                requestPlotEggs:FireServer(false)

                task.spawn(function()
                    repeat
                        for eggKey in pairs(eggs) do
                            hatch:FireServer({
                                EggKey = eggKey
                            })

                            task.wait(0.15)
                        end

                        requestPlotEggs:FireServer(false)
                        task.wait(0.5)
                    until not AutoHatch.Enabled
                end)
            else
                table.clear(eggs)
            end
        end,
        Tooltip = 'auto hatches ur ready eggs'
    })
end)

run(function()
    local AutoRebirth

    AutoRebirth = vape.Categories.Blatant:CreateModule({
        Name = 'AutoRebirth',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat
                        local playerGui = lplr:FindFirstChild('PlayerGui')
                        local main = playerGui and playerGui:FindFirstChild('Main')
                        local rebirthGui = main and main:FindFirstChild('Rebirth')
                        local button = rebirthGui and rebirthGui:FindFirstChild('Rebirth')

                        if button and button:IsA('GuiButton') and firesignal then
                            firesignal(button.Activated)
                        end

                        task.wait(1)
                    until not AutoRebirth.Enabled
                end)
            end
        end,
        Tooltip = 'auto rebirths when u can'
    })
end)

run(function()
    local AutoBuyUpgrade
    local BuyMode

    local function buyOne()
        local playerGui = lplr:FindFirstChild('PlayerGui')
        local upgrade = playerGui and playerGui:FindFirstChild('Upgrade')
        local purchase = upgrade and upgrade:FindFirstChild('Purchase')

        if purchase and purchase:IsA('GuiButton') and firesignal then
            firesignal(purchase.Activated)
            return true
        end
    end

    local function buyMax()
        local playerGui = lplr:FindFirstChild('PlayerGui')
        local upgrade = playerGui and playerGui:FindFirstChild('MaxUpgrade')
        local purchase = upgrade and upgrade:FindFirstChild('Purchase')

        if purchase and purchase:IsA('GuiButton') and firesignal then
            firesignal(purchase.Activated)
            return true
        end
    end

    AutoBuyUpgrade = vape.Categories.Blatant:CreateModule({
        Name = 'AutoBuyUpgrade',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat
                        if BuyMode.Value == 'max' then
                            buyMax()
                        else
                            buyOne()
                        end

                        task.wait(0.5)
                    until not AutoBuyUpgrade.Enabled
                end)
            end
        end,
        Tooltip = 'auto buys hatch luck upgrades'
    })

    BuyMode = AutoBuyUpgrade:CreateDropdown({
        Name = 'buy mode',
        List = {'one', 'max'},
        Function = function() end,
        Tooltip = 'buy one or max upgrade'
    })
end)

run(function()
    local TeleportToBase

    local function getPlot()
        local plots = workspace:FindFirstChild('Plots')

        if not plots then
            return
        end

        for _, plot in ipairs(plots:GetChildren()) do
            local data = plot:FindFirstChild('Data')
            local owner = data and data:FindFirstChild('Owner')

            if owner and owner:IsA('ObjectValue') and owner.Value == lplr then
                return plot
            end
        end
    end

    TeleportToBase = vape.Categories.Utility:CreateModule({
        Name = 'TeleportToBase',
        Function = function(callback)
            if callback then
                local char = lplr.Character
                local root = char and char:FindFirstChild('HumanoidRootPart')
                local plot = getPlot()
                local baseplate = plot and plot:FindFirstChild('Baseplate')

                if root and baseplate and baseplate:IsA('BasePart') then
                    root.CFrame = baseplate.CFrame + Vector3.new(0, 5, 0)
                end

                task.wait()
                TeleportToBase:Toggle()
            end
        end,
        Tooltip = 'teleports u straight to ur base'
    })
end)

run(function()
    local EggAlert
    local MinLuck
    local BlackholeOnly
    local renderedEggs = workspace:WaitForChild('RenderedEggs')
    local alerted = {}

    local function getLuck(egg)
        local eggLuck = egg:FindFirstChild('EggLuck', true)
        local luck = eggLuck and eggLuck:FindFirstChild('Luck', true)

        if not luck or not luck:IsA('TextLabel') then
            return 0, '?'
        end

        local text = luck.Text
        local lower = string.lower(text)
        local number = tonumber(lower:match('[%d%.]+')) or 0
        local suffix = lower:match('[kmbt]')

        if suffix == 'k' then
            number *= 1e3
        elseif suffix == 'm' then
            number *= 1e6
        elseif suffix == 'b' then
            number *= 1e9
        elseif suffix == 't' then
            number *= 1e12
        end

        return number, text
    end

    local function checkEgg(egg)
        if not EggAlert.Enabled or alerted[egg] or not egg:IsA('Model') then
            return
        end

        if BlackholeOnly.Enabled and not string.find(string.lower(egg.Name), 'blackhole', 1, true) then
            return
        end

        task.wait(0.1)

        if not egg.Parent then
            return
        end

        local value, display = getLuck(egg)

        if value >= parseLuck(MinLuck.Value) then
            alerted[egg] = true

            notif(
                'EggAlert',
                egg.Name .. ' | luck ' .. display,
                6
            )
        end
    end

    EggAlert = vape.Categories.Render:CreateModule({
        Name = 'EggAlert',
        Function = function(callback)
            if callback then
                for _, egg in ipairs(renderedEggs:GetChildren()) do
                    task.spawn(checkEgg, egg)
                end

                EggAlert:Clean(renderedEggs.ChildAdded:Connect(function(egg)
                    task.spawn(checkEgg, egg)
                end))

                EggAlert:Clean(renderedEggs.ChildRemoved:Connect(function(egg)
                    alerted[egg] = nil
                end))
            else
                table.clear(alerted)
            end
        end,
        Tooltip = 'alerts u when good eggs spawn'
    })

    MinLuck = EggAlert:CreateTextBox({
        Name = 'min luck',
        Default = '1K',
        Function = function() end
    })

    BlackholeOnly = EggAlert:CreateToggle({
        Name = 'blackhole only',
        Default = false,
        Function = function() end,
        Tooltip = 'only alerts for blackhole eggs'
    })
end)

run(function()
    local AutoFarm
    local Priority
    local MinLuck
    local BlackholeOnly

    local renderedEggs = workspace:WaitForChild('RenderedEggs')
    local eggPlaced = replicatedStorage.Remotes.Game.EggPlaced

    local function getPart(egg)
        local handle = egg:FindFirstChild('Handle', true)

        if handle and handle:IsA('BasePart') then
            return handle
        end

        return egg:FindFirstChildWhichIsA('BasePart', true)
    end

    local function getPrompt(egg)
        for _, obj in ipairs(egg:GetDescendants()) do
            if obj:IsA('ProximityPrompt') and obj.Name == 'Pickup' then
                return obj
            end
        end
    end

    local function getLuck(egg)
        local eggLuck = egg:FindFirstChild('EggLuck', true)
        local luck = eggLuck and eggLuck:FindFirstChild('Luck', true)

        if not luck or not luck:IsA('TextLabel') then
            return 0
        end

        return parseLuck(luck.Text)
    end

    local function getPlot()
        local plots = workspace:FindFirstChild('Plots')

        if not plots then
            return
        end

        for _, plot in ipairs(plots:GetChildren()) do
            local data = plot:FindFirstChild('Data')
            local owner = data and data:FindFirstChild('Owner')

            if owner and owner:IsA('ObjectValue') and owner.Value == lplr then
                return plot
            end
        end
    end

    local function getBasePosition()
        local plot = getPlot()
        local baseplate = plot and plot:FindFirstChild('Baseplate')

        if not baseplate or not baseplate:IsA('BasePart') then
            return
        end

        return baseplate.CFrame:PointToWorldSpace(Vector3.new(
            0,
            baseplate.Size.Y / 2,
            0
        ))
    end

    local function teleport(position)
        local char = lplr.Character
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            return false
        end

        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        root.CFrame = CFrame.new(position + Vector3.new(0, 4, 0))

        return true
    end

    local function isCarryingEgg()
        local playerGui = lplr:FindFirstChild('PlayerGui')
        local main = playerGui and playerGui:FindFirstChild('Main')
        local basketTracker = main and main:FindFirstChild('BasketTracker')
        local capacity = basketTracker and basketTracker:FindFirstChild('Capacity')

        if capacity and capacity:IsA('TextLabel') then
            local current = tonumber(capacity.Text:match('^(%d+)'))

            if current and current > 0 then
                return true
            end
        end

        local char = lplr.Character

        if char then
            for _, tool in ipairs(char:GetChildren()) do
                if tool:IsA('Tool') and string.find(string.lower(tool.Name), 'egg', 1, true) then
                    return true
                end
            end
        end

        return false
    end

    local function validEgg(egg)
        if BlackholeOnly.Enabled then
            if not string.find(string.lower(egg.Name), 'blackhole', 1, true) then
                return false
            end
        end

        if getLuck(egg) < parseLuck(MinLuck.Value) then
            return false
        end

        return true
    end

    local function getTarget()
        local char = lplr.Character
        local root = char and char:FindFirstChild('HumanoidRootPart')

        if not root then
            return
        end

        local best
        local bestValue

        for _, egg in ipairs(renderedEggs:GetChildren()) do
            if egg:IsA('Model') and validEgg(egg) then
                local part = getPart(egg)
                local prompt = getPrompt(egg)

                if part and prompt and prompt.Enabled then
                    local distance = (root.Position - part.Position).Magnitude
                    local luck = getLuck(egg)

                    if Priority.Value == 'highest luck' then
                        if not bestValue or luck > bestValue then
                            best = egg
                            bestValue = luck
                        end
                    else
                        if not bestValue or distance < bestValue then
                            best = egg
                            bestValue = distance
                        end
                    end
                end
            end
        end

        return best
    end

    AutoFarm = vape.Categories.Blatant:CreateModule({
        Name = 'AutoFarm',
        Function = function(callback)
            if callback then
                task.spawn(function()
                    repeat
                        if isCarryingEgg() then
                            local basePosition = getBasePosition()

                            if basePosition then
                                teleport(basePosition)
                                task.wait(0.5)

                                eggPlaced:FireServer({
                                    PlantPosition = basePosition
                                })

                                task.wait(0.7)
                            else
                                task.wait(0.2)
                            end
                        else
                            local egg = getTarget()

                            if egg then
                                local part = getPart(egg)
                                local prompt = getPrompt(egg)

                                if part and prompt then
                                    teleport(part.Position)
                                    task.wait(0.2)

                                    if fireproximityprompt then
                                        fireproximityprompt(prompt)
                                    end

                                    task.wait(0.35)
                                end
                            else
                                task.wait(0.25)
                            end
                        end
                    until not AutoFarm.Enabled
                end)
            end
        end,
        Tooltip = 'collects and places eggs for u'
    })

    Priority = AutoFarm:CreateDropdown({
        Name = 'priority',
        List = {'nearest', 'highest luck'},
        Function = function() end,
        Tooltip = 'choose which matching egg gets farmed'
    })

    MinLuck = AutoFarm:CreateTextBox({
        Name = 'min luck',
        Default = '1',
        Function = function() end
    })

    BlackholeOnly = AutoFarm:CreateToggle({
        Name = 'blackhole only',
        Default = false,
        Function = function() end,
        Tooltip = 'only farms blackhole eggs'
    })
end)