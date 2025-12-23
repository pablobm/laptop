return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "elixir", "eex", "heex",
      "lua",
      "ruby",
      "rust",
    })
  end
}
