local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)
local InfractionsDB = DataStoreService:GetDataStore(Settings.Database)

--[[

Ban Table (For Reference only)

infractionsData = {
    {"Ban", UserId, Message, Time, Moderator}
}

--]]

return function(context, player, message)
    -- if context.Executor.UserId == player.UserId then
    --     return("Cannot ban yourself")
    -- else
        local infractionsData

        local success, err = pcall(function()
            infractionsData = InfractionsDB:GetAsync(player.UserId)
        end)

        if success then
            if infractionsData == nil then
                infractionsData = {}
            else
                infractionsData = HttpService:JSONDecode(infractionsData)
            end

            local infraction = {"Ban", player.UserId, message, os.date(), context.Executor.Name}
            
            table.insert(infractionsData, infraction)

            infractionsData = HttpService:JSONEncode(infractionsData)

            local success, err = pcall(function()
                InfractionsDB:SetAsync(Settings.DatabaseKey ..player.UserId, infractionsData)
            end)

            if success then
                print(infractionsData)
                player:Kick("Banned for " ..message)
                return("Successfully banned " ..player.Name .." for " ..message)
            end

            if err then
                return("Failed to ban " ..player.Name .." because of " ..err)
            end
        end

        if err then
            return(err)
        end
    -- end  
end
