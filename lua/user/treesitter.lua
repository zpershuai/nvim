local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = { 
		"cpp", "c", "lua", "make", "cmake", "markdown", "objc", 
		"json", "typescript", "javascript", "html", "css", 
		"scss", "vue", "svelte", "tsx"
	}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	--[[ ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages ]]
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml" } },
	--[[ context_commentstring = { ]]
	--[[     enable = true, ]]
	--[[     enable_autocmd = false, ]]
	--[[ }, ]]
})

require("ts_context_commentstring").setup({
	enable = true,
	enable_autocmd = false,
})

vim.g.skip_ts_context_commentstring_module = true
--[[ vim.opt.foldmethod = "expr" ]]
--[[ vim.opt.foldexpr = "nvim_treesitter#foldexpr()" ]]
