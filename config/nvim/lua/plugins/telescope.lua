-- INFO: TOOLS (Fuzzy Finder)

return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep"
        },
        cmd = "Telescope",
        event = "VeryLazy",
        opts = function()
            local actions = require("telescope.actions")

            return {
                defaults = {
                    -- Default configuration for telescope goes here:
                    -- config_key = value,
                    dynamic_preview_title = true,
                    mappings = {
                        i = {
                            -- map actions.which_key to <C-h> (default: <C-/>)
                            -- actions.which_key shows the mappings for your picker,
                            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
                        }
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
            }
        end
    },
    {
        'debugloop/telescope-undo.nvim',
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim"
        },
        event = "VeryLazy",
        opts = {
            extensions = {
                undo = {}
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("undo")
        end
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        dependencies = { "nvim-telescope/telescope.nvim" },
        event = "VeryLazy",
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },
            }
        },
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("fzf")
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = { "nvim-telescope/telescope.nvim" },
        event = "VeryLazy",
        opts = {
            ["ui-select"] = {
                require("telescope.themes").get_dropdown({}),
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension("ui-select")
        end
    },
}
