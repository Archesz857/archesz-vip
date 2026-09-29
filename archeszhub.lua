local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Tween = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local C = {
    Main = Color3.fromHex("#c77dff"),
    Glow = Color3.fromHex("#e0aaff"),
    Dark = Color3.fromHex("#1a0f2e"),
    Card = Color3.fromHex("#2b1a47"),
    Border = Color3.fromHex("#9d4edd"),
    Text = Color3.fromHex("#f3e8ff"),
    Green = Color3.fromHex("#7bf1a8"),
    Off = Color3.fromHex("#3f2b63")
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArcheszHub"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local success, _ = pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not success then
    ScreenGui.Parent = LocalPlayer:FindFirstChild("PlayerGui")
end

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 420)
MainFrame.Position = UDim2.new(0.05, 0, 0.5, -210)
MainFrame.BackgroundColor3 = C.Dark
MainFrame.CornerRadius = UDim.new(0, 20)
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 20)

local Border = Instance.new("UIStroke", MainFrame)
Border.Color = C.Border
Border.Thickness = 2
Border.Transparency = 0.3

-- TITLE
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -20, 0, 60)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "💜 ARCHESZ HUB"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextColor3 = C.Glow
Title.TextXAlignment = Enum.TextXAlignment.Left

local Sub = Instance.new("TextLabel", MainFrame)
Sub.Size = UDim2.new(1, -20, 0, 20)
Sub.Position = UDim2.new(0, 10, 0, 45)
Sub.BackgroundTransparency = 1
Sub.Text = "Steal An Egg — Working"
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 11
Sub.TextColor3 = C.Main
Sub.TextXAlignment = Enum.TextXAlignment.Left

-- CONTAINER
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -16, 1, -80)
Container.Position = UDim2.new(0, 8, 0, 70)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 3
Container.ScrollBarColor3 = C.Main
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.CanvasSize = UDim2.new(0, 0, 0, 0)

local Layout = Instance.new("UIListLayout", Container)
Layout.Padding = UDim.new(0, 10)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function MakeToggle(name)
    local Btn = Instance.new("Frame", Container)
    Btn.Size = UDim2.new(1, -10, 0, 50)
    Btn.BackgroundColor3 = C.Card
    Btn.CornerRadius = UDim.new(0, 12)
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 12)
    Instance.new("UIStroke", Btn).Color = C.Border

    local Label = Instance.new("TextLabel", Btn)
    Label.Size = UDim2.new(1, -60, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextColor3 = C.Text
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Switch = Instance.new("Frame", Btn)
    Switch.Size = UDim2.new(0, 44, 0, 24)
    Switch.Position = UDim2.new(1, -54, 0.5, -12)
    Switch.BackgroundColor3 = C.Off
    Switch.CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", Switch)
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 3, 0.5, -9)
    Knob.BackgroundColor3 = Color3.fromHex("#e0d7f0")
    Knob.CornerRadius = UDim.new(1, 0)

    local IsOn = false
    local TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)

    Btn.InputTransparent = false
    Btn.MouseButton1Click:Connect(function()
        IsOn = not IsOn
        TweenService:Create(Switch, TweenInfo, {BackgroundColor3 = IsOn and C.Main or C.Off}):Play()
        TweenService:Create(Knob, TweenInfo, {Position = IsOn and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)}):Play()
    end)

    return function() return IsOn end
end

local AutoSteal = MakeToggle("🥚 Auto Steal Egg")
local AntiTrap = MakeToggle("🛡️ Anti Trap / Fall")
local SpeedBoost = MakeToggle("⚡ Speed Boost")

RS.Heartbeat:Connect(function()
    local Char = LocalPlayer.Character
    if not Char then return end
    local HRP = Char:FindFirstChild("HumanoidRootPart")
    local Hum = Char:FindFirstChild("Humanoid")
    if not HRP or not Hum then return end

    -- Anti Trap
    if AntiTrap() then
        Hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        Hum:SetStateEnabled(Enum.HumanoidStateType.Stunned, false)
    end

    -- Speed
    Hum.WalkSpeed = SpeedBoost() and 32 or 16

    -- Auto Steal
    if AutoSteal() then
        local Target, NearestDist = nil, 150
        for _, Desc in pairs(workspace:GetDescendants()) do
            if Desc:IsA("BasePart") and string.find(string.lower(Desc.Name), "egg") and Desc ~= Char then
                local Dist = (Desc.Position - HRP.Position).Magnitude
                if Dist < NearestDist then
                    NearestDist = Dist
                    Target = Desc
                end
            end
        end
        if Target then
            HRP.CFrame = CFrame.new(Target.Position + Vector3.new(0, 2, 0))
        end
    end
end)

local Drag, StartPos, Offset
MainFrame.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        Drag = true
        StartPos = Input.Position
        Offset = MainFrame.Position
    end
end)
UIS.InputChanged:Connect(function(Input)
    if Drag then
        MainFrame.Position = UDim2.new(
            0, Offset.X.Offset + (Input.Position - StartPos).X,
            0, Offset.Y.Offset + (Input.Position - StartPos).Y
        )
    end
end)
UIS.InputEnded:Connect(function() Drag = false end)

MainFrame.Position = UDim2.new(0.05, 0, 1.2, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {
    Position = UDim2.new(0.05, 0, 0.5, -210)
}):Play()

print("✅ ARCHESZ HUB LOADED — Working!")
