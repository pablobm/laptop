return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        "rubocop", "standardrb",
        "ruff",
        "herb_ls",
        "rust_analyzer",
      },
      ensure_installed = {
        "rubocop", "standardrb",
        "ruff",
        "herb_ls",
        "rust_analyzer",
      }
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
