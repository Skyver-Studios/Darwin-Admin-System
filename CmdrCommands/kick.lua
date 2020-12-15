return {
	Name = "kick";
	Aliases = {"boot"};
	Description = "Kicks a player or set of players.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "players";
			Name = "players";
			Description = "The players to kick.";
		},
		{
			Type = "string";
			Name = "message";
			Description = "The reason of why you're kicking them."
		}
	};
}