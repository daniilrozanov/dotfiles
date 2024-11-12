if vim.loop.os_uname().sysname ~= "Darwin" then
  return {
    "daniilrozanov/cmake.nvim",
    lazy = false,
    config = function()
      require "custom.cmake"
    end,
  }
else
  return {
    dir = "~/repositories/cmake.nvim",
    lazy = false,
    config = function()
      require "custom.cmake"
    end,
  }
end
