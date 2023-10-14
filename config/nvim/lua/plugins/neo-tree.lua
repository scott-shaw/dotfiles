-- Nicer filetree than NetRW
return {{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
    },
    config = function() require("neo-tree").setup({
	close_if_last_window = true,
	popup_border_style = "rounded",
	window = {
	    position = "float",
	    width = 24,
	},
	filesystem = {
	    filtered_items = {
		visible = true,
		hide_dotfiles = false,
		hide_gitignored = false,
	    },
	},
    })
    require("utils.keys").map(
	{ "n", "v" },
	"<C-a>", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer"
    )
    end,},
}
