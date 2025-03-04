-- INFO: LSP (RUST)

return {
  {
    'rust-lang/rust.vim',
    ft = 'rust',
    event = 'BufEnter',
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        -- tools = {},
        -- LSP configuration
        server = {
          -- on_attach = function(client, bufnr) end,
          default_settings = {
            -- rust-analyzer language server configuration
            ['rust-analyzer'] = {
              checkOnSave = { command = 'clippy' },
              cargo = { allFeatures = true },
              diagnostics = { enable = true, experimental = false },
              procMacro = { enable = true },
              inlayHints = { enable = false },
              flags = { debounce_text_changes = 150 },
            },
          },
        },
        -- DAP configuration
        -- dap = {},
      }
    end,
  },
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)
      crates.show()
    end,
  },
}
