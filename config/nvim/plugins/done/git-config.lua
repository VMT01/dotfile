-- TAG: CODING

return {
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
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
				-- add = { text = "┃" },
				-- change = { text = "┋" },
				-- delete = { text = "" },
				-- topdelete = { text = "" },
				-- changedelete = { text = "┃" },
				-- untracked = { text = "┃" },
			},
			current_line_blame = true,
			current_line_blame_opts = { delay = 300 },
			current_line_blame_formatter = "<author> <author_time:%d-%m-%Y>: <summary>",
			preview_config = { border = "rounded" },
		},
		config = function(_, opts)
			local gs = require("gitsigns")
			gs.setup(opts)

			--[[ Navigation ]]
			vim.keymap.set({ "n", "v" }, "]p", function()
				if vim.wo.diff then
					return "]p"
				end

				vim.schedule(gs.next_hunk)
				return "<Ignore>"
			end, { expr = true })
			vim.keymap.set({ "n", "v" }, "[p", function()
				if vim.wo.diff then
					return "[p"
				end

				vim.schedule(gs.prev_hunk)
				return "<Ignore>"
			end, {})

			--[[ Action ]]
			-- Hunk - Changes
			-- vim.keymap.set("n", "<leader>gsh", gs.stage_hunk, {})
			-- vim.keymap.set("n", "<leader>grh", gs.reset_hunk, {})
			-- vim.keymap.set("n", "<leader>guh", gs.undo_stage_hunk, {})

			-- Buffer
			-- vim.keymap.set("n", "<leader>gsb", gs.stage_buffer, {})
			-- vim.keymap.set("n", "<leader>gub", gs.reset_buffer_index, {})

			-- Toggle
			-- vim.keymap.set("n", "<leader>gd", gs.diffthis, {})
			-- vim.keymap.set("n", "<leader>gD", function()
			-- 	gs.diffthis("~")
			-- end, {})
			-- vim.keymap.set("n", "<leader>gtd", gs.toggle_deleted, {})
		end,
	},
	{ "tpope/vim-sleuth", lazy = true, event = "VeryLazy" },
}
