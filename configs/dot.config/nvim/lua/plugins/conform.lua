return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      elixir = { "mix" },

      -- TODO: see if it's possible to run Rubocop when there's a `.rubocop.yml`
      -- and standardrb otherwise. See the example at https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#run-the-first-available-formatter-followed-by-more-formatters,
      -- and implement something like that `first` function to detect the yml
      ruby = { "standardrb" },
    },
    format_on_save = {
      lsp_format = "fallback",

      -- Standardrb/Rubocop are slower than the recommended 500ms timeout
      -- Trying with async to see if it does better
      async = true,
    },
  },
}
