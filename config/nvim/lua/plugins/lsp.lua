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
		dependencies = { "saghen/blink.cmp" },
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
				init_option = { fallbackFlags = { "-std=c++20" } },
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
							pycodestyle = { enabled = true, maxLineLength = 120, ignore = { "E266", "W503", "E203" } },
							ruff = { enabled = false, extendSelect = { "I" }, format = { "I" } },
							-- type checker
							pylsp_mypy = { enabled = false, live_mode = false, dmypy = true, report_progress = false },
							-- auto-completion options
							jedi_completion = { fuzzy = false },
							-- import sorting
							pyls_isort = { enabled = false },
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
	-- Conform: Formatter
	{
		"stevearc/conform.nvim",
		keys = {
			{
				"<C-l>",
				function()
					require("conform").format({ lsp_fallback = true })
				end,
				mode = { "n", "v" },
				desc = "Format file or range",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "black", "ruff_organize_imports", "ruff_format" },
				sh = { "shfmt" },
				bash = { "shfmt" },
			},

			formatters = {
				black = {
					prepend_args = { "--line-length", "120", "--preview" },
				},
			},
		},
	},
	-- Nvim-lint: Linter
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require('lint')
			lint.linters_by_ft = {
				python = { "mypy" },
				javascript = { "eslint_d" },
			}

			local mypy = lint.linters.mypy
			mypy.args = {
				"--ignore-missing-imports",
				"--show-column-numbers",
				"--show-error-codes",
				"--hide-error-context",
				"--no-color",
				"--no-error-summary",
			}

			-- Trigger linting on save and buffer write
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
