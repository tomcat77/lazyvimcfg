-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Add Mason bin directory to PATH so formatters/LSPs installed via Mason are executable
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

-- Check Russian and English text in buffers where LazyVim enables spell checking.
vim.opt.spelllang = { "ru", "en" }

if vim.env.TERM_PROGRAM == "ghostty" or vim.env.TERM == "xterm-ghostty" then
    vim.opt.titlestring = [[nvim@%{strtrans(get(split(getcwd(-1), '/'), -1, '/'))}]]
    vim.opt.titlelen = 0
    vim.opt.title = true
end
