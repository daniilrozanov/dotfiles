return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim",   build = "make" },
    { "nvim-telescope/telescope-smart-history.nvim" },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
  },
  config = function()
    require("telescope").setup {
      extensions = {
        fzf = {},
        wrap_results = true,
        history = {
          -- path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
          limit = 100,
        },
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      defaults = {
        -- configure to use ripgrep
        vimgrep_arguments = {
          "rg",
          "--follow",        -- Follow symbolic links
          "--hidden",        -- Search for hidden files
          "--no-heading",    -- Don't group matches by each file
          "--with-filename", -- Print the file path with the matched lines
          "--line-number",   -- Show line numbers
          "--column",        -- Show column numbers
          "--smart-case",    -- Smart case search

          -- Exclude some patterns from search
          "--glob=!**/.git/*",
          "--glob=!**/.idea/*",
          "--glob=!**/.vscode/*",
          "--glob=!**/build/*",
          "--glob=!**/dist/*",
          "--glob=!**/yarn.lock",
          "--glob=!**/package-lock.json",
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          -- needed to exclude some files & dirs from general search
          -- when not included or specified in .gitignore
          find_command = {
            "rg",
            "--files",
            "--hidden",
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
          },
        },
      },
    }

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "smart_history")
    pcall(require("telescope").load_extension, "rest")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require "telescope.builtin"

    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search [H]elp" })
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Search [K]eymaps" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search [F]iles" })
    vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "Search [S]elect Telescope" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Search current [W]ord" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Search by [G]rep" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Search [D]iagnostics" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Search [R]esume" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>fn", function()
      require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
    end, { desc = "Search [N]eovim files" })

    vim.keymap.set("n", "<leader>fa", function()
      ---@diagnostic disable-next-line: param-type-mismatch
      builtin.find_files { cwd = vim.fs.joinpath(vim.fn.stdpath "data", "lazy") }
    end)
  end,
}
