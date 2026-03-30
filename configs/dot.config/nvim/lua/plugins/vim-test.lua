return {
  "vim-test/vim-test",

  config = function()
   vim.g["test#strategy"] = "neovim_sticky"
   vim.g["test#neovim#term_position"] = "vert"
   vim.g["test#neovim_sticky#use_existing"] = 1

   require("which-key").add({
     {
         "<leader>n",
         group = "🧪 Test",
         nowait = true,
         remap = false,
     },
     {
         "<leader>nr",
         "<cmd>TestNearest<cr>",
         desc = "Run nearest test",
     },
     {
         "<leader>nf",
         "<cmd>TestFile<cr>",
         desc = "Run current file",
     },
     {
         "<leader>na",
         "<cmd>TestSuite<cr>",
         desc = "Run all tests",
     },
     {
         "<leader>nn",
         "<cmd>TestLast<cr>",
         desc = "Rerun latest test",
     },
     {
         "<leader>ng",
         "<cmd>TestVisit<cr>",
         desc = "Go to latest test",
     },
   })
  end
}
