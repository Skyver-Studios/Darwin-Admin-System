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

game.Players.PlayerAdded:Connect(function(player)
    local infractionsData
    
    local success, err = pcall(function()
        infractionsData = InfractionsDB:GetAsync(player.UserId)
    end)

    if infractionsData ~= nil then
        infractionsData = HttpService:JSONDecode(infractionsData)
    end

    if success then
        if infractionsData ~= nil then
            for _, v in ipairs(infractionsData) do
                if v[1] == "Ban" then
                    local b = infractionsData[table.find(infractionsData, v) + 1]
                    if b[1] ~= "Unban" then
                        player:Kick("You are banned for " ..v[3] .." on " ..v[4])
                    end
                end
            end 
        end
    end

    if err then
        error(err)
    end
end)