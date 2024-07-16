-- TAG: UI

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			globalstatus = true,
			disable_filetypes = { statusline = { "lazy", "alpha", "starter" } },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					icon = " ",
					separator = { left = "", right = "" },
					color = { fg = "#1e1e2e", bg = "#b4befe" },
				},
			},
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = {
				{
					"filetype",
					icon_only = true,
					separator = "",
					padding = { left = 1, right = 0 },
				},
				{
					"filename",
					path = 1,
					symbols = {
						modified = " ",
						readonly = "",
						unnamed = "",
					},
				},
			},
			lualine_x = {
				{
					function()
						return require("dap").status()
					end,
					cond = function()
						return package.loaded["dap"] and require("dap").status() ~= ""
					end,
				},
				{
					function()
						return require("noice").api.status.mode.get()
					end,
					cond = function()
						return package.loaded["noice"] and require("noice").api.status.mode.has()
					end,
				},
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff9e64" },
				},
				{
					"diff",
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
				},
				{
					function()
						local msg = "LS Inactive"
						local buf_clients = vim.lsp.get_clients()
						if next(buf_clients) == nil then
							if type(msg) == "boolean" or #msg == 0 then
								return "LS Inactive"
							end
						end
						local buf_client_names = {}

						for _, client in pairs(buf_clients) do
							table.insert(buf_client_names, client.name)
						end

						local unique_client_names = vim.fn.uniq(buf_client_names)
						local language_servers = table.concat(unique_client_names, ", ")

						return language_servers
					end,
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
			lualine_y = {
				{
					"progress",
					separator = "",
					padding = { left = 1, right = 0 },
					color = { fg = "#1e1e2e", bg = "#eba0ac" },
				},
				{
					"location",
					padding = { left = 0, right = 1 },
					color = { fg = "#1e1e2e", bg = "#eba0ac" },
				},
			},
			lualine_z = {
				{
					function()
						return " " .. os.date("%R")
					end,
					color = { fg = "#1e1e2e", bg = "#f2cdcd" },
				},
			},
		},
	},
	config = function(_, opts)
		require("lualine").setup(opts)
	end,
}
