return {
	-- OSC52 clipboard support for SSH/tmux environments
	{
		"ojroques/nvim-osc52",
		event = "VeryLazy",
		keys = {
			{ "<leader>Y", desc = "Yank to system clipboard", mode = { "n", "v" } },
			{ "<leader>yY", desc = "Yank line to system clipboard", mode = "n" },
		},
		config = require("user.config.osc52").setup,
	},
}
