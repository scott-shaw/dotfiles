return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        require("catppuccin").setup({
            flavour = "mocha",
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    aerial = true,
                    alpha = true,
                    diffview = true,
                    markdown = true,
                    mason = true,
                    vimwiki = true,
                    which_key = true,
                    -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
                },
        })
    end
}
