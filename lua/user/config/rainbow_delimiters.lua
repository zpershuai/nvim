local M = {}

M.setup = function()
	vim.g.rainbow_delimiters = {
		highlight = {
			"RainbowDelimiterRed",
			"RainbowDelimiterYellow",
			"RainbowDelimiterBlue",
			"RainbowDelimiterOrange",
			"RainbowDelimiterGreen",
			"RainbowDelimiterViolet",
			"RainbowDelimiterCyan",
		},
	}

	local rainbow = require("rainbow-delimiters")
	vim.g.rainbow_delimiters = vim.tbl_deep_extend("force", vim.g.rainbow_delimiters or {}, {
		strategy = {
			[""] = function(bufnr)
				local has_parser, _ = pcall(vim.treesitter.get_parser, bufnr)
				if has_parser then
					return rainbow.strategy["global"]
				end
				return nil
			end,
		},
	})
end

return M
