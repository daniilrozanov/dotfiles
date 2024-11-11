return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = { rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" } },
  },
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = { "luarocks.nvim", "nvim-treesitter/nvim-treesitter" },
    config = function()
      require "custom.rest"
    end,
  },
}
