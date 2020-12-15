local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

game:GetService("Players").PlayerAdded:Connect(function(player)
    if (game.VIPServerId ~= "" and game.VIPServerOwnerId == 0) then
        
        local waitTime = 5
        
        for _,player in pairs(Players:GetPlayers()) do
            TeleportService:Teleport(game.PlaceId, player)
            wait(waitTime)
            waitTime = waitTime / 2
        end
    end
end)