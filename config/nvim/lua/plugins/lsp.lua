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
                    "shellcheck",
                    "shfmt",
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
                    "pylsp",
                    "jedi_language_server",
                    "bashls",
                    "pyright",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                    },
                },
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    '--query-driver=/usr/bin/c++',
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            black = {
                                enabled = false,
                            },
                            ruff = {
                                enabled = true,
                            },
                            pylint = {
                                enabled = false,
                            },
                            pycodestyle = {
                                enabled = false,
                            },
                            flake8 = {
                                enabled = false,
                            },
                            -- type checker
                            pylsp_mypy = { enabled = false},
                            -- auto-completion options
                            jedi_completion = { fuzzy = true },
                            -- import sorting
                            pyls_isort = { enabled = false },
                        },
                    },
                },
                flags = {
                    debounce_text_changes = 250,
                },
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
        end,
    },
}
