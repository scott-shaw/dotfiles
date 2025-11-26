return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_install = {
					"bashls",
					"black",
					"clangd",
					"lemminx",
					"lua_ls",
					"marksman",
					"mypy",
					"pylsp",
					"ruff",
					"shellcheck",
					"shfmt",
					"stylua",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { 'saghen/blink.cmp' },
		lazy = false,
		config = function()
			-- Lua
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.enable({ "lua_ls" })

			-- C++
			vim.lsp.config("clangd", {
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
			vim.lsp.enable({ "clangd" })

			-- Python
			vim.lsp.config("pylsp", {
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
							pycodestyle = { enabled = true, maxLineLength=120, ignore={"E266", "W503"} },
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
			vim.lsp.enable({ "pylsp" })

			-- Bash
			vim.lsp.config("bashls", {})
			vim.lsp.enable({ "bashls" })
		end,
	},
}
