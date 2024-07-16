-- TAG: EDITOR

return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
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
	},
	config = function(_, opts)
		require("which-key").setup(opts)
		require("which-key").register(opts.defaults)
	end,
}
