-- AI-powered completion plugins
return {
	{
		"supermaven-inc/supermaven-nvim",
		event = "InsertEnter",
		config = function()
			require("supermaven-nvim").setup({
				color = {
					suggestion_color = "#ffffff",
				},
				disable_inline_completion = false,
				disable_keymaps = false,
			})
			-- Use free tier instead of Pro
			vim.cmd("SupermavenUseFree")
		end,
	},
}
