return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        require('aerial').setup({
            open_automatic = true,
            close_automatic_events = {
                "unfocus",
                "switch_buffer",
            },
        })
    end,
}
