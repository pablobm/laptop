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

function rubocop_yml_present(true_or_false)
  return function(bufnr, on_dir)
    file_path = vim.fn.bufname(bufnr)
    _root_dir = vim.fs.root(file_path, {"Gemfile", ".git"})
    _rubocop_yml_present = not not vim.uv.fs_stat(_root_dir .. "/.rubocop.yml")
    if true_or_false == _rubocop_yml_present then
      on_dir(vim.fn.getcwd())
    end
  end
end

vim.lsp.config("rubocop", {
  filetypes = { "ruby" },
  root_dir = rubocop_yml_present(true)
})

vim.lsp.config("standardrb", {
  filetypes = { "ruby" },
  root_dir = rubocop_yml_present(false)
})
