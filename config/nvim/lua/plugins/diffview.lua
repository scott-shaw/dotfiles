return {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>d", "<cmd>DiffviewOpen<cr>" },
        { "<esc>",     "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>" },
    },
    opts = {},
}
