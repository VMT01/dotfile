-- TAG: CODE

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "rafamadriz/friendly-snippets",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lua",
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        luasnip.config.setup({})
        luasnip.filetype_extend("all", { "-" })
        luasnip.filetype_extend("lua", { "all" })
        luasnip.filetype_extend("javascript", { "jsdoc" }) -- TODO: Check this out

        cmp.setup({
            preselect = "item",
            completion = {
                completeopt = "menu,menuone,noinsert",
                keyword_length = 2,
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            sources = cmp.config.sources({
                { name = "nvim_lua", max_item_count = 30 },
                { name = "nvim_lsp", max_item_count = 30 },
                { name = "luasnip",  max_item_count = 15 },
                {
                    name = "buffer",
                    max_item_count = 20,
                    keyword_length = 2,
                    option = {
                        keyword_pattern = [[\k\+]],
                        get_bufnrs = function()
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                },
                { name = "path",   max_item_count = 10 },
                { name = "crates", max_item_count = 10 },
            }),
            enabled = function()
                local buftype = vim.bo.buftype
                if buftype == "prompt" then
                    return false
                end

                local context = require("cmp.config.context")
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end
            end,
            performance = { max_view_entries = 30 },
            experimental = { native_menu = false, ghost_text = true },
            mapping = cmp.mapping.preset.insert({
                ["<C-h>"] = cmp.mapping.scroll_docs(-4),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-l>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-c>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
                ["<tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<s-tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
        })
    end,
}
