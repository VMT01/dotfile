local package = require("core.pack").package
local conf = require("modules.completion.config")

package({
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
	config = conf.nvim_cmp,
})

package({
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = conf.chatgpt,
})

package({
	"williamboman/mason.nvim",
	lazy = false,
})

package({
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim", -- replaces null-ls
	},
	config = conf.mason_null_ls,
})

package({
	"nvimtools/none-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = conf.none_ls,
})

package({
	"williamboman/mason-lspconfig.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = conf.mason_lspconfig,
})

package({
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
	config = conf.nvim_lspconfig,
})

package({
	"rust-lang/rust.vim",
	ft = "rust",
	event = "BufEnter",
})

-- package({
-- 	"simrat39/rust-tools.nvim",
-- 	ft = "rust",
-- 	event = "BufEnter",
-- 	dependencies = "neovim/nvim-lspconfig",
-- })

package({
	"mrcjkb/rustaceanvim",
	version = "^4", -- Recommended
	lazy = false, -- This plugin is already lazy
})

package({
	"saecki/crates.nvim",
	ft = { "rust", "toml" },
	config = conf.crates,
})
