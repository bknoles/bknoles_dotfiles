vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.g.editorconfig = true
-- Disabling to see how I like it
-- vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true       -- default in Neovim, but harmless

-- Matching
vim.opt.showmatch = true

-- Hide ~ for empty lines
vim.opt.fillchars = { eob = " " }

-- Clear search highlight
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- Editing
vim.opt.virtualedit = "onemore"
vim.opt.history = 1000

-- Spellcheck toggle
vim.keymap.set("n", "<F5>", ":setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spellcheck" })

-- Shortcut to edit init.lua
vim.keymap.set("n", "<leader>ev", ":e $MYVIMRC<CR>", { silent = true, desc = "Edit config" })

vim.keymap.set("n", "<leader>w", ":cclose<CR>", { desc = "Close quickfix" })
vim.keymap.set("n", "<leader>q", ":copen<CR>", { desc = "Open quickfix" })

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Open terminal at bottom
-- Trying out toggleterm instead
-- vim.keymap.set("n", "<leader>t", ":bo 15split | terminal<CR>", { desc = "Open terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

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
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map("n", "]h", gs.next_hunk, "Next hunk")
          map("n", "[h", gs.prev_hunk, "Prev hunk")

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hb", gs.blame_line, "Blame line")
          map("n", "<leader>hd", gs.diffthis, "Diff this")

          -- Toggle blame
          map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
        end,
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        map_cr = true,          -- expand on enter (your commented-out setting)
        map_bs = true,          -- delete pairs with backspace
      })
    end
  },
  { "windwp/nvim-ts-autotag", config = true, },
  { "RRethy/nvim-treesitter-endwise" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>ee", ":Neotree toggle<CR>", desc = "Toggle explorer" },
      { "<leader>fr", ":Neotree reveal<CR>", desc = "Reveal current file" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
        },
      })
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_close = 0
      vim.keymap.set("n", "<leader>mp", "<Plug>MarkdownPreviewToggle", { desc = "Toggle markdown preview" })
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier", "eslint_d" },
          javascriptreact = { "prettier", "eslint_d" },
          typescript = { "prettier", "eslint_d" },
          typescriptreact = { "prettier", "eslint_d" },
          css = { "prettier" },
        },
      })

      vim.keymap.set("n", "<leader>dd", vim.diagnostic.open_float, { desc = "Show diagnostic" })
      vim.keymap.set("n", "<leader>df", function()
        require("conform").format({ async = true })
      end, { desc = "Format buffer" })
    end,
  },
  -- Mason: install language servers
  {
    "williamboman/mason.nvim",
    config = true,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "eslint",
          "ruby_lsp",
          "rust_analyzer",
          "pyright",
          "lua_ls",
          "html",
          "cssls",
        },
      })
    end,
  },

  -- LSP keymaps and config
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Keymaps when LSP attaches
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Find references")
          map("K", vim.lsp.buf.hover, "Hover docs")
          map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("gi", vim.lsp.buf.implementation, "Go to implementation")
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Server configs
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Enable servers
      vim.lsp.enable({
        "ts_ls", "eslint", "ruby_lsp", "gopls",
        "rust_analyzer", "pyright", "lua_ls", "html", "cssls",
      })
    end,
  },
  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",     -- LSP completions
      "hrsh7th/cmp-buffer",        -- Buffer words
      "hrsh7th/cmp-path",          -- File paths
      "L3MON4D3/LuaSnip",          -- Snippet engine
      "saadparwaiz1/cmp_luasnip",  -- Snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          -- Tab to cycle through completions
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Enter to confirm
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion
          ["<C-Space>"] = cmp.mapping.complete(),

          -- Scroll docs
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = 15,
        direction = "horizontal",
        open_mapping = "<leader>tt",
      })

    end,
  },
  {
    "da-moon/telescope-toggleterm.nvim",
    config = function()
      require("telescope-toggleterm").setup({
        telescope_mappings = {
          ["<leader>tk"] = require("telescope-toggleterm").actions.exit_terminal,
        }
      })

      vim.keymap.set("n", "<leader>ts", ":Telescope toggleterm<CR>", { desc = "List terminals" })
    end
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = "<C-Right>",
            accept_line = "<C-Down>",
            dismiss = "<C-]>",
            next = "<M-]>",
            prev = "<M-[>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  }

})
