local config = {}

function config.telescope()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
        defaults = {
            dynamic_preview_title = true,
            mappings = {
                i = {
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                    ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                },
            },
            get_selection_window = function()
                local wins = vim.api.nvim_list_wins()
                table.insert(wins, 1, vim.api.nvim_get_current_win())
                for _, win in ipairs(wins) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].buftype == "" then
                        return win
                    end
                end
                return 0
            end,
        },
    })
end

function config.telescope_undo()
    require("telescope").setup({ extensions = { undo = {} } })
    require("telescope").load_extension("undo")
end

function config.telescope_fzf_native()
    require("telescope").setup({
        extensions = {
            fzf = {
                fuzzy = true,       -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            },
        },
    })
    require("telescope").load_extension("fzf")
end

function config.telescope_ui_select()
    require("telescope").setup({
        extensions = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
    })
    require("telescope").load_extension("ui-select")
end

function config.telescope_media()
    local canned = require("telescope._extensions.media.lib.canned")
    require("telescope").setup({
        extensions = {
            media = {
                backend = "viu", -- image/gif backend
                flags = {
                    viu = { move = true }, -- GIF preview
                },
                on_confirm_single = canned.single.copy_path,
                on_confirm_muliple = canned.multiple.bulk_copy,
                cache_path = vim.fn.stdpath("cache") .. "/media",
            },
        },
    })
    require("telescope").load_extension("media")
end

function config.lazygit()
    require("telescope").setup({
        extensions = {
            lazygit = {
                lazygit_floating_window_winblend = 0, -- transparency of floating window
                lazygit_floating_window_scaling_factor = 0.9, -- scaling factor for floating window
                lazygit_floating_window_border_chars = {
                    "╭",
                    "─",
                    "╮",
                    "│",
                    "╯",
                    "─",
                    "╰",
                    "│",
                },                           -- customize lazygit popup window border characters
                lazygit_floating_window_use_plenary = 0, -- use plenary.nvim to manage floating window if available
                lazygit_use_neovim_remote = 1, -- fallback to 0 if neovim-remote is not installed
                lazygit_use_custom_config_file_path = 0, -- config file path is evaluated if this value is 1
                lazygit_config_file_path = {}, -- list of custom config file paths
            },
        },
    })
    require("telescope").load_extension("lazygit")
end

function config.autopairs()
    require("nvim-autopairs").setup({
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = true,  -- disable when recording or executing a macro
        disable_in_visualblock = false, -- disable when insert after visual block mode
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,   -- add bracket pairs after quote
        enable_check_bracket_line = true, --- check bracket in same line
        enable_bracket_in_quote = true, --
        enable_abbr = false,        -- trigger abbreviation
        break_undo = true,          -- switch for basic rule break undo sequence
        check_ts = false,
        map_cr = true,
        map_bs = true, -- map the <BS> key
        map_c_h = false, -- Map the <C-h> key to delete a pair
        map_c_w = false, -- map <c-w> to delete a pair if possible
    })

    -- Automatically add `(` after selecting a function or method
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

function config.comment()
    ---@diagnostic disable-next-line: missing-fields
    require("Comment").setup({
        ignore = "^$",
    })
end

function config.todo_comment()
    require("todo-comments").setup({
        signs = true,
        sign_priority = 8,
        keywords = {
            FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
            TODO = { icon = " ", color = "info", alt = { "todo", "ToDo", "Todo", "toDo" } },
            HACK = { icon = " ", color = "warning", alt = { "hack", "Hack" } },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
            TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        gui_style = { fg = "NONE" },
        merge_keywords = true,
        highlight = {
            multiline = true,
            multiline_pattern = "^.",
            multiline_context = 10,
            before = "",
            keyword = "wide",
            after = "fg",
            pattern = [[.*<(KEYWORDS)\s*:]],
            comments_only = true,
            max_line_len = 400,
            exclude = {},
        },
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
            test = { "Identifier", "#FF00FF" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            pattern = [[\b(KEYWORDS):]],
        },
    })
end

function config.garbage_day()
    require("garbage-day").setup({
        grace_period = 60 * 15,
        excluded_filetypes = { "null-ls" },
        stop_invisible = false,
        notifications = true,
    })
end

function config.vim_illuminate()
    require("illuminate").configure({
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
            "lsp",
            "treesitter",
            "regex",
        },
        -- delay: delay in milliseconds
        delay = 100,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        -- See `:help mode()` for possible values
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        -- See `:help mode()` for possible values
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = nil,
        -- large_file_config: config to use for large files (based on large_file_cutoff).
        -- Supports the same keys passed to .configure
        -- If nil, vim-illuminate will be disabled for large files.
        large_file_overrides = nil,
        -- min_count_to_highlight: minimum number of matches required to perform highlighting
        min_count_to_highlight = 1,
        -- should_enable: a callback that overrides all other settings to
        -- enable/disable illumination. This will be called a lot so don't do
        -- anything expensive in it.
        should_enable = function(bufnr)
            return true
        end,
        -- case_insensitive_regex: sets regex case sensitivity
        case_insensitive_regex = false,
    })
end

return config
