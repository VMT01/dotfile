-- INFO: TOOLS (NOTE TAKER)

return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/*.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        workspaces = {
            {
                name = "Obsidian Vault",
                path = "~/Documents/Obsidian Vault",
                strict = true,
            },
        },
        notes_subdir = "notes",
        -- daily_notes = {
        -- 	folder = "notes/dailies",
        -- 	date_format = "%Y-%m-%d",
        -- 	alias_format = "%B %-d, %Y",
        -- 	default_tags = { "daily-notes" },
        -- 	template = nil,
        -- },
    },
}
