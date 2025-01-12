game:GetService("Players").PlayerAdded:Connect(function(player)
    player.CharacterAdded:Wait()

    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = screenGui
    textLabel.Text = "Hello, " .. player.Name
    textLabel.Size = UDim2.new(0, 300, 0, 50)
    textLabel.Position = UDim2.new(0.5, -150, 0.5, -25)
    textLabel.TextSize = 24
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.BackgroundTransparency = 1
end)
