return {
	-- Startup time analysis
	{ "dstein64/vim-startuptime" },

	-- Performance profiling
	{
		"stevearc/profile.nvim",
		config = require("user.config.profile").setup,
	},
}
