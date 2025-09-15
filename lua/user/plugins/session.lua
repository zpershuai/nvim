return {
	-- Session management
	{
		"folke/persistence.nvim",
		keys = {
			{ "<leader>qs", "<cmd>lua require('persistence').load()<cr>", mode = "n", silent = true, desc = "Restore Session" },
			{ "<leader>ql", "<cmd>lua require('persistence').load({ last = true })<cr>", mode = "n", silent = true, desc = "Restore Last Session" },
			{ "<leader>qd", "<cmd>lua require('persistence').stop()<cr>", mode = "n", silent = true, desc = "Don't Save Current Session" },
		},
		config = function()
			require("persistence").setup({
				dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
				options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" },
				pre_save = nil,
				save_empty = false,
				autosave = true,
				autoload = false,
				autosave_on_exit = true,
				autosave_on_quit = true,
				autosave_on_save = true,
				autosave_on_insert_leave = false,
				autosave_ignore_dirs = {},
				autosave_ignore_filetypes = { "alpha", "dashboard", "neo-tree", "Trouble", "notify", "qf" },
				autosave_ignore_buftypes = { "quickfix", "nofile", "help" },
				autosave_only_in_session = false,
				before_save = nil,
				after_save = nil,
				after_source = nil,
			})
		end,
	},
}
