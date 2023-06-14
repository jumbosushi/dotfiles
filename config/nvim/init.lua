-- ######################### Shortcuts
local set = vim.opt
local cmd = vim.cmd
local o = vim.o
local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','

-- #########################
-- Mappings
options = { noremap = true }

map('i', 'jk', '<Esc>', options)
map('n', '<Space>.', ':<C-u>edit ~/.config/nvim/init.lua<CR>', options)
map('n', '<Space>s.', ':<C-u>source ~/.config/nvim/init.lua<CR>', options)
map('n', '<Space>a', ':<C-u>terminal rg<Space>', options)
map('v', '<Space>c', '"+y', options) -- Copy to clipboard
map('n', '<Space>n', ':noh<CR>', options) -- Remove search highlight
map('n', '<silent><Leader><C-]>', '<C-w><C-]><C-w>T', options)
map('n', '<C-n>', ':NvimTreeToggle<Enter>', options) -- Toggle nvim-tree
map('n', '<Leader>f', ':NvimTreeFindFile<Enter>', options) -- Open file in nvim-tree
--" Gitblame with visualmode
map('v', '<Leader>b', [[:<C-U>!git blame <C-R>=expand("%:p:h")<CR> | sed -n <C-R>=line("'<")<CR>,<C-R>=line("'>")<CR>p<CR>]], { noremap = true, silent = true })

-- #########################
-- Commands
-- Format JSON
cmd('command! FormatJSON :%!python -m json.tool')

-- General Settings
o.syntax = 'on'

-- #########################
-- Sets global variables
set.encoding = 'utf-8'
set.title = true
set.autoindent = true
set.smartindent = true
set.hlsearch = true -- highlight matches
set.incsearch = true -- incremental searching
set.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
set.smartcase = true -- ... unless they contain at least one capital letter
set.backup = false
set.showcmd = true
set.cmdheight = 1
set.laststatus = 2
set.scrolloff = 10
set.shell = 'fish'
set.backupskip = { '/tmp/*', '/private/tmp/*' }
set.inccommand = 'split'
set.smarttab = true
set.breakindent = true
set.shiftwidth = 2
set.tabstop = 2
set.shiftwidth = 2 -- a tab is two spaces
set.expandtab = true -- use spaces, not tabs 
set.wrap = false -- No Wrap lines
set.backspace = { 'start', 'eol', 'indent' } -- backspace through everything in insert mode
set.path:append { '**' } -- Finding files - Search down into subfolders
-- Ignore node_modules from :find
set.wildignore:append { '*/node_modules/*' }
set.shell = '/bin/zsh'
set.tags = './tags'
set.wildmenu = true
set.relativenumber = true
set.cursorline = true -- Horizonal cursor line
-- cursors

-- #########################
-- Language specific spacing
vim.cmd([[
  augroup filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.ts set ts=4 sw=4 sts=4 et
    autocmd BufRead,BufNewFile *.py set ts=4 sw=4 sts=4 et
    autocmd BufRead,BufNewFile *.go set ts=4 sw=4 sts=4 et
    autocmd BufRead,BufNewFile *.js set ts=2 sw=2 sts=2 et
  augroup END
]])

-- #########################
-- Plugins
require('plugins')
require('onedark').load()
vim.cmd([[autocmd BufWritePost * lua require('gitsigns').stage_hunk()]])

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  -- See here for references https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt#L138
  vim.keymap.set('n', 't',     api.node.open.tab,        opts('Tab'))
  vim.keymap.set('n', 's',     api.node.open.vertical,        opts('Tab'))
  vim.keymap.set('n', 'i',     api.node.open.horizontal,        opts('Tab'))
  vim.keymap.set('n', 'x',     api.node.navigate.parent_close,       opts('Tab'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end
require("nvim-tree").setup({
  on_attach = my_on_attach,
  renderer = {
    icons = {
      show = {
        git = true,
        file = false,
        folder = false,
        folder_arrow = true,
      },
      glyphs = {
        folder = {
          arrow_closed = "⏵",
          arrow_open = "⏷",
        },
        git = {
          unstaged = "✹",
          staged = "✚",
          unmerged = "═",
          renamed = "➜",
          untracked = "★",
          deleted = "✖",
          ignored = "◌",
        },
      },
    },
  },
})

