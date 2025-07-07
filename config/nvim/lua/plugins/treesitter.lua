return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
				ensure_installed = { "c", "lua", "vim", "python", "markdown", "markdown_inline", "latex" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true, disable = { "python" } },
			})
		end,
	},
}
