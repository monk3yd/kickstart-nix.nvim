-- ESLint LSP configuration for Neovim

local eslint_cmd = 'vscode-eslint-language-server'

-- Check if the ESLint language server is available
if vim.fn.executable(eslint_cmd) ~= 1 then
    return
end

local root_files = {
    '.eslintrc',
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    'package.json',
}

vim.lsp.start {
    name = 'eslint',
    cmd = { eslint_cmd, '--stdio' },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "svelte", "astro" },
    root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
    capabilities = require('user.lsp').make_client_capabilities(),
    settings = {
        codeAction = {
            disableRuleComment = {
                enable = true,
                location = "separateLine"
            },
            showDocumentation = {
                enable = true
            }
        },
        codeActionOnSave = {
            enable = false,
            mode = "all"
        },
        experimental = {
            useFlatConfig = false
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        problems = {
            shortenToSingleLine = false
        },
        quiet = false,
        rulesCustomizations = {},
        run = "onType",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
            mode = "location"
        }
    },
    handlers = {
        ["eslint/confirmESLintExecution"] = function()
            return { enable = true }
        end,
        ["eslint/noLibrary"] = function()
            vim.notify("ESLint library not found", vim.log.levels.WARN)
            return {}
        end,
        ["eslint/openDoc"] = function()
            return {}
        end,
        ["eslint/probeFailed"] = function()
            vim.notify("ESLint probe failed", vim.log.levels.WARN)
            return {}
        end
    },
    on_attach = function(client, bufnr)
        -- Set the comment string for TypeScript/JavaScript files
        vim.api.nvim_buf_set_option(bufnr, 'commentstring', '// %s')

        -- Create EslintFixAll command for this buffer
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
        })
    end,
}
