local function is_table(x)
    return type(x) == "table"
end

local function is_array(t)
    if not is_table(t) then
        return false
    end

    local n = 0
    for k, _ in pairs(t) do
        if type(k) ~= "number" then
            return false
        end
        n = n + 1
    end

    return n > 0
end

local function copy(v)
    if not is_table(v) then
        return v
    end

    local out = {}
    for k, child in pairs(v) do
        out[k] = copy(child)
    end
    return out
end

local function merge(a, b)
    local out = copy(a or {})

    for k, v in pairs(b or {}) do
        if is_table(v)
            and is_table(out[k])
            and not is_array(v)
            and not is_array(out[k])
        then
            out[k] = merge(out[k], v)
        else
            out[k] = copy(v)
        end
    end

    return out
end

-- local function deep_merge(base, override)
--   if type(base) ~= "table" then
--     return override
--   end
-- 
--   if type(override) ~= "table" then
--     return override ~= nil and override or base
--   end
-- 
--   local result = {}
-- 
--   -- copy base
--   for k, v in pairs(base) do
--     if type(v) == "table" then
--       result[k] = deep_merge(v, {})
--     else
--       result[k] = v
--     end
--   end
-- 
--   -- merge override
--   for k, v in pairs(override) do
--     if type(v) == "table" and type(result[k]) == "table" then
--       result[k] = deep_merge(result[k], v)
--     else
--       result[k] = v
--     end
--   end
-- 
--   return result
-- end

return merge
