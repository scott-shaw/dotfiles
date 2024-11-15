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
                    -- "--background-index",
                    -- "--suggest-missing-includes",
                    -- "--compile-commands-dir=/home/sshaw/bdai",
                },
                filetypes = { "c", "cpp", "objc", "objcpp" },
            })
            lspconfig.pylsp.setup({
                capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            -- linter options
                            pylint = {
                                enabled = false,
                                executable = "pylint",
                                maxLineLength = 120,
                            },
                            pycodestyle = {
                                enabled = true,
                                maxLineLength = 120,
                            },
                            flake8 = {
                                enabled = true,
                                maxLineLength = 120,
                            },
                            -- type checker
                            pylsp_mypy = { enabled = false },
                            -- auto-completion options
                            jedi_completion = { fuzzy = true },
                            -- import sorting
                            pyls_isort = { enabled = false },
                        },
                    },
                },
            })
            -- lspconfig.jedi_language_server.setup({
            --     capabilities = capabilities,
            -- })
            -- lspconfig.pyright.setup({
            --     capabilities = capabilities,
            --     -- root_dir = vim.loop.cwd(),
            --     -- root_files = {
            --     --     "pyproject.toml",
            --     --     "setup.py",
            --     --     "setup.cfg",
            --     --     "requirements.txt",
            --     --     "Pipfile",
            --     --     "pyrightconfig.json",
            --     -- },
            --     settings = {
            --         python = {
            --             analysis = {
            --                 autoSearchPaths = true,
            --                 diagnosticMode = "openFilesOnly",
            --                 useLibraryCodeForTypes = true,
            --                 enableReachabilityAnalysis = false,
            --                 strictParameterNoneValue = false,
            --                 reportMissingImports = "warning",
            --                 reportUnusedVariable = "information",
            --                 -- reportDuplicateImport = "information",
            --                 extraPaths = {
            --                     "~/bdai/projects/watch_understand_do/ws/src/wud_ros/wud_ros/",
            --                     "~/bdai/projects/watch_understand_do/ws/src/wud_ros/",
            --                     "~/bdai/projects/watch_understand_do/ws/src/wud_msgs/srv/",
            --                     "~/bdai/projects/watch_understand_do/ws/src/wud_msgs/",
            --                     "~/bdai/projects/watch_understand_do/**",
            --                     "~/bdai/ws/src/external/ros_utilities/bdai_ros2_wrappers/",
            --                     "~/bdai/ws/src/external/ros_utilities/",
            --                     "~/bdai/ws/src/external/ros_utilities/**",
            --                     "~/bdai/ws/src/external/",
            --                     "~/bdai/ws/src/spot_utilities/spot_utilities/",
            --                     "~/bdai/ws/src/spot_utilities/",
            --                     "~/bdai/ws/src/spot_utilities_msgs/",
            --                     "~/bdai/ws/src/bdai_ros/bdai_ros/",
            --                     "~/bdai/ws/src/bdai_ros/",
            --                     "~/bdai/ws/src/lat_msgs/",
            --                     "~/bdai/ws/src/**",
            --                 },
            --             },
            --         },
            --     },
            -- })
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
        end,
    },
}
