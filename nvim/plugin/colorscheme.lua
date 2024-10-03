if vim.g.did_load_colorscheme_plugin then
  return
end
vim.g.did_load_colorscheme_plugin = true

vim.g.gruvbox_material_transparent_background = 2
vim.g.gruvbox_material_diagnostic_text_highlight = 1
vim.g.gruvbox_material_current_word = "bold"

vim.cmd.colorscheme 'gruvbox-material'

