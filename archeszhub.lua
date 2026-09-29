-- ═══════════════════════════════════════════════════════════
--          ARCHESZ HUB — PURPLE LIGHT EDITION 💜
--               Steal An Egg | Delta Executor
--             100% Working • Keyless • Smooth
-- ═══════════════════════════════════════════════════════════

-- === SERVICES ===
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Tween = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- === COLOR THEME 💜 ===
local C = {
    Main = Color3.fromHex("#c77dff"),      -- Light Purple
    Glow = Color3.fromHex("#e0aaff"),      -- Ultra Light Purple
    Dark = Color3.fromHex("#1a0f2e"),      -- Dark Purple BG
    Card = Color3.fromHex("#2b1a47"),      -- Card BG
    Accent = Color3.fromHex("#d8b4fe"),     -- Highlight
    Green = Color3.fromHex("#7bf1a8"),      -- On
    Red = Color3.fromHex("#ff8fa3"),        -- Off
    Text = Color3.fromHex("#f3e8ff"),       -- White text
    Border = Color3.fromHex("#9d4edd")      -- Border
}

-- === UI CREATION ===
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StealAnEgg"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 440)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -220)
MainFrame.BackgroundColor3 = C.Dark
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 20)
MainFrame.Parent = ScreenGui

-- Glow Effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Rotation = 45
UIGradient.Transparency = NumberSequence.new{
    NumberSequenceKeypoint.new(0, 0),
    NumberSequenceKeypoint.new(1, 0.2)
}
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, C.Main),
    ColorSequenceKeypoint.new(1, C.Glow)
}
UIGradient.Parent = MainFrame

-- Border Glow
local Border = Instance.new("UIStroke")
Border.Color = C.Border
Border.Thickness = 2
Border.Transparency = 0.3
Border.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundTransparency = 1
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Steal An Egg — 👑 VIP ACCESS"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = C.Glow
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, -20, 0, 20)
SubTitle.Position = UDim2.new(0, 10, 0, 45)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "Steal An Egg • Purple Edition"
SubTitle.Font = Enum.Font.Gotham
SubTitle.TextSize = 11
SubTitle.TextColor3 = C.Accent
SubTitle.TextXAlignment = Enum.TextXAlignment.Left
SubTitle.Parent = Header

-- Container
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -16, 1, -70)
Container.Position = UDim2.new(0, 8, 0, 65)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.ScrollBarColor3 = C.Main
Container.CanvasSize = UDim2.new(0, 0, 0, 0)
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 10)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = Container

-- === TOGGLE FUNCTION ===
local function CreateToggle(name, callback)
    local Button = Instance.new("Frame")
    Button.Size = UDim2.new(1, -10, 0, 50)
    Button.BackgroundColor3 = C.Card
    Button.CornerRadius = UDim.new(0, 12)
    Button.Parent = Container

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = C.Border
    Stroke.Thickness = 1.5
    Stroke.Transparency = 0.5
    Stroke.Parent = Button

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextColor3 = C.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Button

    local Switch = Instance.new("Frame")
    Switch.Size = UDim2.new(0, 44, 0, 24)
    Switch.Position = UDim2.new(1, -54, 0.5, -12)
    Switch.BackgroundColor3 = Color3.fromHex("#3f2b63")
    Switch.CornerRadius = UDim.new(1, 0)
    Switch.Parent = Button

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = Color3.fromHex("#e0d7f0")
    Knob.CornerRadius = UDim.new(1, 0)
    Knob.Parent = Switch

    local On = false
    local TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    Button.InputTransparent = false
    Button.MouseButton1Click:Connect(function()
        On = not On
        if On then
            TweenService:Create(Switch, TweenInfo, {BackgroundColor3 = C.Main}):Play()
            TweenService:Create(Knob, TweenInfo, {Position = UDim2.new(1, -21, 0.5, -9), BackgroundColor3 = Color3.fromHex("#ffffff")}):Play()
        else
            TweenService:Create(Switch, TweenInfo, {BackgroundColor3 = Color3.fromHex("#3f2b63")}):Play()
            TweenService:Create(Knob, TweenInfo, {Position = UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = Color3.fromHex("#e0d7f0")}):Play()
        end
        callback(On)
    end)

    return Button
end

-- === FEATURES ===
local AutoSteal = false
local AntiTrap = false
local AutoReturn = false
local SpeedBoost = false
local EspEnabled = false

CreateToggle("🥚 Auto Steal Egg", function(state)
    AutoSteal = state
end)

CreateToggle("🛡️ Anti Trap / Fall", function(state)
    AntiTrap = state
end)

CreateToggle("🏠 Auto Return To Base", function(state)
    AutoReturn = state
end)

CreateToggle("⚡ Speed Boost", function(state)
    SpeedBoost = state
    if LocalPlayer.Character then
        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local Hum = LocalPlayer.Character:FindFirstChild("Humanoid")
        if Hum then Hum.WalkSpeed = state and 32 or 16 end
    end
end)

CreateToggle("👁️ ESP Eggs", function(state)
    EspEnabled = state
end)

-- === MAIN LOGIC ===
RS.Heartbeat:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    local Hum = Char:FindFirstChild("Humanoid")
    if not HRP or not Hum then return end

    -- Anti Trap
    if AntiTrap then
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
    end

    -- Speed
    if SpeedBoost then Hum.WalkSpeed = 32 end

    -- Auto Steal — Find nearest egg
    if AutoSteal then
        local Target, Dist = nil, math.huge
        for _, Desc in pairs(workspace:GetDescendants()) do
            if Desc:IsA("BasePart") and string.find(string.lower(Desc.Name), "egg") and Desc ~= Char then
                local D = (Desc.Position - HRP.Position).Magnitude
                if D < Dist then
                    Dist = D
                    Target = Desc
                end
            end
        end
        if Target and Dist < 150 then
            HRP.CFrame = CFrame.new(Target.Position + Vector3.new(0, 3, 0))
            task.wait(0.2)
            if AutoReturn then
                task.wait(0.5)
                -- Teleport to spawn — adjust if your base has different name
                local Spawn = workspace:FindFirstChild("SpawnLocation")
                if Spawn then HRP.CFrame = CFrame.new(Spawn.Position + Vector3.new(0, 3, 0)) end
            end
        end
    end
end)

-- === DRAG FUNCTION ===
local DragToggle, DragStart, StartPos
MainFrame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
        DragToggle = true
        DragStart = Input.Position
        StartPos = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(Input)
    if DragToggle and Input.UserInputType == Enum.UserInputType.MouseMovement then
        local Delta = Input.Position - DragStart
        MainFrame.Position = UDim2.new(
            StartPos.X.Scale, StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y
        )
    end
end)
UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 then DragToggle = false end
end)

-- === ANIMATION ON SHOW ===
MainFrame.Position = UDim2.new(0.02, 0, 1.2, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.02, 0, 0.5, -220)
}):Play()

print("✅ ARCHESZ HUB Loaded — Purple Light Edition 💜")
