local package = require("core.pack").package
local conf = require("modules.ui.config")

-- Colorscheme
package({
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = conf.catppuccin,
})

-- Dashboard
package({
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"MaximilianLloyd/ascii.nvim",
		"MunifTanjim/nui.nvim",
	},
	event = "VimEnter",
	config = conf.alpha,
})

-- Bufferline
package({
	"akinsho/nvim-bufferline.lua",
	enabled = true,
	event = "VeryLazy",
	dependencies = { "ojroques/nvim-bufdel", "catppuccin/nvim" },
	keys = {
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Move to Prev buffer" } },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Move to Next buffer" } },
		{
			"<A-,>",
			"<Cmd>BufferLineCyclePrev<CR>",
			{ desc = "Move to Prev buffer", remap = true },
		},
		{
			"<A-.>",
			"<Cmd>BufferLineCycleNext<CR>",
			{ desc = "Move to Next buffer", remap = true },
		},
		{ "<A-<>", "<Cmd>BufferLineMovePrev<CR>", { desc = "Move buffer to the left" } },
		{ "<A->>", "<Cmd>BufferLineMoveNext<CR>", { desc = "Move Buffer to the right" } },
		{ "<A-1>", "<Cmd>BufferLineGoTo 1<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-2>", "<Cmd>BufferLineGoTo 2<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-3>", "<Cmd>BufferLineGoTo 3<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-4>", "<Cmd>BufferLineGoTo 4<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-5>", "<Cmd>BufferLineGoTo 5<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-6>", "<Cmd>BufferLineGoTo 6<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-7>", "<Cmd>BufferLineGoTo 7<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-8>", "<Cmd>BufferLineGoTo 8<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-9>", "<Cmd>BufferLineGoTo 9<CR>", { desc = "Goto Buffer number 9" } },
		{ "<A-p>", "<Cmd>BufferLineTogglePin<CR>", { desc = "Pin current Buffer" } },
	},
	config = conf.bufferline,
})

-- Barbecue
package({
	"utilyre/barbecue.nvim",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = conf.barbecue,
})

-- Cinnamon
package({
	"declancm/cinnamon.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = conf.cinnamon,
})

-- Dressing
package({
	"stevearc/dressing.nvim",
	config = conf.dressing,
})

-- Lualine
package({
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = conf.lualine,
})

-- Noice
package({
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = conf.noice,
})

package({
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall", "TSUpdateSync" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	config = conf.nvim_treesitter,
})

package({
	{
		"tpope/vim-rhubarb",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"tpope/vim-fugitive",
				cmd = {
					"Git",
					"Gedit",
					"Gsplit",
					"Gdiffsplit",
					"Gvdiffsplit",
					"Gread",
					"Gwrite",
					"Ggrep",
					"Glgrep",
					"GMove",
					"GDelete",
					"GBrowse",
				},
			},
		},
	},
})

package({
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = conf.gitsigns,
})

package({
	"tpope/vim-sleuth",
	lazy = true,
	event = "VeryLazy",
})

package({
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = { "BufReadPost", "BufNewFile" },
	config = conf.indent_blankline,
})

package({
	"echasnovski/mini.indentscope",
	version = false, -- wait till new 0.7.0 release to put it back on semver
	event = { "BufReadPre", "BufNewFile" },
	config = conf.mini_indentscope,
})
