-- HTML LSP configuration for Neovim

local html_cmd = 'vscode-html-language-server'

-- Check if the HTML language server is available
if vim.fn.executable(html_cmd) ~= 1 then
    print("HTML Language Server not found. Please install 'vscode-langservers-extracted'")
    return
end

local root_files = {
    'package.json',
    '.git',
    '.htmlhintrc',
}

vim.lsp.start {
    name = 'html',
    cmd = { html_cmd, '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
    filetypes = { "html" },
    init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
            css = true,
            javascript = true
        },
        provideFormatter = true
    },
    single_type_support = true,
    on_attach = function(client, bufnr)
        -- Set the comment string for HTML files
        vim.api.nvim_buf_set_option(bufnr, 'commentstring', '<!-- %s -->')

        -- You can add any additional on_attach logic here
        -- For example, setting up keybindings or other buffer-local options
    end,
}

-- Set up an autocommand to handle the 'comments' option
vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    callback = function()
        vim.opt_local.comments = 's:<!--,m:    ,e:-->'
    end
})
