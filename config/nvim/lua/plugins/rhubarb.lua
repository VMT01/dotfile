-- INFO: TOOLS (GIT)

return {
    "tpope/vim-rhubarb",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { 'tpope/vim-fugitive' }
}
