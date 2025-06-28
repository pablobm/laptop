return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      automatic_enable = {
        exclude = {
          -- TODO: autoselect the right Ruby LSP depending on project
          "rubocop", "standardrb",
        }
      }

    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
