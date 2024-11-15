return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    path_display = { "smart" },
                    layout_config = {
                        horizontal = { width = 0.95 },
                        preview_cutoff = 10,
                    },
                },
            })
        end,
    },
}
