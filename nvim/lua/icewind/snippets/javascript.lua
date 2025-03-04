local ls = require("luasnip")
local extras = require("luasnip.extras")
local snippet = ls.snippet
local insert = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = extras.rep

return {
    snippet(
        "banner",
        fmt(
            [[
            console.log("{top}".repeat(100));
            console.log({value});
            console.log("{bottom}".repeat(100));
            ]],
            {
                top = insert(1),
                bottom = rep(1),
                value = insert(2),
            }
        )
    ),
}
