local set = vim.keymap.set

set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write buffer" })

set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- execute current file. TODO: think this can be smarter
set("n", "<leader>r", '<cmd>!"%:p"<cr>')

-- ui navigation
set("n", "<m-j>", "<c-w><c-j>")
set("n", "<m-k>", "<c-w><c-k>")
set("n", "<m-l>", "<c-w><c-l>")
set("n", "<m-h>", "<c-w><c-h>")

set("n", "<m-<>", "<c-w>5<")
set("n", "<m->>", "<c-w>5>")
set("n", "<m-+>", "<c-w>4+")
set("n", "<m-->", "<c-w>4-")

set("n", "<m-v>", "<cmd>vsplit<cr>")
set("n", "<m-s>", "<cmd>split<cr>")

set("n", "<m-q>", "<cmd>q<cr>", { desc = "Quit window" })

set("n", "<m-t>", "<cmd>tabnew<cr>", { desc = "New Tab" })
set("n", "<s-m-t>", "<cmd>tabclose<cr>", { desc = "Close Tab" })
set("n", "<m-n>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
set("n", "<m-p>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Toggle hlsearch if it's on, otherwise just do "enter"
set("n", "<cr>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.hlsearch:get() then
    vim.cmd.nohl()
    return ""
  else
    return "<cr>"
  end
end, { expr = true })

--swap lines
set("n", "<c-j>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! ]c]]
  else
    vim.cmd [[m .+1<CR>==]]
  end
end)
set("n", "<c-k>", function()
  if vim.opt.diff:get() then
    vim.cmd [[normal! [c]]
  else
    vim.cmd [[m .-2<cr>==]]
  end
end)

--lsp
set("n", "grt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
--ui
local toggle = function(obj)
  return function()
    obj.enable(not obj.is_enabled())
  end
end
set("n", "<leader>uh", toggle(vim.lsp.inlay_hint), { desc = "Toggle inlay hints" })
set("n", "<leader>ud", toggle(vim.diagnostic), { desc = "Toggle inlay hints" })
