-- TAG: CODING

return {
	{
		"numToStr/Comment.nvim",
		event = { "BufEnter" },
		opts = {
			ignore = "^$",
		},
		--[[
            NORMAL MODE
            `gcc` - Toggles the current line using linewise comment
            `gbc` - Toggles the current line using blockwise comment
            `[count]gcc` - Toggles the number of line given as a prefix-count using linewise
            `[count]gbc` - Toggles the number of line given as a prefix-count using blockwise
            `gc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
            `gb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
            `gco` - Insert comment to the next line and enters INSERT mode
            `gcO` - Insert comment to the previous line and enters INSERT mode
            `gcA` - Insert comment to end of the current line and enters INSERT mode

            # Linewise
            `gcw` - Toggle from the current cursor position to the next word
            `gc$` - Toggle from the current cursor position to the end of line
            `gc}` - Toggle until the next blank line
            `gc5j` - Toggle 5 lines after the current cursor position
            `gc8k` - Toggle 8 lines before the current cursor position
            `gcip` - Toggle inside of paragraph
            `gca}` - Toggle around curly brackets

            # Blockwise
            `gb2}` - Toggle until the 2 next blank line
            `gbaf` - Toggle comment around a function (w/ LSP/treesitter support)
            `gbac` - Toggle comment around a class (w/ LSP/treesitter support)
        --]]
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost" },
		opts = {
			signs = true,
			sign_priority = 8,
			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
				TODO = { icon = " ", color = "info", alt = { "todo", "ToDo", "Todo", "toDo" } },
				HACK = { icon = " ", color = "warning", alt = { "hack", "Hack" } },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX", "warn", "warning" } },
				PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = " ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			gui_style = { fg = "NONE" },
			merge_keywords = true,
			highlight = {
				multiline = true,
				multiline_pattern = "^.",
				multiline_context = 10,
				before = "",
				keyword = "wide",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
				comments_only = true,
				max_line_len = 400,
				exclude = {},
			},
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
			},
			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		},
	},
}
