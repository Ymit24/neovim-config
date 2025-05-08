vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        -- or                            , branch = '0.1.x',
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "rose-pine/neovim",
        as = "rose-pine",
        config = function()
            require("rose-pine").setup()
            -- vim.cmd("colorscheme rose-pine")
        end,
    })

    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use("nvim-treesitter/playground")

    -- use('gleam-lang/gleam.vim')

    use("nvim-lua/plenary.nvim")
    use("ThePrimeagen/harpoon")

    use("mbbill/undotree")
    use("tpope/vim-fugitive")

    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            --            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },             -- Required
            { "williamboman/mason.nvim" },           -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },         -- Required
            { "hrsh7th/cmp-nvim-lsp" },     -- Required
            { "hrsh7th/cmp-buffer" },       -- Optional
            { "hrsh7th/cmp-path" },         -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" },     -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" },             -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })

    -- use("nvim-tree/nvim-web-devicons")
    -- NOTE: Taking this out. use({ "romgrk/barbar.nvim", requires = "nvim-web-devicons" })

    -- 	use({
    -- 		"nvim-tree/nvim-tree.lua",
    -- 		requires = {
    -- 			"nvim-tree/nvim-web-devicons", -- optional, for file icons
    -- 		},
    -- 		tag = "nightly", -- optional, updated every week. (see issue #1193)
    -- 	})

    use 'echasnovski/mini.nvim'

    use("jose-elias-alvarez/null-ls.nvim")

    use("github/copilot.vim")
end)
