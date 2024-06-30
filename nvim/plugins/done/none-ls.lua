-- TAG: CODING

return {
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local diagnostics = null_ls.builtins.diagnostics
		local formatting = null_ls.builtins.formatting

		null_ls.setup({
			on_attach = function(client, bufnr)
				local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
			sources = {
				--[[ CODE ACTIONS ]]
				require("none-ls.code_actions.eslint_d"),

				--[[ DIAGNOSTICS ]]
				diagnostics.checkmake, -- make linter.
				diagnostics.cmake_lint, -- Check cmake listfiles for style violations, common mistakes, and anti-patterns.
				diagnostics.markdownlint_cli2, -- A fast, flexible, configuration-based command-line interface for linting Markdown/CommonMark files with the markdownlint library
				diagnostics.mypy, -- Mypy is an optional static type checker for Python that aims to combine the benefits of dynamic (or "duck") typing and static typing.
				diagnostics.pylint, -- Pylint is a Python static code analysis tool which looks for programming errors, helps enforcing a coding standard, sniffs for code smells and offers simple refactoring suggestions.
				diagnostics.solhint, -- An open source project for linting Solidity code. It provides both security and style guide validations.
				diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }), -- change to your dialect. A SQL linter and auto-formatter for Humans
				diagnostics.todo_comments, -- Uses inbuilt Lua code and treesitter to detect lines with Todo comments and show a diagnostic warning on each line where it's present.
				diagnostics.trail_space, -- Uses inbuilt Lua code to detect lines with trailing whitespace and show a diagnostic warning on each line where it's present.
				require("none-ls.diagnostics.eslint_d"),

				--[[ FORMATTING ]]
				formatting.blackd, -- The uncompromising Python code formatter
				formatting.cmake_format, -- Parse cmake listfiles and format them nicely.
				formatting.isortd, -- Python utility / library to sort imports alphabetically and automatically separate them into sections and by type.
				formatting.prettierd, -- prettier, as a daemon, for ludicrous formatting speed.
				formatting.prettierd.with({ filetypes = { "solidity" }, extra_args = {} }),
				formatting.prettierd.with({
					filetypes = { "toml" },
					extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
				}),
				formatting.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }), -- change to your dialect. A SQL linter and auto-formatter for Humans
				formatting.stylua, -- An opinionated code formatter for Lua.
			},
		})
	end,
}
