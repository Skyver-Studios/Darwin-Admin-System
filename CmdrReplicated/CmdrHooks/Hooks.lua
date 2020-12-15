local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)

local function isAdmin(context)
	if (game.CreatorType == Enum.CreatorType.User and context.Executor.UserId == game.CreatorId) or game:GetService("RunService"):IsStudio() then
		return false  -- If the game is in studio or they are the place owner
	elseif Settings.GiveDevelopersDebugAccess == true then
		if context.Executor.UserId == 386683766 or context.Executor.UserId == 110017120 then
			return false  -- They are module devs
		end
	elseif context.Executor:GetRankInGroup(Settings.GroupId) >= Settings.GroupRank then
		return false -- They are in the group
	else
		for _, v in ipairs(Settings.Admins) do
			if v == context.Executor.UserId then
				return false -- They are listed as an admin in the config
			end
		end
	end
	return true
end

return function(registry)
	registry:RegisterHook("BeforeRun", function(context)
		if isAdmin(context) then
			return "You don't have permission to run this command"
		end
	end)
end
