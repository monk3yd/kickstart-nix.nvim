local cmd = vim.cmd
local fn = vim.fn
local opt = vim.o
local global = vim.g

-- Set <space> as the leader key
-- <leader> key. Defaults to `\`. Some people prefer space.
global.mapleader = ' '
global.maplocalleader = ' '

opt.compatible = false

-- Set to true if you have a Nerd Font installed
global.have_nerd_font = true

-- Enable true colour support
if fn.has('termguicolors') then
  opt.termguicolors = true
end

-- [[ Options settings ]]
-- See :help option-list
-- See :h <option> to see what the options do

-- Search down into subfolders
opt.path = vim.o.path .. '**'

-- Show line numbers
opt.number = true

-- Switch to relative line numbers, to help with jumping
opt.relativenumber = true

-- Mouse mode, can be useful for resizing split
opt.mouse = 'a'

-- Don't show vim mode if you have status line
opt.showmode = false

-- Sync clipboard between OS and Neovim
opt.clipboard = 'unnamedplus'

-- Enable break indent
opt.breakindent = true

-- Show which line your cursor is on
opt.cursorline = true

opt.lazyredraw = true

-- Highlight matching parentheses, etc
opt.showmatch = true

opt.incsearch = true
opt.hlsearch = true

-- Case insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default (?)
opt.signcolumn = 'yes'

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
opt.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10
opt.sidescrolloff = 10

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 0
opt.foldenable = true
opt.history = 2000
opt.nrformats = 'bin,hex' -- 'octal'

-- Save undo history
opt.undofile = true

-- Check spelling
opt.spell = false
opt.spelllang = 'en'

opt.cmdheight = 0

opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Display lines as one long line
opt.wrap = false

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
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '⚠',
      [vim.diagnostic.severity.INFO] = 'ⓘ',
      [vim.diagnostic.severity.HINT] = '󰌶',
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

global.editorconfig = true

vim.opt.colorcolumn = '100'

-- Native plugins
cmd.filetype('plugin', 'indent', 'on')
cmd.packadd('cfilter') -- Allows filtering the quickfix list with :cfdo

-- let sqlite.lua (which some plugins depend on) know where to find sqlite
vim.g.sqlite_clib_path = require('luv').os_getenv('LIBSQLITE')
