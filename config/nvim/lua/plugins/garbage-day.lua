-- INFO: TOOLS (CLEAN UNUSED LSP)

return {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
        aggressive_mode = false,
        excluded_lsp_clients = { "null-ls", "jdtls", "marksman", "lua_ls" },
        grace_period = 60 * 15, -- 15 mins,
        wakeup_delay = 1000,
        aggresive_mode_ignore = {
            filetype = { "", "markdown", "text", "org", "tex", "asciidoc", "rst" },
            buftype = { "nofile" }
        },
        notifications = true,
        retry = 3,
        timeout = 1000,
    }
}
