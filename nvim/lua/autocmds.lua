local aucmd = vim.api.nvim_create_autocmd
local function augroup(name)
  return vim.api.nvim_create_augroup("chell_" .. name, {})
end

-- highlight after yank
aucmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = augroup "highlight_yank",
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- resize splits if window got resized
aucmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
aucmd({ "BufWritePre" }, {
  group = augroup "auto_create_dir",
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup "auto_cursorline_show",
  callback = function(event)
    if vim.bo[event.buf].buftype == "" then
      vim.opt_local.cursorline = true
    end
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup "auto_cursorline_hide",
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
