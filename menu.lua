-- Создание простого и надежного GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local FlyBtn = Instance.new("TextButton")
local NoclipBtn = Instance.new("TextButton")
local EspBtn = Instance.new("TextButton")

-- Родитель для GUI (CoreGui гарантирует появление поверх игры)
ScreenGui.Parent = game:GetService("CoreGui")

-- Главное окно меню
Frame.Name = "SimpleMenu"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Frame.Position = UDim2.new(0.1, 0, 0.1, 0) -- Появится в левом верхнем углу экрана
Frame.Size = UDim2.new(0, 180, 0, 200)
Frame.Active = true
Frame.Draggable = true -- Можно перетаскивать пальцем/мышкой

-- Заголовок
Title.Parent = Frame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "Xeno Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

-- Функция для быстрой настройки кнопок
local function setupButton(btn, text, posY)
    btn.Parent = Frame
    btn.Position = UDim2.new(0.05, 0, 0, posY)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSans
end

setupButton(FlyBtn, "Fly: OFF", 45)
setupButton(NoclipBtn, "Noclip: OFF", 95)
setupButton(EspBtn, "ESP: OFF", 145)

-- ==================== ЛОГИКА ФУНКЦИЙ ====================
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")

-- 1. ПОЛЕТ (Fly)
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
            bv.velocity = Vector3.new(0, 0, 0)
            
            local uis = game:GetService("UserInputService")
            
            local c1 = uis.InputBegan:Connect(function(input, gpe)
                if gpe then return end
                if input.KeyCode == Enum.KeyCode.W then keys.w = true
                elseif input.KeyCode == Enum.KeyCode.S then keys.s = true
                elseif input.KeyCode == Enum.KeyCode.A then keys.a = true
                elseif input.KeyCode == Enum.KeyCode.D then keys.d = true
                elseif input.KeyCode == Enum.KeyCode.Space then keys.space = true
                elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = true end
            end)
            
            local c2 = uis.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then keys.w = false
                elseif input.KeyCode == Enum.KeyCode.S then keys.s = false
                elseif input.KeyCode == Enum.KeyCode.A then keys.a = false
                elseif input.KeyCode == Enum.KeyCode.D then keys.d = false
                elseif input.KeyCode == Enum.KeyCode.Space then keys.space = false
                elseif input.KeyCode == Enum.KeyCode.LeftShift then keys.lshift = false end
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
            
            bg:Destroy()
            bv:Destroy()
            c1:Disconnect()
            c2:Disconnect()
        end)
    else
        FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        FlyBtn.Text = "Fly: OFF"
    end
end)

-- 2. ПРОХОЖДЕНИЕ СКВОЗЬ СТЕНЫ (Noclip)
local noclip = false
NoclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        NoclipBtn.Text = "Noclip: ON"
    else
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        NoclipBtn.Text = "Noclip: OFF"
    end
end)

runService.Stepped:Connect(function()
    if noclip and player.Character then
        for _, part in pairs(player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 3. ПОДСВЕТКА ИГРОКОВ (ESP)
local espEnabled = false
local highlights = {}

local function addESP(p)
    if p == player then return end
    p.CharacterAdded:Connect(function(char)
        if espEnabled then
            task.wait(0.5)
            local hl = Instance.new("Highlight", char)
            hl.FillColor = Color3.fromRGB(255, 0, 0)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlights[p] = hl
        end
    end)
    if espEnabled and p.Character then
        local hl = Instance.new("Highlight", p.Character)
        hl.FillColor = Color3.fromRGB(255, 0, 0)
        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlights[p] = hl
    end
end

EspBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        EspBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        EspBtn.Text = "ESP: ON"
        for _, p in pairs(game.Players:GetPlayers()) do
            addESP(p)
        end
    else
        EspBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        EspBtn.Text = "ESP: OFF"
        for _, hl in pairs(highlights) do
            if hl then hl:Destroy() end
        end
        highlights = {}
    end
end)

game.Players.PlayerAdded:Connect(addESP)
