-- INFO: TOOLS (GIT)

return {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    event = 'VeryLazy',
    opts = {
        extensions = {
            lazygit = {
                lazygit_floating_window_winblend = 0,         -- transparency of floating window
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
                },                                       -- customize lazygit popup window border characters
                lazygit_floating_window_use_plenary = 0, -- use plenary.nvim to manage floating window if available
                lazygit_use_neovim_remote = 1,           -- fallback to 0 if neovim-remote is not installed
                lazygit_use_custom_config_file_path = 0, -- config file path is evaluated if this value is 1
                lazygit_config_file_path = {},           -- list of custom config file paths
            },
        },
    },
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("lazygit")
    end
}
