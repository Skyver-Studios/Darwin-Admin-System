Settings = {}

Settings.Database = "[INSERT DB HERE]" -- Change this to your DB of choice
Settings.DatabaseKey = "Cmdr_" -- Change this to whatever you want, changing it will loose all database entries
Settings.KeyToActivate = Enum.KeyCode.F2 -- Change the F2 part to what you want your keybind to be
Settings.WebhookEnabled = false -- Whether the webhook is enabled
Settings.Webhook = "" -- Use this for your webhook to log all commands
Settings.GroupId = nil -- Group ID for permissions, defaults as the group that owns the game
Settings.GroupRank = 255 -- Minimum group rank for permissions
Settings.Admins = {} -- Players you want to have admin (Use UserId)
Settings.GiveDevelopersDebugAccess = false -- Change this if you would like the developers to be able to debug Cmdr, default is false


-- Autoconfig
if game.CreatorType == Enum.CreatorType.Group and Settings.GroupId == nil then Settings.GroupId = game.CreatorId else Settings.GroupId = 7; Settings.GroupRank = 255 end

return Settings
