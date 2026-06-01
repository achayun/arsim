-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"

-- If only one tiled window lives on the desktop, absolutely no gaps
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name = "no-gaps-if-one-tiled-window",
    match = { float = false, workspace = "w[tv1]", },
    border_size = 0,
    rounding = 0,
})

-- If only one floating window lives on the desktop, absolutely no gaps
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
hl.window_rule({
    name = "no-gaps-if-fullscreen",
    match = { float = false, workspace = "f[1]", },
    border_size = 0,
    rounding = 0,
})

-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})


