local set = vim.keymap.set

set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

-- ui navigation
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")

set("n", "<leader>wv", "<cmd>vsplit<cr>")
set("n", "<leader>ws", "<cmd>split<cr>")
set("n", "<leader>ww", "<cmd>w<cr>", { desc = "Write buffer" })

set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })

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

set("t", "<C-n>", [[<C-\><C-n>]], { silent = true })
