-- We'll remove the comments setting from here and handle it differently

local gopls_cmd = 'gopls'

-- Check if gopls is available
if vim.fn.executable(gopls_cmd) ~= 1 then
  return
end

local root_files = {
  'go.mod',
  'go.work',
  '.golangci.yml',
  '.golangci.toml',
  'go.sum',
  '.git',
}

vim.lsp.start {
  name = 'gopls',
  cmd = { gopls_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      usePlaceholders = true,
      experimentalPostfixCompletions = true,
      semanticTokens = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true,
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Set the comment string for Go files here
    vim.api.nvim_buf_set_option(bufnr, 'commentstring', '// %s')

    -- You can add any additional on_attach logic here
    -- For example, setting up keybindings or other buffer-local options
  end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.comments = ':// '
  end
})
