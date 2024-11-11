return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    --TODO: move this to files where it is declared
    require("which-key").register {
      ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
      ["<leader>T"] = { name = "Toggle options", _ = "which_key_ignore" },
      ["<leader>t"] = { name = "ToggleTerm", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
      ["<leader>l"] = { name = "LSP", _ = "which_key_ignore" },
      ["<leader><tab>"] = { name = "Tab pages", _ = "which_key_ignore" },
    }
  end,
}
