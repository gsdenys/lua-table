local assert = require "ptable.assertion"
local warning = require "ptable.warning"

local ptable = {}

local iteration = {}

local function get_Keys(t)
    local keyset = {}
    local n = 0

    for k, v in pairs(t) do
        n = n + 1
        keyset[n] = k
    end

    return keyset
end

---Build an iterator through the given table
---@param t table the given table
---@return function - the iterator builded
function ptable.Iterator(t)
    assert.Table(t, "Iterator")

    local keys = get_Keys(t)

    if #keys > 0 then
        local iteration = 1

        return function()
            local value = t[keys[iteration]]
            iteration = iteration + 1

            return value
        end
    end

    --  assert.Table(t, "iter")

    --  local iteration = 1

    --  return function()
    --      local value = t[iteration]
    --      iteration = iteration + 1

    --      return value
    --  end

end

---Build an iterator that iterate in reversed order
---@param t any the given table
---@return function - the inverse iterator builded
function ptable.Inverse(t)
    assert.Table("inverse", t)

    local iteration = #t

    return function()
        local value = t[iteration]
        iteration = iteration - 1

        return value
    end
end

---Build a range iterator
---@param t any
---@param start integer
---@param count any
---@param step integer
---@return function
function ptable.range(t, start, count, step)
    assert.Table("range", t)

    step = step or 1
    count = count or #t
    start = start or 1

    assert.Number("range", start)
    assert.Number("range", count)
    assert.Number("range", step)

    local iteration = start
    local counter = count

    return function()

        if counter > 0 then
            local key = iteration
            local value = t[iteration]
            iteration = iteration + step
            counter = counter - 1

            return key, value
        end
    end
end

function ptable.group(t, k)
    -- iterate through table by grouping values together (group size is k)
    -- in each iteration, the iterator will return a k-tuple
    assert_table("group", t)
    assert_true("group", "k must be > 0!", (type(k) == "number") and (k > 0))

    local i = 0

    return function()
        local values = {}

        for j = 1, k do values[j] = t[i + j] end

        i = i + k

        return unpack(values)
    end
end

function ptable.slide(t, k)
    -- iterate through table like a sliding-window of size k
    -- in each iteration, the iterator will return a k-tuple
    assert_table("slide", t)
    assert_true("slide", "k must be > 0!", (type(k) == "number") and (k > 0))

    local i = 0

    return function()
        local values = {}

        for j = 1, k do values[j] = t[i + j] end

        i = i + 1

        return unpack(values)
    end
end

function ptable.eachi(t, func, ...)
    -- apply the given function to all the elements of the table
    assert_table_func("eachi", t, func)

    for i = 1, #t do func(t[i], ...) end

    return t
end

function ptable.each(t, func, ...)
    -- apply the given function on all (key, value) pairs of table
    assert_table_func("each", t, func)

    for k, v in pairs(t) do func(k, v, ...) end

    return t
end

function ptable.keys(t)
    -- iterate over all table keys 
    assert_table("keys", t)

    local keys = {}
    local j = 1

    for k, _ in pairs(t) do
        keys[j] = k
        j = j + 1
    end

    j = 1

    return function()
        local k = keys[j]
        j = j + 1

        return k
    end
end

function ptable.values(t)
    -- iterate over all table values
    assert_table("values", t)

    local values = {}
    local k = 1

    for _, v in pairs(t) do
        values[k] = v
        k = k + 1
    end

    k = 1

    return function()
        local v = values[k]
        k = k + 1

        return v
    end
end

return ptable
