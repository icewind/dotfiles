-- Check if the method is supported by any of the attached LSPs
local supports = function(bufnr, action)
    action = action:find("/") and action or "textDocument/" .. action
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    for _, client in ipairs(clients) do
        if client.supports_method(action) then
            return true
        end
    end
    return false
end

--- Lsp-specific key mapping
--- @param bufnr number
--- @param keys string
--- @param func function
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
    "ts_ls",
}

local map_keys_for_lsp = function(bufnr)
    mapkey(bufnr, "K", function() return vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover docs" })
    mapkey(bufnr, "<c-k>", function() return vim.lsp.buf.signature_help() end, { mode = "i", desc = "Signature help" })
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
    mapkey(bufnr, "<leader>cc", vim.lsp.codelens.run, {
        has = "codeLens",
        desc = "Display Codelens",
    })
    mapkey(bufnr, "<leader>cC", vim.lsp.codelens.refresh, {
        has = "codeLens",
        desc = "Refresh & Display Codelens",
    })
    mapkey(bufnr, "<leader>cf", vim.lsp.buf.format, { desc = "Format the file", has = "formatting" })
    mapkey(bufnr, "<leader>cf", vim.lsp.buf.format, {
        mode = "v",
        desc = "Format selected text",
        has = "rangeFormatting",
    })
end

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
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
                if vim.lsp.get_client_by_id(event.data.client_id).supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("lsp-format-on-save", { clear = true }),
                        buffer = event.buf,
                        callback = function()
                            vim.lsp.buf.format()
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
    end
}
