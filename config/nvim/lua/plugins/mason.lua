-- INFO: TOOLS (PACKAGE MANAGER)
return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
        border = 'rounded',
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      ensure_installed = {
        'bashls',
        'cmake',
        'docker_compose_language_service',
        'dockerls',
        'gopls',
        'html',
        'jsonls',
        'lua_ls',
        'move_analyzer',
        'pyright',
        'solidity_ls_nomicfoundation',
        'taplo',
        'ts_ls',
        'yamlls',
      },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup {}
        end,
        ts_ls = function()
          require('lspconfig').ts_ls.setup {
            -- root_dir = function(fname)
            --   return lspconfig.util.root_pattern(unpack { "package.json", "nx.json", ".git" })(fname)
            --     or lspconfig.util.find_git_ancestor(fname)
            -- end,
            flags = {
              debouce_text_changes = 150,
            },
            cmd = {
              'typescript-language-server',
              '--stdio',
              -- "--max-old-space-size=4096",
            },
          }
        end,
      },
    },
  },
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'nvimtools/none-ls.nvim', -- replaces null-ls
    },
    opts = {
      ensure_installed = {
        -- CODE ACTIONS
        'gitsigns',
        -- "gomodifytags",
        -- "impl",
        -- "refactoring",

        -- DIAGNOSTICS
        'actionlint',
        'checkmake',
        'cmake_lint',
        'golangci_lint',
        'hadolint',
        'markdownlint_cli2',
        'markuplint',
        'mypy',
        'protolint',
        'pylint',
        'solhint',
        'yamllint',
        'zsh',

        -- LINTER
        'eslint_d',

        -- FORMATTING
        'blackd',
        'buf',
        'cmake_format',
        'gofumpt',
        'goimports',
        'goimports_reviser',
        'golines',
        'isortd',
        'prettierd',
        'stylua',

        -- HOVER
      },
      automatic_installation = false,
      handlers = {
        function(source_name, methods)
          require 'mason-null-ls.automatic_setup'(source_name, methods)
        end,
        eslint_d = function()
          local null_ls = require 'null-ls'
          local eslint_d = require('none-ls.diagnostics.eslint_d').with {
            condition = function(utils)
              return utils.root_has_file { '.eslintrc.js', '.eslintrc.yml', '.eslintrc.json' }
            end,
            env = { NODE_OPTIONS = '--max-old-space-size=4096' },
            extra_args = { '--cache' },
          }
          null_ls.register(eslint_d)
        end,
      },
    },
  },
}
