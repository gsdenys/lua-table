local iterator = require "ptable.iterator"

local ptable = {}

for key,value in pairs(iterator) do ptable[key] = value end

return ptable