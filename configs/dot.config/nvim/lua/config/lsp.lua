--
-- With help from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
--

-- Always show LSP status column, to avoid expand-collapse
vim.o.signcolumn = "yes"

-- updatetime: set updatetime for CursorHold
-- vim.api.nvim_set_option("updatetime", 300) 

vim.api.nvim_create_autocmd(
  "CursorHold", {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(nil, { focusable = false })
    end,
  }
)

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
