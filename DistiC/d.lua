-- Mendapatkan referensi ke layanan yang dibutuhkan
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local HttpService = game:GetService("HttpService")

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
    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Warna teks merah
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna background hitam
    textLabel.TextStrokeTransparency = 0  -- Menambahkan stroke untuk teks yang lebih jelas
    textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Warna stroke hitam
    
    -- Menambahkan efek untuk durasi pesan muncul (misalnya, 3 detik)
    wait(5)  -- Menunggu selama 3 detik
    textLabel:Destroy()  -- Menghapus TextLabel setelah pesan muncul
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
    screenGui.Parent = localPlayer.PlayerGui  -- Memasukkan GUI ke PlayerGui
    
    -- Membuat tombol "Teleport"
    local button = Instance.new("TextButton")
    button.Parent = screenGui
    button.Text = "Teleport"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, 50)  -- Menempatkan tombol di bawah pesan
    button.TextSize = 18
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna tombol hitam
    
    -- Membuat tombol "X" di sebelah kiri "Teleport"
    local closeButton = Instance.new("TextButton")
    closeButton.Parent = button
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 50, 0, 50)  -- Menyelaraskan ukuran tombol X
    closeButton.Position = UDim2.new(0, -50, 0, 0)  -- Posisi tombol "X" di kiri tombol "Teleport"
    closeButton.TextSize = 18
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    
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

    -- Aksi ketika tombol "Teleport" diklik
    button.MouseButton1Click:Connect(function()
        if teleportEnabled then
            teleportEnabled = false  -- Menonaktifkan sementara tombol teleport
            -- Membuka menu pemilihan pemain
            local playerList = players:GetPlayers()
            local playerNames = {}
            
            -- Membuat daftar nama pemain
            for _, player in ipairs(playerList) do
                if player ~= localPlayer then  -- Jangan tampilkan pemain yang menjalankan skrip
                    table.insert(playerNames, player.Name)
                end
            end

            -- Menampilkan pilihan pemain
            local selectionGui = Instance.new("ScreenGui")
            selectionGui.Parent = localPlayer.PlayerGui
            
            local selectionFrame = Instance.new("Frame")
            selectionFrame.Parent = selectionGui
            selectionFrame.Size = UDim2.new(0, 300, 0, 400)  -- Ukuran frame yang lebih besar dan bisa scroll
            selectionFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
            selectionFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            selectionFrame.BorderSizePixel = 2
            
            local scrollFrame = Instance.new("ScrollingFrame")
            scrollFrame.Parent = selectionFrame
            scrollFrame.Size = UDim2.new(1, 0, 1, -50)  -- Ukuran untuk area scroll
            scrollFrame.Position = UDim2.new(0, 0, 0, 50)
            scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #playerNames * 45 + 100)
            scrollFrame.ScrollingEnabled = true
            scrollFrame.BackgroundTransparency = 1
            
            -- Tombol Hide Menu diganti menjadi "-"
            local closeButton = Instance.new("TextButton")
            closeButton.Parent = selectionFrame
            closeButton.Text = "-"  -- Mengubah teks dari "Hide" menjadi "-"
            closeButton.Size = UDim2.new(0, 280, 0, 30)
            closeButton.Position = UDim2.new(0, 10, 0, 10)
            closeButton.TextSize = 18
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            
            closeButton.MouseButton1Click:Connect(function()
                selectionGui:Destroy()
                teleportEnabled = true  -- Menyebabkan tombol teleport dapat ditekan lagi setelah menu ditutup
            end)

            -- Tombol drag untuk menu pilihan pemain
            local function startPlayerSelectionDrag(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = selectionFrame.Position
                end
            end

            local function updatePlayerSelectionDrag(input)
                if dragging and input.UserInputType == Enum.UserInputType.Touch then
                    local delta = input.Position - dragStart
                    selectionFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end

            local function endPlayerSelectionDrag(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end

            -- Menghubungkan drag untuk frame pilihan pemain
            selectionFrame.InputBegan:Connect(startPlayerSelectionDrag)
            selectionFrame.InputChanged:Connect(updatePlayerSelectionDrag)
            selectionFrame.InputEnded:Connect(endPlayerSelectionDrag)

            -- Menambahkan tombol untuk setiap pemain dalam daftar
            local yPosition = 10
            for _, name in ipairs(playerNames) do
                local playerButton = Instance.new("TextButton")
                playerButton.Parent = scrollFrame
                playerButton.Text = name
                playerButton.Size = UDim2.new(0, 280, 0, 40)
                playerButton.Position = UDim2.new(0, 10, 0, yPosition)
                playerButton.TextSize = 20
                playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                playerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                
                -- Menambahkan foto profil pemain
                local profileImage = Instance.new("ImageLabel")
                profileImage.Parent = playerButton
                profileImage.Size = UDim2.new(0, 30, 0, 30)
                profileImage.Position = UDim2.new(0, 10, 0, 5)
                profileImage.Image = getPlayerProfileImage(players:FindFirstChild(name))
                
                playerButton.MouseButton1Click:Connect(function()
                    -- Menghapus GUI pilihan pemain setelah pemilihan
                    selectionGui:Destroy()
                    print("Pemain yang dipilih: " .. name)
                    
                    -- Mencari pemain yang dipilih
                    local targetPlayer = players:FindFirstChild(name)
                    if targetPlayer then
                        -- Teleport pemain yang menjalankan skrip ke pemain yang dipilih
                        local targetCharacter = targetPlayer.Character
                        if targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart") then
                            local targetPosition = targetCharacter.HumanoidRootPart.Position
                            localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))  -- Sedikit mengangkat posisi teleportasi
                            
                            teleportEnabled = true  -- Tombol teleport bisa digunakan lagi setelah teleportasi
                        end
                    end
                end)
                
                yPosition = yPosition + 45  -- Mengatur posisi tombol untuk pemain berikutnya
            end
        end
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
