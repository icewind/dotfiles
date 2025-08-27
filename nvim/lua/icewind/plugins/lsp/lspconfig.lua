local format_with_lsp = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            local buffer_type = vim.api.nvim_buf_get_option(bufnr, "filetype")
            -- Using default formatter
            if not vim.tbl_contains({ "typescript", "typescriptreact", "javascript", "javascriptreact", "json" }, buffer_type) then
                return true
            end

            local is_biome = vim.uv.fs_stat("./biome.json")
            local is_prettier = (vim.uv.fs_stat("./prettierrc") or vim.uv.fs_stat("./prettierrc.json"))
            local is_ts_ls = vim.uv.fs_stat("./package.json")

            -- Biome
            if is_biome and client.name == "biome" then
                return true
            end

            -- Prettier
            if not is_biome and is_prettier and client.name == 'prettierd' then
                return true
            end

            -- Typescript language server
            if not is_biome and not is_prettier and is_ts_ls and client.name == 'ts_ls' then
                return true
            end

            return false
        end,
        bufnr = bufnr,
    })
end

-- Check if the method is supported by any of the attached LSPs
local supports = function(bufnr, action)
    action = action:find("/") and action or "textDocument/" .. action
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        if client:supports_method(action) then
            return true
        end
    end
    return false
end

--- Lsp-specific key mapping
--- @param bufnr number
--- @param keys string
--- @param func function | string
--- @param opts { mode?: string | table, has?: string, desc?: string, nowait?: boolean }
local mapkey = function(bufnr, keys, func, opts)
    if opts.desc then
        opts.desc = "LSP: " .. opts.desc
    end
    if opts.has and not supports(bufnr, opts.has) then
        return
    end
    vim.keymap.set(opts.mode or "n", keys, func, {
        buffer = bufnr,
        desc = opts.desc,
        noremap = true,
        silent = true,
        nowait = opts.nowait
    })
end

-- configuration is in a foler `/after/lsp/{name}.lua`
local language_servers = {
    "lua_ls",
    "ltex",
    "marksman",
    "rust_analyzer",
    "svelte",
    "tailwindcss",
    "eslint",
    "biome",
    "ts_ls",
}

local map_keys_for_lsp = function(bufnr)
    mapkey(bufnr, "K", function() return vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover docs" })
    mapkey(bufnr, "<c-k>", function() return vim.lsp.buf.signature_help() end, { mode = "i", desc = "Signature help" })

    -- Map only if this is not a part of DiffView tabpage
    mapkey(bufnr, "<leader>ca", vim.lsp.buf.code_action, { mode = { "n", "v" }, has = "codeAction" })
    mapkey(bufnr, "<leader>cA", function()
        vim.lsp.buf.code_action({
            context = {
                only = {
                    "source",
                },
                diagnostics = {},
            },
        })
    end, { mode = { "n", "v" }, desc = "Global code actions" })

    mapkey(bufnr, "<leader>cc", vim.lsp.codelens.run, {
        has = "codeLens",
        desc = "Display Codelens",
    })
    mapkey(bufnr, "<leader>cC", vim.lsp.codelens.refresh, {
        has = "codeLens",
        desc = "Refresh & Display Codelens",
    })

    mapkey(bufnr, "<leader>cf", function() format_with_lsp(bufnr) end, {
        desc = "Format the file",
        has = "formatting",
    })

    mapkey(bufnr, "<leader>cf", function() format_with_lsp(bufnr) end, {
        mode = "v",
        desc = "Format selected text",
        has = "rangeFormatting",
    })

    mapkey(bufnr, "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References", nowait = true })
    mapkey(bufnr, "gd", vim.lsp.buf.definition, {
        desc = "Go to definition",
        has = "definition",
    })
    mapkey(bufnr, "gD", vim.lsp.buf.declaration, {
        desc = "Go to declaration",
        has = "declaration"
    })
    mapkey(bufnr, "<leader>rn", vim.lsp.buf.rename, {
        has = "rename",
        desc = "Rename symbol",
    })

    mapkey(bufnr, "<leader>ds", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Document symbols" })
    mapkey(bufnr, "<leader>ws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", { desc = "Workspace symbols" })
end

local setup_none_ls = function()
    local null_ls = require("null-ls")
    null_ls.setup({
        should_attach = function(bufnr)
            return not vim.api.nvim_buf_get_name(bufnr):match("^git://")
        end,
        sources = {
            null_ls.builtins.formatting.prettierd.with({
                filetypes = {
                    "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css",
                    "scss", "less", "html", "json", "jsonc", "yaml", "markdown", "markdown.mdx",
                    "graphql", "handlebars", "astro",
                },
                condition = function(utils)
                    return utils.root_has_file(".prettierrc")
                        or utils.root_has_file(".prettierrc.json")
                        or utils.root_has_file(".prettierrc.js")
                end,
            })
        }
    });
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        "nvimtools/none-ls.nvim",
    },
    config = function()
        vim.lsp.config("*", {
            capabilities = vim.lsp.protocol.make_client_capabilities()
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                map_keys_for_lsp(event.buf)
                -- Automatically format the document on save

                if vim.lsp.get_client_by_id(event.data.client_id):supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("lsp-format-on-save", { clear = true }),
                        buffer = event.buf,
                        callback = function()
                            format_with_lsp(event.buf)
                        end,
                    })
                end
            end
        })

        require("mason").setup()
        require("fidget").setup()
        require("mason-lspconfig").setup({
            ensure_installed = vim.tbl_values(language_servers)
        })

        setup_none_ls()
    end
}
