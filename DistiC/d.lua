print("Hello, World!")
game:GetService("Players").PlayerAdded:Connect(function(player)
    print(player.Name .. " telah bergabung!")
end)