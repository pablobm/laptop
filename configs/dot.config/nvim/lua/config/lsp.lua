--
-- With help from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
--

-- Always show LSP status column, to avoid expand-collapse
vim.o.signcolumn = "yes"

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

if vim.uv.fs_stat(".rubocop.yml") then
  vim.lsp.enable("rubocop")
else
  vim.lsp.enable("standardrb")
end
