package = "power-table"
version = "scm-1"

source = {
	url = "git://github.com/gsdenys/ptable",
}

description = {
	summary = "A library that give superpowers to lua tables",
	detailed = [[
		This library extends the common Lua table by adding iterators, operators and utility functions.
    Visit https://github.com/gsdenys/ptable for more info.
	]],
	homepage = "https://github.com/gsdenys/ptable",
	license = "MIT",
}

dependencies = {
    "lua",
}

build = {
    type = "builtin",
    modules = {
        ['ptable'] = "src/luatable.lua",
		['ptable.assertion'] = "src/assertion.lua",

		['ptable.utils.types'] = "src/utils/types.lua",
		['ptable.utils.level'] = "src/utils/level.lua",
		['ptable.utils.error'] = "src/utils/error.lua",
    },
}