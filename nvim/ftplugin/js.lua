-- ESLint LSP configuration for Neovim

local ts_cmd = 'typescript-language-server'

-- Check if the JS/TS language server is available
if vim.fn.executable(ts_cmd) ~= 1 then
    print("JS/TS language server executable missing")
    return
end

local root_files = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    'package.json',
    '.git'
}

vim.lsp.start {
    name = 'ts_ls',
    init_options = { hostInfo = 'neovim' },
    cmd = { ts_cmd, '--stdio' },
    filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
    },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    single_file_support = true,
    capabilities = require('user.lsp').make_client_capabilities(),
}
