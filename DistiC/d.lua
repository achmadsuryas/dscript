-- Skrip ini akan menampilkan pesan di layar saat pertama kali dijalankan

-- Mendapatkan referensi ke layanan yang dibutuhkan
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

-- Fungsi untuk menampilkan pesan di layar
local function showMessage(message)
    -- Membuat GUI baru
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat TextLabel untuk menampilkan pesan
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = screenGui
    textLabel.Text = message  -- Menampilkan pesan yang diberikan
    textLabel.Size = UDim2.new(0, 400, 0, 50)  -- Menentukan ukuran TextLabel
    textLabel.Position = UDim2.new(0.5, -200, 0.5, -25)  -- Menempatkan TextLabel di tengah layar
    textLabel.TextSize = 24  -- Ukuran teks
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    textLabel.BackgroundTransparency = 1  -- Menyembunyikan background TextLabel
    
    -- Menambahkan efek untuk durasi pesan muncul (misalnya, 3 detik)
    wait(3)  -- Menunggu selama 3 detik
    screenGui:Destroy()  -- Menghapus GUI setelah pesan muncul
end

-- Menampilkan pesan "Hello, [username]" saat pertama kali dijalankan
showMessage("Hello, " .. localPlayer.Name)
