-- hyprcursor
-- https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/


local M = {}


local function die(msg)
  error("cursor.lua: " .. msg, 2)
end

local function shell_quote(s)
  s = tostring(s)
  return "'" .. s:gsub("'", "'\\''") .. "'"
end

local function exec(cmd)
  local ok, why, code = os.execute(cmd)
  if ok ~= true then
    die(string.format("command failed (%s/%s): %s", tostring(why), tostring(code), cmd))
  end
end

local function read_file(path)
  local f = io.open(path, "rb")
  if not f then return nil end
  local data = f:read("*a")
  f:close()
  return data
end

local function write_if_changed(path, data)
  if read_file(path) == data then
    return false
  end

  local f, err = io.open(path, "wb")
  if not f then die("failed to open " .. path .. " for write: " .. tostring(err)) end
  f:write(data)
  f:close()
  return true
end

local function json_escape(s)
  s = tostring(s)
  local map = {
    ["\\"] = "\\\\",
    ["\""] = "\\\"",
    ["\b"] = "\\b",
    ["\f"] = "\\f",
    ["\n"] = "\\n",
    ["\r"] = "\\r",
    ["\t"] = "\\t",
  }
  return s:gsub('[%z\1-\31\\"]', function(c)
    return map[c] or string.format("\\u%04x", c:byte())
  end)
end

local function jstr(s)
  return '"' .. json_escape(s) .. '"'
end

local function assert_hex(name, value)
  if type(value) ~= "string" then
    die(name .. " must be a #RRGGBB color string")
  end
  local hex = value:match("^(#%x%x%x%x%x%x)")
  if not hex then
    die(name .. " must be a #RRGGBB color string, got " .. tostring(value))
  end
  return "#" .. hex:sub(2):upper()
end

local function cursor_cfg(style)
  local cursor = style.cursor or {}
  local bibata = cursor.bibata or {}
  local colors = bibata.colors or {}

  local name = cursor.theme or style.name
  if not name or name == "" then die("style.cursor.theme is required") end

  local shape = bibata.shape or bibata.style or "modern"
  if shape ~= "modern" and shape ~= "original" then
    die("style.cursor.bibata.shape must be 'modern' or 'original'")
  end

  local orientation = bibata.orientation or "normal"
  if orientation ~= "normal" and orientation ~= "right" then
    die("style.cursor.bibata.orientation must be 'normal' or 'right'")
  end

  local dir = "Bibata_Cursor/svg/" .. shape .. (orientation == "right" and "-right" or "")

  local base = assert_hex("style.cursor.bibata.colors.base", colors.base or style.color.bg_hard or style.color.bg)
  local outline = assert_hex("style.cursor.bibata.colors.outline", colors.outline or style.color.fg or style.color.fg_strong)
  local watch = assert_hex("style.cursor.bibata.colors.watch", colors.watch or style.color.bg or base)

  local sizes = bibata.sizes or cursor.build_sizes or { cursor.size or 24 }
  if type(sizes) == "number" then sizes = { sizes } end
  if type(sizes) ~= "table" or #sizes == 0 then die("cursor build sizes must be a non-empty array") end

  return {
    name = name,
    size = tonumber(cursor.size or sizes[#sizes] or 24),
    backend = cursor.backend or "xcursor",
    dir = dir,
    out = "bitmaps/" .. name,
    sizes = sizes,
    colors = {
      { match = "#00FF00", replace = base },
      { match = "#0000FF", replace = outline },
      { match = "#FF0000", replace = watch },
    },
  }
end

local function render_json(cfg)
  local lines = {}
  table.insert(lines, "{")
  table.insert(lines, "  " .. jstr(cfg.name) .. ": {")
  table.insert(lines, "    \"dir\": " .. jstr(cfg.dir) .. ",")
  table.insert(lines, "    \"out\": " .. jstr(cfg.out) .. ",")
  table.insert(lines, "    \"sizes\": [" .. table.concat(cfg.sizes, ", ") .. "],")
  table.insert(lines, "    \"colors\": [")
  for i, color in ipairs(cfg.colors) do
    local comma = i < #cfg.colors and "," or ""
    table.insert(lines, string.format(
      "      { \"match\": %s, \"replace\": %s }%s",
      jstr(color.match), jstr(color.replace), comma
    ))
  end
  table.insert(lines, "    ]")
  table.insert(lines, "  }")
  table.insert(lines, "}")
  return table.concat(lines, "\n") .. "\n"
end


local function mktemp()
    local p = assert(io.popen("mktemp"))
    local name = p:read("*l")
    p:close()
    return name
end

function M.write_render_json(cfg)
  local path = mktemp()
  -- It's a temp file, it will always change. Just write the file
  write_if_changed(path, render_json(cfg))

  return path
end

local function current_script_dir()
    local source = debug.getinfo(2, "S").source
    local path = source:sub(2)
    return path:match("^(.*)/") or "."
end

function M.compile_bibata_cursor(style)
  local cfg = cursor_cfg(style)
  local path = M.write_render_json(cfg)
  local script_dir = current_script_dir()
  local theme_path = script_dir .. "/icons/bibata_cursor"
  -- TODO: Pass output dir to the `make` command. It currently crashes on login. run.sh should write to some log file...
  -- hl.exec_cmd(string.format(
  --   "make -C %s cursor-build RENDER_JSON=%s",
  --   shell_quote(theme_path),
  --   shell_quote(path)
  -- ))
end

function M.apply(style)
    -- Custom generated Bibata Cursor plugin
    if style.cursor.bibata ~= nil then
        M.compile_bibata_cursor(style)
    end

    -- Xcursor (Hyprcusror) env
    hl.env("XCURSOR_THEME", style.cursor.theme)
    hl.env("XCURSOR_SIZE", style.cursor.size)
    -- GTK cursor
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface cursor-theme '%s'"]], style.cursor.theme))
    hl.exec_cmd(string.format([["gsettings set org.gnome.desktop.interface cursor-size %d"]], style.cursor.size))
    -- Hyprcursor Apply switch
    hl.exec_cmd(string.format([["hyprctl setcursor %s %d"]], style.cursor.theme, style.cursor.size))
end

return M
