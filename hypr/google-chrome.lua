-- File: chrome.lua
--
-- Renderer for Google Chrome theme extension.
--
-- Input:
--   style: current style table
--   wallpaper: optional object:
--     {
--       path = "/path/to/file.png",
--       repeat_policy = "no-repeat" | "repeat" | "repeat-x" | "repeat-y",
--       alignment = "center" | "bottom" | ...,
--       logo_alternate = 1,
--     }
--
-- Output:
--   ~/.config/google-chrome/Hyprland-theme-<ThemeName>/manifest.json
--   ~/.config/google-chrome/Hyprland-theme-<ThemeName>/images/<wallpaper>.png

local M = {}

local function shquote(s)
    return "'" .. tostring(s):gsub("'", "'\\''") .. "'"
end

local function path_exists(path)
    local f = io.open(path, "rb")
    if f then
        f:close()
        return true
    end
    return false
end

local function basename(path)
    return tostring(path):match("([^/]+)$") or tostring(path)
end

local function dirname(path)
    return tostring(path):match("^(.*)/[^/]+$") or "."
end

local function strip_hash(color)
    return tostring(color):gsub("^#", "")
end

local function rgb(color)
    local hex = strip_hash(color)

    if #hex ~= 6 then
        error("Chrome color expects #rrggbb, got: " .. tostring(color))
    end

    return {
        tonumber(hex:sub(1, 2), 16),
        tonumber(hex:sub(3, 4), 16),
        tonumber(hex:sub(5, 6), 16),
    }
end

local function slug(s)
    s = tostring(s or "theme")
    s = s:gsub("[^%w%-_]+", "-")
    s = s:gsub("%-+", "-")
    s = s:gsub("^%-", "")
    s = s:gsub("%-$", "")

    if s == "" then
        s = "theme"
    end

    return s
end

local function is_array(t)
    if type(t) ~= "table" then
        return false
    end

    local n = 0
    for k, _ in pairs(t) do
        if type(k) ~= "number" then
            return false
        end
        if k > n then
            n = k
        end
    end

    for i = 1, n do
        if t[i] == nil then
            return false
        end
    end

    return true
end

local function json_escape(s)
    s = tostring(s)
    s = s:gsub("\\", "\\\\")
    s = s:gsub('"', '\\"')
    s = s:gsub("\b", "\\b")
    s = s:gsub("\f", "\\f")
    s = s:gsub("\n", "\\n")
    s = s:gsub("\r", "\\r")
    s = s:gsub("\t", "\\t")
    return s
end

local function json_encode(v, indent)
    indent = indent or 0

    local pad = string.rep("  ", indent)
    local next_pad = string.rep("  ", indent + 1)

    if type(v) == "string" then
        return '"' .. json_escape(v) .. '"'
    end

    if type(v) == "number" or type(v) == "boolean" then
        return tostring(v)
    end

    if v == nil then
        return "null"
    end

    if type(v) ~= "table" then
        error("cannot JSON encode type: " .. type(v))
    end

    local parts = {}

    if is_array(v) then
        for i = 1, #v do
            table.insert(parts, json_encode(v[i], indent + 1))
        end
        return "[" .. table.concat(parts, ", ") .. "]"
    end

    for k, val in pairs(v) do
        table.insert(
            parts,
            next_pad .. '"' .. json_escape(k) .. '": ' .. json_encode(val, indent + 1)
        )
    end

    table.sort(parts)

    return "{\n" .. table.concat(parts, ",\n") .. "\n" .. pad .. "}"
end

local function write_file(path, content)
    os.execute("mkdir -p " .. shquote(dirname(path)))

    local f, err = io.open(path, "w")
    if not f then
        error("failed to open " .. path .. ": " .. tostring(err))
    end

    f:write(content)
    f:close()
end

local function copy_file(src, dst)
    local in_f, in_err = io.open(src, "rb")
    if not in_f then
        error("failed to open source file: " .. src .. ": " .. tostring(in_err))
    end

    local out_f, out_err = io.open(dst, "wb")
    if not out_f then
        in_f:close()
        error("failed to open destination file: " .. dst .. ": " .. tostring(out_err))
    end

    while true do
        local chunk = in_f:read(64 * 1024)
        if not chunk then
            break
        end
        out_f:write(chunk)
    end

    in_f:close()
    out_f:close()
end

local function normalize_wallpaper(wallpaper)
    if wallpaper == nil then
        return nil
    end

    -- Backward compatibility: allow passing a plain path.
    if type(wallpaper) == "string" then
        return {
            path = wallpaper,
            repeat_policy = "no-repeat",
            alignment = "center",
            logo_alternate = 1,
        }
    end

    if type(wallpaper) ~= "table" then
        error("Chrome wallpaper must be nil, path string, or object table")
    end

    if not wallpaper.path or wallpaper.path == "" then
        error("Chrome wallpaper object requires .path")
    end

    local repeat_policy = wallpaper.repeat_policy or "no-repeat"

    local allowed_repeat = {
        ["no-repeat"] = true,
        ["repeat"] = true,
        ["repeat-x"] = true,
        ["repeat-y"] = true,
    }

    if not allowed_repeat[repeat_policy] then
        error("unsupported Chrome ntp_background_repeat policy: " .. tostring(repeat_policy))
    end

    return {
        path = wallpaper.path,
        repeat_policy = repeat_policy,
        alignment = wallpaper.alignment or "center",
        logo_alternate = wallpaper.logo_alternate,
    }
end

local function copy_wallpaper_png(wallpaper, theme_dir)
    wallpaper = normalize_wallpaper(wallpaper)

    if not wallpaper then
        return nil, nil
    end

    if not wallpaper.path:lower():match("%.png$") then
        error(
            "Chrome theme wallpaper must be PNG: "
            .. wallpaper.path
            .. "\nConvert it first, then pass the PNG path."
        )
    end

    if not path_exists(wallpaper.path) then
        error("Chrome wallpaper path does not exist: " .. wallpaper.path)
    end

    local image_dir = theme_dir .. "/images"
    os.execute("mkdir -p " .. shquote(image_dir))

    local dst_name = basename(wallpaper.path)
    local dst_path = image_dir .. "/" .. dst_name

    copy_file(wallpaper.path, dst_path)

    return "images/" .. dst_name, wallpaper
end

local function theme_colors(style)
    local c = style.color
    local p = style.palette or {}

    -- Incognito must be obvious, but not neon-puke.
    -- Prefer Gruvbox purple if available; otherwise use danger.
    local incognito_frame =
        p.faded_purple
        or p.purple
        or c.danger
        or c.border_focus

    local incognito_frame_inactive =
        p.dark3
        or c.surface_high
        or c.surface_alt

    return {
        -- Main theme.
        frame = rgb(c.bg_hard or c.bg),
        frame_inactive = rgb(c.bg or c.bg_hard),
        toolbar = rgb(c.surface or c.bg),
        bookmark_text = rgb(c.fg),
        button_background = rgb(c.surface_alt or c.surface),
        tab_text = rgb(c.fg_strong or c.fg),
        tab_background_text = rgb(c.muted or c.disabled),
        tab_background_text_inactive = rgb(c.disabled or c.muted),
        toolbar_button_icon = rgb(c.fg),

        -- Incognito.
        frame_incognito = rgb(incognito_frame),
        frame_incognito_inactive = rgb(incognito_frame_inactive),
        tab_background_text_incognito = rgb(c.fg_strong or c.fg),
        tab_background_text_incognito_inactive = rgb(c.muted or c.disabled),

        -- Omnibox.
        omnibox_text = rgb(c.accent_alt or c.accent or c.fg),
        omnibox_background = rgb(c.bg),

        -- New tab page.
        ntp_background = rgb(c.bg),
        ntp_header = rgb(c.surface or c.bg),
        ntp_link = rgb(c.accent_alt or c.accent or c.fg),
        ntp_text = rgb(c.muted or c.fg),
    }
end

function M.manifest(style, wallpaper_relpath, wallpaper)
    local theme_name = "Hyprland " .. tostring(style.name or "Theme")

    local theme = {
        colors = theme_colors(style),

        tints = {
            buttons = { -1, -1, -1 },
            frame = { -1, -1, -1 },
            frame_inactive = { -1, -1, 0.485 },

            -- Keep incognito distinct. Do not tint it back toward normal.
            frame_incognito = { -1, -1, -1 },
            frame_incognito_inactive = { -1, -1, -1 },
        },

        properties = {
            ntp_background_alignment = wallpaper and wallpaper.alignment or "center",
            ntp_background_repeat = wallpaper and wallpaper.repeat_policy or "no-repeat",
            ntp_logo_alternate = wallpaper and wallpaper.logo_alternate or 1,
        },
    }

    if wallpaper_relpath then
        theme.images = {
            theme_ntp_background = wallpaper_relpath,
        }
    end

    return {
        manifest_version = 3,
        version = "2.0.0",
        name = theme_name,
        theme = theme,
    }
end

function M.write(style, wallpaper)
    local theme_slug = slug(style.name or "theme")
    local theme_dir =
        os.getenv("HOME")
        .. "/.config/google-chrome/Hyprland-theme-"
        .. theme_slug

    os.execute("mkdir -p " .. shquote(theme_dir))

    local wallpaper_relpath, normalized_wallpaper =
        copy_wallpaper_png(wallpaper, theme_dir)

    local manifest =
        M.manifest(style, wallpaper_relpath, normalized_wallpaper)

    write_file(theme_dir .. "/manifest.json", json_encode(manifest) .. "\n")

    write_file(theme_dir .. "/README.txt", table.concat({
        "Chrome theme generated from Hyprland style.",
        "",
        "Load it manually:",
        "1. Open chrome://extensions",
        "2. Enable Developer mode",
        "3. Click Load unpacked",
        "4. Select this folder:",
        "",
        theme_dir,
        "",
        "If you regenerate the theme, press Reload for this unpacked extension.",
        "",
    }, "\n"))

    return theme_dir
end

return M

