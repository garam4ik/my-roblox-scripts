-- Создание интерфейса Kill Hub для MM2
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleHint = Instance.new("TextLabel")

-- Кнопки функций
local FlyBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local EspBtn = Instance.new("TextButton")
local CoinBtn = Instance.new("TextButton")
local TeleportSheriffBtn = Instance.new("TextButton")
local TeleportLobbyBtn = Instance.new("TextButton")

-- Кнопка для скрытия (для мобильных/удобства)
local HideBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")

-- Главное окно
Frame.Name = "KillHubMM2"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Красная обводка хаба
Frame.Position = UDim2.new(0.1, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 200, 0, 370)
Frame.Active = true
Frame.Draggable = true

-- Заголовок
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Kill Hub | MM2"
Title.TextColor3 = Color3.fromRGB(255, 50, 50)
Title.TextSize = 18
Title.Font = Enum.Font.SourceSansBold

-- Подсказка о скрытии
ToggleHint.Parent = Frame
ToggleHint.Size = UDim2.new(1, 0, 0, 15)
ToggleHint.Position = UDim2.new(0, 0, 0, 30)
ToggleHint.BackgroundTransparency = 1
ToggleHint.Text = "[ Нажми 'K' чтобы скрыть ]"
ToggleHint.TextColor3 = Color3.fromRGB(150, 150, 150)
ToggleHint.TextSize = 11
ToggleHint.Font = Enum.Font.SourceSansItalic

-- Функция настройки кнопок
local function setupButton(btn, text, posY)
    btn.Parent = Frame
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
end

-- Размещение кнопок
setupButton(FlyBtn, "Fly: OFF", 55)
setupButton(NoclipBtn, "Noclip: OFF", 100)
setupButton(EspBtn, "MM2 ESP: OFF", 145)
setupButton(CoinBtn, "Auto Farm Coins: OFF", 190)
setupButton(TeleportSheriffBtn, "TP to Gun / Sheriff", 235)
setupButton(TeleportLobbyBtn, "TP to Lobby", 280)

-- Маленькая кнопка "Скрыть" на экране
HideBtn.Parent = ScreenGui
HideBtn.Position = UDim2.new(0.9, 0, 0.05, 0)
HideBtn.Size = UDim2.new(0, 80, 0, 30)
HideBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
HideBtn.Text = "Show/Hide"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.BorderColor3 = Color3.fromRGB(255, 0, 0)

-- ==================== СИСТЕМА СКРЫТИЯ МЕНЮ ====================
local menuVisible = true
local function toggleMenu()
    menuVisible = not menuVisible
    Frame.Visible = menuVisible
end

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.K then
        toggleMenu()
    end
end)
HideBtn.MouseButton1Click:Connect(toggleMenu)

-- ==================== ЛОГИКА ФУНКЦИЙ ====================
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- 1. Полет (Fly)
local flying = false
local speed = 50
local keys = {w = false, s = false, a = false, d = false, space = false, lshift = false}
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        FlyBtn.Text = "Fly: ON"
        task.spawn(function()
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local bg = Instance.new("BodyGyro", hrp)
            bg.maxTorque = Vector3.new(4e4, 4e4, 4e4)
            bg.cframe = hrp.CFrame
            local bv = Instance.new("BodyVelocity", hrp)
            bv.maxForce = Vector3.new(4e4, 4e4, 4e4)
            local uis = game:GetService("UserInputService")
            
            local c1 = uis.InputBegan:Connect(function(i, g)
                if g then return end
                if i.KeyCode == Enum.KeyCode.W then keys.w = true
                elseif i.KeyCode == Enum.KeyCode.S then keys.s = true
                elseif i.KeyCode == Enum.KeyCode.A then keys.a = true
                elseif i.KeyCode == Enum.KeyCode.D then keys.d = true
                elseif i.KeyCode == Enum.KeyCode.Space then keys.space = true
                elseif i.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = true end
            end)
            local c2 = uis.InputEnded:Connect(function(i)
                if i.KeyCode == Enum.KeyCode.W then keys.w = false
                elseif i.KeyCode == Enum.KeyCode.S then keys.s = false
                elseif i.KeyCode == Enum.KeyCode.A then keys.a = false
                elseif i.KeyCode == Enum.KeyCode.D then keys.d = false
                elseif i.KeyCode == Enum.KeyCode.Space then keys.space = false
                elseif i.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = false end
            end)
            
            while flying and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
                local camera = workspace.CurrentCamera
                local moveDir = Vector3.new(0,0,0)
                if keys.w then moveDir = moveDir + camera.CFrame.LookVector end
                if keys.s then moveDir = moveDir - camera.CFrame.LookVector end
                if keys.a then moveDir = moveDir - camera.CFrame.RightVector end
                if keys.d then moveDir = moveDir + camera.CFrame.RightVector end
                if keys.space then moveDir = moveDir + Vector3.new(0, 1, 0) end
                if keys.lshift then moveDir = moveDir - Vector3.new(0, 1, 0) end
                bv.velocity = moveDir.Unit * speed
                if moveDir == Vector3.new(0,0,0) then bv.velocity = Vector3.new(0,0,0) end
                bg.cframe = camera.CFrame
                task.wait()
            end
            bg:Destroy() bv:Destroy() c1:Disconnect() c2:Disconnect()
        end)
    else
        FlyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
        FlyBtn.Text = "Fly: OFF"
    end
end)

-- 2. Прохождение сквозь стены (Noclip)
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    NoclipBtn.BackgroundColor3 = noclip and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 50)
    NoclipBtn.Text = noclip and "Noclip: ON" or "Noclip: OFF"
end)
runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- 3. Умный MM2 ESP (Подсветка ролей: Убийца - Красный, Шериф - Синий, Невинный - Зеленый)
local espEnabled = false
local espHighlights = {}
local function updateESP()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            if espEnabled then
                local hl = espHighlights[p] or Instance.new("Highlight", p.Character)
                espHighlights[p] = hl
                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                
                -- Проверка роли по вещам в инвентаре MM2
                if p.Backpack:FindFirstChild("Knife") or (p.Character and p.Character:FindFirstChild("Knife")) then
                    hl.FillColor = Color3.fromRGB(255, 0, 0) -- Мардер
                elseif p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then
                    hl.FillColor = Color3.fromRGB(0, 0, 255) -- Шериф
                else
                    hl.FillColor = Color3.fromRGB(0, 255, 0) -- Мирный
                end
            else
                if espHighlights[p] then espHighlights[p]:Destroy() espHighlights[p] = nil end
            end
        end
    end
end

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspBtn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 50)
    EspBtn.Text = espEnabled and "MM2 ESP: ON" or "MM2 ESP: OFF"
    if not espEnabled then
        for _, h in pairs(espHighlights) do if h then h:Destroy() end end
        espHighlights = {}
    end
end)
task.spawn(function()
    while true do
        if espEnabled then updateESP() end
        task.wait(1)
    end
end)

-- 4. Автосбор монет (Auto Farm Coins)
local autoCoin = false
CoinBtn.MouseButton1Click:Connect(function()
    autoCoin = not autoCoin
    CoinBtn.BackgroundColor3 = autoCoin and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(45, 45, 50)
    CoinBtn.Text = autoCoin and "Auto Farm Coins: ON" or "Auto Farm Coins: OFF"
end)
task.spawn(function()
    while true do
        if autoCoin and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local container = workspace:FindFirstChild("Normal") or workspace:FindFirstChild("CoinContainer")
            if container then
                for _, obj in pairs(container:GetDescendants()) do
                    if obj.Name == "Coin_Cent" or obj.Name == "Coin" or obj:IsA("TouchTransmitter") then
                        local coinPart = obj:IsA("TouchTransmitter") and obj.Parent or obj
                        if coinPart:IsA("BasePart") then
                            player.Character.HumanoidRootPart.CFrame = coinPart.CFrame
                            task.wait(0.2)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- 5. Телепорт к пистолету (если Шерифа убили) или к самому Шерифу
TeleportSheriffBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    -- Ищем пистолет на полу
    local droppedGun = workspace:FindFirstChild("GunDrop")
    if droppedGun and droppedGun:IsA("BasePart") then
        hrp.CFrame = droppedGun.CFrame + Vector3.new(0, 2, 0)
        return
    end
    
    -- Если пистолета на полу нет, ищем живого шерифа
    for _, p in pairs(game.Players:GetPlayers()) do
        if p.Backpack:FindFirstChild("Gun") or (p.Character and p.Character:FindFirstChild("Gun")) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                hrp.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 2, 0)
                break
            end
        end
    end
end)

-- 6. Телепорт в безопасное лобби
TeleportLobbyBtn.MouseButton1Click:Connect(function()
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    local lobbyWorkspace = workspace:FindFirstChild("Lobby")
    if hrp and lobbyWorkspace then
        local spawnPart = lobbyWorkspace:FindFirstChildWhichIsA("BasePart", true)
        if spawnPart then
            hrp.CFrame = spawnPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)
