-- TAG: CODE

return {
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = {
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
				-- "rust_analyzer",
				"sqlls",
				"solidity_ls_nomicfoundation",
				"taplo",
				"yamlls",
			},
		},
		config = function(_, opts)
			require("mason").setup({})
			require("mason-lspconfig").setup(opts)
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"b0o/schemastore.nvim",
			"j-hui/fidget.nvim",
			"williamboman/mason-lspconfig.nvim",
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{ "folke/neodev.nvim", opts = {} },
		},
		opts = {
			ensure_installed = nil,
			automatic_installation = false,
		},
		init = function()
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		end,
		config = function(_, opts)
			require("neodev").setup({})
			require("mason").setup({})
			require("mason-lspconfig").setup(opts)

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
		end,
	},
}
