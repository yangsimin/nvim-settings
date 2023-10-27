local HOME = os.getenv("HOME")
vim.cmd.source(HOME .. "/.vimrc")

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

require("lazy").setup({
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "elixir",
          "heex",
          "javascript",
          "html",
          "vue",
          "typescript",
          "tsx",
        },
        sync_install = false,
        highlight = { enable = false },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
            include_surrounding_whitespace = true,
          },
        },
      })
    end,
  },
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
})

vim.cmd([[
  xnoremap gc <Plug>VSCodeCommentarygv
  nnoremap gc <Plug>VSCodeCommentarygv
  nnoremap gcc <Plug>VSCodeCommentaryLine
]])


-- Commands(:)
-- x/wq     (close active tab)
-- xa/wqa   (close all tabs)

-- Keybindings
-- ZZ       (close active tab)
-- gt       (switch next tab)
-- gT       (switch previous tab)
-- gh       (show hover)
-- gd       (go to definition)
-- gD       (peek definition)
-- <C-w>gd  (go to definition in new window)
-- <C-i>    (navigate forward)
-- <C-o>    (navigate back)
-- M        (move cursor to middle)
-- zz       (reveal center)
-- zt       (reveal top)
-- zb       (reveal bottom)
