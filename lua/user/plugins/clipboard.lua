return {
	-- OSC52 clipboard support for SSH/tmux environments
	{
		"ojroques/nvim-osc52",
		event = "VeryLazy",
		keys = {
			{ "<leader>Y", desc = "Yank to system clipboard", mode = { "n", "v" } },
			{ "<leader>yY", desc = "Yank line to system clipboard", mode = "n" },
		},
		config = function()
			require("osc52").setup({
				max_length = 0, -- Maximum length of selection (0 for no limit)
				silent = false, -- Disable message on successful copy
				trim = true, -- Trim surrounding whitespaces before copy
			})
		end,
	},
}
