return {
	Name = "removeinfractions";
	Aliases = {""};
	Description = "Remove all infractions of the target player.";
	Group = "DefaultAdmin";
	Args = {
		{
			Type = "string";
			Name = "player";
			Description = "The player you wish to remove all the infractions for.";
		}
	};
}