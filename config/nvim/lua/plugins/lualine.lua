-- INFO: UI

return {
    'nvim-lualine/lualine.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            -- component_separators = { left = '', right = '' },
            component_separators = '',
            -- section_separators = { left = '', right = '' },
            section_separators = { left = '', right = '' },
            disabled_filetypes = {
                statusline = { "lazy", "dashboard", "starter" },
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {
                { 'mode', icon = " ", separator = { left = '' } }
            },
            lualine_b = {
                'branch',
                {
                    'diff',
                    symbols = {
                        added = ' ',
                        modified = '󰝤 ',
                        removed = ' ',
                        cond = function()
                            return vim.fn.winwidth(0) > 80
                        end
                    },
                }
            },
            lualine_c = { '%=' },
            lualine_x = {},
            lualine_y = {
                -- { 'filetype', icon_only = true },
                -- { 'filename', path = 1, symbols = { modified = " ", readonly = "", unnamed = "" } },
                {
                    'diagnostics',
                    sources = { 'nvim_diagnostic' },
                    symbols = { error = ' ', warn = ' ', info = ' ' },
                    diagnostics_color = {
                        error = { fg = '#ec5f67' },
                        warn = { fg = '#ECBE7B' },
                        info = { fg = '#008080' },
                    },
                }
            },
            lualine_z = {
                {
                    function()
                        local msg = 'No Active Lsp'
                        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                        local clients = vim.lsp.get_active_clients()
                        if next(clients) == nil then
                            return msg
                        end
                        for _, client in ipairs(clients) do
                            local filetypes = client.config.filetypes
                            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                return client.name
                            end
                        end
                        return msg
                    end,
                    icon = '  LSP:',
                    color = { fg = '#ffffff', gui = 'bold' },
                },
                { 'location', separator = { right = '' } }
            }
        },
        -- inactive_sections = {
        --     lualine_a = { 'filename' },
        --     lualine_b = {},
        --     lualine_c = {},
        --     lualine_x = {},
        --     lualine_y = {},
        --     lualine_z = { 'location' }
        -- },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    }
}
