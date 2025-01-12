-- Mendapatkan referensi ke layanan yang dibutuhkan
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
    textLabel.Size = UDim2.new(0, 300, 0, 40)  -- Ukuran lebih kecil
    textLabel.Position = UDim2.new(0.5, -150, 0.1, 0)  -- Di bagian atas layar
    textLabel.TextSize = 18  -- Ukuran teks lebih kecil
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Warna teks merah
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna background hitam
    textLabel.TextStrokeTransparency = 0  -- Stroke teks
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Warna stroke hitam
end

-- Fungsi untuk menampilkan tombol pilih pemain dan teleportasi
local function showPlayerSelectionAndTeleport()
    -- Membuat GUI utama
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TeleportGui"
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat navbar
    local navbar = Instance.new("Frame")
    navbar.Parent = screenGui
    navbar.Size = UDim2.new(1, 0, 0, 50)
    navbar.Position = UDim2.new(0, 0, 0, 0)
    navbar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna navbar hitam
    
    local navbarLabel = Instance.new("TextLabel")
    navbarLabel.Parent = navbar
    navbarLabel.Text = "DistiC X - 0.1"
    navbarLabel.Size = UDim2.new(1, 0, 1, 0)
    navbarLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    navbarLabel.TextSize = 18
    navbarLabel.BackgroundTransparency = 1  -- Transparan

    -- Membuat tombol "Teleport"
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Text = "Teleport"
    button.Size = UDim2.new(0, 150, 0, 40)  -- Ukuran lebih kecil
    button.Position = UDim2.new(0.5, -75, 0.5, 0)  -- Di tengah layar
    button.TextSize = 14  -- Ukuran teks lebih kecil
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna tombol hitam

    -- Fitur Drag untuk menu utama
    local dragging = false
    local dragStart = nil
    local startPos = nil

    -- Fungsi untuk drag pada GUI
    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = navbar.Position
        end
    end

    local function updateDrag(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            navbar.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            screenGui.Position = navbar.Position -- Sesuaikan posisi frame lainnya
        end
    end

    local function endDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end

    -- Menghubungkan drag untuk Navbar
    navbar.InputBegan:Connect(startDrag)
    navbar.InputChanged:Connect(updateDrag)
    navbar.InputEnded:Connect(endDrag)

    -- Aksi ketika tombol "Teleport" diklik
    button.MouseButton1Click:Connect(function()
        print("Teleport button clicked!")
    end)
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
