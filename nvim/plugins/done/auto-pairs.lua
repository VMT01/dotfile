-- TAG: CODING

return {
	"windwp/nvim-autopairs",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "hrsh7th/nvim-cmp" }, -- Optional dependency
	config = function()
		require("nvim-autopairs").setup({})

		-- Automatically add `(` after selecting a function or method
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,
}
