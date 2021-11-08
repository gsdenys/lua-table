local assert = require "ptable.assertion"

local ptable = {}

---Obtains the list ok keys
---@param t any the table
---@return table - the keys list
function ptable.Keys(t)
    assert.Table(t, "Keys")

    local keyset = {}
    local n = 1

    for k, _ in pairs(t) do
        keyset[n] = k
        n = n + 1
    end

    return keyset
end

---Build an iterator through the given table
---@param t table the given table
---@return function - the iterator builded
-- function ptable.Iterator(self, t)
--    assert.Table(t, "Iterator")

--    local keys = self.Keys(t)
--    local iteration = 1

--    return function()
--        local value = t[#keys and keys[iteration] or iteration]
--        iteration = iteration + 1

--        return value
--    end
-- end

-- function ptable.Iterator(self, t)
--     assert.Table(t, "Iterator")

--     local it = {}
--     it.t = t

--     it.keys = self.Keys(t)
--     it.iteration = 1

--     function it:Key()
--         return #self.keys and self.keys[self.iteration] or self.iteration
--     end

--     function it:HasNext()
--         if #self.keys > 0 then return self.iteration < #self.keys end

--         return self.iteration < #self.t
--     end

--     function it:Next()
--         local value = t[it:Key()]
--         self.iteration = self.iteration + 1

--         return value
--     end

--     return it
-- end

function ptable.Iterator(t)
   assert.Table(t, "Iterator")

   local iterator = require "ptable.basics.iterator"

   return iterator(t)
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

return ptable
