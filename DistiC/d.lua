local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

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
    textLabel.Size = UDim2.new(0, 200, 0, 25)  -- 200x25
    textLabel.Position = UDim2.new(0.5, -100, 0.5, -50)  -- Tengah layar
    textLabel.TextSize = 12  -- Ukuran teks yang proporsional
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Warna teks merah
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna background hitam
    textLabel.BorderSizePixel = 2
    textLabel.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Bingkai putih
    textLabel.TextStrokeTransparency = 0  -- Menambahkan stroke untuk teks yang lebih jelas
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Warna stroke hitam
    
    wait(5) -- Durasi pesan ditampilkan
    textLabel:Destroy()
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

-- Fungsi untuk menampilkan tombol pilih pemain dan teleportasi
local function showPlayerSelectionAndTeleport()
    -- Membuat GUI utama
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportGui"
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat tombol "Teleport"
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Text = "Teleport"
    button.Size = UDim2.new(0, 200, 0, 50) -- Ukuran serasi
    button.Position = UDim2.new(0.5, -100, 0.5, 50)  -- Menempatkan tombol di bawah pesan
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna tombol hitam
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Bingkai putih
    
    -- Membuat tombol "X" di sebelah kiri "Teleport"
    local closeButton = Instance.new("TextButton")
    closeButton.Parent = button
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 50, 0, 50)  -- Ukuran serasi dengan tombol "Teleport"
    closeButton.Position = UDim2.new(0, -60, 0, 0)  -- Posisi tombol "X" di kiri tombol "Teleport"
    closeButton.TextSize = 18
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.BorderSizePixel = 2
    closeButton.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Bingkai putih
    
    -- Menambahkan fungsionalitas untuk menyembunyikan GUI ketika tombol "X" ditekan
    local teleportEnabled = true
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()  -- Menghapus GUI utama
        teleportEnabled = true  -- Memungkinkan tombol teleport ditekan lagi
    end)

    -- Fitur Drag untuk tombol "Teleport" di perangkat mobile
    local dragging = false
    local dragStart = nil
    local startPos = nil

    -- Fungsi untuk drag pada GUI
    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = button.Position
        end
    end

    local function updateDrag(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            button.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    local function endDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end

    -- Menghubungkan drag untuk tombol Teleport
    button.InputBegan:Connect(startDrag)
    button.InputChanged:Connect(updateDrag)
    button.InputEnded:Connect(endDrag)
end

-- Fungsi untuk menampilkan menu setiap kali karakter pemain direspawn
local function onCharacterAdded(character)
    -- Tampilkan GUI kembali setelah respawn
    showMessage("DistiC X")
    showPlayerSelectionAndTeleport()
end

-- Menghubungkan fungsi dengan event CharacterAdded
localPlayer.CharacterAdded:Connect(onCharacterAdded)

-- Menampilkan pesan "DistiC X" saat pertama kali dijalankan
showMessage("DistiC X")
-- Menampilkan tombol untuk memilih pemain dan teleportasi
showPlayerSelectionAndTeleport()
