-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

-- general
lvim.log.level = "info"

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = ","
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["H"] = "^"
lvim.keys.normal_mode["L"] = "$"
lvim.keys.normal_mode["R"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["E"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-b>"] = ":NvimTreeToggle<CR>"
lvim.keys.normal_mode["ff"] = ":lua vim.lsp.buf.format()<CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- insert_mode keymapping
lvim.keys.insert_mode["<C-v>"] = "<ESC>pa"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
  { command = "stylua" },
  {
    command = "prettier",
    extra_args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
})
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
  { command = "flake8", filetypes = { "python" } },
  {
    command = "shellcheck",
    args = { "--severity", "warning" },
  },
})
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "proselint",
  },
}

-- ~/.config/nvim/lua/plugins/telescope.lua
-- 配置ctrl+j、ctrl+k来浏览文件
local actions = require("telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
  },
  {
    "tpope/vim-surround",
    -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
    -- setup = function()
    --  vim.o.timeoutlen = 500
    -- end
  },
  {
    -- 文本插件
    "brooth/far.vim",
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    config = function()
      vim.cmd "highlight default link gitblame SpecialComment"
      require("gitblame").setup { enabled = false }
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require('neoscroll').setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { '<C-u>', '<C-d>', '<C-f>',
          '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
        hide_cursor = true,          -- Hide cursor while scrolling
        stop_eof = true,             -- Stop at <EOF> when scrolling downwards
        use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
        respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil,       -- Default easing function
        pre_hook = nil,              -- Function to run before the scrolling animation starts
        post_hook = nil,             -- Function to run after the scrolling animation ends
      })
    end
  },
  {
    "nvim-treesitter",
    event = "BufRead",
    config = function()
      require('nvim-treesitter.configs').setup({
        -- 支持的语言
        ensure_installed = { "html", "css", "vim", "lua", "javascript", "typescript", "c", "cpp", "python", "vue" },
        -- 启用代码高亮
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        --启用增量选择
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<CR>',
            node_decremental = '<BS>',
            scope_incremental = '<TAB>'
          }
        },
        -- 启用基于 Treesitter 的代码格式化(=)
        indent = {
          enable = true
        },
      })
    end,
  }
}
