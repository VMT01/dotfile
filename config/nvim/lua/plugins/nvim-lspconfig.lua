-- INFO: TOOLS (LSP)

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "b0o/schemastore.nvim",
            "j-hui/fidget.nvim",
            "williamboman/mason-lspconfig.nvim",
            { "antosha417/nvim-lsp-file-operations", config = true },
            "folke/lazydev.nvim",
        },
    }
}
