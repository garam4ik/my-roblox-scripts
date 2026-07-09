-- Kill Hub | Steal a Brainrot Duels Edition
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleHint = Instance.new("TextLabel")

local LeftPanel = Instance.new("Frame")
local MainPanel = Instance.new("Frame")

local TabMainBtn = Instance.new("TextButton")
local TabFarmBtn = Instance.new("TextButton")
local TabSettingsBtn = Instance.new("TextButton")

local TabMainContent = Instance.new("Frame")
local TabFarmContent = Instance.new("Frame")
local TabSettingsContent = Instance.new("Frame")

-- Вкладка "Основное"
local FlyBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local EspBtn = Instance.new("TextButton")
local InfJumpBtn = Instance.new("TextButton")

-- Вкладка "Авто-Фарм"
local AutoCollectBtn = Instance.new("TextButton")
local AutoDuelBtn = Instance.new("TextButton")

-- Вкладка "Настройки"
local SpeedTitle = Instance.new("TextLabel")
local SpeedPlusBtn = Instance.new("TextButton")
local SpeedMinusBtn = Instance.new("TextButton")
local SpeedValueLabel = Instance.new("TextLabel")

local HideBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")

Frame.Name = "BrainrotHub"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 20, 30)
Frame.BorderSizePixel = 3
Frame.BorderColor3 = Color3.fromRGB(180, 50, 255)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(0.15, 0, 1, 0)
Frame.Size = UDim2.new(0.7, 0, 0.8, 0)
Frame.Active = true
Frame.Draggable = true

Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Brainrot Duels Hub"
Title.TextColor3 = Color3.fromRGB(180, 50, 255)
Title.TextSize = 24
Title.Font = Enum.Font.SourceSansBold
Title.TextTransparency = 1

ToggleHint.Parent = Frame
ToggleHint.Size = UDim2.new(1, 0, 0, 20)
ToggleHint.Position = UDim2.new(0, 0, 0, 42)
ToggleHint.BackgroundTransparency = 1
ToggleHint.Text = "[ Нажми 'K' для Скрытия ]"
ToggleHint.TextColor3 = Color3.fromRGB(150, 150, 150)
ToggleHint.TextSize = 14
ToggleHint.Font = Enum.Font.SourceSansItalic
ToggleHint.TextTransparency = 1

LeftPanel.Parent = Frame
LeftPanel.BackgroundColor3 = Color3.fromRGB(18, 15, 22)
LeftPanel.BorderSizePixel = 0
LeftPanel.Position = UDim2.new(0, 0, 0, 70)
LeftPanel.Size = UDim2.new(0.25, 0, 1, -70)

MainPanel.Parent = Frame
MainPanel.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
MainPanel.BorderSizePixel = 0
MainPanel.Position = UDim2.new(0.25, 0, 0, 70)
MainPanel.Size = UDim2.new(0.75, 0, 1, -70)

local function createTabButton(btn, text, order)
    btn.Parent = LeftPanel
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, (order - 1) * 55)
    btn.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 16
    btn.Font = Enum.Font.SourceSansBold
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
end

createTabButton(TabMainBtn, "Основное", 1)
createTabButton(TabFarmBtn, "Авто-Фарм", 2)
createTabButton(TabSettingsBtn, "Настройки", 3)

local function setupContentFrame(f)
    f.Parent = MainPanel
    f.Size = UDim2.new(1, 0, 1, 0)
    f.BackgroundTransparency = 1
    f.Visible = false
end

setupContentFrame(TabMainContent)
setupContentFrame(TabFarmContent)
setupContentFrame(TabSettingsContent)

local function setupGridButton(btn, text, posX, posY, parent)
    btn.Parent = parent
    btn.Size = UDim2.new(0.43, 0, 0, 50)
    btn.Position = UDim2.new(posX, 0, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(45, 40, 55)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 18
    btn.Font = Enum.Font.SourceSansBold
    btn.BackgroundTransparency = 1
    btn.TextTransparency = 1
end

setupGridButton(FlyBtn, "Fly: OFF", 0.05, 20, TabMainContent)
setupGridButton(NoclipBtn, "Noclip: OFF", 0.52, 20, TabMainContent)
setupGridButton(EspBtn, "Player ESP: OFF", 0.05, 85, TabMainContent)
setupGridButton(InfJumpBtn, "Inf Jump: OFF", 0.52, 85, TabMainContent)

setupGridButton(AutoCollectBtn, "Auto Collect: OFF", 0.05, 20, TabFarmContent)
setupGridButton(AutoDuelBtn, "Auto Duel: OFF", 0.52, 20, TabFarmContent)

SpeedTitle.Parent = TabSettingsContent
SpeedTitle.Size = UDim2.new(0.9, 0, 0, 30)
SpeedTitle.Position = UDim2.new(0.05, 0, 0, 20)
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.Text = "Настройка WalkSpeed (Скорость бега)"
SpeedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedTitle.TextSize = 18
SpeedTitle.Font = Enum.Font.SourceSansBold
SpeedTitle.TextXAlignment = Enum.TextXAlignment.Left

SpeedMinusBtn.Parent = TabSettingsContent
SpeedMinusBtn.Size = UDim2.new(0, 50, 0, 50)
SpeedMinusBtn.Position = UDim2.new(0.05, 0, 0, 60)
SpeedMinusBtn.BackgroundColor3 = Color3.fromRGB(55, 50, 65)
SpeedMinusBtn.Text = "-"
SpeedMinusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedMinusBtn.TextSize = 24
SpeedMinusBtn.Font = Enum.Font.SourceSansBold

SpeedValueLabel.Parent = TabSettingsContent
SpeedValueLabel.Size = UDim2.new(0, 100, 0, 50)
SpeedValueLabel.Position = UDim2.new(0.2, 0, 0, 60)
SpeedValueLabel.BackgroundTransparency = 1
SpeedValueLabel.Text = "16"
SpeedValueLabel.TextColor3 = Color3.fromRGB(180, 50, 255)
SpeedValueLabel.TextSize = 22
SpeedValueLabel.Font = Enum.Font.SourceSansBold

SpeedPlusBtn.Parent = TabSettingsContent
SpeedPlusBtn.Size = UDim2.new(0, 50, 0, 50)
SpeedPlusBtn.Position = UDim2.new(0.45, 0, 0, 60)
SpeedPlusBtn.BackgroundColor3 = Color3.fromRGB(55, 50, 65)
SpeedPlusBtn.Text = "+"
SpeedPlusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedPlusBtn.TextSize = 24
SpeedPlusBtn.Font = Enum.Font.SourceSansBold

HideBtn.Parent = ScreenGui
HideBtn.Position = UDim2.new(0.85, 0, -0.1, 0)
HideBtn.Size = UDim2.new(0, 100, 0, 40)
HideBtn.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
HideBtn.Text = "Show/Hide"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.TextSize = 16
HideBtn.Font = Enum.Font.SourceSansBold
HideBtn.BorderColor3 = Color3.fromRGB(180, 50, 255)

local function switchTab(activeFrame, activeBtn)
    TabMainContent.Visible = false
    TabFarmContent.Visible = false
    TabSettingsContent.Visible = false
    TabMainBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
    TabFarmBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
    TabSettingsBtn.BackgroundColor3 = Color3.fromRGB(40, 35, 45)
    activeFrame.Visible = true
    activeBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 255)
end

TabMainBtn.MouseButton1Click:Connect(function() switchTab(TabMainContent, TabMainBtn) end)
TabFarmBtn.MouseButton1Click:Connect(function() switchTab(TabFarmContent, TabFarmBtn) end)
TabSettingsBtn.MouseButton1Click:Connect(function() switchTab(TabSettingsContent, TabSettingsBtn) end)
switchTab(TabMainContent, TabMainBtn)

local TweenService = game:GetService("TweenService")
local animInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
TweenService:Create(Frame, animInfo, {Position = UDim2.new(0.15, 0, 0.1, 0), BackgroundTransparency = 0}):Play()
TweenService:Create(HideBtn, animInfo, {Position = UDim2.new(0.85, 0, 0.02, 0)}):Play()

task.spawn(function()
    task.wait(0.2)
    TweenService:Create(Title, animInfo, {TextTransparency = 0}):Play()
    TweenService:Create(ToggleHint, animInfo, {TextTransparency = 0}):Play()
    for _, elem in pairs({TabMainBtn, TabFarmBtn, TabSettingsBtn}) do TweenService:Create(elem, animInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play() end
    for _, elem in pairs({FlyBtn, NoclipBtn, EspBtn, InfJumpBtn, AutoCollectBtn, AutoDuelBtn}) do TweenService:Create(elem, animInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play() end
end)

local menuVisible = true
local function toggleMenu()
    menuVisible = not menuVisible
    if menuVisible then
        Frame.Visible = true
        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2.new(0.15, 0, 0.1, 0)}):Play()
    else
        local hideTween = TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Position = UDim2.new(0.15, 0, 1.1, 0)})
        hideTween:Play()
        hideTween.Completed:Connect(function() if not menuVisible then Frame.Visible = false end end)
    end
end
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe) if not gpe and input.KeyCode == Enum.KeyCode.K then toggleMenu() end end)
HideBtn.MouseButton1Click:Connect(toggleMenu)

-- ==================== ЛОГИКА ФУНКЦИЙ ====================
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

local currentSpeed = 16
local function updateSpeed(value)
    currentSpeed = math.clamp(currentSpeed + value, 16, 250)
    SpeedValueLabel.Text = tostring(currentSpeed)
    if player.Character and player.Character:FindFirstChild("Humanoid") then player.Character.Humanoid.WalkSpeed = currentSpeed end
end
SpeedPlusBtn.MouseButton1Click:Connect(function() updateSpeed(10) end)
SpeedMinusBtn.MouseButton1Click:Connect(function() updateSpeed(-10) end)
player.CharacterAdded:Connect(function(char) char:WaitForChild("Humanoid").WalkSpeed = currentSpeed end)

-- 1. Fly
local flying = false
local speed = 50
local keys = {w = false, s = false, a = false, d = false, space = false, lshift = false}
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.BackgroundColor3 = flying and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55)
    FlyBtn.Text = flying and "Fly: ON" or "Fly: OFF"
    if flying then
        task.spawn(function()
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local bg = Instance.new("BodyGyro", hrp) bg.maxTorque = Vector3.new(4e4, 4e4, 4e4) bg.cframe = hrp.CFrame
            local bv = Instance.new("BodyVelocity", hrp) bv.maxForce = Vector3.new(4e4, 4e4, 4e4)
            local uis = game:GetService("UserInputService")
            local c1 = uis.InputBegan:Connect(function(i, g) if g then return end if i.KeyCode == Enum.KeyCode.W then keys.w = true elseif i.KeyCode == Enum.KeyCode.S then keys.s = true elseif i.KeyCode == Enum.KeyCode.A then keys.a = true elseif i.KeyCode == Enum.KeyCode.D then keys.d = true elseif i.KeyCode == Enum.KeyCode.Space then keys.space = true elseif i.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = true end end)
            local c2 = uis.InputEnded:Connect(function(i) if i.KeyCode == Enum.KeyCode.W then keys.w = false elseif i.KeyCode == Enum.KeyCode.S then keys.s = false elseif i.KeyCode == Enum.KeyCode.A then keys.a = false elseif i.KeyCode == Enum.KeyCode.D then keys.d = false elseif i.KeyCode == Enum.KeyCode.Space then keys.space = false elseif i.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = false end end)
            while flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                local camera = workspace.CurrentCamera local moveDir = Vector3.new(0,0,0)
                if keys.w then moveDir = moveDir + camera.CFrame.LookVector end if keys.s then moveDir = moveDir - camera.CFrame.LookVector end if keys.a then moveDir = moveDir - camera.CFrame.RightVector end if keys.d then moveDir = moveDir + camera.CFrame.RightVector end if keys.space then moveDir = moveDir + Vector3.new(0, 1, 0) end if keys.lshift then moveDir = moveDir - Vector3.new(0, 1, 0) end
                bv.velocity = moveDir.Unit * speed if moveDir == Vector3.new(0,0,0) then bv.velocity = Vector3.new(0,0,0) end bg.cframe = camera.CFrame task.wait()
            end
            bg:Destroy() bv:Destroy() c1:Disconnect() c2:Disconnect()
        end)
    end
end)

-- 2. Noclip
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function() noclip = not noclip NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55) NoclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF" end)
runService.Stepped:Connect(function() if noclip and player.Character then for _, part in pairs(player.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end end)

-- 3. ESP
local espEnabled = false local espHighlights = {}
local function updateESP()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if espEnabled then
                local hl = espHighlights[p] or Instance.new("Highlight", p.Character) espHighlights[p] = hl hl.OutlineColor = Color3.fromRGB(255, 255, 255) hl.FillColor = Color3.fromRGB(180, 50, 255)
            else if espHighlights[p] then espHighlights[p]:Destroy() espHighlights[p] = nil end end
        end
    end
end
EspBtn.MouseButton1Click:Connect(function() espEnabled = not espEnabled EspBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55) EspBtn.Text = espEnabled and "Player ESP: ON" or "Player ESP: OFF" if not espEnabled then for _, h in pairs(espHighlights) do if h then h:Destroy() end end espHighlights = {} end end)
task.spawn(function() while true do if espEnabled then updateESP() end task.wait(1) end end)

-- 4. Infinite Jump (Пофиксили баг с ресетом)
local infJump = false
local lastJump = 0
InfJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    InfJumpBtn.BackgroundColor3 = infJump and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55)
    InfJumpBtn.Text = infJump and "Inf Jump: ON" or "Inf Jump: OFF"
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJump and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
        local hrp = player.Character.HumanoidRootPart
        if humanoid and tick() - lastJump > 0.15 then
            lastJump = tick()
            hrp.Velocity = Vector3.new(hrp.Velocity.X, humanoid.JumpPower or 50, hrp.Velocity.Z)
        end
    end
end)

-- 5. Auto Collect
local autoCollect = false
AutoCollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    AutoCollectBtn.BackgroundColor3 = autoCollect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55)
    AutoCollectBtn.Text = autoCollect and "Auto Collect: ON" or "Auto Collect: OFF"
end)

task.spawn(function()
    while true do
        if autoCollect and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("TouchTransmitter") and obj.Parent and obj.Parent:IsA("BasePart") then
                    local part = obj.Parent
                    if not part:IsDescendantOf(player.Character) and part.Name ~= "HumanoidRootPart" then
                        player.Character.HumanoidRootPart.CFrame = part.CFrame
                        task.wait(0.1)
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- 6. Auto Duel
local autoDuel = false
AutoDuelBtn.MouseButton1Click:Connect(function()
    autoDuel = not autoDuel
    AutoDuelBtn.BackgroundColor3 = autoDuel and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 40, 55)
    AutoDuelBtn.Text = autoDuel and "Auto Duel: ON" or "Auto Duel: OFF"
end)

task.spawn(function()
    while true do
        if autoDuel then
            local pGui = player:FindFirstChild("PlayerGui")
            if pGui then
                for _, gui in pairs(pGui:GetDescendants()) do
                    if gui:IsA("TextButton") and (string.find(string.lower(gui.Text), "duel") or string.find(string.lower(gui.Text), "accept")) then
                        if gui.Visible and gui.AbsoluteSize.X > 0 then
                            gui:Activate()
                        end
                    end
                end
            end
        end
        task.wait(1)
    end
end)
