local nvim_create_autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
	return vim.api.nvim_create_augroup("vmtpld_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })

-- Highlight on yank
nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
	pattern = "*",
})

-- resize splits if window got resized
nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- remember last cursor location of files
nvim_create_autocmd("BufReadPost", {
	group = augroup("last_location"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- wrap and check for spell in text filetypes
nvim_create_autocmd("FileType", {
	group = augroup("wrap_and_spell"),
	pattern = { "gitcommit", "markdown", "tex" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

nvim_create_autocmd("FileType", {
	group = augroup("toggle_spell_checking"),
	desc = "Turn on spell checking on files where it makes sense.",
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

nvim_create_autocmd("FileType", {
	desc = "Disable foldcolumn",
	group = augroup("adjust_foldcolumn"),
	pattern = {
		"neotest-summary",
		"dap-repl",
		"NeogitCommitMessage",
		"NeogitCommitView",
		"NeogitPopup",
		"NeogitStatus",
	},
	callback = function()
		vim.opt_local.foldcolumn = "0"
	end,
})

-- close some stuff with q
nvim_create_autocmd("FileType", {
	group = augroup("close_buffers"),
	-- this is the stuff to close
	pattern = "fugitive",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "q", "<Cmd>q<CR>", { noremap = true, silent = true })
	end,
})

nvim_create_autocmd("BufRead", {
	desc = "Open non-Vim-readable files in system default applications.",
	group = augroup("open_externally"),
	pattern = "*.png, *.jpg, *.gif, *.pdf, *.xls*, *.ppt, *.doc*, *.rtf",
	command = "sil exe '!open ' . shellescape(expand('%:p')) | bd | let &ft=&ft",
})

nvim_create_autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufWinEnter",
	"CursorHold",
	"InsertLeave",

	-- include this if you have set `show_modified` to `true`
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

nvim_create_autocmd("FileType", {
	pattern = {
		"help",
		"neo-tree",
		"Trouble",
		"lazy",
		"mason",
		"notify",
		"toggleterm",
		"lazyterm",
	},
	callback = function()
		vim.b.miniindentscope_disable = true
	end,
})
