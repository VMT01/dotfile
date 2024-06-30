-- TAG: UI

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSInstall", "TSUpdateSync" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"windwp/nvim-ts-autotag",
	},
	opts = {
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
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
