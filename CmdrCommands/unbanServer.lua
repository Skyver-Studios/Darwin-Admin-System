local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
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

return function(context, player, message)
    player = Players:GetUserIdFromNameAsync(player)
    local infractionsData

    local success, err = pcall(function()
        infractionsData = InfractionsDB:GetAsync(Settings.DatabaseKey ..player)
    end)


    if success then
        if infractionsData == nil then
            return("Player doesn't have any infractions.")
        else
            print(infractionsData)
            infractionsData = HttpService:JSONDecode(infractionsData)
            local infraction = {"Unban", player, message, os.date(), context.Executor.Name}

            table.insert(infractionsData, infraction)

            infractionsData = HttpService:JSONEncode(infractionsData)

            local success, err = pcall(function()
                InfractionsDB:SetAsync(Settings.DatabaseKey ..player, infractionsData)
            end)

            if success then
                return("Unbanned " ..Players:GetNameFromUserIdAsync(player))
            end

            if err then
                return(err)
            end
        end
    end
end