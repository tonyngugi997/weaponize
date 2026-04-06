-- ============================================================================
-- WEAPONIZE - Neovim Configuration
-- ============================================================================
-- Author:  Tony Ngugi
-- GitHub:  @tonyngugi997
-- Repo:    https://github.com/tonyngugi997/weaponize
-- License: MIT
-- ----------------------------------------------------------------------------
-- Turn your Android into a god-mode development environment.
-- No laptop. No PC. No excuses.
-- ============================================================================


----------------------------------------------------------------------------
-- basic defaults (feel free to customize these as you like)
-- ----------------------------------------------------------------------------
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

-- ----------------------------------------------------------------------------
-- 2. GLOBAL KEYMAPS
-- ----------------------------------------------------------------------------
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

-- Terminal (toggleterm)
map("n", "<leader>tt", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

-- ----------------------------------------------------------------------------
-- 3. PLUGIN MANAGER (lazy.nvim)
-- ----------------------------------------------------------------------------
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

    -- =========================== LSP & MASON (Python, Lua, JS/TS, Rust) ===========================
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
    },

    -- =========================== AUTOCOMPLETION (Bordered, Icons, Snippets) ===========================
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D4/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()
            require("lspkind").init()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
                    }),
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        before = function(entry, vim_item)
                            vim_item.menu = "[" .. (entry.source.name or "?") .. "]"
                            return vim_item
                        end,
                    }),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                experimental = { ghost_text = true },
            })
        end,
    },
    "L3MON4D4/LuaSnip",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind.nvim",

    -- =========================== FILE EXPLORER (nvim-tree) ===========================
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    width = 30,
                    side = "left",
                    number = false,
                    relativenumber = false,
                },
                renderer = {
                    group_empty = true,
                    icons = {
                        show = { file = true, folder = true, folder_arrow = true, git = true },
                    },
                },
                filters = { dotfiles = false },
                git = { ignore = false },
                actions = { open_file = { quit_on_open = false } },
            })
        end,
    },

    -- =========================== TELESCOPE (Fuzzy Finder) ===========================
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("telescope").setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = { horizontal = { prompt_position = "top" } },
                    sorting_strategy = "ascending",
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                        },
                    },
                },
            })
        end,
    },

    -- =========================== INDENTATION GUIDES ===========================
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "│", highlight = "Whitespace" },
                scope = { enabled = true, show_start = false, show_end = false },
                exclude = { filetypes = { "help", "dashboard", "lazy", "mason" } },
            })
        end,
    },

    -- =========================== GIT INTEGRATION ===========================
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                },
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns
                    vim.keymap.set("n", "<leader>hs", gs.stage_hunk, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>hr", gs.reset_hunk, { buffer = bufnr })
                    vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr })
                end,
            })
        end,
    },

    -- =========================== STATUSLINE (Lualine) ===========================
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = { theme = "catppuccin", component_separators = "", section_separators = "" },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    lualine_c = { "filename", "diagnostics" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },

    -- =========================== TABLINE (Bufferline) ===========================
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    diagnostics = "nvim_lsp",
                    offsets = { { filetype = "NvimTree", text = "Explorer", text_align = "left" } },
                },
            })
        end,
    },

    -- =========================== AUTO-PAIRING ===========================
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- =========================== COMMENT TOGGLE ===========================
    {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    },

    -- =========================== SURROUND (fixed plugin name) ===========================
    {
        "kylechui/nvim-surround",
        version = "*",
        config = function()
            require("nvim-surround").setup({})
        end,
    },

    -- =========================== TERMINAL (Toggleterm) ===========================
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({
                size = 12,
                open_mapping = [[<leader>tt]],
                direction = "horizontal",
                start_in_insert = true,
                shade_terminals = true,
            })
        end,
    },

    -- =========================== SYNTAX HIGHLIGHTING (Treesitter) ===========================
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "javascript", "typescript", "rust", "c", "bash", "json", "yaml" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    -- =========================== WHICH-KEY (Help popup) ===========================
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({ window = { border = "single" } })
        end,
    },

    -- =========================== DASHBOARD (Weaponize startup screen) ===========================
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        config = function()
            local db = require("dashboard")
            db.setup({
                theme = "hyper",   -- hacker style
                config = {
                    header = {
                        "                                                                      ",
                        "  ██     ██ ███████  █████  ██████  ██████  ███    ██ ██ ███████╗ ███████╗",
                        "  ██     ██ ██      ██   ██ ██   ██ ██   ██ ████   ██ ██ ██      ██      ",
                        "  ██  █  ██ █████   ███████ ██████  ██████  ██ ██  ██ ██ █████   ███████╗",
                        "  ██ ███ ██ ██      ██   ██ ██      ██   ██ ██  ██ ██ ██ ██           ██",
                        "   ███ ███  ███████ ██   ██ ██      ██   ██ ██   ████ ██ ███████ ███████║",
                        "                                                                      ",
                        "  ⚡  W E A P O N I Z E  |  H A C K E R   E D I T I O N  ⚡",
                        "                                                                      ",
                    },
                    center = {
                        { icon = "🔍 ", desc = "Find File", action = "Telescope find_files", shortcut = "<leader>ff" },
                        { icon = "📁 ", desc = "Explorer", action = "NvimTreeToggle", shortcut = "<leader>e" },
                        { icon = "📝 ", desc = "New File", action = "enew", shortcut = "Ctrl + n" },
                        { icon = "⚙️ ", desc = "Plugins", action = "Lazy", shortcut = "<leader>l" },
                        { icon = "🐙 ", desc = "Git Status", action = "Neogit", shortcut = "<leader>gg" },
                    },
                    footer = {
                        "🔥 Your Android is now a development fortress.",
                        "   Type <leader>? for all keymaps.",
                        "",
                    },
                },
            })
        end,
    },
}, {
    install = { colorscheme = { "catppuccin" } },
    checker = { enabled = true, notify = false },
    change_detection = { notify = false },
})

-- ----------------------------------------------------------------------------
-- 4. FINAL AUTOCOMMANDS (LSP, format on save, etc.)
-- ----------------------------------------------------------------------------
-- Ensure LSP completion triggers automatically
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

-- Auto‑format on save (optional – uncomment if you want)
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.py", "*.lua", "*.js", "*.ts", "*.rs" },
--   callback = function() vim.lsp.buf.format({ async = false }) end,
-- })

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})

print("🔥 Weaponize Hacker Edition loaded. Type <leader>? for help.")