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
opt.clipboard = 'unnamedplus'
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2  -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true    -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true  -- Use spaces instead of tabs
opt.list = true       -- Show some invisible characters (tabs...
opt.number = true     -- Print line number
opt.relativenumber = true
opt.showmode = false
opt.signcolumn = "yes"
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true  -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true  -- Put new windows right of current
opt.tabstop = 2
opt.shiftwidth = 2
opt.smoothscroll = true
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false
vim.opt.swapfile = false
vim.g.markdown_recommended_style = 0

vim.cmd([[colorscheme wildcharm]])

vim.api.nvim_set_hl(0, "CursorLine", { background = '#553119' })

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

local add = MiniDeps.add

-- PLUGINS
add({ source = 'stevearc/oil.nvim' })
require("oil").setup()

local map = vim.keymap.set
local nomap = vim.keymap.del

map("n", "-", "<cmd>Oil<cr>", { desc = "Open the oil file menu" })

add({ source = 'ggandor/leap.nvim' })
map({ "n", "v" }, "m", "<Plug>(leap-forward)", { desc = "Leap forward" })
map({ "n", "v" }, "M", "<Plug>(leap-backward)", { desc = "Leap backward" })

add({
  source = "ibhagwan/fzf-lua",
  depends = { "nvim-tree/nvim-web-devicons" },
})
map("n", "<leader>ff", function() require('fzf-lua').files() end, { desc = "Find files" })
map("n", "<leader>fw", function() require('fzf-lua').live_grep() end, { desc = "Find live grep" })
map("n", "<leader>fz", function() require('fzf-lua').lgrep_curbuf() end, { desc = "Find live grep in buffer" })

add({ source = 'folke/which-key.nvim' })
require('which-key').setup({
  triggers = {
    { "<auto>",   mode = "nixsotc" },
    { "<Leader>", mode = { "n", "v" } },
  }
})

add({ source = "nvim-treesitter/nvim-treesitter" })
add({
  source = "ThePrimeagen/harpoon",
  checkout = "harpoon2",
  depends = { "nvim-lua/plenary.nvim" },
})

local harpoon = require("harpoon")
harpoon:setup({})
map("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon List" })
map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon Add" })
map("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon Goto 1" })
map("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon Goto 2" })
map("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon Goto 3" })
map("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon Goto 4" })
map("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon Goto 5" })

add({ source = "folke/zen-mode.nvim" })

-- LSP

add({ source = 'neovim/nvim-lspconfig' })

add({ source = "williamboman/mason.nvim" })
require("mason").setup()

vim.lsp.enable("rubocop")
vim.lsp.config("rubocop", {})
vim.lsp.enable("ruby-lsp")
vim.lsp.config("ruby-lsp", {})
vim.lsp.enable('lua_ls')
vim.lsp.enable('dartls')
vim.lsp.enable('gopls')
vim.lsp.enable('rust_analyzer')
vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})

map("n", "<leader>fm", vim.lsp.buf.format, { desc = "format buffer" })
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code action" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "code rename" })
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "goto definition" })

-- CUSTOM TREE SITTER LANGS
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.shadow = {
  install_info = {
    url = "~/dev/luna/tree-sitter-shadow",  -- local path or git repo
    files = { "src/parser.c" },             -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main",                        -- default branch in case of git repo if different from master
    generate_requires_npm = false,          -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "shd",                         -- if filetype does not match the parser name
}

-- In your init.lua, after adding nvim-treesitter
add({ source = "nvim-treesitter/nvim-treesitter" })

vim.filetype.add({
  extension = {
    shd = "shadow",
  },
})

-- !!! Add this block !!!
require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "shadow" }, -- Make sure "shadow" is here!

  -- Install parsers synchronously (only applied when `ensure_installed` is not "all")
  sync_install = false,

  -- Automatically install missing parsers when entering a buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  highlight = {
    enable = true, -- !!! Crucial: Enable highlighting !!!
    disable = {},  -- A list of language names to attach highlighting to.
    -- Set this to `true` for all Lua files, or a list of languages
    additional_vim_regex_highlighting = false,
  },
  -- If you also want to enable indenting or other features:
  -- indent = { enable = true },
  -- auto_tag = { enable = true },
  -- etc.
})

vim.treesitter.language.register("shadow", "shd")

-- MINI Modules
require('mini.completion').setup()
require('mini.pairs').setup()
require('mini.surround').setup()
require('mini.bracketed').setup()
require('mini.git').setup()
require('mini.diff').setup()
require('mini.icons').setup()
require('mini.indentscope').setup()
require('mini.statusline').setup()
