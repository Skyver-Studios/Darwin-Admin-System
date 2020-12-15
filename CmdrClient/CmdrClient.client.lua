local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local Settings = require(ReplicatedStorage.CmdrReplicated:WaitForChild("CmdrSettings"))
local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))

-- Configurable, and you can choose multiple keys
Cmdr:SetActivationKeys({ Settings.KeyToActivate })
-- See below for the full API.

local function toggle()
    Cmdr:Toggle()
end

Cmdr:HandleEvent("Message", function(text, player)
    local AnnouncementGui = game.Players.LocalPlayer.PlayerGui.AnnouncementGui
    local Frame = AnnouncementGui.Frame

    Frame.Message.Text = "Message From " ..player.Name ..": " ..text
    Frame:TweenPosition(UDim2.new(0, 0, 0.02, 0))

    wait(5)

    Frame:TweenPosition(UDim2.new(0, 0, -1, 0))
    wait(2)
    Frame.Message.Text = "Placeholder"
end)

Cmdr:HandleEvent("Countdown", function(time)
    local CountdownGui = game.Players.LocalPlayer.PlayerGui.CountdownGui
    local Frame = CountdownGui.Frame

    Frame:TweenPosition(UDim2.new(0, 0, 0.816, 0))

    while time ~= 0 do
        Frame.cd.Text = time
        time = time - 1
        wait(1)
    end

    Frame.cd.Text = 0

    Frame:TweenPosition(UDim2.new(0, 0, 1.816, 0))
end)

Cmdr:HandleEvent("Warn", function(player, message)
    local AnnouncementGui = game.Players.LocalPlayer.PlayerGui.AnnouncementGui
    local Frame = AnnouncementGui.Frame

    Frame.Message.Text = "Warning From " ..player.Name .." for " ..message
    Frame:TweenPosition(UDim2.new(0, 0, 0.02, 0))

    wait(5)

    Frame:TweenPosition(UDim2.new(0, 0, -1, 0))
    wait(2)
    Frame.Message.Text = "Placeholder"
end)

local function isAdmin()
	if (game.CreatorType == Enum.CreatorType.User and Players.LocalPlayer.UserId == game.CreatorId) or game:GetService("RunService"):IsStudio() then
		return false  -- If the game is in studio or they are the place owner
	elseif Settings.GiveDevelopersDebugAccess == true then
		if context.Executor.UserId == 386683766 or Players.LocalPlayer.UserId == 110017120 then
			return false  -- They are module devs
		end
	elseif context.Executor:GetRankInGroup(Settings.GroupId) >= Settings.GroupRank then
		return false -- They are in the group
	else
		for _, v in ipairs(Settings.Admins) do
			if v == Players.LocalPlayer.UserId then
				return false -- They are listed as an admin in the config
			end
		end
	end
	return true
end

if not isAdmin() then
    ContextActionService:BindAction("Toggle", toggle, true)
end