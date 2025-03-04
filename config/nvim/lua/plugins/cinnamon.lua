-- INFO: UI

return {
    "declancm/cinnamon.nvim",
    version = "*", -- use latest release
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        -- disabled = false, -- Disables the plugin.
        keymaps = {
            basic = true, -- Enable the provided 'basic' keymaps
            extra = true, -- Enable the provided 'extra' keymaps
        },
        options = {
            -- The scrolling mode
            -- `cursor`: Smoothly scrolls the cursor for any movement
            -- `window`: Smoothly scrolls the window ONLY when the cursor moves out of view
            mode = "window",
            delay = 5,       -- The default delay (in ms) between each line when scrolling.
            max_delta = {
                time = 2000, -- Maximum duration for a movement (in ms). Automatically adjusts the step delay
                line = 100,  -- Maximum distance for line movements. Set to `nil` to disable
            },
        },
    },
    -- config = function(_, opts)
    --     require('cinnamon').setup(opts)
    -- end
}
