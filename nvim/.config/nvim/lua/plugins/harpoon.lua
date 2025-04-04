return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Add buffer to harpoon" })

    vim.keymap.set("n", "<leader><leader>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle harpoon menu" })

    vim.keymap.set("n", "<c-n>", function()
      require("harpoon"):list():next()
    end, { desc = "Goto next harpooned" })

    vim.keymap.set("n", "<c-p>", function()
      require("harpoon"):list():prev()
    end, { desc = "Goto prev harpooned" })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set("n", string.format("<leader>%d", idx), function()
        harpoon:list():select(idx)
      end, { desc = string.format("Goto %d harpooned", idx) })
    end
  end,
}
