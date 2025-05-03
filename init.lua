-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- NVIM RAW CONFIG
vim.g.mapleader = " "
vim.o.cursorline = true
vim.o.termguicolors = true
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }


local opt = vim.opt

opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.list = true -- Show some invisible characters (tabs...
opt.number = true -- Print line number
opt.relativenumber = true
opt.showmode = false
opt.signcolumn = "yes"
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2
opt.smoothscroll = true
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false
vim.opt.swapfile = false
vim.g.markdown_recommended_style = 0

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add 
local map_multistep = require('mini.keymap').map_multistep
local map_combo = require('mini.keymap').map_combo

local mode = {'i', 'c', 'x', 's', 'n' }

-- PLUGINS
add({ source = 'stevearc/oil.nvim' })
require("oil").setup()
map_combo("n", '-', function() require("oil").open() end, { desc= "Open Oil" })

add({source='ggandor/leap.nvim'})
require("leap")

map_combo({'v', 'V', 'x', 's', 'S', 'n'}, 'M','<Plug>(leap)', { desc= "Open Oilsss" })

add({source="williamboman/mason.nvim"})
require("mason").setup()


-- MINI Modules
local miniclue = require('mini.clue')
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = 'n', keys = '<Leader>' },
    { mode = 'x', keys = '<Leader>' },

    -- Built-in completion
    { mode = 'i', keys = '<C-x>' },

    -- `g` key
    { mode = 'n', keys = 'g' },
    { mode = 'x', keys = 'g' },

    -- Marks
    { mode = 'n', keys = "'" },
    { mode = 'n', keys = '`' },
    { mode = 'x', keys = "'" },
    { mode = 'x', keys = '`' },

    -- Registers
    { mode = 'n', keys = '"' },
    { mode = 'x', keys = '"' },
    { mode = 'i', keys = '<C-r>' },
    { mode = 'c', keys = '<C-r>' },

    -- Window commands
    { mode = 'n', keys = '<C-w>' },

    -- `z` key
    { mode = 'n', keys = 'z' },
    { mode = 'x', keys = 'z' },
  },

  window = {
    delay = 200,
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
  },
})
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.bracketed').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.statusline').setup()
