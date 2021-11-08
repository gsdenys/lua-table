
local types = require "ptable.utils.types"
local level = require "ptable.utils.level"
local errors = require "ptable.utils.error"

local format = string.format
local type = type

---Table that contains all implementation type of assertion.
---Basically this table just contains functions
local assertion = {}

---The name of table function. I'd opt to not use reflection to make it
---faster.
local TABLE_FUNCTION_NAME = "Table"

---failOnAssert function that throws an exception each called time
---@param msg string the error message
---@param fn string the function name
local function failOnAssert(msg, fn)
    local message = errors.MESSAGE_BASE .. msg
    error(format(message, level.ERROR, fn))
end

---sendWarning function that print the message each called time
---@param msg string the warn message
---@param fn string the function name
local function sendWarning(msg, fn)
    local message = errors.MESSAGE_BASE .. msg
    print(format(message, level.WARN, fn))
end

---assert_table function to help others function to call table assertion
---@param t table the table that want to try
---@param fn function the function name
local function assert_table(t, fn)
    if type(t) ~= types.TABLE then
        failOnAssert(errors.T_MUST_BE_NOT_NIL_TABLE, fn)
    end
end

---Table assert that throws exception when <t> receiver parameter has the
---type different of 'table'
---@param t table the table that want to ty
function assertion.Table(t) assert_table(t, TABLE_FUNCTION_NAME) end

---Function assert that throws exception when <t> parameter has the type
---different of 'table' or the <f> parameter has the type different of 'function'
---@param fn string the function name
---@param t table the table that want to try
---@param f function the function that want to try
function assertion.Func(fn, t, f)
    assert_table(t, fn)

    if type(f) ~= types.FUNCTION then
        failOnAssert(errors.REQUIRE_NOT_NIL_FUNCTION, fn)
    end
end

---Number assert that throws exception when <num> parameter has the type different
---of 'number'
---@param fn string the function name
---@param num number the numbert that want to try
function assertion.Number(fn, num)
    if type(num) ~= types.NUMBER then failOnAssert(errors.REQUIRE_NUMBER, fn) end
end

---True function that throws exception when <test> is false
---@param fn string the function name
---@param msg string the error message
---@param test boolean the test
function assertion.True(fn, msg, test) if not test then failOnAssert(msg, fn) end end

---Nil value warning function that use print to comunitate with user
---@param fn string the function name
---@param value string the warning message
function assertion.Nil(fn, value)
    if value == nil then sendWarning(errors.NIL_VALUE, fn) end
end

---Test function that warn when the execution pass in the test
---@param fn string the function name
---@param msg string the warn message
---@param test boolean the test
function assertion.Test(fn, msg, test) if test then sendWarning(msg, fn) end end

--Export assertion table function
return assertion
