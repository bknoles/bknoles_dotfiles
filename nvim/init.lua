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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
	defaults = {
	  layout_strategy = "vertical",
	  layout_config = {
	    vertical = {
	      height = 0.6,
	      preview_height = 0.5,
	      preview_cutoff = 0,
	    },
	  },
	},
      })

      -- Files
      vim.keymap.set("n", "<Leader>p", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep in files" })
      vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Grep word under cursor" })
      vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Recent files" })

      -- Buffers
      vim.keymap.set("n", ";", builtin.buffers, { desc = "Buffers" })

      -- Git
      vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })

      -- Help
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })

      vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Commands" })
      vim.keymap.set("n", "<leader><leader>", builtin.builtin, { desc = "Telescope pickers" })
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
})
