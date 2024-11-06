local jsonls_cmd = 'vscode-json-language-server'

-- Check if json language server is available
if vim.fn.executable(jsonls_cmd) ~= 1 then
  return
end

local root_files = {
  '.git',
  'package.json',
  'jsconfig.json',
  'tsconfig.json',
}

vim.lsp.start {
  name = 'jsonls',
  cmd = { jsonls_cmd, '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    json = {
      -- Enable schema downloads from schemastore.org
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
      -- Configure json formatting
      format = {
        enable = true,
      },
      -- Configure completion features
      completion = {
        completePropertyWithSemicolon = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Set the comment string for JSON files
    vim.api.nvim_buf_set_option(bufnr, 'commentstring', '// %s')

    -- Disable formatting if you want to use another formatter like prettier
    -- client.server_capabilities.documentFormattingProvider = false
    -- client.server_capabilities.documentRangeFormattingProvider = false

    -- You can add any additional on_attach logic here
    -- For example, setting up keybindings or other buffer-local options
  end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt_local.comments = ':// '
  end
})

-- Optional: Set up additional JSON-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    -- Concealment settings for JSON
    vim.opt_local.conceallevel = 0
    -- Ensure proper indentation
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end
})
