-- TAG: CODING

return {
	"zeioth/garbage-day.nvim",
	event = "BufReadPost",
	opts = {
		grace_period = 60 * 15,
		excluded_filetypes = { "null-ls" },
		stop_invisible = false,
		notifications = true,
	},
}
