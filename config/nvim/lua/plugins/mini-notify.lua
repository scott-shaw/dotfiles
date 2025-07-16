return {
	"echasnovski/mini.notify",
    version = false,
	config = function()
		require("mini.notify").setup({
			content = {
				-- Function which formats the notification message
				-- By default prepends message with notification time
				format = nil,

				-- Function which orders notification array from most to least important
				-- By default orders first by level and then by update timestamp
				sort = nil,
			},
			lsp_progress = {
				-- Whether to enable showing
				enable = true,
				-- Duration (in ms) of how long last message should be shown
				duration_last = 1000,
			},
			window = {
				config = function()
					local has_statusline = vim.o.laststatus > 0
					local bottom_space = vim.o.cmdheight + (has_statusline and 1 or 0)
					return { anchor = "SE", col = vim.o.columns, row = vim.o.lines - bottom_space }
				end,
			},
		})
		vim.notify = require("mini.notify").make_notify({
			ERROR = { duration = 10000, hl_group = "DiagnosticError" },
			WARN = { duration = 2000, hl_group = "DiagnosticWarn" },
			INFO = { duration = 2000, hl_group = "DiagnosticInfo" },
			DEBUG = { duration = 1000, hl_group = "DiagnosticHint" },
			TRACE = { duration = 1000, hl_group = "DiagnosticOk" },
			OFF = { duration = 1000, hl_group = "MiniNotifyNormal" },
		})
	end,
}
