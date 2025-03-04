-- INFO: EDITOR

return {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
        { "anuvyklack/middleclass" },
        { "anuvyklack/animation.nvim", enabled = true },
    },
    opts = {
        animation = { enable = true },
        autowidth = { enable = true }
    }
}
