-- INFO: TOOLS (LSP)

return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
  },
  opts = function()
    local null_ls = require 'null-ls'

    local code_actions = null_ls.builtins.code_actions
    local diagnostics = null_ls.builtins.diagnostics
    local formatting = null_ls.builtins.formatting
    local completion = null_ls.builtins.completion

    return {
      border = 'rounded',
      default_timeout = -1,
      diagnostics_format = '[#{c}] #{m} (#{s})',
      -- on_attach = function(client, bufnr)
      --   local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      --   if client.supports_method "textDocument/formatting" then
      --     vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format { bufnr = bufnr }
      --       end,
      --     })
      --   end
      -- end,
      sources = {
        -- require "none-ls.code_actions.eslint_d",

        --[[ COMPLETION ]]
        completion.luasnip, -- Snippet engine for Neovim, written in Lua.

        --[[ DIAGNOSTICS ]]
        -- diagnostics.actionlint, -- Actionlint is a static checker for GitHub Actions workflow files.
        -- diagnostics.checkmake, -- make linter.
        -- diagnostics.cmake_lint, -- Check cmake listfiles for style violations, common mistakes, and anti-patterns.
        -- diagnostics.golangci_lint, -- A Go linter aggregator.
        -- diagnostics.hadolint, -- A smarter Dockerfile linter that helps you build best practice Docker images.
        -- diagnostics.markdownlint_cli2, -- A fast, flexible, configuration-based command-line interface for linting Markdown/CommonMark files with the markdownlint library
        -- diagnostics.markuplint, -- A linter for all markup developers.
        -- diagnostics.mypy, -- Mypy is an optional static type checker for Python that aims to combine the benefits of dynamic (or "duck") typing and static typing.
        -- diagnostics.protolint, -- A pluggable linter and fixer to enforce Protocol Buffer style and conventions.
        -- diagnostics.pylint, -- Pylint is a Python static code analysis tool which looks for programming errors, helps enforcing a coding standard, sniffs for code smells and offers simple refactoring suggestions.
        -- diagnostics.solhint, -- An open source project for linting Solidity code. It provides both security and style guide validations.
        -- diagnostics.yamllint, -- A linter for YAML files.
        -- diagnostics.zsh,  -- Uses zsh's own -n option to evaluate, but not execute, zsh scripts.
        -- require("none-ls.diagnostics.eslint_d").with {
        --   condition = function(utils)
        --     return utils.root_has_file { ".eslintrc.js", ".eslintrc.yml", ".eslintrc.json" }
        --   end,
        -- },

        --[[ FORMATTING ]]
        -- formatting.blackd, -- The uncompromising Python code formatter
        -- formatting.buf,  -- A new way of working with Protocol Buffers.
        -- formatting.cmake_format, -- Parse cmake listfiles and format them nicely.
        -- formatting.gofumpt, -- Enforce a stricter format than gofmt, while being backwards compatible.
        -- formatting.goimports, -- Updates your Go import lines, adding missing ones and removing unreferenced ones.
        -- formatting.goimports_reviser, -- Tool for Golang to sort goimports by 3 groups: std, general and project dependencies.
        -- formatting.golines, -- Applies a base formatter (eg. goimports or gofmt), then shortens long lines of code.
        -- formatting.isortd, -- Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
        -- formatting.prettierd,
        -- -- formatting.prettierd.with({
        -- -- 	condition = function(utils)
        -- -- 		return utils.root_has_file({ ".prettierrc", ".prettierrc.yml" })
        -- -- 	end,
        -- -- }),
        -- -- formatting.prettierd.with({ extra_filetypes = { "solidity" } }),
        -- -- formatting.prettierd.with({
        -- -- 	extra_filetypes = { "toml" },
        -- -- 	extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
        -- -- }),
        -- formatting.stylua, -- An opinionated code formatter for Lua.
      },
    }
  end,
  -- config = conf.none_ls,
}
