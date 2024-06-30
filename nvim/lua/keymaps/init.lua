local keymap = require("core.keymap")
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = " "
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- leaderkey
nmap({ " ", "", opts(noremap) })
xmap({ " ", "", opts(noremap) })

nmap({
	-- close buffer
	-- { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
	-- Select all
	{ "<C-a>", "gg<S-v>G", opts(noremap, silent) },
	-- Save
	{ "<C-s>", cmd("update"), opts(noremap) },
	-- Yank
	{ "Y", "y$", opts(noremap) },
	-- Buffer jump
	{ "]b", cmd("bn"), opts(noremap) },
	{ "[b", cmd("bp"), opts(noremap) },
	-- Remove trailing white space
	{ "<Leader>t", cmd("TrimTrailingWhitespace"), opts(noremap) },
	-- window jump
	{ "<C-h>", "<C-w>h", opts(noremap) },
	{ "<C-l>", "<C-w>l", opts(noremap) },
	{ "<C-j>", "<C-w>j", opts(noremap) },
	{ "<C-k>", "<C-w>k", opts(noremap) },
	-- quit
	{ "<C-q>", cmd("q!"), opts(noremap, silent) },
	-- LSP
	{ "K", vim.lsp.buf.hover, opts(noremap, silent) },
})

-- imap({
-- 	-- insert mode
-- 	{ "<C-h>", "<Bs>", opts(noremap) },
-- 	{ "<C-e>", "<End>", opts(noremap) },
-- })

-- commandline remap
-- cmap({
-- 	{ "<C-b>", "<Left>", opts(noremap) },
-- })

-- nmap({
-- 	-- plugin manager: Lazy.nvim
-- 	{ "<Leader>pu", cmd("Lazy update"), opts(noremap, silent) },
-- 	{ "<Leader>pi", cmd("Lazy install"), opts(noremap, silent) },
-- 	-- dashboard
-- 	{ "<Leader>n", cmd("DashboardNewFile"), opts(noremap, silent) },
-- 	{ "<Leader>ss", cmd("SessionSave"), opts(noremap, silent) },
-- 	{ "<Leader>sl", cmd("SessionLoad"), opts(noremap, silent) },
-- 	-- nvimtree
-- 	{ "<Leader>e", cmd("NvimTreeToggle"), opts(noremap, silent) },
-- 	-- Telescope
-- 	{ "<Leader>b", cmd("Telescope buffers"), opts(noremap, silent) },
-- 	{ "<Leader>fa", cmd("Telescope live_grep"), opts(noremap, silent) },
-- 	{ "<Leader>ff", cmd("Telescope find_files"), opts(noremap, silent) },
-- })
