local templ_cmd = 'templ'

-- Check if templ language server is available
if vim.fn.executable(templ_cmd) ~= 1 then
  return
end

local root_files = {
  'go.mod',
  'go.work',
  '.git',
}

vim.lsp.start {
  name = 'templ',
  cmd = { templ_cmd, 'lsp' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { 'templ' },
  settings = {
    templ = {
      -- You can add Templ-specific settings here if they become available
    },
  },
  on_attach = function(client, bufnr)
    -- Set the comment string for Templ files
    vim.api.nvim_buf_set_option(bufnr, 'commentstring', '{/* %s */}')

    -- You can add any additional on_attach logic here
    -- For example, setting up keybindings or other buffer-local options
  end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
  pattern = "templ",
  callback = function()
    vim.opt_local.comments = ':// '
  end
})

-- Ensure .templ files are recognized as Templ filetype
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.templ",
  callback = function()
    vim.bo.filetype = "templ"
  end
})
