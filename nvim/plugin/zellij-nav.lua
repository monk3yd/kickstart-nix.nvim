if vim.g.did_load_zellijnav_plugin then
    return
end
vim.g.did_load_zellijnav_plugin = true

require("zellij-nav").setup()

local keymap = vim.keymap

keymap.set("n", "<C-h>", "<CMD>ZellijNavigateLeft<CR>", { silent = true, desc = "navigate left" })
keymap.set("n", "<C-j>", "<CMD>ZellijNavigateDown<CR>", { silent = true, desc = "navigate down"  })
keymap.set("n", "<C-k>", "<CMD>ZellijNavigateUp<CR>", { silent = true, desc = "navigate up" })
keymap.set("n", "<C-l>", "<CMD>ZellijNavigateRight<CR>", { silent = true, desc = "navigate right" })

