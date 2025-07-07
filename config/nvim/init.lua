-- ==================================================================
-- | NEOVIM CONFIG                                                  |
-- | Scott Shaw                                                     |
-- | Mar 27 2025                                                    |
-- ==================================================================

require("utils.lazy")

-- +++++++++++++++++++++++++ Keybindings +++++++++++++++++++++++++
-- General
-- Block indent
-- shift-v to select, < or > to indent block

-- Multi-cursor
-- ctrl-v to select, shift-i to go to INSERT, type, press ESC
-- ctrl-v to select, d to delete

-- Comments
-- Block comment/uncomment
-- ctrl-v move up/down, shift-i, make changes, esc
-- ctrl-v move up/down/left/right, x to delete
--
-- Using comment.nvim
-- select lines in VISUAL, gc to linewise comment, gb to blockwise comment

-- Navigation
-- :w : save
-- :wq/ZZ : save and quit
-- :q/ZQ : quit

-- /<keyword> : search in file (n for next match, N for previous match)
-- :nohl : remove highlights (useful after search)

-- ctrl-w + left/right : change windows (good from navigating to aerial)
-- <number> + down/up (or j/k) : jump <number> lines relative to current line
-- ctrl-w + v/s : split window vertically/horizontally
-- shift + left/right : jump to front of next word
-- ctrl + shift + left/right : jump to front/end of line

-- Flash
-- s : jump

-- ctrl-a : file tree
-- return : open
-- t : open in new tab
-- a : create new file / directory (if name ends with /)
-- r : rename
-- d : delete (careful this is rm)
-- m : move
-- ctrl-s : grep
-- ctrl-f : file search
-- ctrl-d : recent files
-- for previous three:
-- return : open
-- ctrl-t : open in new tab
-- ctrl-e : aerial (show file structure)
-- return: jump to line
-- <leader>-ww : open wiki
-- <leader>-wt : open wiki in new tab

-- Info
-- ctrl-o : show codeowners
-- ctrl-b : git blame
-- ctrl-h : show file history
-- <leader>-d : show git diff for file

-- Automation
-- ctrl-l : autoformat
-- ctrl-g : generate docstring template

-- Plugins
-- :Lazy (package manager)
-- :Mason (manage language servers)
-- :LspInfo (check lsp server info)
-- :Glow (preview markdown)

-- +++++++++++++++++++++++++ Vim Settings +++++++++++++++++++++++++
vim.o.mouse="a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.ttyfast = true
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.treesitter.language.register('markdown', 'vimwiki')

-- persistent undos
vim.bo.undofile = true

-- sidebar error symbols
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "",
        }
    }
})

-- set color scheme
vim.cmd.colorscheme "catppuccin"

-- +++++++++++++++++++++++++ Set Keybindings +++++++++++++++++++++++++
local map = require("utils.keys").map
map("i", "jk", "<esc>")

-- select, yank, replace
map("n", "<leader>v", "viw")
map("n", "<leader>y", "yiw")
map("n", "<leader>r", ":%s/<C-R><C-W>/")
-- reload file
map("n", "<leader>e", ":edit!<CR>")

-- search
-- map("n", "<C-s>", ":Telescope live_grep<CR>", "Live grep")
map("n", "<C-f>", ":Telescope find_files<CR>", "Search for files")
map("n", "<C-d>", ":Telescope oldfiles<CR>", "Look through recent files")
map("n", "<C-s>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

map("n", "<C-S-s>", "<cmd>Telescope live_grep<CR>")
map("n", "<C-S-f>", "<cmd>Telescope find_files<CR>", "Search for files")

-- indentation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- navigation
map("n", "<C-Left>", ":tabprevious<CR>", "Move to left tab")
map("n", "<C-Right>", ":tabnext<CR>", "Move to right tab")

map("n", "<C-S-Left>", "^", "Go to beginning of line")
map("n", "<C-S-Right>", "$", "Go to end of line")

map("n", "<S-Left>", "B", "Previous word")
map("n", "<S-Right>", "W", "Next word")

-- open file tree
map({ "n", "v" }, "<C-a>", "<cmd>NeoTreeRevealToggle<cr>", "Toggle file explorer")

-- git history and blame
map("n", "<C-b>", ":BlameToggle<CR>", "Toogle git blame")
map("n", "<C-h>", ":DiffviewOpen origin/main<CR>", "View file history for the current branch")

-- git code owners
map("n", "<C-o>", ":GhCoWho<CR>", "View file history for the current branch")

-- Neogen
map("n", "<C-g>", ":Neogen<CR>", "Generate docstring template")

-- Aerial
map("n", "<C-e>", ":AerialToggle<CR>", "Generate docstring template")
map("n", "ZZ", ":AerialClose<CR> <BAR> ZZ", "Rebind close & save to also close aerial")
map("n", "ZQ", ":AerialClose<CR> <BAR> ZQ", "Rebind close to also close aerial")

-- Wiki
map("n", "<leader>w", "<leader>wt", "open wiki in new tab")

-- jump to definition
map('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>')
map('n', 'gt', '<cmd>tab split | lua vim.lsp.buf.type_definition()<CR>')
