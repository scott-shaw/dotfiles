-- ==================================================================
-- | NEOVIM CONFIG                                                  |
-- | Scott Shaw                                                     |
-- | Jan 29 2024                                                    |
-- | Based on: https://github.com/frans-johansson/lazy-nvim-starter |
-- ==================================================================

require("utils.lazy")

-- VIM SETTINGS
vim.o.number = true
vim.o.ttyfast = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.signcolumn = "yes"

-- persistent undos
vim.bo.undofile = true

-- sidebar error symbols
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

-- set color scheme
vim.cmd([[colorscheme tokyonight-night]])

-- KEYBINDINGS
local map = require("utils.keys").map
map("i", "jk", "<esc>")

map("n", "<C-Left>", ":tabprevious<CR>", "move to left tab")
map("n", "<C-Right>", ":tabnext<CR>", "move to right tab")

map("n", "<C-s>", ":Telescope live_grep<CR>", "search through all files")
map("n", "<C-f>", ":Telescope find_files<CR>", "search for files")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-S-Left>", "^", "Go to beginning of line")
map("n", "<C-S-Right>", "$", "Go to end of line")

map("n", "<S-Left>", "B", "prev word")
map("n", "<S-Right>", "W", "next word")

map({ "n", "v" }, "<C-a>", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer")
