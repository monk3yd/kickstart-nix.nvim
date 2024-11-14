-- TypeScript LSP configuration for Neovim

local ts_cmd = 'typescript-language-server'

-- Check if the TypeScript language server is available
if vim.fn.executable(ts_cmd) ~= 1 then
    print("TypeScript Language Server not found. Please install via: npm install -g typescript typescript-language-server")
    return
end

local root_files = {
    'package.json',
    'tsconfig.json',
    'jsconfig.json',
    '.git'
}

vim.lsp.start {
    name = 'typescript',
    cmd = { ts_cmd, '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
    init_options = {
        hostInfo = "neovim"
    },
    single_file_support = true,
    on_attach = function(client, bufnr)
        -- Set the comment string for TypeScript/JavaScript files
        vim.api.nvim_buf_set_option(bufnr, 'commentstring', '// %s')

        -- Enable formatting on save if the server supports it
        if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx"
    },
    callback = function()
        vim.opt_local.comments = '//,/*:*,://'
    end
})
