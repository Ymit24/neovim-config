local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Associate your parser with your custom language file pattern
parser_config.lumina = {
    install_info = {
        url = "~/dev/tree-sitter-lumina",
        files = { "src/parser.c" } -- Path to your Tree-sitter parser

    },
    filetype = "lumina" -- Filetype you want to associate
}

-- Associate your parser with your custom language file pattern
parser_config.luna = {
    install_info = {
        url = "~/dev/logisim/digital_computer/tree-sitter-luna",
        files = { "src/parser.c" }               -- Path to your Tree-sitter parser
    },
    requires_generate_from_grammar = false,      -- if folder contains pre-generated src/parser.c
    filetype = "luna"                            -- Filetype you want to associate
}
vim.treesitter.language.register('luna', 'luna') -- the someft filetype will use the python parser and queries.
vim.filetype.add({
    extension = {
        luna = 'luna',
    },
})
-- Shadow
parser_config.shadow = {
    install_info = {
        url = "~/dev/logisim/digital_computer/tree-sitter-shadow",
        files = { "src/parser.c" }                   -- Path to your Tree-sitter parser
    },
    requires_generate_from_grammar = false,          -- if folder contains pre-generated src/parser.c
    filetype = "shadow"                              -- Filetype you want to associate
}
vim.treesitter.language.register('shadow', 'shadow') -- the someft filetype will use the python parser and queries.
vim.filetype.add({
    extension = {
        shadow = 'shadow',
    },
})
-- Lunar
parser_config.lunar = {
    install_info = {
        url = "~/dev/logisim/digital_computer/tree-sitter-lunar",
        files = { "src/parser.c" }                 -- Path to your Tree-sitter parser
    },
    requires_generate_from_grammar = false,        -- if folder contains pre-generated src/parser.c
    filetype = "lunar"                             -- Filetype you want to associate
}
vim.treesitter.language.register('lunar', 'lunar') -- the someft filetype will use the python parser and queries.
vim.filetype.add({
    extension = {
        lunar = 'lunar',
    },
})
-- Bulb
parser_config.bulb = {
    install_info = {
        url = "~/dev/logisim/digital_computer/tree-sitter-bulb",
        files = { "src/parser.c" }               -- Path to your Tree-sitter parser
    },
    requires_generate_from_grammar = false,      -- if folder contains pre-generated src/parser.c
    filetype = "bulb"                            -- Filetype you want to associate
}
vim.treesitter.language.register('bulb', 'bulb') -- the someft filetype will use the python parser and queries.
vim.filetype.add({
    extension = {
        bulb = 'bulb',
    },
})

-- Enable Tree-sitter highlighting
require 'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "javascript", "typescript", "rust", "c", "lua", "vim", "help" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (for "all")
    -- NOTE: WHY? -- ignore_install = { "javascript" },
    ignore_install = { "help" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

vim.cmd [[
    autocmd BufNewFile,BufRead *.la set filetype=lumina
]]

function augroup(name, cb)
    local id = vim.api.nvim_create_augroup(name, {})
    local function do_create(event, opts)
        local newopts = vim.deepcopy(opts)
        newopts.group = id
        vim.api.nvim_create_autocmd(event, newopts)
    end

    cb(do_create)
end

-- Define the function to execute the toggles and print debug messages
_G.toggleHighlight = function()
    vim.cmd("TSToggle highlight")
    vim.cmd("TSToggle highlight")
end

-- Create the autocmd to trigger when a .scm file is written
vim.cmd [[
  augroup HighlightSCM
    autocmd!
    autocmd BufWritePost *.scm lua _G.toggleHighlight()
  augroup END
]]
