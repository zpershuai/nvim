local M = {}

M.setup = function()
	require("flit").setup({
		keys = { f = "f", F = "F", t = "t", T = "T" },
		labeled_modes = "nvo",
	})
end

return M
