
local table = {}

function table.void()
end

function table.isnil(a)
   return a == nil
end

function table.odd(a)
   return a % 2 == 1
end

function table.even(a)
   return a % 2 == 0
end

function table.half(a)
   return a * .5
end

function table.double(a)
   return a * 2
end

function table.sqr(a)
   return a * a
end

function table.pow(a, b)
   return a ^ b
end

function table.increase(a)
   return a + 1
end

function table.decrease(a)
   return a - 1
end

function table.positive(a)
   return a >= 0
end

function table.negative(a)
   return a < 0
end

function table.itself(a)
   return a
end

function table.identity(a)
   return a == a
end

function table.eq(a, b)
   return a == b
end

function table.neq(a, b)
   return a ~= b
end

function table.gt(a, b)
   return a > b
end

function table.lt(a, b)
   return a < b
end

function table.ge(a, b)
   return a >= b
end

function table.le(a, b)
   return a <= b
end

function table.sum(a, b)
   return a + b
end

function table.sub(a, b)
   return a - b
end

function table.mul(a, b)
   return a * b
end

function table.div(a, b)
   return a / b
end

return table