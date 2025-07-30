-- Show line numbers
vim.o.nu = true

-- Indent with 2 spaces
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- Use the system clipboard.
-- Taken from Julia Evans's "The Secrets Rules of the Terminal"
vim.o.clipboard = "unnamed"

-- lazy.vim
require("config.lazy")
require("config.lsp")
require("config.cmp")
require("config.terminal")
