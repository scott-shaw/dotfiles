local M = {}

function M.map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

function M.set_leader(key)
    vim.g.mapleader = key
    vim.g.maplocalleader = key
    M.map({ "n", "v" }, key, "<nop>")
end

return M
