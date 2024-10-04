if vim.g.did_load_statuscol_plugin then
  return
end
vim.g.did_load_statuscol_plugin = true

local builtin = require('statuscol.builtin')
require('statuscol').setup {
  -- setopt = true,
  relculright = true,
  segments = {
    { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
    { text = { '%s' }, click = 'v:lua.ScSa' },
    {
      text = { builtin.lnumfunc, ' ' },
      condition = { true, builtin.not_empty },
      click = 'v:lua.ScLa',
    },
  },
}
