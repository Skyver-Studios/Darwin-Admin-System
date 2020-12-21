return function(context, players, tool)
	tool2 = game.ServerStorage.Tools:FindFirstChild(tool)

	if tool2 ~= nil then
		for _, v in pairs(players) do
			local vtool = tool2:Clone()
			vtool.Parent = v.Backpack
		end
		
		return("Gave " ..tool .." to %d Player(s)"):format(#players)
	else
		return("Invalid Tool")
	end
end	