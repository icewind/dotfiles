return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = { 'nvim-orgmode/org-bullets.nvim' },
    config = function()
        require('orgmode').setup({
            org_agenda_files = vim.env.ORGFILES_PATH or '~/projects/orgfiles/**/*',
            org_default_notes_file = vim.env.ORGFILES_REFILE_PATH or '~/projects/orgfiles/refile.org',
            mappings = {
                org_return_uses_meta_return = true,
                org = {
                    org_toggle_checkbox = { 'cix', desc = 'Toggle checkbox' },
                }
            },
        })

        require('org-bullets').setup({
            symbols = {
                checkboxes = {
                    half = { "-", "@org.checkbox.halfchecked" },
                    done = { "✓", "@org.keyword.done" },
                    todo = { " ", "@org.keyword.todo" },
                },
            },
        })
    end,
}
