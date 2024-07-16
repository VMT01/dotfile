local config = {}

function config.catppuccin()
	require("catppuccin").setup({
		flavour = "macchiato", -- latte, frappe, macchiato, mocha
		background = {       -- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = false, -- disables setting the background color.
		show_end_of_buffer = false,   -- shows the '~' characters after the end of buffers
		term_colors = false,          -- sets terminal colors (e.g. `g:terminal_color_0`)
		dim_inactive = {
			enabled = false,            -- dims the background color of inactive window
			shade = "dark",
			percentage = 0.15,          -- percentage of the shade to apply to the inactive window
		},
		no_italic = false,            -- Force no italic
		no_bold = false,              -- Force no bold
		no_underline = false,         -- Force no underline
		styles = {                    -- Handles the styles of general hi groups (see `:h highlight-args`):
			comments = { "italic" },    -- Change the style of comments
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
			-- miscs = {}, -- Uncomment to turn off hard-coded styles
		},
		color_overrides = {},
		custom_highlights = {},
		default_integrations = true,
		integrations = {
			barbecue = {
				dim_dirname = true, -- directory name is dimmed by default
				bold_basename = true,
				dim_context = false,
				alt_background = false,
			},
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			treesitter = true,
			notify = false,
			mini = {
				enabled = true,
				indentscope_color = "",
			},
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})
	vim.cmd("colorscheme catppuccin")
end

function config.alpha()
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
end

function config.bufferline()
	require("bufferline").setup({
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
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
	})
	require("bufdel").setup({ quit = false }) -- quit Neovim when last buffer is closed
	vim.api.nvim_create_autocmd("BufAdd", {
		callback = function()
			vim.schedule(function()
				pcall(nvim_bufferline)
			end)
		end,
	})
end

function config.barbecue()
	require("barbecue").setup({
		show_basename = true,
		show_dirname = false,
		theme = "auto",
		kinds = {
			Array = " ",
			Boolean = " ",
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Macro = " ",
			Method = " ",
			Module = " ",
			Namespace = " ",
			Null = " ",
			Number = " ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		},
		exclude_filetypes = { "gitcommit", "Trouble", "toggleterm" },
		create_autocmd = false,
	})
end

function config.cinnamon()
	require("cinnamon").setup({
		disabled = false, -- Disables the plugin.
		keymaps = {
			basic = true, -- Enable the provided 'basic' keymaps
			extra = true, -- Enable the provided 'extra' keymaps
		},

		options = {
			-- The scrolling mode
			-- `cursor`: Smoothly scrolls the cursor for any movement
			-- `window`: Smoothly scrolls the window ONLY when the cursor moves out of view
			mode = "window",
			delay = 4, -- The default delay (in ms) between each line when scrolling.
			max_delta = {
				time = 1000, -- Maximum duration for a movement (in ms). Automatically adjusts the step delay
				line = 100, -- Maximum distance for line movements. Set to `nil` to disable
			},
		},
	})
end

function config.dressing()
	require("dressing").setup({
		input = {
			-- Set to false to disable the vim.ui.input implementation
			enabled = true,

			-- Default prompt string
			default_prompt = "Input",

			-- Trim trailing `:` from prompt
			trim_prompt = true,

			-- Can be 'left', 'right', or 'center'
			title_pos = "left",

			-- When true, input will start in insert mode.
			start_in_insert = true,

			-- These are passed to nvim_open_win
			border = "rounded",
			-- 'editor' and 'win' will default to being centered
			relative = "cursor",

			-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
			prefer_width = 40,
			width = nil,
			-- min_width and max_width can be a list of mixed types.
			-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
			max_width = { 140, 0.9 },
			min_width = { 20, 0.2 },

			buf_options = {},
			win_options = {
				-- Disable line wrapping
				wrap = false,
				-- Indicator for when text exceeds window
				list = true,
				listchars = "precedes:…,extends:…",
				-- Increase this for more context when text scrolls off the window
				sidescrolloff = 0,
			},

			-- Set to `false` to disable
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
					["<Up>"] = "HistoryPrev",
					["<Down>"] = "HistoryNext",
				},
			},

			override = function(conf)
				-- This is the config that will be passed to nvim_open_win.
				-- Change values here to customize the layout
				return conf
			end,

			-- see :help dressing_get_config
			get_config = nil,
		},
		select = {
			-- Set to false to disable the vim.ui.select implementation
			enabled = true,

			-- Priority list of preferred vim.select implementations
			backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

			-- Trim trailing `:` from prompt
			trim_prompt = true,

			-- Options for telescope selector
			-- These are passed into the telescope picker directly. Can be used like:
			-- telescope = require('telescope.themes').get_ivy({...})
			telescope = nil,

			-- Options for fzf selector
			fzf = {
				window = {
					width = 0.5,
					height = 0.4,
				},
			},

			-- Options for fzf-lua
			fzf_lua = {
				-- winopts = {
				--   height = 0.5,
				--   width = 0.5,
				-- },
			},

			-- Options for nui Menu
			nui = {
				position = "50%",
				size = nil,
				relative = "editor",
				border = {
					style = "rounded",
				},
				buf_options = {
					swapfile = false,
					filetype = "DressingSelect",
				},
				win_options = {
					winblend = 0,
				},
				max_width = 80,
				max_height = 40,
				min_width = 40,
				min_height = 10,
			},

			-- Options for built-in selector
			builtin = {
				-- Display numbers for options and set up keymaps
				show_numbers = true,
				-- These are passed to nvim_open_win
				border = "rounded",
				-- 'editor' and 'win' will default to being centered
				relative = "editor",

				buf_options = {},
				win_options = {
					cursorline = true,
					cursorlineopt = "both",
				},

				-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
				-- the min_ and max_ options can be a list of mixed types.
				-- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
				width = nil,
				max_width = { 140, 0.8 },
				min_width = { 40, 0.2 },
				height = nil,
				max_height = 0.9,
				min_height = { 10, 0.2 },

				-- Set to `false` to disable
				mappings = {
					["<Esc>"] = "Close",
					["<C-c>"] = "Close",
					["<CR>"] = "Confirm",
				},

				override = function(conf)
					-- This is the config that will be passed to nvim_open_win.
					-- Change values here to customize the layout
					return conf
				end,
			},

			-- Used to override format_item. See :help dressing-format
			format_item_override = {},

			-- see :help dressing_get_config
			get_config = nil,
		},
	})
end

function config.lualine()
	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "auto",
			globalstatus = true,
			disable_filetypes = { statusline = { "lazy", "alpha", "starter" } },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					icon = " ",
					separator = { left = "", right = "" },
					color = { fg = "#1e1e2e", bg = "#b4befe" },
				},
			},
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filetype",
					icon_only = true,
					separator = "",
					padding = { left = 1, right = 0 },
				},
				{
					"filename",
					path = 1,
					symbols = {
						modified = " ",
						readonly = "",
						unnamed = "",
					},
				},
			},
			lualine_x = {
				{
					function()
						return require("dap").status()
					end,
					cond = function()
						return package.loaded["dap"] and require("dap").status() ~= ""
					end,
				},
				{
					function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.mode.get()
					end,
					cond = function()
						---@diagnostic disable-next-line: undefined-field
						return package.loaded["noice"] and require("noice").api.status.mode.has()
					end,
				},
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff9e64" },
				},
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
				{
					function()
						local msg = "LS Inactive"
						local buf_clients = vim.lsp.get_clients()
						if next(buf_clients) == nil then
							if type(msg) == "boolean" or #msg == 0 then
								return "LS Inactive"
							end
						end
						local buf_client_names = {}

						for _, client in pairs(buf_clients) do
							table.insert(buf_client_names, client.name)
						end

						local unique_client_names = vim.fn.uniq(buf_client_names)
						---@diagnostic disable-next-line: param-type-mismatch
						local language_servers = table.concat(unique_client_names, ", ")

						return language_servers
					end,
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
			lualine_y = {
				{
					"progress",
					separator = "",
					padding = { left = 1, right = 0 },
					color = { fg = "#1e1e2e", bg = "#eba0ac" },
				},
				{
					"location",
					padding = { left = 0, right = 1 },
					color = { fg = "#1e1e2e", bg = "#eba0ac" },
				},
			},
			lualine_z = {
				{
					function()
						return " " .. os.date("%R")
					end,
					color = { fg = "#1e1e2e", bg = "#f2cdcd" },
				},
			},
		},
	})
end

function config.noice()
	require("noice").setup({
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		routes = {
			{
				filter = {
					event = "msg_show",
					any = {
						{ find = "%d+L, %d+B" },
						{ find = "; after #%d+" },
						{ find = "; before #%d+" },
					},
				},
				view = "mini",
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			inc_rename = true,
			lsp_doc_border = true,
		},
	})
end

function config.nvim_treesitter()
	require("nvim-treesitter.configs").setup({
		modules = {},
		ensure_installed = {
			"bash",
			"cmake",
			"comment",
			"dockerfile",
			"graphql",
			"javascript",
			"jsdoc",
			"json",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"regex",
			"rust",
			"solidity",
			"sql",
			"toml",
			"typescript",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
		sync_install = true,
		auto_install = false,
		ignore_install = {},
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
		},

		-- windwp/nvim-ts-autotag
		autotag = { enable = true },
		context_commentstring = { enable = true, enable_autocmd = false },
		indent = { enable = true },
		matchup = { enable = true, enable_quotes = true },
		incremental_selection = { enable = true },

		-- nvim-treesitter/nvim-treesitter-textobjects
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

				keymaps = {
					-- ["ab"] = { query = "@block.outer", desc = "Around block" },
					["ac"] = { query = "@class.outer", desc = "Around class" },
					["a?"] = { query = "@conditional.outer", desc = "Around conditional" },
					["af"] = { query = "@function.outer", desc = "Around function" },
					["al"] = { query = "@loop.outer", desc = "Around loop" },
					["aa"] = { query = "@parameter.outer", desc = "Around argument" },

					["ib"] = { query = "@block.inner", desc = "Inside block" },
					["ic"] = { query = "@class.inner", desc = "Inside class" },
					["i?"] = { query = "@conditional.inner", desc = "Inside conditional" },
					["if"] = { query = "@function.inner", desc = "Inside function" },
					["il"] = { query = "@loop.inner", desc = "Inside loop" },
					["ia"] = { query = "@parameter.inner", desc = "Inside argument" },
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>snp"] = "@parameter.inner",
					["<leader>snf"] = "@function.inner",
					["<leader>snc"] = "@class.inner",
				},
				swap_previous = {
					["<leader>spp"] = "@parameter.inner",
					["<leader>spf"] = "@function.inner",
					["<leader>spc"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]f"] = { query = "@function.outer", desc = "Next function start" },
					["]p"] = { query = "@parameter.outer", desc = "Next parameter start" },
					["]c"] = { query = "@class.outer", desc = "Next class start" },
					["]l"] = { query = "@loop.outer", desc = "Next loop start" },
					["]s"] = { query = "@scope", desc = "Next scope start" },
					["]]"] = { query = "@fold", desc = "Next fold start" },
				},
				goto_next_end = {
					["]F"] = { query = "@function.outer", desc = "Next function end" },
					["]P"] = { query = "@parameter.outer", desc = "Next parameter end" },
					["]C"] = { query = "@class.outer", desc = "Next class end" },
					["]L"] = { query = "@loop.outer", desc = "Next loop end" },
					["]S"] = { query = "@scope", desc = "Next scope end" },
					["]["] = { query = "@fold", desc = "Next fold end" },
				},
				goto_previous_start = {
					["[f"] = { query = "@function.outer", desc = "Previous function start" },
					["[p"] = { query = "@parameter.outer", desc = "Previous parameter start" },
					["[c"] = { query = "@class.outer", desc = "Previous class start" },
					["[l"] = { query = "@loop.outer", desc = "Previous loop start" },
					["[s"] = { query = "@scope", desc = "Previous scope start" },
					["[]"] = { query = "@fold", desc = "Previous fold start" },
				},
				goto_previous_end = {
					["[F"] = { query = "@function.outer", desc = "Previous function end" },
					["[P"] = { query = "@parameter.outer", desc = "Previous parameter end" },
					["[C"] = { query = "@class.outer", desc = "Previous class end" },
					["[L"] = { query = "@loop.outer", desc = "Previous loop end" },
					["[S"] = { query = "@scope", desc = "Previous scope end" },
					["[["] = { query = "@fold", desc = "Previous fold end" },
				},
				-- goto_next = {},
				-- goto_previous = {},
			},
		},
	})
end

function config.gitsigns()
	local gs = require("gitsigns")
	gs.setup({
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
	})

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
end

function config.indent_blankline()
	require("ibl").setup({
		indent = { char = "│" },
		exclude = {
			filetypes = {
				"help",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
		},
		scope = { enabled = false },
	})
end

function config.mini_indentscope()
	require("mini.indentscope").setup({
		symbol = "│",
		options = { try_as_border = true },
	})
end

return config
