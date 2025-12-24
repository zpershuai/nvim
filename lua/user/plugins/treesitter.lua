return {
	-- Rainbow delimiters
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "VeryLazy",
		config = require("user.config.rainbow_delimiters").setup,
	},

	-- Treesitter context window
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPost",
		config = require("user.config.treesitter_context").setup,
	},
}
