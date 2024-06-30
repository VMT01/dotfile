local package = require("core.pack").package
local conf = require("modules.tools.config")

package({
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    cmd = "Telescope",
    config = conf.telescope,
})

package({
    "debugloop/telescope-undo.nvim",
    event = "BufReadPost",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = conf.telescope_undo,
})

package({
    "nvim-telescope/telescope-fzf-native.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    build =
    "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    config = conf.telescope_fzf_native,
})

package({
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = conf.telescope_ui_select,
})

package({
    "dharmx/telescope-media.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    config = conf.telescope_media,
})

package({
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    config = conf.lazygit,
})

package({
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/nvim-cmp" }, -- Optional dependency
    config = conf.autopairs,
})

package({
    "tpope/vim-surround",
    event = "VeryLazy",
})

package({
    "numToStr/Comment.nvim",
    event = { "BufEnter" },
    config = conf.comment,
})

package({
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost" },
    config = conf.todo_comment,
})

package({
    "zeioth/garbage-day.nvim",
    event = "BufReadPost",
    config = conf.garbage_day,
})

package({
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    ft = { "markdown" },
})

package({
    "RRethy/vim-illuminate",
    event = "VeryLazy",
    config = conf.vim_illuminate,
})
