-- Enable vim.loader for faster startup (replaces impatient.nvim)
vim.loader.enable()

require("user.options")
require("user.keymaps")
require("user.lazy")

require("user.colorscheme")
require("user.cmp")
require("user.lsp")
require("user.nvim-web-devicons")
require("user.telescope")
require("user.treesitter")
require("user.autopairs")
require("user.comment")
require("user.gitsigns")
require("user.nvim-tree")
--[[ require "user.bufferline" ]]
require("user.lualine")
require("user.toggleterm")
--[[ require "user.project" ]]
-- require("user.impatient") -- Removed: using vim.loader instead
require("user.indentline")
require("user.alpha")
require("user.whichkey")
require("user.autocommands")
require("user.aerial")
require("user.spectre")
--[[ require "user.tagbar" ]]
require("user.neogit")
require("user.nvim-root")
require("user.tmux")
require("user.diffview")
--require "user.trouble"
--require "user.airline"
require("user.barbar")
require("user.dired")

require("user.formatter")

-- modern formatter integration (Prettier/Prettierd/eslint_d)
require("user.conform")

require("user.leetcode")
