--##############################################
--weaponize configuration script
--###############################################
-- we start with basic default settings
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.timeoutlen = 300
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--##############################################

--GLOBAL KEYMAPS
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>q", ":q<CR>", { desc = "Quit file" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "File explorer" })
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Buffers" })
map("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Help" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file" })

--##############################################

-- terminal (toggleterm) 
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

--##############################################

--PLUGIN CONFIGURATIONS (lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

    -- =========================== THEME (Catppuccin Mocha) ===========================
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",   -- dark, hacker vibe
                transparent_background = false,
                term_colors = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                    treesitter = true,
                    indent_blankline = { enabled = true },
                    lsp_trouble = true,
                    which_key = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },

        {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "pyright", "lua_ls", "tsserver", "rust_analyzer" },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            local on_attach = function(client, bufnr)
                -- Enable completion trigger
                if client.supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
                end
                -- Buffer keymaps
                local bufopts = { buffer = bufnr, noremap = true, silent = true }
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
            end

              -- Python (pyright) – this gives you os.listdir, etc.
            lspconfig.pyright.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

                        -- Lua
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
                settings = { Lua = { runtime = { version = "LuaJIT" }, diagnostics = { globals = { "vim" } } } },
            })
            -- TypeScript / JavaScript
            lspconfig.tsserver.setup({ on_attach = on_attach, capabilities = capabilities })
            -- Rust
            lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
        end,
    }

