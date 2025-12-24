local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("", "<C-g>", "<C-c>", opts)
keymap("", "<C-a>", "<Home>", opts)
keymap("", "<C-e>", "<End>", opts)
--keymap("n", '<leader>->', ":BufferLineCloseRight", opts)
--keymap("n", "<leader>-<", ":BufferLineCloseLeft", opts)
keymap("n", "<leader><leader>", ":Telescope commands<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- BarBar --
-- Goto buffer in position...
-- keymap('n', '<leader>-1', '<Cmd>BufferGoto 1<CR>', opts)
-- keymap('n', '<leader>-2', '<Cmd>BufferGoto 2<CR>', opts)
-- keymap('n', '<leader>-3', '<Cmd>BufferGoto 3<CR>', opts)
-- keymap('n', '<leader>-4', '<Cmd>BufferGoto 4<CR>', opts)
-- keymap('n', '<leader>-5', '<Cmd>BufferGoto 5<CR>', opts)
-- keymap('n', '<leader>-6', '<Cmd>BufferGoto 6<CR>', opts)
-- keymap('n', '<leader>-7', '<Cmd>BufferGoto 7<CR>', opts)
-- keymap('n', '<leader>-8', '<Cmd>BufferGoto 8<CR>', opts)
-- keymap('n', '<leader>-9', '<Cmd>BufferGoto 9<CR>', opts)
-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- LSP convenience keys
-- <leader>lf -> format
keymap("n", "<leader>lf", "<cmd>Format<cr>", opts)

-- <leader>li -> LSP info
keymap("n", "<leader>li", ":LspInfo<CR>", opts)

-- <leader>lj / <leader>lk -> next/prev diagnostic
keymap("n", "<leader>lj", ":lua vim.diagnostic.goto_next({ float = { border = 'rounded' } })<CR>", opts)
keymap("n", "<leader>lk", ":lua vim.diagnostic.goto_prev({ float = { border = 'rounded' } })<CR>", opts)

-- Telescope keymaps
keymap("n", "<leader>ff", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
keymap("n", "<leader>fr", ":Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fc", ":Telescope commands<CR>", opts)

-- Git keymaps
keymap("n", "<leader>gg", ":Neogit<CR>", opts)
keymap("n", "<leader>gd", ":DiffviewOpen<CR>", opts)
keymap("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>gu", ":Gitsigns undo_stage_hunk<CR>", opts)
keymap("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts)
keymap("n", "<leader>gb", ":Gitsigns blame_line<CR>", opts)

-- File operations
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>E", ":NvimTreeFindFile<CR>", opts)

-- Terminal
keymap("n", "<leader>tt", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>", opts)
keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", opts)
keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>", opts)

-- Window management
keymap("n", "<leader>wv", ":vsplit<CR>", opts)
keymap("n", "<leader>ws", ":split<CR>", opts)
keymap("n", "<leader>ww", ":wincmd w<CR>", opts)
keymap("n", "<leader>wq", ":wincmd q<CR>", opts)

-- Buffer management
keymap("n", "<leader>bd", ":Bdelete<CR>", opts)
keymap("n", "<leader>bn", ":bnext<CR>", opts)
keymap("n", "<leader>bp", ":bprevious<CR>", opts)

