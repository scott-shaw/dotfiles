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
                    vimgrep_arguments = {
                        "rg",
                        "--follow", -- Follow symbolic links
                        "--hidden", -- Search for hidden files
                        "--no-heading", -- Don't group matches by each file
                        "--with-filename", -- Print the file path with the matched lines
                        "--line-number", -- Show line numbers
                        "--column", -- Show column numbers
                        "--smart-case", -- Smart case search

                        -- Exclude some patterns from search
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/build/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/yarn.lock",
                        "--glob=!**/package-lock.json",
                    },
                },
            })
        end,
    },
}
