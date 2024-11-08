-- First ensure null-ls is installed and imported
local null_ls = require("null-ls")

-- Python formatter configuration
local formatting = null_ls.builtins.formatting

local pyright_cmd = 'pyright-langserver'

-- Check if pyright is available
if vim.fn.executable(pyright_cmd) ~= 1 then
  return
end

local root_files = {
  'pyproject.toml',
  'setup.py',
  'setup.cfg',
  'requirements.txt',
  'Pipfile',
  'pyrightconfig.json',
  '.git',
}

-- Initialize null-ls with Python formatters
null_ls.setup({
  sources = {
    -- You can choose between different formatters:
    formatting.black.with({
      extra_args = { "--fast", "--line-length=88" }
    }),
  },
})

vim.lsp.start {
  name = 'pyright',
  cmd = { pyright_cmd, '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
        -- Enable more strict checking
        diagnosticSeverityOverrides = {
          reportGeneralTypeIssues = "warning",
          reportOptionalMemberAccess = "warning",
          reportOptionalSubscript = "warning",
          reportPrivateImportUsage = "warning",
        },
      },
    },
  },
  on_attach = function(client, bufnr)
    -- Set the comment string for Python files
    vim.api.nvim_buf_set_option(bufnr, 'commentstring', '# %s')

    -- You can add any additional on_attach logic here
    -- For example, setting up keybindings or other buffer-local options
  end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.comments = ':# '
  end
})
