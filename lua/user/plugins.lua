local plugins = {}

-- Core plugins
local core_plugins = {
	  "folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
	"nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
	"windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
	"numToStr/Comment.nvim", -- Easily comment stuff
	"nvim-tree/nvim-web-devicons", -- Updated from kyazdani42
	"nvim-tree/nvim-tree.lua", -- Updated from kyazdani42

	"moll/vim-bbye",
	"nvim-lualine/lualine.nvim",
	"akinsho/toggleterm.nvim",

	-- Removed impatient.nvim - using vim.loader instead
	"lukas-reineke/indent-blankline.nvim",
	"goolord/alpha-nvim",
	"antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
	"folke/which-key.nvim",

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	"lunarvim/darkplus.nvim",

	-- cmp plugins
	-- Install nvim-cmp, and buffer source as a dependency
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
	},

	-- snippets
	"L3MON4D3/LuaSnip", --snippet engine
	"rafamadriz/friendly-snippets", -- a bunch of snippets to use

	-- LSP
	"neovim/nvim-lspconfig", -- enable LSP
	--[[ "williamboman/nvim-lsp-installer", -- simple to use language server installer ]]
	"williamboman/mason.nvim",
	-- bridge mason and lspconfig to ensure servers get installed
	"williamboman/mason-lspconfig.nvim",
	"tamago324/nlsp-settings.nvim", -- language server settings defined in json for
	"jose-elias-alvarez/null-ls.nvim", -- for formatters and linters

	-- Telescope
	"nvim-telescope/telescope.nvim",
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	"nvim-telescope/telescope-project.nvim",
	"nvim-telescope/telescope-live-grep-args.nvim",
	"nvim-telescope/telescope-file-browser.nvim",
	"MattesGroeger/vim-bookmarks",
	"tom-anders/telescope-vim-bookmarks.nvim",
	"kelly-lin/telescope-ag",
	"notjedi/nvim-rooter.lua",
	-- end Telescope

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	"JoosepAlviste/nvim-ts-context-commentstring",

	-- Git
	"lewis6991/gitsigns.nvim",

	"stevearc/aerial.nvim",
	"vijaymarupudi/nvim-fzf",
	"editorconfig/editorconfig-vim",
	"iamcco/markdown-preview.nvim",
	"ThePrimeagen/git-worktree.nvim",
	"nvim-pack/nvim-spectre",
	"pelodelfuego/vim-swoop",
	"UtkarshVerma/molokai.nvim",
	"jackm245/nordark.nvim",
	{
		"sindrets/diffview.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"vim-scripts/copypath.vim",
	"tpope/vim-fugitive",
	"Mofiqul/vscode.nvim",
	"aserowy/tmux.nvim",

	"romgrk/barbar.nvim",
	{
		"X3eRo0/dired.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
	},

	-- Modern formatter with Prettier/Prettierd and eslint_d integration
	"stevearc/conform.nvim",

	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
		},
		config = true,
	},
	{
		"kawre/leetcode.nvim",
		build = ":TSUpdate html",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- required by telescope
			"MunifTanjim/nui.nvim",

			-- optional
			"nvim-treesitter/nvim-treesitter",
			"rcarriga/nvim-notify",
			"nvim-tree/nvim-web-devicons",
		},
	},

	-- Word highlighting
	{
		"lfv89/vim-interestingwords",
		event = "VeryLazy",
		config = function()
			-- Set up highlight colors
			vim.cmd("highlight InterestingWord1 guibg=#3c3c3c gui=none")
			vim.cmd("highlight InterestingWord2 guibg=#5c5c5c gui=none")
			vim.cmd("highlight InterestingWord3 guibg=#7c7c7c gui=none")
			vim.cmd("highlight InterestingWord4 guibg=#9c9c9c gui=none")
			vim.cmd("highlight InterestingWord5 guibg=#bcbcbc gui=none")
			vim.cmd("highlight InterestingWord6 guibg=#dcdcdc gui=none")
			
			-- Ensure colors persist after colorscheme changes
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.cmd("highlight InterestingWord1 guibg=#3c3c3c gui=none")
					vim.cmd("highlight InterestingWord2 guibg=#5c5c5c gui=none")
					vim.cmd("highlight InterestingWord3 guibg=#7c7c7c gui=none")
					vim.cmd("highlight InterestingWord4 guibg=#9c9c9c gui=none")
					vim.cmd("highlight InterestingWord5 guibg=#bcbcbc gui=none")
					vim.cmd("highlight InterestingWord6 guibg=#dcdcdc gui=none")
				end,
			})
		end,
	},
}

-- Merge all plugin modules
local function merge_plugins(...)
	local result = {}
	for _, plugin_list in ipairs({...}) do
		for _, plugin in ipairs(plugin_list) do
			table.insert(result, plugin)
		end
	end
	return result
end

-- Load modular plugin configurations
local diagnostics_plugins = require("user.plugins.diagnostics")
local ui_plugins = require("user.plugins.ui")
local typescript_plugins = require("user.plugins.typescript")
local editor_plugins = require("user.plugins.editor")
local files_plugins = require("user.plugins.files")
local session_plugins = require("user.plugins.session")
local clipboard_plugins = require("user.plugins.clipboard")
local fold_plugins = require("user.plugins.fold")
local completion_plugins = require("user.plugins.completion")
local performance_plugins = require("user.plugins.performance")
local snippets_plugins = require("user.plugins.snippets")
local treesitter_plugins = require("user.plugins.treesitter")

-- Combine all plugins
return merge_plugins(
	core_plugins,
	diagnostics_plugins,
	ui_plugins,
	typescript_plugins,
	editor_plugins,
	files_plugins,
	session_plugins,
	clipboard_plugins,
	fold_plugins,
	completion_plugins,
	performance_plugins,
	snippets_plugins,
	treesitter_plugins
)
