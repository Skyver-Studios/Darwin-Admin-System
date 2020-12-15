return {
	Name = "warn";
	Aliases = {""};
	Description = "Warns the target player";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "player";
			Name = "player";
			Description = "The player you wish to warn.";
		}, {
			Type = "string";
			Name = "message";
			Description = "The warn message.";
		},
	};
}