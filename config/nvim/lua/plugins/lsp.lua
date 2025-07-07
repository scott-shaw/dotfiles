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
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--function-arg-placeholders",
					"--query-driver=/usr/bin/c++",
					"--completion-style=detailed",
					"--fallback-style=llvm",
				},
				filetypes = { "c", "cpp", "objc", "objcpp" },
				init_option = { fallbackFlags = { '-std=c++20' } },
			})
			lspconfig.pylsp.setup({
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							-- formatter options
							black = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- linter options
							pylint = { enabled = false, executable = "pylint" },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = true, maxLineLength=120, ignore={"E266"} },
							ruff = { enabled = true },
							-- type checker
							pylsp_mypy = { enabled = false, live_mode = false, dmypy = true, report_progress = false },
							-- auto-completion options
							jedi_completion = { fuzzy = false },
							-- import sorting
							pyls_isort = { enabled = true },
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
