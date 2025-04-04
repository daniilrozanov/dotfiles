vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    require("conform").format {
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    }
  end,
})

return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      cpp = { "clang-format" },
      c = { "clang-format" },
    },
  }
}
-- {
--   config = function()
--     vim.api.nvim_create_autocmd("LspAttach", {
--       callback = function(args)
--         local bufnr = args.buf
--         local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")
--         local builtin = require "telescope.builtin"
--
--         vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
--         vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
--         vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
--         vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
--         vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, { desc = "[D]ocument [S]ymbols" })
--         vim.keymap.set("n", "<leader>lw", builtin.lsp_dynamic_workspace_symbols, { desc = "[W]orkspace Symbols" })
--         -- nmap("gd", builtin.lsp_definitions, { desc = "[G]oto [D]efinition" })
--         -- nmap("gr", builtin.lsp_references, { desc = "[G]oto [R]eferences" })
--
--         local filetype = vim.bo[bufnr].filetype
--         if disable_semantic_tokens[filetype] then
--           client.server_capabilities.semanticTokensProvider = nil
--         end
--
--         if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
--           vim.keymap.set("n", "<leader>Th", function()
--             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
--           end, { desc = "[T]oggle Inlay [H]ints" })
--         end
--       end,
--     })
--
--     -- Autoformatting Setup
--     require("conform").setup {
--     }
--
--   end,
-- }
