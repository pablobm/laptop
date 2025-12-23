return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        "rubocop",
        "standardrb",
        "rust_analyzer",
      }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
