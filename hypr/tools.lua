-- KeePassXC goes to tools workspace
hl.window_rule({
	name = "keepassxc-ws",
	match = { class = "^(org.keepassxc.KeePassXC)$" },
	float = true,
	workspace = 9,
})

-- Language selector
hl.window_rule({
    match = {class = "fcitx", },
    float = true,
})

-- Floating volume control
hl.window_rule({
	name = "volume_control",
	match = { class = "^(org.pulseaudio.pavucontrol)$", },
	float = true,
})

-- Blueman-manager
hl.window_rule({
	name = "blueman_manager",
    match  = { class = "blueman-manager", },
    float = true,
})

