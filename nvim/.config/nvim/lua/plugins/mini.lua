return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    -- Better Around/Inside textobjects
    require("mini.ai").setup { n_lines = 500 }
  end,
}
