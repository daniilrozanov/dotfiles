--TODO: make it prettier

require("neodev").setup {
  library = {
    plugins = { "nvim-dap-ui" },
    types = true,
  },
}

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

local lspconfig = require "lspconfig"

local servers = {
  bashls = true,
  gopls = true,
  lua_ls = true,
  rust_analyzer = true,

  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },

  clangd = {
    init_options = { clangdFileStatus = true },
  },
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

require("mason").setup()
local ensure_installed = {
  "stylua",
  "lua_ls",
  "clangd",
  "clang-format",
  "neocmake",
}

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {}, {
    capabilities = capabilities,
  }, config)

  lspconfig[name].setup(config)
end

local disable_semantic_tokens = {
  lua = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
    local builtin = require "telescope.builtin"

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
    vim.keymap.set("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace Symbols" })
    -- nmap("gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
    -- nmap("gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
    -- nmap("gI", builtin.lsp_implementations, { desc = "[G]oto [I]mplementation" })

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end

    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.keymap.set("n", "<leader>Th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      end, { desc = "[T]oggle Inlay [H]ints" })
    end
  end,
})

-- Autoformatting Setup
require("conform").setup {
  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { "clang-format" },
    c = { "clang-format" },
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format {
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    }
  end,
})
