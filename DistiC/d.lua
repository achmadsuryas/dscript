local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

local function showMessage(message)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "MessageGui"
	screenGui.Parent = localPlayer.PlayerGui

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = screenGui
	textLabel.Text = message
	textLabel.Size = UDim2.new(0, 200, 0, 50)
	textLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
	textLabel.TextSize = 54
	textLabel.TextColor3 = Color3.fromRGB(233, 229, 234)
	textLabel.BackgroundTransparency = 1
	textLabel.TextStrokeTransparency = 1

	textLabel.Font = Enum.Font.GothamBold

	wait(5)
	textLabel:Destroy()
end

local function mainMenu()
	if localPlayer:WaitForChild("PlayerGui"):FindFirstChild("DistiCXMenu") then
		return
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DistiCXMenu"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

	local mainMenuFrame = Instance.new("Frame")
	mainMenuFrame.Parent = screenGui
	mainMenuFrame.Size = UDim2.new(0, 400, 0, 300)
	mainMenuFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
	mainMenuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	mainMenuFrame.ClipsDescendants = true

	local navbar = Instance.new("Frame")
	navbar.Parent = mainMenuFrame
	navbar.Size = UDim2.new(1, 0, 0, 50)
	navbar.Position = UDim2.new(0, 0, 0, 0)
	navbar.BackgroundColor3 = Color3.fromRGB(102, 0, 204)
	navbar.BorderSizePixel = 0

	local navbarLabel = Instance.new("TextLabel")
	navbarLabel.Parent = navbar
	navbarLabel.Text = "DistiC X - 0.1"
	navbarLabel.Size = UDim2.new(1, -50, 1, 0)
	navbarLabel.Position = UDim2.new(0, 0, 0, 0)
	navbarLabel.TextSize = 24
	navbarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	navbarLabel.BackgroundTransparency = 1
	navbarLabel.Font = Enum.Font.GothamBold

	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Parent = navbar
	minimizeButton.Text = "-"
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -40, 0, 10)
	minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.TextSize = 18

	local showButton = Instance.new("TextButton")
	showButton.Parent = screenGui
	showButton.Text = "DistiC X"
	showButton.Size = UDim2.new(0, 120, 0, 50)
	showButton.Position = UDim2.new(0, 10, 1, -60)
	showButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	showButton.TextColor3 = Color3.fromRGB(250, 250, 250)
	showButton.Font = Enum.Font.GothamBold
	showButton.TextSize = 18
	showButton.Visible = false

	minimizeButton.MouseButton1Click:Connect(function()
		mainMenuFrame.Visible = false
		showButton.Visible = true
	end)

	showButton.MouseButton1Click:Connect(function()
		mainMenuFrame.Visible = true
		showButton.Visible = false
	end)

	local speedLabel = Instance.new("TextLabel")
	speedLabel.Parent = mainMenuFrame
	speedLabel.Text = "Speed Hack"
	speedLabel.Size = UDim2.new(0.4, -10, 0, 30)
	speedLabel.AnchorPoint = Vector2.new(0, 0)
	speedLabel.Position = UDim2.new(0, 10, 0, 60)
	speedLabel.TextSize = 18
	speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Font = Enum.Font.Gotham

	local speedTextBox = Instance.new("TextBox")
	speedTextBox.Parent = mainMenuFrame
	speedTextBox.PlaceholderText = "Ex: 100"
	speedTextBox.Size = UDim2.new(0.4, -10, 0, 30)
	speedTextBox.AnchorPoint = Vector2.new(0, 0)
	speedTextBox.Position = UDim2.new(0.5, 10, 0, 60)
	speedTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	speedTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedTextBox.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
	speedTextBox.Font = Enum.Font.Gotham
	speedTextBox.TextSize = 18
	speedTextBox.ClearTextOnFocus = false
	speedTextBox.Text = ""

	speedTextBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			local speed = tonumber(speedTextBox.Text)
			if speed and localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
				localPlayer.Character.Humanoid.WalkSpeed = speed
			else
				warn("Invalid speed input!")
			end
		end
	end)

	local teleportLabel = Instance.new("TextLabel")
	teleportLabel.Parent = mainMenuFrame
	teleportLabel.Text = "Teleport"
	teleportLabel.Size = UDim2.new(0.4, -10, 0, 30)
	teleportLabel.Position = UDim2.new(0, 10, 0, 100)
	teleportLabel.TextSize = 18
	teleportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	teleportLabel.BackgroundTransparency = 1
	teleportLabel.Font = Enum.Font.Gotham

	local playerDropdown = Instance.new("TextButton")
	playerDropdown.Parent = mainMenuFrame
	playerDropdown.Text = "Select Player"
	playerDropdown.Size = UDim2.new(0.4, -10, 0, 30)
	playerDropdown.Position = UDim2.new(0.5, 10, 0, 100)
	playerDropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	playerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
	playerDropdown.Font = Enum.Font.GothamBold
	playerDropdown.TextSize = 18

	local playerList = Instance.new("ScrollingFrame")
	playerList.Parent = mainMenuFrame
	playerList.Size = UDim2.new(0.4, -10, 0, 100)
	playerList.Position = UDim2.new(0.5, 10, 0, 140)
	playerList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	playerList.ScrollBarThickness = 5
	playerList.Visible = false

	playerDropdown.MouseButton1Click:Connect(function()
		playerList.Visible = not playerList.Visible

		for _, button in ipairs(playerList:GetChildren()) do
			if button:IsA("TextButton") then
				button:Destroy()
			end
		end

		local yOffset = 0
		for _, player in ipairs(players:GetPlayers()) do
			if player ~= localPlayer then
				local playerButton = Instance.new("TextButton")
				playerButton.Parent = playerList
				playerButton.Text = player.Name
				playerButton.Size = UDim2.new(1, 0, 0, 30)
				playerButton.Position = UDim2.new(0, 0, 0, yOffset)
				playerButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				playerButton.Font = Enum.Font.Gotham
				playerButton.TextSize = 18

				playerButton.MouseButton1Click:Connect(function()
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						localPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
					end
				end)

				yOffset = yOffset + 35
			end
		end
	end)

	local dragging = false
	local dragStartPos = nil
	local dragFramePos = nil

	local function onDragStart(input)
		dragging = true
		dragStartPos = input.Position
		dragFramePos = mainMenuFrame.Position
	end

	local function onDragMove(input)
		if dragging then
			local delta = input.Position - dragStartPos
			mainMenuFrame.Position = UDim2.new(dragFramePos.X.Scale, dragFramePos.X.Offset + delta.X, dragFramePos.Y.Scale, dragFramePos.Y.Offset + delta.Y)
		end
	end

	local function onDragEnd()
		dragging = false
	end

	local UserInputService = game:GetService("UserInputService")

	mainMenuFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			onDragStart(input)
		end
	end)

	mainMenuFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			onDragMove(input)
		end
	end)

	mainMenuFrame.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			onDragEnd()
		end
	end)
end

showMessage("DistiC X")
mainMenu()
