vim.opt.clipboard = 'unnamedplus' -- <string = ""> use the clipboard as the unnamed register
vim.opt.cmdheight = 0 -- <number = 1> number of lines to use for the command-line
vim.opt.completeopt = 'menu,menuone,preview,noselect' -- <string = "menu,preview"> options for Insert mode completion
vim.opt.conceallevel = 1 -- <number = 0> whether concealable text is shown or hidden
vim.opt.confirm = true -- <bool = false> ask what to do about unsaved/read-only files
vim.opt.cursorline = true -- <bool = false> highlight the screen line of the cursor
vim.opt.equalalways = false -- <bool = true> windows are automatically made the same size
vim.opt.expandtab = true -- <bool = false> use spaces when <Tab> is inserted
-- <string = ""> characters to use for displaying special items
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
-- vim.opt.foldclose = "all"          -- <string = ""> close a fold when the cursor leaves it
vim.opt.foldcolumn = 'auto' -- <string = "0"> width of the column used to indicate folds
vim.opt.foldenable = true -- <bool = true> set to display all folds open
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.opt.formatoptions = 'tcroqnlj' -- <string = "tcqj"> how automatic formatting is to be done
-- if vim.fn.executable("rg") == 1 then
--     vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
-- end
vim.opt.history = 2000 -- <number = 10000> number of command-lines that are remembered
vim.opt.hlsearch = false -- <bool = true> highlight matches with last search pattern
vim.opt.ignorecase = true -- <bool = false> ignore case in search patterns
vim.opt.infercase = true -- <bool = false> adjust case of match for keyword completion
vim.opt.laststatus = 3 -- <number = 2> tells when last window has status lines
vim.opt.list = true -- <bool = false> show <Tab> and <EOL>
-- <string = "tab:> ,trail:-,nbsp:+"> characters for displaying in list mode
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.mouse = 'a' -- <string = "nvi"> enable the use of mouse clicks
vim.opt.mousemoveevent = true -- <bool = false> report mouse moves with <MouseMove>
vim.opt.number = true -- <bool = false> print the line number in front of each line
vim.opt.pumheight = 15 -- <number = 0> maximum number of items to show in the popup menu
vim.opt.redrawtime = 1500 -- <number = 2000> timeout for 'hlsearch' and :match highlighting
vim.opt.relativenumber = true -- <bool = false> show relative line number in front of each line
vim.opt.ruler = false -- <bool = true> show cursor line and column in the status line
vim.opt.scrolloff = 2 -- <number = 0> minimum nr. of lines above and below cursor
-- <string = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal"> options for :mksession
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
vim.opt.shiftwidth = 4 -- <number = 8> number of spaces to use for (auto)indent step
vim.opt.shortmess = 'aoOTIcF' -- <string = "ltToOCF"> list of flags, reduce length of messages
vim.opt.showcmd = false -- <bool = true> show (partial) command somewhere
vim.opt.showmode = false -- <bool = true> message on status line to show current mode
vim.opt.showtabline = 0 -- <number = 1> tells when the tab pages line is displayed
vim.opt.sidescrolloff = 5 -- <number = 0> min. nr. of columns to left and right of cursor
vim.opt.signcolumn = 'yes' -- <string = "auto"> when and how to display the sign column
vim.opt.smartcase = true -- <bool = false> no ignore case when pattern has uppercase
vim.opt.smartindent = true -- <bool = false> smart autoindenting for C programs
vim.opt.shiftround = true -- <bool = false> round indent to multiple of shiftwidth
if vim.fn.has 'nvim-0.10' == 1 then
  vim.opt.smoothscroll = true -- <bool = false> scroll by screen lines when 'wrap' is set
end
vim.opt.softtabstop = 4 -- <number = 0> number of spaces that <Tab> uses while editing
vim.opt.splitbelow = true -- <bool = false> new window from split is below the current one
vim.opt.splitkeep = 'screen' -- <string = "cursor"> determines scroll behavior for split windows
vim.opt.splitright = true -- <bool = false> new window is put right of the current one
vim.opt.swapfile = false -- <bool = true> whether to use a swapfile for a buffer
vim.opt.tabstop = 2 -- <number = 8> number of spaces that <Tab> in file uses
vim.opt.termguicolors = true -- <bool = false> enable 24-bit RGB color in the TUI
vim.opt.textwidth = 100 -- <number = 0> maximum width of text that is being inserted
vim.opt.timeoutlen = 500 -- <number = 1000> time out time in milliseconds
vim.opt.ttimeoutlen = 10 -- <number = 50> time out time for key codes in milliseconds
vim.opt.undofile = true -- <bool = false> save undo information in a file
vim.opt.updatetime = 100 -- <number = 4000> after this many milliseconds flush swap file
vim.opt.virtualedit = 'block' -- <string = ""> when to use virtual editing
vim.opt.whichwrap = 'h,l,<,>,[,],~' -- <string = "b,s"> allow specified keys to cross line boundaries
vim.opt.wildignorecase = true -- <bool = false> ignore case when completing file names
vim.opt.wildmode = 'longest:full,full' -- <string = "full"> ignore case when completing file names
vim.opt.winminwidth = 10 -- <number = 1> minimal number of columns for any window
vim.opt.winwidth = 30 -- <number = 20> minimal number of columns for current window
vim.opt.wrap = false -- <bool = true> long lines wrap and continue on the next line

vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]
