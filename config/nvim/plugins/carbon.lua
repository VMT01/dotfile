return {
	"ellisonleao/carbon-now.nvim",
	lazy = true,
	cmd = "CarbonNow",
	opts = { options = { theme = "One Light", font_family = "JetBrains Mono", padding_horizontal = "100px" } },
	keys = {
		{ "<leader>cn", [[<Cmd>CarbonNow<CR>]], mode = "v" },
	},
	config = true,
}
