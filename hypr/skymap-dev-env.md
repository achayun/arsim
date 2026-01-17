# Skymap devenv
# Set the layout to master, not dwindle
workspace = 2, layoutopt:orientation:left, default:true
# Send the app to workspace 5 automatically
windowrule {
	name = skymap-dev-term
	match:class = ^(skymap)$
	float = true
	move = 0 0
	size = 50% 100%
	workspace = 2
}

bindd = $mainMod CTRL, D, 🌌skymap terminal, exec, kitty --class "skymap"

