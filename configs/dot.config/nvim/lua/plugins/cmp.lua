--
-- With help from https://rsdlt.github.io/posts/rust-nvim-ide-guide-walkthrough-development-debug/
--

return {
  "hrsh7th/nvim-cmp",

  dependencies = {
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-calc",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-path",

    -- TODO: Look into these
    -- "hrsh7th/cmp-vsnip",
    -- "hrsh7th/vim-vsnip",
  },

  config = function()
    local cmp = require("cmp")
    cmp.setup({
      -- Enable LSP snippets
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
      },
      -- Installed sources:
      sources = {
        { name = 'path' },

        { name = 'nvim_lsp', keyword_length = 3 },

        -- display function signatures with current parameter emphasized
        { name = 'nvim_lsp_signature_help' },

        -- complete neovim's Lua runtime API such vim.lsp.*
        { name = 'nvim_lua', keyword_length = 2 },

        -- source current buffer
        { name = 'buffer', keyword_length = 2 },

        -- source for math calculation
        { name = 'calc' }

        -- TODO: Look into this one
        -- nvim-cmp source for vim-vsnip
        -- { name = 'vsnip', length = 2 },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { 'menu', 'abbr', 'kind' },
        format = function(entry, item)
          local menu_icon = {
            nvim_lsp = 'λ',
            vsnip = '⋗',
            buffer = 'Ω',
            path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
        end,
      },
    })
  end
}
