local opt = vim.opt_local

-- Set local settings for terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", {}),
  callback = function()
    opt.number = false
    opt.relativenumber = false
    opt.scrolloff = 0
  end,
})

-- Easily hit escape in terminal mode.
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("t", "<m-q>", "<c-\\><c-n><cmd>quit<cr>")
