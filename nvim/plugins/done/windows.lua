-- TAG: EDITOR

return {
	"anuvyklack/windows.nvim",
	event = "WinNew",
	dependencies = {
		{ "anuvyklack/middleclass" },
		{ "anuvyklack/animation.nvim", enabled = true },
	},
	opts = {
		animation = { enable = true },
		autowidth = { enable = true },
	},
	init = function()
		vim.o.winwidth = 10
		vim.o.winminwidth = 10
		vim.o.equalalways = false
	end,
}
