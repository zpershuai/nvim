return {
	-- Rainbow delimiters
	{
		"HiPhish/rainbow-delimiters.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
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
