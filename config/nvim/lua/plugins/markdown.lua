return {
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
    name = "render-markdown",                                                    -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
    config = function()
        require("render-markdown").setup({
            file_types = { "markdown", "vimwiki" },
            heading = {
                -- Turn on / off heading icon & background rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = true,
                -- Replaces '#+' of 'atx_h._marker'
                -- The number of '#' in the heading determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- The result is left padded with spaces to hide any additional '#'
                icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " },
                -- Added to the sign column if enabled
                -- The 'level' is used to index into the array using a cycle
                signs = { "󰉴 " },
                -- The 'level' is used to index into the array using a clamp
                -- Highlight for the heading icon and extends through the entire line
                backgrounds = {
                    "RenderMarkdownH1Bg",
                    "RenderMarkdownH2Bg",
                    "RenderMarkdownH3Bg",
                    "RenderMarkdownH4Bg",
                    "RenderMarkdownH5Bg",
                    "RenderMarkdownH6Bg",
                },
                -- The 'level' is used to index into the array using a clamp
                -- Highlight for the heading and sign icons
                foregrounds = {
                    "RenderMarkdownH1",
                    "RenderMarkdownH2",
                    "RenderMarkdownH3",
                    "RenderMarkdownH4",
                    "RenderMarkdownH5",
                    "RenderMarkdownH6",
                },
            },

            code = {
                -- Turn on / off code block & inline code rendering
                enabled = true,
                -- Turn on / off any sign column related rendering
                sign = true,
                -- Determines how code blocks & inline code are rendered:
                --  none: disables all rendering
                --  normal: adds highlight group to code blocks & inline code, adds padding to code blocks
                --  language: adds language icon to sign column if enabled and icon + name above code blocks
                --  full: normal + language
                style = "full",
                -- Amount of padding to add to the left of code blocks
                left_pad = 4,
                -- Determins how the top / bottom of code block are rendered:
                --  thick: use the same highlight as the code body
                --  thin: when lines are empty overlay the above & below icons
                border = "thick",
                -- Used above code blocks for thin border
                above = "▄",
                -- Used below code blocks for thin border
                below = "▀",
                -- Highlight for code blocks & inline code
                highlight = "RenderMarkdownCode",
            },

            checkbox = {
                -- Turn on / off checkbox state rendering
                enabled = true,
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'
                    icon = "󰄱 ",
                    -- Highlight for the unchecked icon
                    highlight = "RenderMarkdownUnchecked",
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'
                    icon = "󰱒 ",
                    -- Highligh for the checked icon
                    highlight = "RenderMarkdownChecked",
                },
                -- Define custom checkbox states, more involved as they are not part of the markdown grammar
                -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
                -- Can specify as many additional states as you like following the 'todo' pattern below
                --   The key in this case 'todo' is for healthcheck and to allow users to change its values
                --   'raw': Matched against the raw text of a 'shortcut_link'
                --   'rendered': Replaces the 'raw' value when rendering
                --   'highlight': Highlight for the 'rendered' icon
                custom = {
                    todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
                },
            },

            bullet = {
                -- Turn on / off list bullet rendering
                enabled = true,
                -- Replaces '-'|'+'|'*' of 'list_item'
                -- How deeply nested the list is determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
                icons = { "●", "○", "◆", "◇" },
                -- Highlight for the bullet icon
                highlight = "RenderMarkdownBullet",
            },

            link = {
                -- Turn on / off inline link icon rendering
                enabled = true,
                -- Inlined with 'image' elements
                image = "󰥶 ",
                -- Inlined with 'inline_link' elements
                hyperlink = "󰌹 ",
                -- Applies to the inlined icon
                highlight = "RenderMarkdownLink",
            },

            quote = {
                -- Turn on / off block quote & callout rendering
                enabled = true,
                -- Replaces '>' of 'block_quote'
                icon = "▋",
                -- Highlight for the quote icon
                highlight = "RenderMarkdownQuote",
            },

            dash = {
                -- Turn on / off thematic break rendering
                enabled = true,
                -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
                -- The icon gets repeated across the window's width
                icon = "─",
                -- Highlight for the whole line generated from the icon
                highlight = "RenderMarkdownDash",
            },
        })
    end,
    {
        "nfrid/markdown-togglecheck",
        dependencies = { "nfrid/treesitter-utils" },
        ft = { "markdown" },
    },
}
