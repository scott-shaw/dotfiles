return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.black.with({
                    extra_args = { "--line-length 120 --preview" }
                }),
                null_ls.builtins.diagnostics.mypy.with({
                    extra_args = { "--ignore-missing-imports" }
                }),
                null_ls.builtins.formatting.shfmt,
                -- null_ls.builtins.diagnostics.clang_check,
                -- null_ls.builtins.formatting.clang_format,
            },
        })
        vim.keymap.set("n", "<C-l>", vim.lsp.buf.format, {})
    end,
}
