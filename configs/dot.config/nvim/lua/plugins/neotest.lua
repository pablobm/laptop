return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- To define key bindings in this file
    "folke/which-key.nvim",

    -- Languages
    "jfpedroza/neotest-elixir",
    "olimorris/neotest-rspec",
  },

  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-elixir"),
        require("neotest-rspec"),
      }
    })

    require("which-key").add({
      {
          "<leader>n",
          group = "🧪 Test",
          nowait = true,
          remap = false,
      },
      {
          "<leader>nr",
          "<cmd>lua require('neotest').run.run()<cr>",
          desc = "Run nearest test",
      },
      {
          "<leader>nf",
          "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
          desc = "Run current file",
      },
      {
          "<leader>na",
          "<cmd>lua require('neotest').run.run({ suite = true })<cr>",
          desc = "Run all tests",
      },
      {
          "<leader>nd",
          "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>",
          desc = "Debug nearest test",
      },
      {
          "<leader>ns",
          "<cmd>lua require('neotest').run.stop()<cr>",
          desc = "Stop test",
      },
      {
          "<leader>nn",
          "<cmd>lua require('neotest').run.attach()<cr>",
          desc = "Attach to nearest test",
      },
      {
          "<leader>no",
          "<cmd>lua require('neotest').output.open()<cr>",
          desc = "Show test output",
      },
      {
          "<leader>np",
          "<cmd>lua require('neotest').output_panel.toggle()<cr>",
          desc = "Toggle output panel",
      },
      {
          "<leader>nv",
          "<cmd>lua require('neotest').summary.toggle()<cr>",
          desc = "Toggle summary",
      },
      {
          "<leader>nc",
          "<cmd>lua require('neotest').run.run({ suite = true, env = { CI = true } })<cr>",
          desc = "Run all tests with CI",
      },
    })
  end
}
