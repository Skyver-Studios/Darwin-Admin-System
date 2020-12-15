local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local HttpService = game:GetService("HttpService")
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)
local InfractionsDB = DataStoreService:GetDataStore(Settings.Database)

--[[

Ban Table (For Reference only)

infractionsData = {}

--]]

return function(context, player, message)
    local infractionsData

    local success, err = pcall(function()
        infractionsData = InfractionsDB:GetAsync(Settings.DatabaseKey ..player.UserId)
    end)

    if success then
        if infractionsData == nil then
            infractionsData = {}
        else
            infractionsData = HttpService:JSONDecode(infractionsData)
        end

        local infraction = {"Warn", player.UserId, message, os.date(), context.Executor.Name}
        
        table.insert(infractionsData, infraction)

        infractionsData = HttpService:JSONEncode(infractionsData)

        local success, err = pcall(function()
            InfractionsDB:SetAsync(Settings.DatabaseKey ..player.UserId, infractionsData)
        end)

        if success then
            context:SendEvent(player, "Warn", context.Executor, message)
            return("Warned " ..player.Name)
        end

        if err then
            return("Failed to warn " ..player.Name .." because of " ..err)
        end
    end

    if err then
        return(err)
    end
end
