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

vim.lsp.config("rubocop", {
  filetypes = { "ruby" },
  root_dir = function(bufnr, on_dir)
    file_path = vim.fn.bufname(bufnr)
    root_dir = vim.fs.root(file_path, {"Gemfile", ".git"})
    if vim.uv.fs_stat(root_dir .. "/.rubocop.yml") then
      vim.print("RUBOCOP!")
      on_dir(vim.fn.getcwd())
    end
  end
})

vim.lsp.config("standardrb", {
  filetypes = { "ruby" },
  root_dir = function(bufnr, on_dir)
    file_path = vim.fn.bufname(bufnr)
    root_dir = vim.fs.root(file_path, {"Gemfile", ".git"})
    if not vim.uv.fs_stat(root_dir .. "/.rubocop.yml") then
      vim.print("STANDARDRB!")
      on_dir(vim.fn.getcwd())
    end
  end
})
