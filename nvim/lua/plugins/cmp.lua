-- return {
--   "hrsh7th/nvim-cmp",
--   event = "InsertEnter",
--   priority = 100,
--   dependencies = {
--     "onsails/lspkind.nvim",
--     "hrsh7th/cmp-nvim-lsp",
--     "hrsh7th/cmp-path",
--     "hrsh7th/cmp-buffer",
--     {
--       "L3MON4D3/LuaSnip",
--       build = "make install_jsregexp",
--       dependencies = { "rafamadriz/friendly-snippets" },
--     },
--     "saadparwaiz1/cmp_luasnip",
--   },
--   config = function()
print("eeeeeeeeee")
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

local lspkind = require "lspkind"
lspkind.init {}

local luasnip = require "luasnip"
luasnip.config.setup {}
require("luasnip.loaders.from_vscode").lazy_load()

local cmp = require "cmp"

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = { completeopt = "menu,menuone,noinsert" },
  mapping = cmp.mapping.preset.insert {
    -- ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    -- ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      },
      { "i", "c" }
    ),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    -- ["<C-y>"] = cmp.mapping.confirm { select = true },
    --   -- Will move you to the right of each of the snippet's expansion locations.
    ["<C-l>"] = cmp.mapping(function()
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    -- Will move you to the left of each of the snippet's expansion locations.
    ["<C-h>"] = cmp.mapping(function()
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer" },
  },
}

luasnip.config.set_config {
  history = false,
  updateevents = "TextChanged,TextChangedI",
}
