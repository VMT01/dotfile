-- TAG: CODE

return {
    {
        "williamboman/mason.nvim",
        lazy = false,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim", -- replaces null-ls
        },
        opts = {
            ensure_installed = nil,
            automatic_installation = true,
        },
        config = function(_, opts)
            require("mason-null-ls").setup(opts)
        end,
    },
}
