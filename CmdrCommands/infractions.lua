return {
	Name = "infractions";
	Aliases = {"viewinfractions"};
	Description = "View the infractions of the target player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "player";
			Description = "The player you wish to view infractions for.";
		}
	};
}