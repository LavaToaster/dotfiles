local fn = vim.fn
local installPath = DATA_PATH..'/site/pack/packer/start/packer.nvim'

-- install packer if it's not installed already
local packerBootstrap = nil
if fn.empty(fn.glob(installPath)) > 0 then
  packerBootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', installPath})
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer').startup(function(use)
  -- Packer should manage itself
  use 'wbthomason/packer.nvim'

  -- window
  -- use {'dracula/vim', as = 'dracula'}
  use 'Mofiqul/dracula.nvim'
  use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }
  use 'scrooloose/nerdcommenter'
  use {'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use 'glepnir/galaxyline.nvim'
  use 'mhinz/vim-startify'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-tree'.setup {} end
  }
  use 'lukas-reineke/indent-blankline.nvim'

  -- features
  use {'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'fladson/vim-kitty'

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'hrsh7th/nvim-cmp'
  use 'folke/lsp-colors.nvim'

  -- use 'hrsh7th/nvim-compe'
  -- use 'folke/lsp-trouble.nvim'
  -- use 'folke/lsp-colors.nvim'
  -- use 'glepnir/lspsaga.nvim'

  -- this will automatically install listed dependencies
  -- only the first time NeoVim is opened, because that's when Packer gets installed
  if packerBootstrap then
    require('packer').sync()
  end
end)

-- plugin specific configs go here
require('plugin-config/telescope')
require('plugin-config/nvim-tree')
require('plugin-config/barbar')
require('plugin-config/galaxyline')
require('plugin-config/gitsigns')
require('plugin-config/indent-guide-lines')
require('plugin-config/nvim-cmp')

return packer
