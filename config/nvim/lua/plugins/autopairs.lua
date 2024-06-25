return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
    opts = {
        disable_filetype = { "TelescopePrompt", "text", "markdown" },
    },
}
