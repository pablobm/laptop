-- Show line numbers
vim.o.nu = true

-- Indent with 2 spaces
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- lazy.vim
require("config.lazy")
require("config.lsp")
require("config.cmp")
