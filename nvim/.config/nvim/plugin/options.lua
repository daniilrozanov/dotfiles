local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.mouse = "a"

opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

opt.breakindent = true -- Enable break indent

opt.undofile = true -- Save undo history

opt.ignorecase = true -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.smartcase = true

opt.signcolumn = "yes" -- Keep signcolumn on by default

opt.updatetime = 250 -- Decrease update time

opt.timeoutlen = 300 -- Decrease mapped sequence wait time

opt.splitright = true -- Configure how new splits should be opened
opt.splitbelow = true

opt.list = true -- Sets how neovim will display certain whitespace characters in the editor.
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- opt.inccommand = "split" -- Preview substitutions live

opt.cursorline = true -- Show which line your cursor is on

opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
opt.sidescrolloff = 5

opt.hlsearch = true -- Set highlight on search
opt.incsearch = true

opt.background = "dark"

opt.laststatus = 3
