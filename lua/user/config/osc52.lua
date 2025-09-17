local M = {}

function M.setup()
	require("osc52").setup({
		max_length = 0,
		silent = false,
		trim = true,
	})
end

return M
