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
                    --"jedi_language_server",
                    "bashls",
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
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                maxLineLength = 120,
                            },
                            flake8 = {
                                enabled = true,
                                maxLineLength = 120,
                            }
                        }
                    }
                }
            })
            --lspconfig.jedi_language_server.setup({
            --    capabilities = capabilities,
            --})
            lspconfig.bashls.setup({
                capabilities = capabilities,
            })
		end,
	},
}
