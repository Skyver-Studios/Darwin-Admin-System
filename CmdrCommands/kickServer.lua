local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)
local InfractionsDB = DataStoreService:GetDataStore(Settings.Database)

return function (context, players, message)
	for _, player in pairs(players) do
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

			local infraction = {"Kick", player.UserId, message, os.date(), context.Executor.Name}
			
			table.insert(infractionsData, infraction)

			infractionsData = HttpService:JSONEncode(infractionsData)

			local success, err = pcall(function()
				InfractionsDB:SetAsync(Settings.DatabaseKey ..player.UserId, infractionsData)
			end)

			if success then
				player:Kick("Kicked by admin for " ..message)
			end

			if err then
				return(err)
			end
		end
	end

	return ("Kicked %d players."):format(#players)
end