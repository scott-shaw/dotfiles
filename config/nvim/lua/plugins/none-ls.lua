return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black.with({
                    extra_args = {"--line-length 120 --preview"}
                }),
				null_ls.builtins.diagnostics.mypy.with({
                    extra_args = {"--ignore-missing-imports"}
                }),
				null_ls.builtins.diagnostics.ruff.with({
                    extra_args = {"--line-length 120"}
                }),
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
