vim.lsp.config('*', { root_makers = { '.git' } })

vim.lsp.enable({ 'clangd', 'lua_ls' })

--Probably I dont need this :\
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if client:supports_method('textDocument/completion') then
--       vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
--     end
--   end,
-- })
