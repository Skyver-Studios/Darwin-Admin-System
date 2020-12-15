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
    local infractionsData

    local success, err = pcall(function()
        infractionsData = InfractionsDB:GetAsync(Settings.DatabaseKey ..player)
    end)

    if err then
        return(err)
    end

    if success then
        if infractionsData ~= nil then
            infractionsData = HttpService:JSONDecode(infractionsData)

            
            for _, v in ipairs(infractionsData) do
                context:Reply(v[1] .." for " ..v[3] .." on " ..v[4] .." by " ..v[5])
            end
            
            return("Returned Infractions")
        else
            return("Player has no recorded infractions.")
        end
    end
end