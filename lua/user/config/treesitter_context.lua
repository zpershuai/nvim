local M = {}

M.setup = function()
	require("treesitter-context").setup({
		enable = true,
		max_lines = 3,
		trim_scope = "outer",
		mode = "cursor",
		separator = nil,
	})
end

return M
