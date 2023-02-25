-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Packer can manage itself
  'wbthomason/packer.nvim',
  -- neogit
  'TimUntersberger/neogit',

  -- colorscheme
  'folke/tokyonight.nvim',
  'sainnhe/everforest',
  'tiagovla/tokyodark.nvim',
 {
      'catppuccin/nvim', 
      name='catppuccin'
  },
 
  -- Tl
  'nvim-telescope/telescope.nvim',
  
  -- Editor
  'hrsh7th/cmp-buffer',
  'onsails/lspkind-nvim', 
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  'nvim-lua/lsp_extensions.nvim',
  'glepnir/lspsaga.nvim',
  'simrat39/symbols-outline.nvim',
  'neovim/nvim-lspconfig',
  {
      "nvim-treesitter/nvim-treesitter", 
      build = ":TSUpdate"
  },
  "nvim-treesitter/playground",
  "romgrk/nvim-treesitter-context",

  "mfussenegger/nvim-dap",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text", 
  "iamcco/markdown-preview.nvim",
  {
      "nvim-lualine/lualine.nvim",
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
  },
})
