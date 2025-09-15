local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	--[[ popup_mappings = { ]]
	--[[ 	scroll_down = "<c-d>", -- binding to scroll down inside the popup ]]
	--[[ 	scroll_up = "<c-u>", -- binding to scroll up inside the popup ]]
	--[[ }, ]]
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = true,
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		-- border = "none",
		padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			-- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	--[[ ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label ]]
	--[[ hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate ]]
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	triggers = {
		{ "<auto>", mode = "nxso" },
	},
	-- triggers = {"<leader>"} -- or specify a list manually
	--[[ triggers_blacklist = { ]]
	--[[ 	-- list of mode / prefixes that should never be hooked by WhichKey ]]
	--[[ 	-- this is mostly relevant for key maps that start with a native binding ]]
	--[[ 	-- most people should not need to change this ]]
	--[[ 	i = { "j", "k" }, ]]
	--[[ 	v = { "j", "k" }, ]]
	--[[ }, ]]
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	{ "<leader>B", group = "Bookmarks", nowait = true, remap = false },
	{
		"<leader>BA",
		"<cmd>Telescope vim_bookmarks all<cr>",
		desc = "Show All Bookmarks",
		nowait = true,
		remap = false,
	},
	{ "<leader>BD", "<cmd>BookmarkClearAll <cr>", desc = "Delete All Bookmarks", nowait = true, remap = false },
	{ "<leader>Ba", "<cmd>BookmarkToggle<cr>", desc = "Bookmarks Add", nowait = true, remap = false },
	{
		"<leader>Bc",
		"<cmd>Telescope vim_bookmarks current_file<cr>",
		desc = "Show current file Bookmarks",
		nowait = true,
		remap = false,
	},
	{ "<leader>Bd", "<cmd>BookmarkClear<cr>", desc = "Bookmarks Delete", nowait = true, remap = false },

	{ "<leader>C", group = "Configuration", nowait = true, remap = false },
	{ "<leader>CR", "<cmd>:source %<cr>", desc = "Reconfig", nowait = true, remap = false },

	{ "<leader>P", group = "LazyPlugin", nowait = true, remap = false },
	{ "<leader>Pc", "<cmd>Lazy check<cr>", desc = "check", nowait = true, remap = false },
	{ "<leader>Pi", "<cmd>Lazy install<cr>", desc = "Install", nowait = true, remap = false },
	{ "<leader>Ps", "<cmd>Lazy sync<cr>", desc = "Sync", nowait = true, remap = false },
	{ "<leader>Pu", "<cmd>Lazy update<cr>", desc = "Update", nowait = true, remap = false },

	{ "<leader>b", group = "Buffers", nowait = true, remap = false },
	{ "<leader>b<", "<cmd>BufferMovePrev<cr>", desc = "Buffer MovePrevious", nowait = true, remap = false },
	{ "<leader>b>", "<cmd>BufferMoveNext<cr>", desc = "Buffer MoveNext", nowait = true, remap = false },
	{ "<leader>bP", "<cmd>BufferPin<cr>", desc = "Pin", nowait = true, remap = false },
	{ "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Buffers List", nowait = true, remap = false },
	{ "<leader>bh", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
	{ "<leader>bi", "<cmd>AerialToggle<cr>", desc = "Function List", nowait = true, remap = false },
	{ "<leader>bp", "<cmd>BufferPick<cr>", desc = "Pick", nowait = true, remap = false },

	{ "<leader>c", group = "Code", nowait = true, remap = false },
	{ "<leader>cf", "<cmd>FormatWrite<cr>", desc = "Format", nowait = true, remap = false },
	{ "<leader>co", desc = "Organize Imports", nowait = true, remap = false },
	{ "<leader>cF", desc = "Fix All", nowait = true, remap = false },
	{ "<leader>cR", desc = "Rename File", nowait = true, remap = false },

	{ "<leader>d", group = "Directory", nowait = true, remap = false },
	{ "<leader>dD", "<cmd>Telescope file_browser<cr>", desc = "Enter current Project", nowait = true, remap = false },
	{
		"<leader>dd",
		"<cmd>Telescope file_browser path=%:p:h<cr>",
		desc = "Enter current Dir",
		nowait = true,
		remap = false,
	},

	{ "<leader>e", group = "Explorer", nowait = true, remap = false },
	{ "<leader>eo", desc = "Oil Explorer", nowait = true, remap = false },

	{ "<leader>f", group = "Files" }, -- group
	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
	{ "<leader>fj", desc = "Flash Jump", nowait = true, remap = false },
	{ "<leader>fJ", desc = "Flash Treesitter", nowait = true, remap = false },
	{ "<leader>fs", "<cmd>w!<CR>", desc = "Save" },
	{ "<leader>ft", "<cmd>NvimTreeToggle<CR>", desc = "Explorer" },
	{ "<leader>fT", "<cmd>NvimTreeFocus<CR>", desc = "Explorer" },
	{ "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Open Recent File" },
	{ "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help_tags" },
	{ "<leader>fn", "<cmd>enew<CR>", desc = "New File" },
	{ "<leader>fc", "<cmd>e ~/.config/nvim/init.lua<CR>", desc = "Configuration" },
	{ "<leader>fy", "<cmd>file<CR>", desc = "File Path" },

	{ "<leader>g", group = "Git", nowait = true, remap = false },
	{ "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Diff Project", nowait = true, remap = false },
	{
		"<leader>gR",
		"<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
		desc = "Reset Buffer",
		nowait = true,
		remap = false,
	},
	{ "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
	{ "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
	{ "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
	{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Neogit", nowait = true, remap = false },
	{ "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
	{ "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
	{ "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
	{ "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
	{
		"<leader>gp",
		"<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
		desc = "Preview Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gr",
		"<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
		desc = "Reset Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gs",
		"<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
		desc = "Stage Hunk",
		nowait = true,
		remap = false,
	},
	{
		"<leader>gu",
		"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
		desc = "Undo Stage Hunk",
		nowait = true,
		remap = false,
	},

	{ "<leader>p", group = "Projects", nowait = true, remap = false },
	{
		"<leader>pA",
		"<cmd>lua project_add_cwd(vim.loop.cwd())<cr>",
		desc = "add current pwd",
		nowait = true,
		remap = false,
	},
	{ "<leader>pa", "<cmd>lua project_add_cwd()<cr>", desc = "add project", nowait = true, remap = false },
	{ "<leader>pp", "<cmd>Telescope project<cr>", desc = "Find project", nowait = true, remap = false },
	{ "<leader>pP", desc = "Telescope Projects", nowait = true, remap = false },

	{ "<leader>q", group = "Quit", nowait = true, remap = false },
	{ "<leader>qs", desc = "Restore Session", nowait = true, remap = false },
	{ "<leader>ql", desc = "Restore Last Session", nowait = true, remap = false },
	{ "<leader>qd", desc = "Don't Save Current Session", nowait = true, remap = false },
	{ "<leader>qQ", "<cmd>qall!<CR>", desc = "quit all buffer", nowait = true, remap = false },
	{ "<leader>qq", "<cmd>BufferClose<CR>", desc = "quit current buffer", nowait = true, remap = false },

	{ "<leader>s", group = "Search & Surround", nowait = true, remap = false },
	{ "<leader>sa", desc = "Add surround (ys)", nowait = true, remap = false },
	{ "<leader>sd", desc = "Delete surround (ds)", nowait = true, remap = false },
	{ "<leader>sr", desc = "Replace surround (cs)", nowait = true, remap = false },
	{ "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands", nowait = true, remap = false },
	{ "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
	{ "<leader>sR", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
	{
		"<leader>sS",
		"<cmd>Telescope grep_string<CR>",
		desc = "Search in current buffer",
		nowait = true,
		remap = false,
	},
	{ "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
	{ "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
	{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
	{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps", nowait = true, remap = false },
	{ "<leader>sp", "<cmd>Telescope live_grep<CR>", desc = "Search in current project", nowait = true, remap = false },
	{ "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
	{
		"<leader>ss",
		"<cmd>Telescope current_buffer_fuzzy_find<CR>",
		desc = "Search in current buffer",
		nowait = true,
		remap = false,
	},

	{ "<leader>t", group = "Terminal & TODO", nowait = true, remap = false },
	{ "<leader>tT", desc = "Todo Telescope", nowait = true, remap = false },
	{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
	{
		"<leader>th",
		"<cmd>ToggleTerm size=10 direction=horizontal<cr>",
		desc = "Horizontal",
		nowait = true,
		remap = false,
	},
	{ "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>", desc = "Node", nowait = true, remap = false },
	{ "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
	{ "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", nowait = true, remap = false },
	{ "<leader>tu", "<cmd>lua _NCDU_TOGGLE()<cr>", desc = "NCDU", nowait = true, remap = false },
	{
		"<leader>tv",
		"<cmd>ToggleTerm size=80 direction=vertical<cr>",
		desc = "Vertical",
		nowait = true,
		remap = false,
	},

	{ "<leader>w", group = "Windows", nowait = true, remap = false },
	{ "<leader>w<", "<cmd>BufferCloseBuffersLeft<CR>", desc = "close left windows", nowait = true, remap = false },
	{ "<leader>w>", "<cmd>BufferCloseBuffersRight<CR>", desc = "close right windows", nowait = true, remap = false },
	{ "<leader>wc", "<cmd>BufferClose<CR>", desc = "close current window", nowait = true, remap = false },
	{ "<leader>wh", "<cmd>split<CR>", desc = "split window to bottom", nowait = true, remap = false },
	{
		"<leader>wp",
		"<cmd>BufferCloseAllButPinned<CR>",
		desc = "close all but pinned window",
		nowait = true,
		remap = false,
	},
	{ "<leader>wv", "<cmd>vsplit<CR>", desc = "split window to right", nowait = true, remap = false },

	{ "<leader>y", group = "highlight", nowait = true, remap = false },
	{
		"<leader>yA",
		"<cmd>lua vim.diagnostic.setloclist()<CR>",
		desc = "Show All error",
		nowait = true,
		remap = false,
	},
	{ "<leader>ya", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find references", nowait = true, remap = false },
	{ "<leader>ye", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show error", nowait = true, remap = false },
	{ "<leader>yi", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show info", nowait = true, remap = false },
	{
		"<leader>yn",
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		desc = "Show next error",
		nowait = true,
		remap = false,
	},
	{
		"<leader>yp",
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		desc = "Show prev error",
		nowait = true,
		remap = false,
	},
	{ "<leader>yx", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Goto definition", nowait = true, remap = false },
	{ "<leader>yh", desc = "Highlight word (toggle)", nowait = true, remap = false },
	{ "<leader>yH", desc = "Clear word highlights", nowait = true, remap = false },
	{ "<leader>yc", desc = "Clear current file highlights", nowait = true, remap = false },

	{ "<leader>u", group = "UI", nowait = true, remap = false },
	{ "<leader>un", desc = "Notification History", nowait = true, remap = false },
	{ "<leader>ud", desc = "Dismiss Notifications", nowait = true, remap = false },
	{ "<leader>uc", desc = "Toggle Colorizer", nowait = true, remap = false },

	{ "<leader>x", group = "Diagnostics", nowait = true, remap = false },
	{ "<leader>xx", desc = "Trouble Toggle", nowait = true, remap = false },
	{ "<leader>xw", desc = "Workspace Diagnostics", nowait = true, remap = false },
	{ "<leader>xd", desc = "Document Diagnostics", nowait = true, remap = false },
	{ "<leader>xr", desc = "LSP References", nowait = true, remap = false },

	{ "<leader>1", "<cmd>BufferGoto 1<cr>", desc = "Window 1", nowait = true, remap = false },
	{ "<leader>2", "<cmd>BufferGoto 2<cr>", desc = "Window 2", nowait = true, remap = false },
	{ "<leader>3", "<cmd>BufferGoto 3<cr>", desc = "Window 3", nowait = true, remap = false },
	{ "<leader>4", "<cmd>BufferGoto 4<cr>", desc = "Window 4", nowait = true, remap = false },
	{ "<leader>5", "<cmd>BufferGoto 5<cr>", desc = "Window 5", nowait = true, remap = false },
	{ "<leader>6", "<cmd>BufferGoto 6<cr>", desc = "Window 6", nowait = true, remap = false },
	{ "<leader>7", "<cmd>BufferGoto 7<cr>", desc = "Window 7", nowait = true, remap = false },
	{ "<leader>8", "<cmd>BufferGoto 8<cr>", desc = "Window 8", nowait = true, remap = false },
	{ "<leader>9", "<cmd>BufferGoto 9<cr>", desc = "Window 9", nowait = true, remap = false },
}

local windows = {
	{ "<c-x>", group = "window" },
	{ "<c-x>+", desc = "Increase height" },
	{ "<c-x>-", desc = "Decrease height" },
	{ "<c-x>1", "<cmd>only<cr>", desc = "Close other windows" },
	{ "<c-x>2", "<cmd>split<cr>", desc = "Split window" },
	{ "<c-x>3", "<cmd>vsplit<cr>", desc = "Split window vertically" },
	{ "<c-x><", desc = "Decrease width" },
	{ "<c-x>=", desc = "Equally high and wide" },
	{ "<c-x>>", desc = "Increase width" },
	{ "<c-x>T", desc = "Break out into a new tab" },
	{ "<c-x>h", desc = "Go to the left window" },
	{ "<c-x>j", desc = "Go to the down window" },
	{ "<c-x>k", desc = "Go to the up window" },
	{ "<c-x>l", desc = "Go to the right window" },
	{ "<c-x>q", desc = "Quit a window" },
	{ "<c-x>w", desc = "Switch windows" },
	{ "<c-x>x", desc = "Swap current with next" },
	{ "<c-x>|", desc = "Max out the width" },
}

which_key.setup(setup)
which_key.add(mappings, opts)
which_key.add(windows, { mode = "n", prefix = "", preset = true })
