--
-- With help from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
--

-- Set completeopt to have a better completion experience
-- :help completeopt
vim.opt.completeopt = {
  "menuone",  -- Popup even when there's only one match
  "noselect", -- Do not insert text until a selection is made
  "noinsert"  -- Do not select, force to select one from the menu
}

-- shortness: avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + { c = true}

