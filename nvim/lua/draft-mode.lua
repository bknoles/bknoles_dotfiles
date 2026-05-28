local ghostty_config = vim.fn.expand("~/.config/ghostty/config")
local ghostty_script = vim.fn.expand("~/.config/ghostty/writing-mode")

local function ghostty_writing_active()
  local f = io.open(ghostty_config, "r")
  if not f then return false end
  local content = f:read("*a")
  f:close()
  return content:match("config%-file = writing/on") ~= nil
end

local function apply_draft_colors()
  vim.o.background = "light"
  -- vim.cmd("colorscheme pencil")
  vim.g.zenbones_lightness = "bright"
  vim.cmd("colorscheme zenbones")
end

local function apply_draft_keymaps()
  vim.keymap.set({ "n", "v" }, "<Up>",    "gk", { desc = "Visual line up" })
  vim.keymap.set({ "n", "v" }, "<Down>",  "gj", { desc = "Visual line down" })
  vim.keymap.set("i", "<Up>",   "<C-o>gk", { desc = "Visual line up" })
  vim.keymap.set("i", "<Down>", "<C-o>gj", { desc = "Visual line down" })
  vim.keymap.set({ "n", "v" }, "<M-b>",     "b", { desc = "Word left" })
  vim.keymap.set({ "n", "v" }, "<M-f>",     "w", { desc = "Word right" })
  vim.keymap.set({ "n", "v" }, "<M-Left>",  "b", { desc = "Word left" })
  vim.keymap.set({ "n", "v" }, "<M-Right>", "w", { desc = "Word right" })
  vim.keymap.set("i", "<M-b>",     "<C-o>b", { desc = "Word left" })
  vim.keymap.set("i", "<M-f>",     "<C-o>w", { desc = "Word right" })
  vim.keymap.set("i", "<M-Left>",  "<C-o>b", { desc = "Word left" })
  vim.keymap.set("i", "<M-Right>", "<C-o>w", { desc = "Word right" })
end

local function apply_draft_display_styles()
  vim.o.linebreak = true
  require("zen-mode").open()
end

local function reset_default_colors()
  vim.o.background = "dark"
  vim.cmd("colorscheme night-owl")
end

local function reset_default_keymaps()
  for _, mode in ipairs({ "n", "v", "i" }) do
    pcall(vim.keymap.del, mode, "<Up>")
    pcall(vim.keymap.del, mode, "<Down>")
    pcall(vim.keymap.del, mode, "<M-b>")
    pcall(vim.keymap.del, mode, "<M-f>")
    pcall(vim.keymap.del, mode, "<M-Left>")
    pcall(vim.keymap.del, mode, "<M-Right>")
  end
end

local function reset_default_display_styles()
  vim.o.linebreak = false
  require("zen-mode").close()
end

local function disable_bg_detection()
  for _, ac in ipairs(vim.api.nvim_get_autocmds({ group = "nvim.tty", event = "TermResponse" })) do
    vim.api.nvim_del_autocmd(ac.id)
  end
end

local function toggle_draft_mode()
  if not ghostty_writing_active() then
    disable_bg_detection()
    apply_draft_colors()
    apply_draft_keymaps()
    apply_draft_display_styles()
    vim.fn.system(ghostty_script .. " on")
    vim.notify("Draft mode ON", vim.log.levels.INFO)
  else
    reset_default_colors()
    reset_default_keymaps()
    reset_default_display_styles()

    vim.fn.system(ghostty_script .. " off")
    vim.notify("Draft mode OFF", vim.log.levels.INFO)
  end
end

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.schedule(function()
      if ghostty_writing_active() then
        apply_draft_colors()
      end
    end)
  end,
})

vim.api.nvim_create_user_command("Draft", toggle_draft_mode, { desc = "Toggle draft/writing mode" })
vim.keymap.set("n", "<leader>dr", toggle_draft_mode, { desc = "Toggle draft mode" })
