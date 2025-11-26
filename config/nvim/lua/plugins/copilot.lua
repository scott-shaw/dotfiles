return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                enabled = true,
                auto_trigger = false, -- Prevent automatic suggestions
                keymap = {
                    accept = "<C-q>", -- Example: Accept suggestion with Ctrl+J
                    dismiss = "<C-S-q>",
                },
            },
        })
    end,
}
