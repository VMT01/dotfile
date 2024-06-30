-- TAG: EDITOR
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Telescope",
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				defaults = {
					dynamic_preview_title = true,
					mappings = {
						i = {
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						},
					},
					get_selection_window = function()
						local wins = vim.api.nvim_list_wins()
						table.insert(wins, 1, vim.api.nvim_get_current_win())
						for _, win in ipairs(wins) do
							local buf = vim.api.nvim_win_get_buf(win)
							if vim.bo[buf].buftype == "" then
								return win
							end
						end
						return 0
					end,
				},
			})
		end,
	},
	{
		"debugloop/telescope-undo.nvim",
		event = "BufReadPost",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			extensions = { undo = {} },
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("undo")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		opts = {
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		},
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"dharmx/telescope-media.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local canned = require("telescope._extensions.media.lib.canned")
			require("telescope").setup({
				extensions = {
					media = {
						backend = "viu", -- image/gif backend
						flags = {
							viu = { move = true }, -- GIF preview
						},
						on_confirm_single = canned.single.copy_path,
						on_confirm_muliple = canned.multiple.bulk_copy,
						cache_path = vim.fn.stdpath("cache") .. "/media",
					},
				},
			})
			require("telescope").load_extension("media")
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					lazygit = {
						lazygit_floating_window_winblend = 0, -- transparency of floating window
						lazygit_floating_window_scaling_factor = 0.9, -- scaling factor for floating window
						lazygit_floating_window_border_chars = {
							"╭",
							"─",
							"╮",
							"│",
							"╯",
							"─",
							"╰",
							"│",
						}, -- customize lazygit popup window border characters
						lazygit_floating_window_use_plenary = 0, -- use plenary.nvim to manage floating window if available
						lazygit_use_neovim_remote = 1, -- fallback to 0 if neovim-remote is not installed
						lazygit_use_custom_config_file_path = 0, -- config file path is evaluated if this value is 1
						lazygit_config_file_path = {}, -- list of custom config file paths
					},
				},
			})
			require("telescope").load_extension("lazygit")
		end,
	},
}
