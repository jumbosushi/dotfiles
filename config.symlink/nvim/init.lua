-- #########################
-- Shortcuts
local set = vim.opt
local cmd = vim.cmd
local o = vim.o
local map = vim.api.nvim_set_keymap

vim.g.mapleader = ','
-- General Settings
o.syntax = 'on'

-- #########################
-- Sets global variables
set.autoindent = true -- use the indentation of the current line as a template for the indentation of the next line
set.backupext = ".bak" -- Extension used for backup files
set.backspace = { 'start', 'eol', 'indent' } -- backspace through everything in insert mode
set.backup = true -- Keep a backup
-- Create a backup dir in ~/.config if it doesn't exist.
local backupdir = vim.fn.stdpath('config') .. '/backup'
if not vim.fn.isdirectory(backupdir) then
   vim.fn.mkdir(backupdir, "p")
end
set.backupdir = backupdir -- Set backup dir as ~/.config/backup
set.backupskip = { '/tmp/*', '/private/tmp/*' }
set.breakindent = true -- Every wrapped line will continue visually indented
set.cmdheight = 1 -- # of lines used for command-line
set.cursorline = true -- Horizonal cursor line
set.expandtab = true -- use spaces, not tabs
set.hlsearch = true -- highlight matches
set.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
set.inccommand = 'split' -- Create a partial off-screen space for multi-line substitutions
set.incsearch = true -- incremental searching
set.laststatus = 2 -- Last window will always have a status line
set.path:append { '**' } -- Finding files - Search down into subfolders
set.relativenumber = true -- Use relative number
set.scrolloff = 10 -- Min # of screen lines to keep above & below cursor
set.shell = '/bin/zsh' -- Which shell to use
set.shiftwidth = 2 -- Spaces used for << cmd and autoindent
set.showcmd = true -- Show last command at the bottom
set.smartcase = true -- ... unless they contain at least one capital letter
set.smartindent = true -- Automatically add indent for lines after { and remove it after }
set.smarttab = true -- Tab in front of a line inserts spaces as specified with 'shiftwidth', and a Tab in the middle of a line inserts spaces as specified with 'tabstop'.
set.tabstop = 2 -- Width of the tab character
set.tags = './tags'
set.title = true -- Use filename as the title of the window
set.wildignore:append { '*/node_modules/*' } -- Ignore node_modules from :find
set.wildmenu = true -- Command-line completion operates in  an enhanced mode
set.wrap = false -- No Wrap lines

-- #########################
-- Mappings
options = { noremap = true }
map('i', 'jk', '<Esc>', options)
map('n', '<Space>.', ':<C-u>edit ~/.config/nvim/init.lua<CR>', options)
map('n', '<Space>s.', ':<C-u>source ~/.config/nvim/init.lua<CR>', options)
map('n', '<Leader>p', ':<C-u>edit ~/.config/nvim/lua/plugins.lua<CR>', options) -- Open file in nvim-tree
map('n', '<Space>a', ':<C-u>terminal rg<Space>', options)
map('n', '<Space>h', ':help ', options)
map('v', '<Space>c', '"+y', options) -- Copy to clipboard
map('n', '<Space>n', ':noh<CR>', options) -- Remove search highlight
map('n', '<silent><Leader><C-]>', '<C-w><C-]><C-w>T', options)
map('n', '<C-n>', ':NvimTreeToggle<Enter>', options) -- Toggle nvim-tree
map('n', '<Leader>f', ':NvimTreeFindFile<Enter>', options) -- Open file in nvim-tree
--" Gitblame with visualmode
map('v', '<Leader>b', [[:<C-U>!git blame <C-R>=expand("%:p:h")<CR> | sed -n <C-R>=line("'<")<CR>,<C-R>=line("'>")<CR>p<CR>]], { noremap = true, silent = true })
-- fzf-lua bindings
map("n", "<C-p>", ":FzfLua files<CR>", { silent = true })
map("n", "<C-b>", ":FzfLua buffers<CR>", { silent = true })
map("n", "<Leader-t>", ":FzfLua tags<CR>", { silent = true })

-- #########################
-- Commands
-- Format JSON
cmd('command! FormatJSON :%!python -m json.tool')

-- #########################
-- White space trimming
-- Need _G to enable calling this from vimscript
function _G.StripTrailingWhitespace()
    local blocklist = {
        markdown = true,
        md = true
    }
    -- Don't strip on these filetypes
    if blocklist[vim.bo.filetype] then
        return
    end
    -- Substitute trailing whitespace
    vim.cmd('%s/\\s\\+$//e')
end
vim.cmd('autocmd BufWritePre * lua StripTrailingWhitespace()')

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
-- Debugging
vim.cmd([[
  nnoremap <Space>d odebuger<Esc>
  autocmd FileType python nnoremap<buffer> <Space>d oimport pprint; printer = pprint.PrettyPrinter(indent=4); import pdb; pdb.set_trace()<Esc>
  autocmd FileType ruby nnoremap<buffer> <Space>d obinding.pry<Esc>
  autocmd FileType javascript nnoremap<buffer>  <Space>d odebugger<Esc>
  " print
  nnoremap <Space>p oprint<Esc>
  autocmd FileType go nnoremap<buffer> <Space>p ofmt.Println("")<Esc>bla
  autocmd FileType javascript nnoremap<buffer> <Space>p oconsole.log("")<Esc>bla
]])

-- #########################
-- Plugins

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
require('plugins')
require('onedark').load()
vim.cmd([[autocmd BufWritePost * lua require('gitsigns').stage_hunk()]])

-- #########################
-- Plugins: NvimTree

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
  vim.keymap.set('n', 't',     api.node.open.tab,               opts('Tab'))
  vim.keymap.set('n', 's',     api.node.open.vertical,          opts('Tab'))
  vim.keymap.set('n', 'i',     api.node.open.horizontal,        opts('Tab'))
  vim.keymap.set('n', 'x',     api.node.navigate.parent_close,  opts('Tab'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,            opts('Help'))
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

-- #########################
-- Plugins: nvim-cmp
-- Set up nvim-cmp.
local cmp = require'cmp'
local select_opts = {behavior = cmp.SelectBehavior.Select}
-- Read this: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- Use the name from here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
require('lspconfig')['pyright'].setup { capabilities = capabilities }
require('lspconfig')['ruby_lsp'].setup { capabilities = capabilities }

-- #########################
-- Plugins: nvim-treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "ruby", "bash" },
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
  highlight = {
    enable = true,
    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}


-- #########################
-- Plugins: nvim-treesitter
-- let g:vimwiki_auto_chdir = 0
-- let g:vimwiki_list = [{'path': '$HOME/Dropbox/wiki',
--                       \ 'syntax': 'markdown', 'ext': '.md'}]
--
