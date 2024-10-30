-- JavaScript LSP configuration for Neovim

local js_cmd = 'vscode-eslint-language-server'

-- Check if the JavaScript language server is available
if vim.fn.executable(js_cmd) ~= 1 then
    print("JavaScript Language Server not found. Please install 'vscode-langservers-extracted'")
    return
end

local root_files = {
    'package.json',
    'jsconfig.json',
    '.git',
    '.eslintrc.js',
    '.eslintrc.json'
}

require('lspconfig').eslint.setup {}

vim.lsp.start {
    name = 'javascript',
    cmd = { js_cmd, '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
    filetypes = { "javascript", "javascriptreact", "javascript.jsx" },
    init_options = {
        provideFormatter = true,
        preferences = {
            quotePreference = "single",
            importModuleSpecifierPreference = "relative"
        }
    },
    settings = {
        javascript = {
            format = {
                enable = true,
                insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
                insertSpaceAfterKeywordsInControlFlowStatements = true
            },
            suggestionActions = {
                enabled = true
            },
            updateImportsOnFileMove = {
                enabled = "always"
            },
            validate = {
                enable = true
            }
        }
    },
    on_attach = function(client, bufnr)
        -- Set the comment string for JavaScript files
        vim.api.nvim_buf_set_option(bufnr, 'commentstring', '// %s')

        -- You can add any additional on_attach logic here
        -- For example, setting up keybindings or other buffer-local options
    end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "javascript.jsx" },
    callback = function()
        vim.opt_local.comments = '//,/*:*,://'
    end
})
