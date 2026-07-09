-- Индикатор работы скрипта (Мини-панель)
local IndicatorGui = Instance.new("ScreenGui")
local IndicatorFrame = Instance.new("Frame")
local IndicatorDot = Instance.new("Frame")
local IndicatorText = Instance.new("TextLabel")

IndicatorGui.Parent = game:GetService("CoreGui")
IndicatorGui.Name = "ScriptIndicator"

IndicatorFrame.Parent = IndicatorGui
IndicatorFrame.BackgroundColor3 = Color3.fromRGB(30, 25, 35)
IndicatorFrame.BorderSizePixel = 1
IndicatorFrame.BorderColor3 = Color3.fromRGB(180, 50, 255)
IndicatorFrame.Position = UDim2.new(0, 10, 0, 10)
IndicatorFrame.Size = UDim2.new(0, 130, 0, 30)

IndicatorDot.Parent = IndicatorFrame
IndicatorDot.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
IndicatorDot.BorderSizePixel = 0
IndicatorDot.Position = UDim2.new(0, 8, 0, 9)
IndicatorDot.Size = UDim2.new(0, 12, 0, 12)

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(1, 0)
Corner.Parent = IndicatorDot

IndicatorText.Parent = IndicatorFrame
IndicatorText.BackgroundTransparency = 1
IndicatorText.Position = UDim2.new(0, 26, 0, 0)
IndicatorText.Size = UDim2.new(1, -26, 1, 0)
IndicatorText.Text = "Hub Active"
IndicatorText.TextColor3 = Color3.fromRGB(255, 255, 255)
IndicatorText.TextSize = 14
IndicatorText.Font = Enum.Font.SourceSansBold
IndicatorText.TextXAlignment = Enum.TextXAlignment.Left

-- Логика переворота и отслеживания предметов
local players = game:GetService("Players")
local player = players.LocalPlayer

-- Функция создания уведомления на экране
local function showNotification(brainrotName)
    local NotificationGui = Instance.new("ScreenGui")
    local NotificationLabel = Instance.new("TextLabel")
    
    NotificationGui.Parent = game:GetService("CoreGui")
    
    NotificationLabel.Parent = NotificationGui
    NotificationLabel.Size = UDim2.new(0, 350, 0, 50)
    NotificationLabel.Position = UDim2.new(0.5, -175, 0.3, 0)
    NotificationLabel.BackgroundColor3 = Color3.fromRGB(20, 15, 25)
    NotificationLabel.BorderSizePixel = 2
    NotificationLabel.BorderColor3 = Color3.fromRGB(180, 50, 255)
    NotificationLabel.Text = "В руках брейн рот: " .. tostring(brainrotName)
    NotificationLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    NotificationLabel.TextSize = 18
    NotificationLabel.Font = Enum.Font.SourceSansBold
    
    task.wait(3)
    game:GetService("TweenService"):Create(NotificationLabel, TweenInfo.new(0.5), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    NotificationGui:Destroy()
end

-- Функция принудительного физического переворота
local function flipCharacter()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        
        -- Удаляем старый гироскоп, если он был
        if hrp:FindFirstChild("FlipGyro") then
            hrp.FlipGyro:Destroy()
        end
        
        -- Создаем физический гироскоп, который держит персонажа вверх ногами
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlipGyro"
        bg.maxTorque = Vector3.new(4e4, 0, 4e4) -- Удерживаем наклон по осям X и Z
        bg.P = 10000
        bg.cframe = hrp.CFrame * CFrame.Angles(0, 0, math.rad(180)) -- Переворачиваем на 180°
        bg.Parent = hrp
        
        -- Возвращаем в нормальное положение через 4 секунды
        task.delay(4, function()
            if bg and bg.Parent then
                bg:Destroy()
            end
        end)
    end
end

-- Функция для подключения проверки инструментов
local function setupCharacter(char)
    char.ChildAdded:Connect(function(child)
        if child:IsA("Tool") then
            flipCharacter()
            task.spawn(function()
                showNotification(child.Name)
            end)
        end
    end)
end

player.CharacterAdded:Connect(setupCharacter)
if player.Character then
    setupCharacter(player.Character)
end
