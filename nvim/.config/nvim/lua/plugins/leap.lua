return {
  "ggandor/leap.nvim",
  lazy = false, --TODO: lazy
  config = function()
    vim.keymap.set("n", "s", "<Plug>(leap)", { desc = "Leap" })
    vim.keymap.set("n", "S", "<Plug>(leap-from-window)", { desc = "Leap other window" })
    require("leap").setup { safe_labels = {} }
  end,
}
