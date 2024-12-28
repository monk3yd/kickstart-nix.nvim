if vim.g.did_load_ufo_plugin then
    return
end
vim.g.did_load_ufo_plugin = true

local ufo = require('ufo')
ufo.setup {
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
    provider_selector = function()
        return {'treesitter', 'indent'}
    end
}

vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open All Folds' })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close All Folds' })
vim.keymap.set('n', 'zm', ufo.closeFoldsWith, { desc = 'Close Folds With' })
vim.keymap.set('n', 'zr', ufo.openFoldsExceptKinds, { desc = 'Close Folds Except' })

vim.keymap.set('n', '<leader>z', 'za', { silent = true, desc = 'Toogle Fold' })

