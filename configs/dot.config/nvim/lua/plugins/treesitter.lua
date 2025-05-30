return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "elixir", "eex", "heex",
        "lua",
        "ruby",
        "rust",
      },
      highlight = { enable = true, }
    }
  end
}
