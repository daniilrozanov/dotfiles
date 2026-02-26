require("substitute").setup {}

vim.keymap.set("n", ",", require("substitute").operator, { noremap = true })
vim.keymap.set("n", ",,", require("substitute").line, { noremap = true })
vim.keymap.set("x", ",", require("substitute").visual, { noremap = true })
