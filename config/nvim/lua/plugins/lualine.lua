return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "tokyonight",
				component_separators = "|",
				section_separators = "",
			},
			sections = {
				lualine_b = {
					"branch",
					{
						'diff',
						colored = true,
						diff_color = {
							added    = 'LuaLineDiffAdd',
							modified = 'LuaLineDiffChange',
							removed  = 'LuaLineDiffDelete',
						},
						symbols = { added = '+', modified = '~', removed = '-' },
						source = nil,
					},
					{
						"diagnostics",
						sections = { "error", "warn", "info", "hint" },
						symbols = { error = " ", warn = " ", info = " ", hint = "" },
						colored = true,
						update_in_insert = true,
						always_visible = false,
					},
				},
				lualine_x = {
					{
						"datetime",
						style = "%m/%d/%Y %H:%M",
					},
					"fileformat",
					{
						"filetype",
						colored = true,
						icon_only = false,
						icon = { align = "right" },
					},
				},
			},
		})
	end,
}
