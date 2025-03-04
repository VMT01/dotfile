-- INFO: TOOLS

return {
  "stevearc/conform.nvim",
  event = { "LspAttach", "BufReadPost", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      cmake = { "cmake_format" },
      lua = { "stylua" },
      go = { "goimports", "gofumpt", "goimports_reviser", "golines" },
      python = { "isortd", "blackd" },
      proto = { "buf" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      css = { "prettierd" },
      scss = { "prettierd" },
      less = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      -- ["*"] = { "prettierd" },
    },
    default_format_opts = { lsp_format = "fallback" },
    format_on_save = { lsp_format = "fallback", timeout_ms = 500 },
    format_after_save = { async = true, lsp_format = "fallback" },
  },
}
