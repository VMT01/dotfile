local config = {}

function config.nvim_ufo()
	---@diagnostic disable-next-line: missing-fields
	require("ufo").setup({
		fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
			local newVirtText = {}
			local suffix = ("   ... ↙ %d "):format(endLnum - lnum)
			local sufWidth = vim.fn.strdisplaywidth(suffix)
			local targetWidth = width - sufWidth
			local curWidth = 0
			for _, chunk in ipairs(virtText) do
				local chunkText = chunk[1]
				local chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if targetWidth > curWidth + chunkWidth then
					table.insert(newVirtText, chunk)
				else
					chunkText = truncate(chunkText, targetWidth - curWidth)
					local hlGroup = chunk[2]
					table.insert(newVirtText, { chunkText, hlGroup })
					chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if curWidth + chunkWidth < targetWidth then
						suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
					end
					break
				end
				curWidth = curWidth + chunkWidth
			end
			table.insert(newVirtText, { suffix, "MoreMsg" })
			return newVirtText
		end,
	})
end

function config.neo_tree()
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })
	require("neo-tree").setup({
		close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
		sort_case_insensitive = true, -- used when sorting files and directories in the tree
		sort_function = function(a, b) -- this sorts files and directories descendantly
			if a.type == b.type then
				return a.path < b.path
			else
				return a.type < b.type
			end
		end,
		-- default_component_configs = {
		container = { enable_character_fade = true },
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side

			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",

			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "󰜌",
			-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
			-- then these will never be used.
			default = "*",
			highlight = "NeoTreeFileIcon",
		},
		modified = { symbol = "[+]", highlight = "NeoTreeModified" },
		name = { trailing_slash = true, use_git_status_colors = true, highlight = "NeoTreeFileName" },
		git_status = {
			symbols = {
				-- Change type
				added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
				modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
				deleted = "✖", -- this can only be used in the git_status source
				renamed = "󰁕", -- this can only be used in the git_status source

				-- Status type
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "",
				conflict = "",
			},
			-- If you don't want to use these columns, you can set `enabled = false` for each of them individually
			file_size = {
				enabled = false,
				required_width = 64, -- min width of window required to show this column
			},
			type = {
				enabled = false,
				required_width = 122, -- min width of window required to show this column
			},
			last_modified = {
				enabled = false,
				required_width = 88, -- min width of window required to show this column
			},
			created = {
				enabled = false,
				required_width = 110, -- min width of window required to show this column
			},
			symlink_target = {
				enabled = false,
			},
		},
		-- A list of functions, each representing a global custom command
		-- that will be available in all sources (if not overridden in `opts[source_name].commands`)
		-- see `:h neo-tree-custom-commands-global`
		commands = {},
		window = {
			position = "right",
			width = 35,
			mapping_options = { noremap = true, nowait = true },
			mappings = {
				["<space>"] = {
					"toggle_node",
					nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
				},
				["<2-LeftMouse>"] = "open",
				["<cr>"] = "open",
				["<esc>"] = "cancel", -- close preview or floating neo-tree window
				["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } }, -- doesn't work in alacritty
				-- Read `# Preview Mode` for more information
				["h"] = "focus_preview",
				["S"] = "open_split",
				["s"] = "open_vsplit",
				-- ["S"] = "split_with_window_picker",
				-- ["s"] = "vsplit_with_window_picker",
				-- ["t"] = "open_tabnew",
				-- ["<cr>"] = "open_drop",
				-- ["t"] = "open_tab_drop",
				["w"] = "open_with_window_picker",
				--["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
				["C"] = "close_node",
				["z"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
				["a"] = {
					"add",
					-- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
					-- some commands may take optional config options, see `:h neo-tree-mappings` for details
					config = {
						show_path = "absolute", -- "none", "relative", "absolute"
					},
				},
				["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = { "copy", config = { show_path = "absolute" } }, -- takes text input for destination, also accepts the optional config.show_path option like "add":
				["m"] = { "move", config = { show_path = "absolute" } }, -- takes text input for destination, also accepts the optional config.show_path option like "add".
				["q"] = "close_window",
				["R"] = "refresh",
				["?"] = "show_help",
				["<"] = "prev_source",
				[">"] = "next_source",
				["i"] = "show_file_details",
			},
		},
		nesting_rules = {},
		filesystem = {
			filtered_items = {
				visible = false, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = true,
				hide_gitignored = true,
				hide_hidden = true, -- only works on Windows for hidden files/directories
				hide_by_name = {
					"node_modules", -- JS/TS
					".vscode", -- VSCode
					"target", -- Rust
				},
				hide_by_pattern = { -- uses glob style patterns
					"*.meta",
					"*/src/*/tsconfig.json",
				},
				always_show = { -- remains visible even if other settings would normally hide it
					".gitignored",
				},
				never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
					-- ".DS_Store",
					-- "thumbs.db"
				},
				never_show_by_pattern = { -- uses glob style patterns
					--".null-ls_*",
				},
			},
			follow_current_file = {
				enabled = true, -- This will find and focus the file in the active buffer every time the current file is changed while the tree is open.
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
			},
			group_empty_dirs = true, -- when true, empty folders will be grouped together
			hijack_netrw_behavior = "open_default",
			--[[
                    "open_default": netrw disabled, opening a directory opens neo-tree in whatever position is specified in window.position
                    "open_current": netrw disabled, opening a directory opens within the window like netrw would, regardless of window.position
                    "disabled"    : netrw left alone, neo-tree does not handle opening dirs
                ]]
			use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes instead of relying on nvim autocmd events.
			window = {
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = "fuzzy_finder",
					["D"] = "fuzzy_finder_directory",
					["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
					["f"] = "filter_on_submit",
					["<c-x>"] = "clear_filter",
					["[g"] = "prev_git_modified",
					["]g"] = "next_git_modified",
					["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
					["oc"] = { "order_by_created", nowait = false },
					["od"] = { "order_by_diagnostics", nowait = false },
					["og"] = { "order_by_git_status", nowait = false },
					["om"] = { "order_by_modified", nowait = false },
					["on"] = { "order_by_name", nowait = false },
					["os"] = { "order_by_size", nowait = false },
					["ot"] = { "order_by_type", nowait = false },
					-- ['<key>'] = function(state) ... end,
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<down>"] = "move_cursor_down",
					["<C-n>"] = "move_cursor_down",
					["<up>"] = "move_cursor_up",
					["<C-p>"] = "move_cursor_up",
					-- ['<key>'] = function(state, scroll_padding) ... end,
				},
				commands = {}, -- Add a custom command or override a global one using the same function name
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every time
					--              -- the current file is changed while the tree is open.
					leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						["gp"] = "git_push",
						["gg"] = "git_commit_and_push",
						["o"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
						["oc"] = { "order_by_created", nowait = false },
						["od"] = { "order_by_diagnostics", nowait = false },
						["om"] = { "order_by_modified", nowait = false },
						["on"] = { "order_by_name", nowait = false },
						["os"] = { "order_by_size", nowait = false },
						["ot"] = { "order_by_type", nowait = false },
					},
				},
			},
		},
		-- mrbjarksen/neo-tree-diagnostics.nvim
		diagnostics = {
			auto_preview = { -- May also be set to `true` or `false`
				enabled = false, -- Whether to automatically enable preview mode
				preview_config = { use_float = true }, -- Config table to pass to auto preview (for example `{ use_float = true }`)
				event = "neo_tree_buffer_enter", -- The event to enable auto preview upon (for example `"neo_tree_window_after_open"`)
			},
			bind_to_cwd = true,
			diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
			-- "position" means diagnostic items are sorted strictly by their positions.
			-- May also be a function.
			follow_current_file = { -- May also be set to `true` or `false`
				enabled = true, -- This will find and focus the file in the active buffer every time
				always_focus_file = false, -- Focus the followed file, even when focus is currently on a diagnostic item belonging to that file
				expand_followed = true, -- Ensure the node of the followed file is expanded
				leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
				leave_files_open = false, -- `false` closes auto expanded files, such as with `:Neotree reveal`
			},
			group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
			group_empty_dirs = true, -- when true, empty directories will be grouped together
			show_unloaded = true, -- show diagnostics from unloaded buffers
			refresh = {
				delay = 100, -- Time (in ms) to wait before updating diagnostics. Might resolve some issues with Neovim hanging.
				event = "vim_diagnostic_changed", -- Event to use for updating diagnostics (for example `"neo_tree_buffer_enter"`)
				-- Set to `false` or `"none"` to disable automatic refreshing
				max_items = 10000, -- The maximum number of diagnostic items to attempt processing
				-- Set to `false` for no maximum
			},
		},
		sources = {
			"filesystem",
			-- "buffer",
			"git_status",
			"diagnostics",
		},
	})
end

function config.whichkey()
	local opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			g = {
				d = { vim.lsp.buf.definition, "Goto definition" },
				D = { vim.lsp.buf.declaration, "Goto declaration" },
				i = { vim.lsp.buf.implementation, "Goto implementation" },
				t = { vim.lsp.buf.type_definition, "Goto type definition" },
				r = { vim.lsp.buf.references, "Goto references" },
			},
			z = {
				M = { require("ufo").closeAllFolds, "Close all folds" },
				R = { require("ufo").openAllFolds, "Open all folds" },
			},
			["<leader>"] = {
				["<space>"] = {
					name = "Managers",
					l = { "<cmd>Lazy<cr>", "[L]azy" },
					m = { "<cmd>Mason<cr>", "[M]ason" },
					n = { "<cmd>NullLsInfo<cr>", "[N]ull-ls Info" },
				},
				b = {
					name = "[B]uffers",
					c = {
						name = "[C]lose",
						a = { "<Cmd>Neotree reveal<CR> <bar> <Cmd>BufDelOthers<CR>", "Close [a]ll but current buffer" },
						A = { "<Cmd>Neotree reveal<CR> <bar> <Cmd>BufDelAll<CR>", "Close [A]ll buffers" },
						o = { "<Cmd>BufDelOthers<CR>", "Close [O]ther buffers" },
					},
					d = { "<Cmd>BufDel<CR>", "[D]elete current buffer" },
				},
				c = {
					name = "[C]hatGPT/[C]arbon",
					c = "[C]apture",
					-- c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
					e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
					g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
					t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
					k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
					d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
					a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
					o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
					s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
					f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
					x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
					r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
					l = {
						"<cmd>ChatGPTRun code_readability_analysis<CR>",
						"Code Readability Analysis",
						mode = { "n", "v" },
					},
				},
				f = {
					name = "[F]uzzy finds/[F]ile explore",
					b = { "<Cmd>Telescope buffers<CR>", "Toggle [B]uffers list" },
					c = { "<Cmd>Telescope commands<CR>", "Togle [C]ommands list" },
					e = { "<Cmd>Neotree toggle<CR>", "Neotree [E]xplorer" },
					d = { require("telescope.builtin").diagnostics, "[D]iagnostics for current buffer" },
					f = { "<Cmd>Telescope find_files<CR>", "Fuzzy find [F]iles" },
					F = {
						"<Cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>",
						"Fuzzy find hidden [F]iles",
					},
					h = { "<Cmd>Telescope command_history<CR>", "Toggle command [H]istory" },
					k = { require("telescope.builtin").keymaps, "Lists normal mode [K]eymappings" },
					m = { "<Cmd>Telescope man_pages<CR>", "[M]an Pages" },
					n = { require("telescope").extensions.notify.notify, "Show all [N]otifications in Telescope" },
					r = { "<Cmd>Telescope oldfiles<CR>", "Fuzzy find [R]ecent files" },
					t = { "<Cmd>TodoTelescope<CR>", "Open [T]odos" },
					u = { "<Cmd>Telescope undo<CR>", "Toggle [U]ndo tree" },
					w = { "<Cmd>Telescope live_grep<CR>", "Live grep [W]ord" },
				},
				g = {
					name = "[G]it",
					g = { "<Cmd>LazyGit<CR>", "Toggle Lazy[G]it" },
					s = {
						name = "[S]tage",
						b = { require("gitsigns").stage_buffer, "Git stage [B]uffer" },
						h = { require("gitsigns").stage_hunk, "Git stage [H]unk" },
					},
					u = {
						name = "[U]ndo",
						b = { require("gitsigns").reset_buffer_index, "Git stage [B]uffer" },
						h = { require("gitsigns").undo_stage_hunk, "Git stage [H]unk" },
					},
					t = {
						name = "[T]oggle",
						d = { require("gitsigns").diffthis, "Toggle diffthis" },
						D = { "<Cmd>require('gitsigns').diffthis('~')<CR>", "Toggle diffthis('~')" },
						t = { require("gitsigns").toggle_deleted, "Toggle deleted" },
					},
				},
				l = {
					name = "[L]sp",
					a = { vim.lsp.buf.code_action, "See available code [A]ctions" },
					d = {
						function()
							vim.diagnostic.open_float(nil, { border = "single" })
						end,
						"Show line [D]iagnostics",
					},
					D = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Show buffer diagnostics" },
					i = { "<cmd>LspInfo<cr>", "LSP [I]nformation" },
					r = { vim.lsp.buf.rename, "Smart [R]ename" },
					s = { "<cmd>LspRestart<cr>", "Re[S]tart LSP" },
				},
				m = {
					name = "[M]arkdown",
					s = { "<cmd>MarkdownPreview<CR>", "Markdown [S]tart" },
					S = { "<cmd>MarkdownPreviewStop<CR>", "Markdown [S]top" },
					t = { "<cmd>MarkdownPreviewToggle<CR>", "Markdown [T]oggle" },
				},
				n = {
					name = "[N]otify",
					a = { "<Cmd>lua require('noice').cmd('all')<CR>", "Noice [A]ll" },
					d = { "<Cmd>lua require('noice').cmd('dismiss')<CR>", "Noice [D]ismiss all" },
					l = { "<Cmd>lua require('noice').cmd('last')<CR>", "Noice [L]ast message" },
					h = { "<Cmd>lua require('noice').cmd('history')<CR>", "Noice [H]istory" },
				},
				s = {
					name = "[S]wap",
					n = {
						name = "[N]ext",
						c = { "@class.inner", "[C]lass" },
						f = { "@function.inner", "[F]unction" },
						p = { "@parameter.inner", "[P]arameter" },
					},
					p = {
						name = "[P]revious",
						c = { "@class.inner", "[C]lass" },
						f = { "@function.inner", "[F]unction" },
						p = { "@parameter.inner", "[P]arameter" },
					},
				},
			},
		},
		icons = { group = "" },
		popup_mappings = { scroll_down = "<C-j>", scroll_up = "<C-k>" },
	}
	require("which-key").setup(opts)
	require("which-key").register(opts.defaults)
end

function config.notify()
	---@diagnostic disable-next-line: missing-fields
	require("notify").setup({
		background_colour = "#000000",
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
	})
end

function config.windows()
	require("windows").setup({
		animation = { enable = true },
		autowidth = { enable = true },
	})
end

return config
