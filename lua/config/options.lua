-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Add Mason bin directory to PATH so formatters/LSPs installed via Mason are executable
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
