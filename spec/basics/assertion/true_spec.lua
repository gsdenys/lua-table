require "busted.runner"()

describe("Assertion", function()
    describe("True", function()
        it("should have an error message", function()
            local function some_test()
                local assertion = require "ptable.assertion"
                assertion.True("test", "some error message", false)
            end

            local _, err = pcall(some_test)
            assert.is_not.Nil(err)
        end)

        it("should not have an error", function()
            local function some_test()
                local assertion = require "ptable.assertion"
                assertion.True("test", "Some error message", true)
            end

            local _, err = pcall(some_test)
            assert.Nil(err)
        end)

        it("should not have an error", function()
            local function some_test()
                local assertion = require "ptable.assertion"
                assertion.True("test", "Some error message", not false)
            end

            local _, err = pcall(some_test)
            assert.Nil(err)
        end)
    end)
end)
