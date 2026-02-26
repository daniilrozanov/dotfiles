return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- TODO: move this to where mappings created
    spec = {
      { "<leader>f",     desc = "Find" },
      { "<leader>T",     desc = "Toggle options" },
      { "<leader>t",     desc = "ToggleTerm" },
      { "<leader>g",     desc = "Git" },
      { "<leader>l",     desc = "LSP" },
      { "<leader><tab>", desc = "Tab pages" },
    }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
