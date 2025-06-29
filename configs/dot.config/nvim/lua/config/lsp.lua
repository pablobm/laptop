-- Always show LSP status column, to avoid expand-collapse
vim.o.signcolumn = "yes"

-- Manual enable of LSPs
vim.api.nvim_create_user_command(
  "EnableLsp",
  function(opts)
    vim.lsp.enable(opts.args)
  end,
  { nargs = 1 }
)

-- Format file
vim.api.nvim_create_user_command(
  "Fix",
  function()
    vim.lsp.buf.format()
  end,
  {}
)
