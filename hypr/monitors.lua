-- Monitor Configuration: https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List all monitors: hyprctl monitors
hl.monitor({
	output = "desc:Dell Inc. DELL S2725DC 48KTQC4",
	mode = "2560x1440@143.97Hz",
	position = "auto",
	scale = "auto",
	vrr = 1, -- 0=off, 1=on, 2=fullscreen only
})

-- This old TV has some modeline issues
-- Add reserved space to the left
hl.monitor({
	output = "desc:Panasonic Industry Company PanasonicTV1",
	mode = "preferred",
	reserved_area = { top = 10, bottom = 15, left = 20, right = 18},
})


