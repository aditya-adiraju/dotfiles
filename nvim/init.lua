local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local fn = vim.fn
vim.o.termguicolors = true

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  -- Autocomplete
  use 'neovim/nvim-lspconfig'
  use "williamboman/mason-lspconfig.nvim"
  use "williamboman/mason.nvim"
  use 'mfussenegger/nvim-lint'

  -- COC stuff
  use { 'neoclide/coc.nvim', branch='release' }
  use { 'pappasam/coc-jedi',  build='yarn install --frozen-lockfile && yarn build', branch='main' }
  
  use 'windwp/nvim-ts-autotag'

  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'

  -- Colors and pretty doodads
  use 'norcalli/nvim-colorizer.lua'
  use 'windwp/nvim-autopairs'
  use 'mhartington/formatter.nvim'

  -- Themes
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'nvim-tree/nvim-web-devicons'

  -- Git 
  use 'lewis6991/gitsigns.nvim'
  use 'tpope/vim-fugitive'

  -- Fuzzy Find and file browsers :))))
  use {
      "nvim-telescope/telescope-file-browser.nvim",
      requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  use { 'ms-jpq/chadtree', branch='chad', build='python3 -m chadtree deps' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- INIT PLUGINS
require('colorizer').setup()
require('gitsigns').setup()
require('nvim-ts-autotag').setup()
require("mason").setup()
-- I AM TOO LAZY TO MAKE THIS LOOK PRETTY
local remap = vim.api.nvim_set_keymap
local npairs = require('nvim-autopairs')
npairs.setup({map_cr=false})

-- skip it, if you use another global object
_G.MUtils= {}

-- new version for custom pum
MUtils.completion_confirm=function()
    if vim.fn["coc#pum#visible"]() ~= 0  then
        return vim.fn["coc#pum#confirm"]()
    else
        return npairs.autopairs_cr()
    end
end

remap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})


-- VIM CONFIGS

vim.g.mapleader = ' '
vim.opt.clipboard:append {'unnamedplus'}
vim.g.airline_theme = 'catppuccin'


local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.syntax = 'on'
o.errorbells = false
o.smartcase = true
o.showmode = false
bo.swapfile = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt='menuone,noinsert,noselect'
bo.autoindent = true
bo.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
wo.number = true
wo.relativenumber = true

wo.signcolumn = 'yes'
wo.wrap = false

vim.cmd[[colorscheme catppuccin]]

local keyset = vim.keymap.set
-- Autocomplete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<tab>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<tab>"]], opts)

keyset('', '<leader>v', '<cmd>CHADopen<cr>', {noremap = true})
keyset('', '<leader>p', '<cmd>Format<cr>', {noremap = true})
keyset('', '<leader>P', '<cmd>FormatWrite<cr>', {noremap = true})

local builtin = require('telescope.builtin')
keyset('n', '<leader>ff', builtin.find_files, {})
keyset('n', '<leader>fg', builtin.live_grep, {})
keyset('n', '<leader>fb', builtin.buffers, {})
keyset('n', '<leader>fh', builtin.help_tags, {})
