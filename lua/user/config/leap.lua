local M = {}

M.setup = function()
	vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { silent = true })
	vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-from-window)", { silent = true })

	local group = vim.api.nvim_create_augroup("LeapStatus", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "LeapEnter",
		group = group,
		callback = function()
			vim.g.leap_active = true
			vim.api.nvim_echo({ { "LEAP MODE", "ModeMsg" } }, false, {})
		end,
	})
	vim.api.nvim_create_autocmd("User", {
		pattern = "LeapLeave",
		group = group,
		callback = function()
			vim.g.leap_active = false
			vim.api.nvim_echo({ { "" } }, false, {})
		end,
	})
end

return M
