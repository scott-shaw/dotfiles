return {
	"princejoogie/dir-telescope.nvim",
	-- telescope.nvim is a required dependency
	requires = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("dir-telescope").setup({
			-- these are the default options set
			hidden = true,
			no_ignore = true,
			show_preview = true,
			follow_symlinks = false,
		})
	end,
}
