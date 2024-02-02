return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require("mason").setup({
                ensure_install = {
                    "mypy",
                    "ruff",
                    "black",
                    "stylua",
                },
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_install = {
                    "lua_ls",
                    "clangd",
                    "pyright",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
            })
            lspconfig.clangd.setup({})
            lspconfig.pyright.setup({})
        end,
    },
}
