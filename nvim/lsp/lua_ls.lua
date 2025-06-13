return {
    settings = {
        telemetry = { enable = false },
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                }
            },
            diagnostics = {
                globals = {
                    'vim',
                    'require',
                },
            },
        },
    },
}
