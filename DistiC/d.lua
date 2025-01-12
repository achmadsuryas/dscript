-- Fungsi untuk memungkinkan drag-and-drop pada GUI
local function enableDrag(guiElement)
    local dragging = false
    local dragStart, startPos

    local function startDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = guiElement.Position
        end
    end

    local function updateDrag(input)
        if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
            local delta = input.Position - dragStart
            guiElement.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end

    local function endDrag(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end

    guiElement.InputBegan:Connect(startDrag)
    guiElement.InputChanged:Connect(updateDrag)
    guiElement.InputEnded:Connect(endDrag)
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
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, 50)  -- Menempatkan tombol di bawah pesan
    button.TextSize = 10
    button.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Warna teks putih
    button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Warna tombol hitam

    -- Membuka menu pemilihan pemain ketika tombol diklik
    button.MouseButton1Click:Connect(function()
        -- Membuat menu pilihan pemain
        local selectionGui = Instance.new("ScreenGui")
        selectionGui.Parent = localPlayer.PlayerGui
        
        local selectionFrame = Instance.new("Frame")
        selectionFrame.Parent = selectionGui
        selectionFrame.Size = UDim2.new(0, 300, 0, 400)
        selectionFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
        selectionFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        selectionFrame.BorderSizePixel = 2
        
        -- Mengaktifkan drag pada frame menu
        enableDrag(selectionFrame)

        -- Tombol "Close"
        local closeButton = Instance.new("TextButton")
        closeButton.Parent = selectionFrame
        closeButton.Text = "-"
        closeButton.Size = UDim2.new(0, 280, 0, 30)
        closeButton.Position = UDim2.new(0, 10, 0, 10)
        closeButton.TextSize = 18
        closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        closeButton.MouseButton1Click:Connect(function()
            selectionGui:Destroy()
        end)

        -- Daftar pemain dengan scroll
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Parent = selectionFrame
        scrollFrame.Size = UDim2.new(1, 0, 1, -50)
        scrollFrame.Position = UDim2.new(0, 0, 0, 50)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #players:GetPlayers() * 45 + 100)
        scrollFrame.BackgroundTransparency = 1

        local yPosition = 10
        for _, player in ipairs(players:GetPlayers()) do
            if player ~= localPlayer then
                local playerButton = Instance.new("TextButton")
                playerButton.Parent = scrollFrame
                playerButton.Text = player.Name
                playerButton.Size = UDim2.new(0, 280, 0, 40)
                playerButton.Position = UDim2.new(0, 10, 0, yPosition)
                playerButton.TextSize = 20
                playerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                playerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)

                yPosition = yPosition + 45

                playerButton.MouseButton1Click:Connect(function()
                    selectionGui:Destroy()
                    print("Pemain yang dipilih: " .. player.Name)
                end)
            end
        end
    end)
end

-- Memanggil fungsi untuk pertama kali
showPlayerSelectionAndTeleport()
