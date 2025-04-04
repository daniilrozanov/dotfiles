return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "json",
        "markdown",
        "vim",
        "vimdoc",
        "cpp",
        "cmake",
        "query",
        "http",
        "proto",
        "xml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    }

    local syntax_on = {
      -- elixir = true,
      -- php = true,
    }

    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      callback = function(args)
        local bufnr = args.buf
        local ft = vim.bo[bufnr].filetype
        pcall(vim.treesitter.start)

        -- if syntax_on[ft] then
        --   vim.bo[bufnr].syntax = "on"
        -- end
      end,
    })
  end,
}
