local htmx_cmd = 'htmx-lsp'

-- Check if the HTMX language server is available
if vim.fn.executable(htmx_cmd) ~= 1 then
  print("HTMX LSP not found. Please install it with 'npm install -g htmx-lsp'")
  return
end

local root_files = {
  '.git',
  'go.mod',
}

vim.lsp.start {
  name = 'htmx',
  cmd = { htmx_cmd },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" },
  single_type_support = true,
}
