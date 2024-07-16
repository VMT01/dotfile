local config = {}

function config.nvim_cmp()
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
			{ name = "luasnip", max_item_count = 15 },
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
			{ name = "path", max_item_count = 10 },
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
		---@diagnostic disable-next-line: missing-fields
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
end

function config.chatgpt()
	require("chatgpt").setup({
		api_key_cmd = "pass openai-key",
	})
end

function config.mason_null_ls()
	require("mason-null-ls").setup({
		ensure_installed = {},
		automatic_installation = true,
	})
end

function config.none_ls()
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
end

function config.mason_lspconfig()
	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"bashls",
			"cmake",
			"dockerls",
			"docker_compose_language_service",
			"graphql",
			"jsonls",
			"jdtls",
			"tsserver",
			"lua_ls",
			"move_analyzer",
			"pyright",
			"sqlls",
			"solidity_ls_nomicfoundation",
			"taplo",
			"yamlls",
		},
	})
end

function config.nvim_lspconfig()
	require("neodev").setup({})
	require("mason").setup({})
	require("mason-lspconfig").setup({
		ensure_installed = nil,
		automatic_installation = false,
	})
	local lspconfig = require("lspconfig")
	lspconfig.bashls.setup({})
	lspconfig.cmake.setup({})
	lspconfig.dockerls.setup({})
	lspconfig.docker_compose_language_service.setup({})
	lspconfig.graphql.setup({})
	lspconfig.jsonls.setup({})
	lspconfig.jdtls.setup({})
	lspconfig.tsserver.setup({})
	lspconfig.lua_ls.setup({})
	lspconfig.move_analyzer.setup({})
	lspconfig.pyright.setup({})
	-- lspconfig.rust_analyzer.setup({})
	lspconfig.sqlls.setup({})
	lspconfig.solidity_ls_nomicfoundation.setup({})
	lspconfig.taplo.setup({})
	lspconfig.yamlls.setup({})
end

-- function config.rust_tools()
-- 	require("rust-tools").setup({})
-- end

function config.crates()
	local crates = require("crates")
	crates.setup()
	crates.show()
	-- vim.keymap.set("n", "<leader>uc", crates.upgrade_all_crates, {})
end

return config
