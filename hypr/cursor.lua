-- hyprcursor
-- https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/


local M = {}
function M.apply(style)
    -- Xcursor (Hyprcusror) env
    hl.env("XCURSOR_THEME", style.cursor.theme)
    hl.env("XCURSOR_SIZE", style.cursor.size)
    -- Hyprcursor Apply switch
    hl.exec_cmd(string.format([["hyprctl setcursor %s %d"]], style.cursor.theme, style.cursor.size))
    -- GTK cursor
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface cursor-theme '%s'"]], style.cursor.theme))
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface cursor-size %d"]], style.cursor.size))
end

return M
