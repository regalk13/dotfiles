-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- neogit
  use("TimUntersberger/neogit")
  
  -- colorscheme
  use 'folke/tokyonight.nvim'
  use("sainnhe/everforest")
  use('shaunsingh/oxocarbon.nvim', { run = './install.sh' })
  use('catppuccin/nvim', { as="catppuccin" })
  -- Tl
  use("nvim-telescope/telescope.nvim")
  
  -- Editor
  use("hrsh7th/cmp-buffer")
  use("onsails/lspkind-nvim") 
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/nvim-cmp")
  use("L3MON4D3/LuaSnip")
  use("saadparwaiz1/cmp_luasnip")
  use("nvim-lua/lsp_extensions.nvim")
  use("glepnir/lspsaga.nvim")
  use("simrat39/symbols-outline.nvim")
  use 'neovim/nvim-lspconfig'
  use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
  })
  use("tzachar/cmp-tabnine", { run = "./install.sh" })
  use("nvim-treesitter/playground")
  use("romgrk/nvim-treesitter-context")

  use("mfussenegger/nvim-dap")
  use("rcarriga/nvim-dap-ui")
  use("theHamsta/nvim-dap-virtual-text") 
  use("ThePrimeagen/vim-be-good")
end)
