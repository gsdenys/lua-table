require "busted.runner"()

describe("Iterator", function()
    local kv = {a = 1, b = 2, c = 3}
    local nm = {1, 2, 3}

    describe("Key", function()
        it("should have nil value", function()
            local ptable = require "ptable.iterator"
            local i = ptable.Iterator(kv)

            assert.Nil(i:Key())
        end)

        it("should have nil value", function()
            local ptable = require "ptable.iterator"
            local i = ptable.Iterator(nm)

            assert.Nil(i:Key())
        end)

    end)
end)
