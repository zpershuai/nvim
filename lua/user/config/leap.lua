local M = {}

M.setup = function()
	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { silent = true })
	vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-from-window)", { silent = true })
end

return M
