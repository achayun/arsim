-- Assign steam to workspaces
hl.window_rule({
	name = "steam-ws",
	match = { class = "^steam", },
	workspace = "name:S"
})

-- Steam - Sign in window should float
hl.window_rule({
	name = "steam-game",
	match = { title = "^Sign in to Steam", class = "^steam" },
	float = true,
})

-- Steam - Run any game in Fullscreen
hl.window_rule({
	name = "steam-game",
	match = {class = "^steam_app_\\d+$", },
	fullscreen = true,
	tag = "+game",
	idle_inhibit = "fullscreen",
    opaque = true,
    no_anim = true,
    no_blur = true,
    no_dim = true,
})
