local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
   PACKER_BOOTSTRAP = fn.system {
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
   }
   print "Installing packer close and reopen Neovim..."
   vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
   return
end

-- Have packer use a popup window
packer.init {
   display = {
      open_fn = function()
         return require("packer.util").float { border = "rounded" }
      end,
   },
   compile_path = require("packer.util").join_paths(fn.stdpath('config'), 'lua/user', 'packer_compiled.lua')
}

-- Install your plugins here
return packer.startup(function(use)
   -- My plugins here
   use "wbthomason/packer.nvim"    -- Have packer manage itself
   use "goolord/alpha-nvim"        -- Welcome Screen
   use {
      'lewis6991/impatient.nvim',  -- Speed up load time
      config = {
         -- Cache packer_compiled.lua
         compile_path = fn.stdpath('config')..'/lua/user/packer_compiled.lua'
      }
   }
   use {
      'nvim-telescope/telescope.nvim', -- General fuzzy finder
      requires = { {'nvim-lua/plenary.nvim'} }
   }
   use {
      'nvim-telescope/telescope-fzf-native.nvim', -- Fzf for Telescope
      run = 'make' 
   }
   use 'shaunsingh/nord.nvim'       -- Colorscheme
   use "folke/which-key.nvim"       -- Which key, shows shortcuts
   use {
      'lewis6991/gitsigns.nvim',
      requires = {
         'nvim-lua/plenary.nvim'
      },
   }
   use {
      'kyazdani42/nvim-tree.lua',
      requires = {
         'kyazdani42/nvim-web-devicons', -- optional, for file icon
      },
   }
   use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
   }
   -- Snippets + Autocomplete
   use "akinsho/toggleterm.nvim"
   use 'hrsh7th/cmp-buffer'
   use 'hrsh7th/cmp-path'
   use 'hrsh7th/cmp-cmdline'
   use 'hrsh7th/nvim-cmp'
   use "hrsh7th/cmp-nvim-lsp"
   use 'L3MON4D3/LuaSnip'
   use "rafamadriz/friendly-snippets"
   -- LSP
   use 'neovim/nvim-lspconfig' -- enable LSP
   use 'williamboman/nvim-lsp-installer' -- LSP installer helper
   use "tamago324/nlsp-settings.nvim"
   use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

   -- Treesitter
   use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
   }

   -- Movement
   use 'ggandor/lightspeed.nvim'

   -- NeoGit
   use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }

   -- Automatically set up your configuration after cloning packer.nvim
   -- Put this at the end after all plugins
   if PACKER_BOOTSTRAP then
      require("packer").sync()
   end
end)
