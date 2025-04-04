vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

vim.opt.breakindent = true        -- Enable break indent

vim.opt.undofile = true           -- Save undo history

vim.opt.ignorecase = true         -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- Keep signcolumn on by default

vim.opt.updatetime = 250   -- Decrease update time

vim.opt.timeoutlen = 300   -- Decrease mapped sequence wait time

vim.opt.splitright = true  -- Configure how new splits should be opened
vim.opt.splitbelow = true

vim.opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- vim.opt.inccommand = "split" -- Preview substitutions live

vim.opt.cursorline = true -- Show which line your cursor is on

vim.opt.scrolloff = 10    -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.sidescrolloff = 5

vim.opt.hlsearch = true -- Set highlight on search
vim.opt.incsearch = true

vim.opt.background = "dark"

vim.opt.laststatus = 3

vim.diagnostic.config({ virtual_text = true, virtual_line = false })
