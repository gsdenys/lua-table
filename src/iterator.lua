local assert = require "luatable.assertion"

local table = {}

function table.iter(t)
-- build an iterator through the given table
   assert.Table("iter", t)

   local i = 1

   return function()
      local v = t[i]
      i = i + 1

      return v
   end
end

function table.inverse(t)
-- build an iterator that iterate in reversed order
   assert_table("inverse", t)

   local i = #t

   return function()
      local v = t[i]
      i = i - 1

      return v
   end
end

function table.range(t, start, count, step)
-- build a range iterator
   assert_table ("range", t)
   
   step  = step  or 1
   count = count or #t
   start = start or 1

   assert_number("range", start)
   assert_number("range", count)
   assert_number("range", step)

   local i = start
   local c = count

   return function()

      if c > 0 then
         local k = i
         local v = t[i]
         i = i + step
         c = c - 1

         return k, v
      end
   end
end

function table.group(t, k)
-- iterate through table by grouping values together (group size is k)
-- in each iteration, the iterator will return a k-tuple
   assert_table("group", t)
   assert_true ("group", "k must be > 0!", (type(k) == "number") and (k > 0))

   local i = 0

   return function()
      local values = {}

      for j = 1, k do
         values[j] = t[i + j]
      end

      i = i + k

      return unpack(values)
   end
end

function table.slide(t, k)
-- iterate through table like a sliding-window of size k
-- in each iteration, the iterator will return a k-tuple
   assert_table("slide", t)
   assert_true ("slide", "k must be > 0!", (type(k) == "number") and (k > 0))
    
   local i = 0

   return function()
      local values = {}

      for j = 1, k do
         values[j] = t[i + j]
      end

      i = i + 1

      return unpack(values)
   end
end

function table.eachi(t, func, ...)
-- apply the given function to all the elements of the table
   assert_table_func("eachi", t, func)

   for i = 1, #t do
      func(t[i], ...)
   end

   return t
end

function table.each(t, func, ...)
-- apply the given function on all (key, value) pairs of table
   assert_table_func("each", t, func)

   for k, v in pairs(t) do
      func(k, v, ...)
   end

   return t
end

function table.keys(t)
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

function table.values(t)
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

return table