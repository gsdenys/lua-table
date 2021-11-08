


local function get_keys(t)
    local keyset = {}
    local n = 1

    for k, _ in pairs(t) do
        keyset[n] = k
        n = n + 1
    end

    return keyset
end

local iterator = {}

function iterator:Key()
    if #self.keys > 0 then
        return self.keys[self.it]
    end

    return  self.it
end

function iterator:value()
    return  self.t[self:Key()]
end

function iterator:HasNext()
    if #self.keys > 0 then return self.it < #self.keys end

    return self.it < #self.t
end

function iterator:Next()
    self.it = self.it + 1
    return self.t[self:Key()]
end


return function (t)
    local it = iterator

    it.t = t
    it.keys = get_keys(t)
    it.it = 0

    return it
end


