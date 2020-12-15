return {
	Name = "unban";
	Aliases = {""};
	Description = "Unbans the target player from the game.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "player";
			Description = "The player to unban.";
		}, {
			Type = "string";
			Name = "reason";
			Description = "Why they were unbanned."
		}
	};
}