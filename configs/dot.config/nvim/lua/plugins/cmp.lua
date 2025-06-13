return {
  "hrsh7th/nvim-cmp",

  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },

  opts = {
    sources = {
      name = "nvim_lsp",
      name = "buffer",
    }
  }
}
