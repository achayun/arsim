local function hypr_color(color)
    if color == nil then
        return nil
    end

    -- Already in Hyprland format.
    if color:match("^rgb%(") or color:match("^rgba%(") then
        return color
    end

    -- Convert "#rrggbb" or "#rrggbbaa".
    local hex = color:gsub("^#", "")

    if #hex == 6 then
        return "rgb(" .. hex .. ")"
    elseif #hex == 8 then
        return "rgba(" .. hex .. ")"
    end

    error("Unsupported color format: " .. tostring(color))
end

local function gtk_config(s)
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface gtk-theme '%s'"]], s.gtk.gtk_theme))
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface color-scheme '%s'"]], s.gtk.color_theme))
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface icon-theme '%s'"]], s.gtk.icon_theme))
end

local function apply_global_style(s)
    gtk_config(s)
    hl.config({
        general = {
            gaps_in = s.metric.gap.inner,
            gaps_out = s.metric.gap.outer,

            border_size = s.component.window.border.width,

            col = {
                active_border = {
                    colors = {
                        hypr_color(s.component.window.border.active.colors[1]),
                        hypr_color(s.component.window.border.active.colors[2]),
                    },
                    angle = s.component.window.border.active.angle,
                },

                inactive_border = hypr_color(s.component.window.border.inactive),
            },

            layout = "dwindle",
            resize_on_border = false,
        },

        decoration = {
            rounding = s.component.window.radius,

            active_opacity = s.component.window.opacity.active,
            inactive_opacity = s.component.window.opacity.inactive,

            shadow = {
                enabled = s.component.window.shadow.enabled,
                range = s.component.window.shadow.range,
                render_power = s.component.window.shadow.render_power,
                color = hypr_color(s.component.window.shadow.color),
            },

            blur = {
                enabled = s.component.window.blur.enabled,
                size = s.component.window.blur.size,
                passes = s.component.window.blur.passes,
            },
        },
    })
end

return apply_global_style
