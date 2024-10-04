-- Set <space> as the leader key
-- <leader> key. Defaults to `\`. Some people prefer space.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.compatible = false

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Enable true colour support
if vim.fn.has('termguicolors') then
  vim.opt.termguicolors = true
end

-- [[ Options settings ]]
-- See :help option-list
-- See :h <option> to see what the options do

-- Search down into subfolders
vim.opt.path = vim.o.path .. '**'

-- Show line numbers
vim.opt.number = true

-- Switch to relative line numbers to help with jumping
vim.opt.relativenumber = true

-- Mouse mode, can be useful for resizing split
vim.opt.mouse = 'a'

-- Don't show vim mode if you have status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (?)
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true

-- NOTE:
-- This may need to be moved to after/plugin configuration
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

-- ?
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.lazyredraw = true

-- Highlight matching parentheses, etc
vim.opt.showmatch = true

vim.opt.history = 2000
vim.opt.nrformats = 'bin,hex' -- 'octal'

-- UFO plugin folding
vim.opt.foldcolumn = '1' -- '0' is not bad
vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Display lines as one long line
vim.opt.wrap = false

-- Check spelling
vim.opt.spell = false
vim.opt.spelllang = 'en'

vim.opt.cmdheight = 0

-- Configure Neovim diagnostic messages

local function prefix_diagnostic(prefix, diagnostic)
  return string.format(prefix .. ' %s', diagnostic.message)
end

vim.diagnostic.config {
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      if severity == vim.diagnostic.severity.ERROR then
        return prefix_diagnostic('󰅚', diagnostic)
      end
      if severity == vim.diagnostic.severity.WARN then
        return prefix_diagnostic('⚠', diagnostic)
      end
      if severity == vim.diagnostic.severity.INFO then
        return prefix_diagnostic('ⓘ', diagnostic)
      end
      if severity == vim.diagnostic.severity.HINT then
        return prefix_diagnostic('󰌶', diagnostic)
      end
      return prefix_diagnostic('■', diagnostic)
    end,
  },
  signs = {
    text = {
      -- Requires Nerd fonts
      [vim.diagnostic.severity.ERROR] = ' 󰅚',
      [vim.diagnostic.severity.WARN] = ' ⚠',
      [vim.diagnostic.severity.INFO] = ' ⓘ',
      [vim.diagnostic.severity.HINT] = ' 󰌶',
    },
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'if_many',
    header = '',
    prefix = '',
  },
}

vim.g.editorconfig = true

vim.opt.colorcolumn = '100'

-- Native plugins
vim.cmd.filetype('plugin', 'indent', 'on')
vim.cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
