-- INFO: UI

return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
        "MaximilianLloyd/ascii.nvim",
        "MunifTanjim/nui.nvim"
    },
    opts = function()
        local ascii = require("ascii")

        return {
            theme = 'hyper', --  theme is doom and hyper default is hyper
            -- disable_move = false, --  default is false disable move keymap for hyper
            -- shortcut_type = 'number', --  shorcut type 'letter' or 'number'
            -- shuffle_letter = true,      --  default is true, shortcut 'letter' will be randomize, set to false to have ordered letter.
            -- change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
            config = { --  config used for theme
                header = ascii.get_random_global(),
                -- week_header = {
                --     enable = true,
                -- },
                shortcut = nil,
                project = { enable = false },
                mru = { limit = 5, cwd_only = true }
            },
            hide = {
                statusline = false, -- hide statusline default is true
                tabline = false,    -- hide the tabline
                winbar = false,     -- hide winbar
            },
            -- preview = {
            --     command = true,     -- preview command
            --     file_path = true,   -- preview file path
            --     file_height = true, -- preview file height
            --     file_width = true   -- preview file width
            -- },
        }
    end,
}
