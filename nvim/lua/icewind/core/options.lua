local constants = require("icewind.core.constants")
--------------------------------------------------------------------------------
-- Global editor options
--
-- Some of the options for older versions of NeoVim were omitted
-- since they have sane defaults in NeoVim 0.4+
--------------------------------------------------------------------------------

local set = vim.opt
local g = vim.g

set.hidden = true

-- UI language

-- Language settings
-- Disabled it because it works pretty bad. Using cspell at the moment
set.spell = false
set.spelllang = { "en_US" }
set.spellsuggest = "5"
set.spelloptions = "camel"

-- Set the colorscheme
vim.cmd.colorscheme(constants.color_scheme)

-- General UI settings
set.signcolumn = "yes:1"
set.fillchars = { eob = " " }
set.shortmess:append({ W = true, I = true, c = true, C = true })
set.showmode = false -- Dont show mode since we have a statusline
set.wildmode = "longest:full,full" -- Command-line completion mode
set.splitkeep = "screen"

set.mouse = "a"
set.clipboard = "unnamedplus" -- Use system clipboard

set.termguicolors = true
set.number = true
set.relativenumber = true
set.ruler = true
set.background = "dark"
set.colorcolumn = "120"
set.splitright = true
set.splitbelow = true

-- Global status line for neovim 0.7+
set.laststatus = 3

-- Default formatting options
set.conceallevel = 0
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4

set.expandtab = true
set.wrap = false
set.autoindent = true
set.smarttab = true
set.shiftround = true

-- Search options
set.hlsearch = true
set.incsearch = true
set.smartcase = true
set.ignorecase = true
set.showmatch = true
set.formatoptions = "jcroqlnt"
set.grepformat = "%f:%l:%c:%m"
set.grepprg = "rg --vimgrep"

-- Disable swap files. No need because of version control systems
g.nobackup = true
g.noswapfile = true
g.noundofile = true

-- Popup menu
set.pumblend = 0 -- Popup blend. Values from 0 to 100
set.pumheight = 10 -- Maximum number of entries in a popup

-- No need to set specific color for floating windows, I use rounded border for them
vim.api.nvim_set_hl(0, "NormalFloat", {})
vim.api.nvim_set_hl(0, "FloatBorder", {})

-- Session options
set.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }

-- Using treesitter to fold/unfold
vim.wo.foldlevel = 20
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- Autocompletion
set.completeopt = { "menu", "menuone", "noselect" }

-- TODO: Move the following lines out of the main config file

-- Code highlight in markdown files
g.markdown_fenced_languages = { "rust", "go", "typescript", "javascript", "python", "sql", "css", "json", "mermaid" }

-- Databases
g["db_ui_use_nerd_fonts"] = 1
g["db_ui_save_location"] = "~/Projects/SQLPad"

-- Markdown preview theme.
-- Better to see mermaid diagrams contrast before exporting them to Confluence
g.mkdp_theme = "light"

vim.diagnostic.config({
    severity_short = true,
    signs = {
        text = {
            -- They will be drawn in different colors
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "●",
        },
    },
})
