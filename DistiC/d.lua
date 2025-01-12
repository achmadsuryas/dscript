-- Mendapatkan referensi ke layanan yang dibutuhkan
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService") -- Layanan untuk input

-- Fungsi untuk menampilkan pesan di layar
local function showMessage(message)
    -- Cek jika GUI sudah ada
    local existingGui = localPlayer.PlayerGui:FindFirstChild("MessageGui")
    if existingGui then
        existingGui:Destroy()  -- Hapus jika sudah ada
    end

    -- Membuat GUI baru
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MessageGui"
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat TextLabel untuk menampilkan pesan
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = screenGui
    textLabel.Text = message  -- Menampilkan pesan yang diberikan
    textLabel.Size = UDim2.new(0, 400, 0, 50)  -- Menentukan ukuran TextLabel
    textLabel.Position = UDim2.new(0.5, -200, 0.5, -25)  -- Menempatkan TextLabel di tengah layar
    textLabel.TextSize = 24  -- Ukuran teks
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Warna teks merah
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna background hitam
    textLabel.TextStrokeTransparency = 0  -- Menambahkan stroke untuk teks yang lebih jelas
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Warna stroke hitam
end

-- Fungsi untuk mendapatkan foto profil pemain dari ID Roblox mereka
local function getPlayerProfileImage(player)
    local success, result = pcall(function()
        return players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
    end)

    if success then
        return result
    else
        return "rbxassetid://1234567890"  -- Gambar default jika gagal mendapatkan foto profil
    end
end

-- Fungsi untuk menampilkan menu teleportasi
local function showTeleportMenu()
    -- Pastikan tidak membuat menu duplikat
    if localPlayer.PlayerGui:FindFirstChild("TeleportGui") then
        return
    end

    -- Membuat GUI utama
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportGui"
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat tombol "Teleport"
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Text = "Teleport"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.8, 0)  -- Posisi default
    button.TextSize = 20
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna tombol hitam
    
    -- Fitur drag pada tombol "Teleport"
    local dragging = false
    local dragStart, startPos

    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    button.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    -- Menampilkan daftar pemain untuk teleportasi
    button.MouseButton1Click:Connect(function()
        local playerList = players:GetPlayers()
        local selectionGui = Instance.new("ScreenGui")
        selectionGui.Parent = localPlayer.PlayerGui
        
        local frame = Instance.new("Frame")
        frame.Parent = selectionGui
        frame.Size = UDim2.new(0, 300, 0, 400)
        frame.Position = UDim2.new(0.5, -150, 0.5, -200)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

        local closeButton = Instance.new("TextButton")
        closeButton.Parent = frame
        closeButton.Text = "X"
        closeButton.Size = UDim2.new(0, 30, 0, 30)
        closeButton.Position = UDim2.new(1, -35, 0, 5)
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

        closeButton.MouseButton1Click:Connect(function()
            selectionGui:Destroy()
        end)

        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Parent = frame
        scrollFrame.Size = UDim2.new(1, -10, 1, -50)
        scrollFrame.Position = UDim2.new(0, 5, 0, 40)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #playerList * 50)

        local y = 0
        for _, player in ipairs(playerList) do
            if player ~= localPlayer then
                local button = Instance.new("TextButton")
                button.Parent = scrollFrame
                button.Text = player.Name
                button.Size = UDim2.new(1, -10, 0, 50)
                button.Position = UDim2.new(0, 5, 0, y)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

                button.MouseButton1Click:Connect(function()
                    local target = player.Character
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        localPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
                    end
                end)

                y = y + 50
            end
        end
    end)
end

-- Menampilkan pesan dan menu teleportasi saat skrip dijalankan
showMessage("DistiC X")
showTeleportMenu()
