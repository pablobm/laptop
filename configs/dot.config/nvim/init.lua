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

-- updatetime: time between last keystroke and CursorHold firing.
-- I have an event on CursorHold elsewhere, but
-- this has to be set early on or it won't work.
-- Note that this affects other behaviours. A too-short
-- value could lead to bad performance.
vim.o.updatetime = 300

-- Remove trailing space on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- lazy.vim
require("config.lazy")
require("config.lsp")
require("config.cmp")
require("config.terminal")
