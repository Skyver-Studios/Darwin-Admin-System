local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)
local InfractionsDB = DataStoreService:GetDataStore(Settings.Database)

--[[

Ban Table (For Reference only)

infractions = {}
infractions.infractions = {}
infractions.timeOfBan = os.date()
infractions.adminWhoBanned = context.Executor.UserId
infractions.banMessage = message

--]]

return function(context, player)
    local player = game.Players:GetUserIdFromNameAsync(player)

    local success, err = pcall(function()
        InfractionsDB:RemoveAsync(Settings.DatabaseKey ..player)
    end)

    if success then
        return("Removed all infractions from " ..Players:GetNameFromUserIdAsync(player))
    end

    if err then
        return(err)
    end
end