local package = require("core.pack").package
local conf = require("modules.editor.config")

package({
	"kevinhwang91/nvim-ufo",
	enabled = true,
	dependencies = {
		"kevinhwang91/promise-async",
		{
			"luukvbaal/statuscol.nvim",
			config = function()
				local builtin = require("statuscol.builtin")
				require("statuscol").setup({
					relculright = true,
					segments = {
						{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
						{ text = { "%s" }, click = "v:lua.ScSa" },
						{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
					},
				})
			end,
		},
	},
	event = "BufReadPost",
	config = conf.nvim_ufo,
})

package({
	"anuvyklack/fold-preview.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = "anuvyklack/keymap-amend.nvim",
})

package({
	"nvim-neo-tree/neo-tree.nvim",
	event = false,
	branch = "v3.x",
	dependencies = {
		"mrbjarksen/neo-tree-diagnostics.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window
		{
			"s1n7ax/nvim-window-picker",
			version = "2.*",
			config = function()
				require("window-picker").setup({
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
						-- filter using buffer options
						bo = {
							-- if the file type is one of following, the window will be ignored
							filetype = { "neo-tree", "neo-tree-popup", "notify" },
							-- if the buffer type is one of following, the window will be ignored
							buftype = { "terminal", "quickfix" },
						},
					},
				})
			end,
		},
	},
	cmd = "Neotree",
	config = conf.neo_tree,
})

package({
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = { "lewis6991/gitsigns.nvim" },
	config = conf.whichkey,
})

package({
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	config = conf.notify,
})

package({
	"anuvyklack/windows.nvim",
	event = "WinNew",
	dependencies = {
		{ "anuvyklack/middleclass" },
		{ "anuvyklack/animation.nvim", enabled = true },
	},
	config = conf.windows,
})
