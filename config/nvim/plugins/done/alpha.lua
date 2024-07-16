-- TAG: EDITOR

return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
		"MaximilianLloyd/ascii.nvim",
	},
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")
		local ascii = require("ascii")

		dashboard.section.header.val = ascii.get_random_global()
		dashboard.section.buttons.val = {
			dashboard.button("f", " 󰈞 Find file", ":Telescope find_files<CR>"),
			dashboard.button("r", " 󱋡 Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("l", " ⚡Lazy", ":Lazy<CR>"),
			dashboard.button("q", " 󰿅 Quit NVIM", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
