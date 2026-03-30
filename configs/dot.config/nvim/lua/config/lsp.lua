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

local function rubocop_yml_expected(expecting_rubocop_yml)
  return function(bufnr, on_dir)
    -- Get the name of the current buffer. This will be a full path if a file
    local file_path = vim.fn.bufname(bufnr)

    -- Traverse directories up the hierarchy until one of Gemfile or .git is found.
    -- This should be the root of the project.
    local _root_dir = vim.fs.root(file_path, {"Gemfile", ".git"})

    -- Is there a .rubocop.yml at the root?
    local _rubocop_yml_present = not not (_root_dir and vim.uv.fs_stat(_root_dir .. "/.rubocop.yml"))

    -- Assuming that a _root_dir was found
    -- If there is a .rubocop.yml AND we expected it to be present, call on_dir().
    -- If there is NO .rubocop.yml AND we did NOT expect it, also call on_dir().
    -- Otherwise, do nothing.
    if _root_dir and expecting_rubocop_yml == _rubocop_yml_present then
      -- Notify that we found an appropriate root dir
      on_dir(vim.fn.getcwd())
    end
  end
end

vim.lsp.config("rubocop", {
  root_dir = rubocop_yml_expected(true)
})

vim.lsp.config("standardrb", {
  root_dir = rubocop_yml_expected(false)
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})
