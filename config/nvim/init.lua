-- ==================================================================
-- | NEOVIM CONFIG                                                  |
-- | Scott Shaw                                                     |
-- | Jul 20 2023                                                    |
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
vim.bo.undofile=true

-- Open neotree if no file is given
vim.api.nvim_create_augroup("neotree", {})
vim.api.nvim_create_autocmd("UiEnter", {
    group = "neotree",
    callback = function()
    if vim.fn.argc() == 0 then
	vim.cmd [[Neotree toggle]]
    end
  end,
})

-- set color scheme
vim.cmd [[colorscheme tokyonight-night]]

 -- KEYBINDINGS
local map = require("utils.keys").map
map("i", "jk", "<esc>")

map("n", "<C-Left>", ":tabprevious<CR>", "move to left tab")
map("n", "<C-Right>", ":tabnext<CR>", "move to right tab")

map("n", "<C-s>", ":Telescope live_grep<CR>", "search through all files")

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<S-Left>", "^", "Go to beginning of line")
map("n", "<S-Right>", "$", "Go to end of line")

