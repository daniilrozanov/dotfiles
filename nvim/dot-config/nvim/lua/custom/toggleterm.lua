require("toggleterm").setup {
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.33
    end
  end,
}

local Terminal = require("toggleterm.terminal").Terminal
local on_open = function(_)
  vim.cmd "startinsert!"
  -- vim.keymap.set("n", "q", "<cmd>close<CR>", { noremap = true, silent = true, buffer = term.bufnr })
end
local on_close = function(_)
  vim.cmd "startinsert!"
end
if vim.fn.executable "lazygit" then
  local lazygit = Terminal:new {
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    on_open = on_open,
    on_close = on_close,
    count = 999,
  }
  vim.keymap.set("n", "<leader>gg", function()
    lazygit:toggle()
  end, { desc = "ToggleTerm LazyGit" })
end

vim.keymap.set("n", "<leader>tf", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "float")
end)
vim.keymap.set("n", "<leader>tv", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "vertical")
end)
vim.keymap.set("n", "<leader>th", function()
  Terminal:new({ count = vim.v.count1, on_open = on_open, on_close = on_close }):toggle(nil, "horizontal")
end)
