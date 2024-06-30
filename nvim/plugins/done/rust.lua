return {
	{
		"rust-lang/rust.vim",
		ft = "rust",
		event = "BufEnter",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		event = "BufEnter",
		dependencies = "neovim/nvim-lspconfig",
		config = function()
			require("rust-tools").setup({})
		end,
	},
	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
			crates.show()
			-- vim.keymap.set("n", "<leader>uc", crates.upgrade_all_crates, {})
		end,
	},
}
