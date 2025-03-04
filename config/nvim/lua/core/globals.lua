------------------------------------------------------------------------
--                          custom variables                          --
------------------------------------------------------------------------
vim.g.is_win = (vim.fn.has 'win32' or vim.fn.has 'win64') and true or false
vim.g.is_linux = (vim.fn.has 'unix' and (not vim.fn.has 'macunix')) and true or false
vim.g.is_mac = vim.fn.has 'macunix' and true or false

-- vim.g.logging_level             = "info"

------------------------------------------------------------------------
--                         builtin variables                          --
------------------------------------------------------------------------
vim.g.loaded_python3_provider = 0 -- Disable python provider
vim.g.loaded_ruby_provider = 0 -- Disable ruby provider
vim.g.loaded_perl_provider = 0 -- Disable perl provider
vim.g.loaded_node_provider = 0 -- Disable node provider
vim.g.did_install_default_menus = 1 -- do not load menu

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Use English as main language
vim.cmd [[language en_US.UTF-8]]

-- Whether to load netrw by default, see https://github.com/bling/dotvim/issues/4
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.netrw_liststyle = 3
if vim.g.is_win then
  vim.g.netrw_http_cmd = 'curl --ssl-no-revoke -Lo'
end

-- Do not load tohtml.vim
vim.g.loaded_2html_plugin = 1

-- Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
-- related to checking files inside compressed files)
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tarPlugin = 1

-- Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

-- -- Disable sql omni completion, it is broken.
-- vim.g.loaded_sql_completion = 1

vim.g.verbose = 0
