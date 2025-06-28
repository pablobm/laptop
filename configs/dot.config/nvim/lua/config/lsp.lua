function EnableStandardRb()
  vim.lsp.config(
    'standardrb',
    {
      cmd = {'bundle', 'exec', 'standardrb', '--lsp'},  
      root_dir = vim.fs.dirname(
        vim.fs.find(
          {'.git', 'Gemfile'}, 
          { upward = true }
        )[1]
      ),
      filetypes = { 'ruby' }
    }
  )
  vim.lsp.enable('standardrb')
end

vim.api.nvim_create_user_command('StandardRb', EnableStandardRb, {})

function EnableRubocop()
  vim.lsp.config(
    'rubocop',
    {
      cmd = {'bundle', 'exec', 'rubocop', '--lsp'},  
      root_dir = vim.fs.dirname(
        vim.fs.find(
          {'.git', 'Gemfile', '.rubocop.yml'}, 
          { upward = true }
        )[1]
      ),
      filetypes = { 'ruby' }
    }
  )
  vim.lsp.enable('rubocop')
end

vim.api.nvim_create_user_command('Rubocop', EnableRubocop, {})
