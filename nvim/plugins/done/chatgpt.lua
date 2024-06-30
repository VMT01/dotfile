return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		api_key_cmd = "pass openai-key",
	},
	config = function(_, opts)
		require("chatgpt").setup(opts)
	end,
}
