-- INFO: Editor

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  dependencies = { 'lewis6991/gitsigns.nvim', 'echasnovski/mini.icons' },
  opts = {
    preset = 'helix', -- false | "classic" | "modern" | "helix"
    icons = { group = ' ' },
    keys = { scroll_down = '<C-j>', scroll_up = '<C-k>' },
  },
  config = function(_, opts)
    local wk = require 'which-key'
    wk.setup(opts)
    wk.add {
      mode = { 'n', 'v' },

      { '<C-a>', 'gg<S-v>G', desc = 'Select all' },
      { '<C-h>', '<C-w>h' },
      { '<C-j>', '<C-w>j' },
      { '<C-k>', '<C-w>k' },
      { '<C-l>', '<C-w>l' },
      { '<C-s>', '<cmd>update<cr>', desc = '[S]ave buffer' },
      { '<C-q>', '<cmd>q!<cr>', desc = '[Q]uit' },

      { '<leader><space>', group = 'Managers' },
      { '<leader><space>l', '<cmd>Lazy<cr>', desc = '[L]azy' },
      { '<leader><space>m', '<cmd>Mason<cr>', desc = '[M]ason' },
      { '<leader><space>n', '<cmd>NullLsInfo<cr>', desc = '[N]ull-ls Info' },

      -- BUFFER
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Move to Prev buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Move to Next buffer' },
      { '<A-p>', '<cmd>BufferLineTogglePin<cr>', desc = 'Pin current Buffer' },
      { '<leader>b', group = '[B]uffers' },
      { '<leader>bc', group = '[C]lose' },
      { '<leader>bcA', '<Cmd>Neotree reveal<CR> <bar> <Cmd>BufDelAll<CR>', desc = 'Close [A]ll buffers' },
      {
        '<leader>bca',
        '<Cmd>Neotree reveal<CR> <bar> <Cmd>BufDelOthers<CR>',
        desc = 'Close [a]ll but current buffer',
      },
      { '<leader>bco', '<Cmd>BufDelOthers<CR>', desc = 'Close [O]ther buffers' },
      { '<leader>bd', '<Cmd>BufDel<CR>', desc = '[D]elete current buffer' },

      -- LLM Gen. Not implemented for (Change, Change_Code, Generate, Make_Concise, Make_List,
      -- Make_Table)
      -- { '<leader>c[', "<cmd>'<,'>Gen<CR>", desc = 'LLM [C]ode Gen' },
      -- { '<leader>ca', "<cmd>'<,'>Gen Ask<CR>", desc = 'LLM Ask' },
      -- { '<leader>cc', "<cmd>'<,'>Gen Chat<CR>", desc = 'LLM Chat' },
      -- { '<leader>ce', "<cmd>'<,'>Gen Enhance_Code<CR>", desc = 'LLM Enhance Code' },
      -- { '<leader>cg', "<cmd>'<,'>Gen Enhance_Grammar_Spelling<CR>", desc = 'LLM Enhance Grammar Spelling' },
      -- { '<leader>cr', "<cmd>'<,'>Gen Review_Code<CR>", desc = 'LLM Review Code' },
      -- { '<leader>cs', "<cmd>'<,'>Gen Summarize<CR>", desc = 'LLM Summarize' },
      -- { '<leader>cw', "<cmd>'<,'>Gen Enhance_Wording<CR>", desc = 'LLM Enhance Wording' },

      -- Fuzzy finder
      { '<leader>f', group = '[F]uzzy finds' },
      { '<leader>fe', '<cmd>Neotree toggle<cr>', desc = 'Neotree [E]xplorer' },
      {
        '<leader>fF',
        function()
          require('telescope.builtin').find_files { hidden = true }
        end,
        desc = 'Fuzzy find hidden [F]iles',
      },
      { '<leader>fb', '<Cmd>Telescope buffers<CR>', desc = 'Toggle [B]uffers list' },
      { '<leader>fc', '<Cmd>Telescope commands<CR>', desc = 'Togle [C]ommands list' },
      { '<leader>fd', require('telescope.builtin').diagnostics, desc = '[D]iagnostics for current buffer' },
      { '<leader>fe', '<Cmd>Neotree toggle<CR>', desc = 'Neotree [E]xplorer' },
      { '<leader>ff', '<Cmd>Telescope find_files<CR>', desc = 'Fuzzy find [F]iles' },
      { '<leader>fh', '<Cmd>Telescope command_history<CR>', desc = 'Toggle command [H]istory' },
      { '<leader>fk', require('telescope.builtin').keymaps, desc = 'Lists normal mode [K]eymappings' },
      { '<leader>fm', '<Cmd>Telescope man_pages<CR>', desc = '[M]an Pages' },
      {
        '<leader>fn',
        require('telescope').extensions.notify.notify,
        desc = 'Show all [N]otifications in Telescope',
      },
      {
        '<leader>fr',
        '<Cmd>Telescope oldfiles<CR>',
        desc = 'Fuzzy find [R]ecent files',
      },
      { '<leader>ft', '<Cmd>TodoTelescope<CR>', desc = 'Open [T]odos' },
      {
        '<leader>fu',
        '<Cmd>Telescope undo<CR>',
        desc = 'Toggle [U]ndo tree',
      },
      { '<leader>fw', '<Cmd>Telescope live_grep<CR>', desc = 'Live grep [W]ord' },

      -- LSP
      { '<leader>l', group = '[L]sp' },
      {
        '<leader>lD',
        '<cmd>Telescope diagnostics bufnr=0<cr>',
        desc = 'Show buffer diagnostics',
      },
      {
        '<leader>la',
        vim.lsp.buf.code_action,
        desc = 'See available code [A]ctions',
      },
      {
        '<leader>ld',
        function()
          vim.diagnostic.open_float(nil, { border = 'single' })
        end,
        desc = 'Show line [D]iagnostics',
      },
      {
        '<leader>li',
        '<cmd>LspInfo<cr>',
        desc = 'LSP [I]nformation',
      },
      { '<leader>lr', vim.lsp.buf.rename, desc = 'Smart [R]ename' },
      { '<leader>ls', '<cmd>LspRestart<cr>', desc = 'Re[S]tart LSP' },

      -- Git sign
      {
        ']p',
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            require('gitsigns').nav_hunk 'next'
          end
        end,
        desc = 'Next hunk',
      },
      {
        '[p',
        function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            require('gitsigns').nav_hunk 'prev'
          end
        end,
        desc = 'Prev hunk',
      },
      { '<leader>g', group = '[G]it' },
      { '<leader>gg', '<Cmd>LazyGit<CR>', desc = 'Toggle Lazy[G]it' },
      { '<leader>gs', group = '[S]tage' },
      { '<leader>gsb', require('gitsigns').stage_buffer, desc = 'Git stage [B]uffer' },
      { '<leader>gsh', require('gitsigns').stage_hunk, desc = 'Git stage [H]unk' },
      { '<leader>gt', group = '[T]oggle' },
      {
        '<leader>gtD',
        function()
          require('gitsigns').diffthis '~'
        end,
        desc = "Toggle diffthis('~')",
      },
      { '<leader>gtd', require('gitsigns').diffthis, desc = 'Toggle diffthis' },
      { '<leader>gtt', require('gitsigns').preview_hunk_inline, desc = 'Toggle deleted' },
      { '<leader>gu', group = '[U]ndo' },
      { '<leader>gub', require('gitsigns').reset_buffer_index, desc = 'Git reset [B]uffer' },
      { '<leader>guh', require('gitsigns').stage_hunk, desc = 'Git reset [H]unk' },

      -- Markdown preview
      { '<leader>m', group = '[M]arkdown' },
      { '<leader>mS', '<cmd>MarkdownPreviewStop<CR>', desc = 'Markdown [S]top' },
      { '<leader>ms', '<cmd>MarkdownPreview<CR>', desc = 'Markdown [S]tart' },
      { '<leader>mt', '<cmd>MarkdownPreviewToggle<CR>', desc = 'Markdown [T]oggle' },

      -- Notify
      { '<leader>n', group = '[N]otify' },
      { '<leader>na', "<Cmd>lua require('noice').cmd('all')<CR>", desc = 'Noice [A]ll' },
      { '<leader>nd', "<Cmd>lua require('noice').cmd('dismiss')<CR>", desc = 'Noice [D]ismiss all' },
      { '<leader>nh', "<Cmd>lua require('noice').cmd('history')<CR>", desc = 'Noice [H]istory' },
      { '<leader>nl', "<Cmd>lua require('noice').cmd('last')<CR>", desc = 'Noice [L]ast message' },

      -- Obsidian
      { '<leader>o', group = '[O]bsidian' },
      { '<leader>ob', '<Cmd>ObsidianBacklinks<CR>', desc = 'Show Obsidian [B]acklinks' },
      {
        '<leader>oc',
        "<Cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
        desc = 'Toggle [C]heckbox',
      },
      { '<leader>ol', '<Cmd>ObsidianLinks<CR>', desc = 'Show Obsidian [L]inks' },
      { '<leader>on', '<Cmd>ObsidianNew<CR>', desc = 'Create [N]ew Note' },
      { '<leader>oN', '<Cmd>ObsidianToday<CR>', desc = 'Create [N]ew Daily Note' },
      { '<leader>oo', '<Cmd>ObsidianOpen<CR>', desc = '[O]pen in Obsidian App' },
      { '<leader>oq', '<Cmd>ObsidianQuickSwitch<CR>', desc = '[Q]uick switch' },
      { '<leader>os', '<Cmd>ObsidianSearch<CR>', desc = '[S]earch Obsidian' },
      { '<leader>ot', '<Cmd>ObsidianTags<CR>', desc = 'Get [T]ag list' },
      { '<leader>ow', '<Cmd>ObsidianWorkspace<CR>', desc = 'Switch [W]orkspace' },

      -- GOTO
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto declaration' },
      { 'gd', vim.lsp.buf.definition, desc = 'Goto definition' },
      { 'gi', vim.lsp.buf.implementation, desc = 'Goto implementation' },
      { 'gr', vim.lsp.buf.references, desc = 'Goto references' },
      { 'gt', vim.lsp.buf.type_definition, desc = 'Goto type definition' },

      -- Folds
      { 'zM', require('ufo').closeAllFolds, desc = 'Close all folds' },
      { 'zR', require('ufo').openAllFolds, desc = 'Open all folds' },
    }
  end,
}
