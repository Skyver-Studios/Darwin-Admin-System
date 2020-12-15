local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local Cmdr = require(game.ServerScriptService.Cmdr.Server.Cmdr)
local Settings = require(ReplicatedStorage.CmdrReplicated.CmdrSettings)

Cmdr:RegisterHooksIn(game.ReplicatedStorage.CmdrReplicated.CmdrHooks)

Cmdr:RegisterHook("AfterRun", function(context)
    if Settings.WebhookEnabled == true then
        if context.Group == "DefaultAdmin" or context.Group == "DefaultDebug" then
            local data = {
                ["content"] = context.Executor.Name .." executed the command " ..context.Name .."\nRaw: " ..context.RawText
            }
            data = HttpService:JSONEncode(data)
            HttpService:PostAsync(Settings.Webhook, data)
        end
    end
end)

Cmdr:RegisterDefaultCommands() -- This loads the default set of commands that Cmdr comes with. (Optional)
Cmdr:RegisterCommandsIn(game.ServerScriptService.Cmdr.Commands) -- Register commands from your own folder. (Optional)
