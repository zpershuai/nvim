require("telescope.themes").get_custom = function(opts)
    opts = vim.tbl_deep_extend("force", { layout_config = { height = 15 } }, opts)
    return require("telescope.themes").get_ivy(opts)
end

local ivy_theme = require('telescope.themes').get_ivy {}
vim.cmd([[autocmd User TelescopePreviewerLoaded setlocal number]])

local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require("telescope.actions")
local previewers = require("telescope.previewers")

telescope.setup({
    defaults = {

        prompt_prefix = " ",
        selection_caret = " ",
        path_display = { "smart" },

        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
        },
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",

        layout_defaults = {
            bottom_pane = {
                height = 15,
                preview_cutoff = 120,
                prompt_position = "top",
            },
            center = {
                height = 0.4,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.5,
            },
            cursor = {
                height = 0.9,
                preview_cutoff = 40,
                width = 0.8,
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 120,
                prompt_position = "bottom",
                width = 0.8,
            },
            vertical = {
                height = 0.9,
                preview_cutoff = 40,
                prompt_position = "bottom",
                width = 0.8,
            },
        },

        file_sorter = previewers.get_fzy_sorter,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,

        prompt_position = "bottom",
        mappings = {
            i = {
                ["<C-j>"] = actions.cycle_history_next,
                ["<C-k>"] = actions.cycle_history_prev,

                ["<C-n>"] = actions.move_selection_next,
                ["<C-p>"] = actions.move_selection_previous,

                --[[ ["<C-c>"] = actions.close, ]]
                ["<C-g>"] = actions.close,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,

                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<C-l>"] = actions.complete_tag,
                ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            },

            n = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_default,
                ["<C-x>"] = actions.select_horizontal,
                ["<C-v>"] = actions.select_vertical,
                ["<C-t>"] = actions.select_tab,

                --[[ ["<C-c>"] = actions.close, ]]
                ["<C-g>"] = actions.close,

                ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
                ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

                ["j"] = actions.move_selection_next,
                ["k"] = actions.move_selection_previous,
                ["H"] = actions.move_to_top,
                ["M"] = actions.move_to_middle,
                ["L"] = actions.move_to_bottom,

                ["<Down>"] = actions.move_selection_next,
                ["<Up>"] = actions.move_selection_previous,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,

                ["<C-u>"] = actions.preview_scrolling_up,
                ["<C-d>"] = actions.preview_scrolling_down,

                ["<PageUp>"] = actions.results_scrolling_up,
                ["<PageDown>"] = actions.results_scrolling_down,

                ["?"] = actions.which_key,
            },
        },
    },
    pickers = {
        current_buffer_fuzzy_find = {
            tiebreak = function (a, b)
                return a.lnum < b.lnum
            end,
            theme = "custom",
            previewer = false,
            path_display = { "absolute" },
        },
        live_grep_args = {
            theme = "ivy",
            previewer = false,
            path_display = { "absolute" },
        },
        grep_string = {
            theme = "ivy",
            path_display = { "absolute" },
        },
        oldfiles = {
            theme = "custom",
            previewer = false,
            path_display = { "absolute" },
        },
        find_files = {
            theme = "custom",
            --[[ previewer = false, ]]
            path_display = { "absolute" },
        },
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
        file_browser = {
            theme = "custom",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
                ["i"] = {
                    -- your custom insert mode mappings
                    ["<C-b>"] = require "telescope".extensions.file_browser.actions.goto_home_dir,
                    ["<C-c>"] = require "telescope".extensions.file_browser.actions.create,
                    ["<C-h>"] = require "telescope".extensions.file_browser.actions.goto_parent_dir,
                    ["<C-l>"] = require "telescope".extensions.file_browser.actions.goto_cwd,
                    ["<C-d>"] = require "telescope".extensions.file_browser.actions.remove,
                    ["<C-r>"] = require "telescope".extensions.file_browser.actions.rename,
                    ["<C-z>"] = require "telescope".extensions.file_browser.actions.toggle_hidden,
                    ["<C-y>"] = require "telescope".extensions.file_browser.actions.copy,
                    ["<C-m>"] = require "telescope".extensions.file_browser.actions.move
                },
                ["n"] = {
                    -- your custom normal mode mappings
                    ["b"] = require "telescope".extensions.file_browser.actions.goto_home_dir,
                    ["c"] = require "telescope".extensions.file_browser.actions.create,
                    ["h"] = require "telescope".extensions.file_browser.actions.goto_parent_dir,
                    ["l"] = require "telescope".extensions.file_browser.actions.goto_cwd,
                    ["d"] = require "telescope".extensions.file_browser.actions.remove,
                    ["r"] = require "telescope".extensions.file_browser.actions.rename,
                    ["z"] = require "telescope".extensions.file_browser.actions.toggle_hidden,
                    ["y"] = require "telescope".extensions.file_browser.actions.copy,
                    ["m"] = require "telescope".extensions.file_browser.actions.move
                },
            },
        },
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        },
        project = {
            theme = "dropdown",
            --[[ previewer = false, ]]
            --[[ path_display = { "absolute" }, ]]
        },
    },
})

require("telescope").load_extension("project")
require("telescope").load_extension("file_browser")
require('telescope').load_extension('fzf')
require('telescope').load_extension('ag')
require('telescope').load_extension('vim_bookmarks')


local _utils = require("telescope._extensions.project.utils")
local _git = require("telescope._extensions.project.git")
_G.project_add_cwd = function(arg)
    local path = arg
    if path == nil then path = _git.try_and_find_git_path() end
    local projects = _utils.get_project_objects()
    local path_not_in_projects = true

    local file = io.open(_utils.telescope_projects_file, "w")
    for _, project in pairs(projects) do
        if project.path == path then
            project.activated = 1
            path_not_in_projects = false
        end
        _utils.store_project(file, project)
    end

    if path_not_in_projects then
        local new_project = _utils.get_project_from_path(path)
        _utils.store_project(file, new_project)
    end

    io.close(file)
    print('Project added: ' .. path)
end


local bookmark_actions = require('telescope').extensions.vim_bookmarks.actions

function _G.TelBookmarks()
  require('telescope').extensions.vim_bookmarks.all {
    attach_mappings = function(_, map)
      map('i', '<C-x>', bookmark_actions.delete_selected_or_at_cursor)
      map('n', 'dd', bookmark_actions.delete_selected_or_at_cursor)
      return true
    end
  }
end

