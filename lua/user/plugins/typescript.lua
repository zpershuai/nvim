return {
	-- TypeScript Tools
	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		keys = {
			{ "<leader>co", "<cmd>TSToolsOrganizeImports<cr>", mode = "n", silent = true, desc = "Organize Imports" },
			{ "<leader>cF", "<cmd>TSToolsFixAll<cr>", mode = "n", silent = true, desc = "Fix All" },
			{ "<leader>cR", "<cmd>TSToolsRenameFile<cr>", mode = "n", silent = true, desc = "Rename File" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = require("user.config.typescript").setup,
	},
}
