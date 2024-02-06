return {
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim", -- Easily comment stuff
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
    
  "moll/vim-bbye",
  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",
  
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
  "folke/which-key.nvim",

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  "lunarvim/darkplus.nvim",
  
  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  
  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  
  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/nvim-lsp-installer", -- simple to use language server installer
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  
  -- Telescope
  "nvim-telescope/telescope.nvim",
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' 
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
      'sindrets/diffview.nvim', 
      dependencies = {
          "nvim-lua/plenary.nvim",
      }, 
  },
  {
      "TimUntersberger/neogit",
      dependencies = {
          "nvim-lua/plenary.nvim",
      },
  },
  "vim-scripts/copypath.vim",
  "tpope/vim-fugitive",
  "Mofiqul/vscode.nvim",
  "aserowy/tmux.nvim",
  
  "romgrk/barbar.nvim",
  "dstein64/vim-startuptime",
}
