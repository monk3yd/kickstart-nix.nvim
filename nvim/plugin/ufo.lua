if vim.g.did_load_ufo_plugin then
    return
end
vim.g.did_load_ufo_plugin = true

require('ufo').setup {
    open_fold_hl_timeout = 150,
    close_fold_kinds_for_lt = { 'imports', 'comment'},
    close_fold_kinds_for_ft = {
        default = {default = {}}
    },
    enable_get_fold_virt_text = false,
    preview = {
        win_config = {
            border = { '', '─', '', '', '', '─', '', '' },
            winhighlight = 'Normal:Folded',
            winblend = 0
        },
        mappings = {
            scrollU = '<C-u>',
            scrollD = '<C-d>'
        }
    },
    provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
    end
}

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--     })
-- end
-- require('ufo').setup({
--     open_fold_hl_timeout = 150,
--     close_fold_kinds_for_lt = { 'imports', 'comment'},
--     close_fold_kinds_for_ft = {
--         default = {default = {}}
--     },
--     enable_get_fold_virt_text = false,
--     preview = {
--         win_config = {
--             border = { '', '─', '', '', '', '─', '', '' },
--             winhighlight = 'Normal:Folded',
--             winblend = 0
--         },
--         mappings = {
--             scrollU = '<C-u>',
--             scrollD = '<C-d>'
--         }
--     },
-- })

vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close Folds With' })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Close Folds Except' })

vim.keymap.set('n', '<leader>z', 'za', { silent = true, desc = 'Toogle Fold' })

