return function(context)
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        v:Kick("Server Shutdown")
    end
    game:GetService("Players").PlayerAdded:Connect(function(player)
        player:Kick("Server Shutdown")
    end)
    return("Shutting Down")
end