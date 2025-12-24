-- AI-powered completion plugins
return {
	{
		"supermaven-inc/supermaven-nvim",
		event = "VeryLazy",
		config = function()
			require("supermaven-nvim").setup({
				color = {
					suggestion_color = "#ffffff",
				},
				disable_inline_completion = false,
				disable_keymaps = false,
			})
			-- Use free tier instead of Pro
			-- Set up autocmd to run command after UI enters
			vim.api.nvim_create_autocmd("UIEnter", {
				once = true,
				callback = function()
					vim.defer_fn(function()
						pcall(vim.cmd, "SupermavenUseFree")
					end, 500)
				end,
			})
		end,
	},
}
