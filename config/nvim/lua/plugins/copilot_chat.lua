return {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
        model = 'gpt-5',

        window = {
            layout = "vertical", -- 'vertical', 'horizontal', 'float'
            width = 0.5, -- 50% of screen width
        },

        headers = {
            user = ' ', -- Header to use for user questions
            assistant = '  ' , -- Header to use for AI answers
            tool = ' ', -- Header to use for tool calls
          },

        separator = "━━",
        show_folds = true, -- Disable folding for cleaner look
        auto_insert_mode = false, -- Enter insert mode when opening
    },
}
