return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  setup = function()
    require("nvim-treesitter").install({
      "elixir", "eex", "heex",
      "lua",
      "ruby",
      "rust",
    })
  end
}
