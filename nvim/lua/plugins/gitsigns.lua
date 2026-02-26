local gitsigns = require "gitsigns"

local on_attach = function(bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  -- Navigation
  map("n", "]c", function()
    if vim.wo.diff then
      vim.cmd.normal { "]c", bang = true }
    else
      gitsigns.nav_hunk "next"
    end
  end)

  map("n", "[c", function()
    if vim.wo.diff then
      vim.cmd.normal { "[c", bang = true }
    else
      gitsigns.nav_hunk "prev"
    end
  end)

  -- Actions
  map("n", "<leader>gs", gitsigns.stage_hunk, { desc = "Stage hunk" })
  map("n", "<leader>gr", gitsigns.reset_hunk, { desc = "Reset hunk" })
  map("v", "<leader>gs", function()
    gitsigns.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Stage hunk" })
  map("v", "<leader>gr", function()
    gitsigns.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
  end, { desc = "Reset hunk" })
  map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Stage buffer" })
  map("n", "<leader>gu", gitsigns.undo_stage_hunk, { desc = "Undo stage hunk" })
  map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "Reset buffer" })
  map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Preview hunk" })
  map("n", "<leader>gb", function()
    gitsigns.blame_line { full = true }
  end, { desc = "Blame line" })
  map("n", "<leader>Tb", gitsigns.toggle_current_line_blame, { desc = "Toggle blame line" })
  map("n", "<leader>Td", gitsigns.toggle_deleted, { desc = "Toggle deleted" })
  map("n", "<leader>gd", gitsigns.diffthis, { desc = "Diff this" })
  map("n", "<leader>gD", function()
    gitsigns.diffthis "~"
  end, { desc = "Diff this ~" })
end

gitsigns.setup {
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = on_attach,
}

vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit" })
