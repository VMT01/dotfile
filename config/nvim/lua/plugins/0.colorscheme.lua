-- INFO: UI

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  event = 'VeryLazy',
  -- lazy = false,
  -- priority = 1000,
  opts = {
    flavor = 'macchiato', -- latte, frappe, macchiato, mocha
    -- background = {        -- :h background
    --     light = "latte",
    --     dark = "macchiato",
    -- },
    -- transparent_background = false, -- disables setting the background color.
    -- show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
    -- term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = true, -- dims the background color of inactive window
      -- shade = "dark",
      -- percentage = 0.005,         -- percentage of the shade to apply to the inactive window
    },
    -- no_italic = false,              -- Force no italic
    -- no_bold = false,                -- Force no bold
    -- no_underline = false,           -- Force no underline
    styles = {
      -- comments = { "italic" },    -- Change the style of comments
      -- conditionals = { "italic" },
      -- loops = {},
      functions = { 'bold' },
      -- keywords = {},
      -- strings = {},
      -- variables = {},
      -- numbers = {},
      -- booleans = {},
      -- properties = {},
      -- types = {},
      -- operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    -- color_overrides = {},
    -- custom_highlights = {},
    -- default_integrations = true,
    integrations = {
      barbecue = {
        dim_dirname = true, -- directory name is dimmed by default
        bold_basename = true,
        dim_context = false,
        alt_background = false,
      },
      cmp = true,
      dashboard = true,
      gitsigns = true,
      neotree = true,
      -- treesitter = true,
      -- notify = false,
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
}
