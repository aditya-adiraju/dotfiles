local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local fn = vim.fn

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
  use { 'neoclide/coc.nvim', branch='release' }
  use { 'pappasam/coc-jedi',  build='yarn install --frozen-lockfile && yarn build', branch='main' }
  

  use 'nvim-treesitter/nvim-treesitter'
  use 'sheerun/vim-polyglot'
  use { 'ms-jpq/chadtree', branch='chad', build='python3 -m chadtree deps' }
  use 'petRUShka/vim-sage'

  


 
  -- Themes
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use { "catppuccin/nvim", as = "catppuccin" }

  if packer_bootstrap then
    require('packer').sync()
  end
end)


-- INIT PLUGINS


-- VIM CONFIGS

vim.g.mapleader = ','
vim.opt.clipboard:append {'unnamedplus' }
vim.g.airline_theme = 'catppuccin'


local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.termguicolors = true
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
