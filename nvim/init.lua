vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.termguicolors = true

-- Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
	ensure_installed = {
	  "ruby", "javascript", "typescript", "tsx",
	  "html", "css", "yaml", "dockerfile",
	  "lua", "vim", "vimdoc",
	  "python", "rust", "go",
	},
      })
    end,
  },
  {
    "oxfist/night-owl.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("night-owl")
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
  },
  { "norcalli/nvim-colorizer.lua", config = true },
  -- TODO later: setup git signs for line numbers
  -- { "lewis6991/gitsigns.nvim", config = true }
  { "kylechui/nvim-surround", config = true },
  { "tpope/vim-fugitive" },
})
