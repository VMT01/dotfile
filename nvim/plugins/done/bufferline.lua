-- TAG: UI

return {
	"akinsho/nvim-bufferline.lua",
	enabled = true,
	event = "VeryLazy",
	dependencies = { "ojroques/nvim-bufdel", "catppuccin/nvim" },
	opts = {
		options = {
			offsets = {
				{ filetype = "neo-tree", text = "File Explorer", separator = true, text_align = "center" },
				{ filetype = "NvimTree", text = "File Explorer", separator = true, text_align = "center" },
			},
			separator_style = "thin",
			always_show_bufferline = false,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diag)
				local ret = (diag.error and " " .. diag.error .. " " or "")
					.. (diag.warning and " " .. diag.warning or "")
				return vim.trim(ret)
			end,
			color_icons = true,
			show_buffer_icons = true,
			hover = { enabled = true, delay = 0, reveal = { "close" } },
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- require("bufferline").setup({
		-- 	highlights = require("catppuccin.groups.integrations.bufferline").get(),
		-- })
		require("bufdel").setup({ quit = false }) -- quit Neovim when last buffer is closed
		vim.api.nvim_create_autocmd("BufAdd", {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
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
}
