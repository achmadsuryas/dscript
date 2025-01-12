local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- DistiC X
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

-- Fungsi untuk membuat dan menampilkan menu utama
local function mainMenu()
	if localPlayer:WaitForChild("PlayerGui"):FindFirstChild("DistiCXMenu") then
		return -- Jangan buat ulang jika sudah ada
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DistiCXMenu"
	screenGui.ResetOnSpawn = false -- Agar GUI tidak dihapus saat respawn
	screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

	-- Frame utama (Main Menu)
	local mainMenuFrame = Instance.new("Frame")
	mainMenuFrame.Parent = screenGui
	mainMenuFrame.Size = UDim2.new(0, 400, 0, 300)
	mainMenuFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
	mainMenuFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	mainMenuFrame.ClipsDescendants = true

	-- Navbar di dalam kotak
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

	-- Tombol "-" untuk menyembunyikan GUI
	local minimizeButton = Instance.new("TextButton")
	minimizeButton.Parent = navbar
	minimizeButton.Text = "-"
	minimizeButton.Size = UDim2.new(0, 30, 0, 30)
	minimizeButton.Position = UDim2.new(1, -40, 0, 10)
	minimizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	minimizeButton.Font = Enum.Font.GothamBold
	minimizeButton.TextSize = 18

	-- Tombol kecil "DistiC X" untuk menampilkan GUI
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

	-- Fungsi untuk menyembunyikan GUI saat tombol "-" ditekan
	minimizeButton.MouseButton1Click:Connect(function()
		mainMenuFrame.Visible = false
		showButton.Visible = true
	end)

	-- Fungsi untuk menampilkan kembali GUI saat tombol kecil ditekan
	showButton.MouseButton1Click:Connect(function()
		mainMenuFrame.Visible = true
		showButton.Visible = false
	end)

	-- Menambahkan fungsi drag pada navbar
	local isDragging = false
	local dragStart = nil
	local startPos = nil

	navbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = true
			dragStart = input.Position
			startPos = mainMenuFrame.Position
		end
	end)

	navbar.InputChanged:Connect(function(input)
		if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			mainMenuFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)

	navbar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDragging = false
		end
	end)

	-- TextBox untuk Speed Hack
	local speedLabel = Instance.new("TextLabel")
	speedLabel.Parent = mainMenuFrame
	speedLabel.Text = "Speed Hack"
	speedLabel.Size = UDim2.new(0, 100, 0, 30)
	speedLabel.Position = UDim2.new(0, 10, 0, 60)
	speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Font = Enum.Font.GothamBold
	speedLabel.TextSize = 18

	local speedInput = Instance.new("TextBox")
	speedInput.Parent = mainMenuFrame
	speedInput.Size = UDim2.new(0, 100, 0, 30)
	speedInput.Position = UDim2.new(0, 120, 0, 60)
	speedInput.Text = "16" -- Default speed
	speedInput.TextColor3 = Color3.fromRGB(255, 255, 255)
	speedInput.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	speedInput.Font = Enum.Font.GothamBold
	speedInput.TextSize = 18
	speedInput.ClearTextOnFocus = false

	-- Mengubah kecepatan pemain sesuai dengan input
	speedInput.FocusLost:Connect(function()
		local speedValue = tonumber(speedInput.Text)
		if speedValue then
			localPlayer.Character.Humanoid.WalkSpeed = speedValue
		end
	end)
end

showMessage("DistiC X")
mainMenu()

localPlayer.CharacterAdded:Connect(function()
	mainMenu()
end)
