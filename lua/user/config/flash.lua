local M = {}

function M.setup()
	require("flash").setup({
		modes = {
			char = {
				enabled = false,
			},
			treesitter = {
				enabled = true,
				disable = { "lazy", "fzf", "regex" },
				debounce = 15,
				multi_line = true,
				label = {
					before = true,
					after = true,
					style = "inline",
				},
				highlight = {
					backdrop = false,
					matches = false,
				},
				pattern = [[\b\w+]],
				action = function(match, state)
					state:hide()
					vim.api.nvim_win_set_cursor(0, { match.row, match.col + 1 })
				end,
				label = {
					before = { 0, 0 },
					after = { 0, -1 },
					style = "inline",
				},
				keys = { "f", "F", "t", "T", ";", "," },
			},
		},
	})
end

return M
