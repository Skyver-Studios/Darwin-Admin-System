local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")

return function(context)
	print("closing")
	if (#Players:GetPlayers() == 0) then
		return
	end

	if (game:GetService("RunService"):IsStudio()) then
		return
	end

	local RCode = TeleportService:ReserveServer(game.PlaceId)

	TeleportService:TeleportToPrivateServer(game.PlaceId, RCode, Players:GetPlayers())

	Players.PlayerAdded:Connect(function(player)
		TeleportService:TeleportToPrivateServer(game.PlaceId, RCode, {player})
	end)
	game:BindToClose(function()
		print("Hmm, this doesn't seem to fire....")
	end)
	return("Restarting!")
end
