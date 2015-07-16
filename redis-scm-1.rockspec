package = "redis"
version = "scm-1"
source = {
    url    = "git://github.com/zloidemon/redis.git",
    branch = "master",
}
description = {
    summary    = "Redis server in Tarantool",
    homepage   = "https://github.com/zloidemon/redis.git",
    license    = "BSD",
    maintainer = "Veniamin Gvozdikov <vgvozdikov@tarantool.org>"
}
dependencies = {
    "lua >= 5.1"
}
build = {
    type = "builtin",
    modules = {
        ["redis.commands"]   = "redis/commands.lua",
        ["redis.connection"] = "redis/connection.lua",
        ["redis.init"]       = "redis/init.lua",
        ["redis.keys"]       = "redis/keys.lua",
        ["redis.sets"]       = "redis/sets.lua",
        ["redis.strings"]    = "redis/strings.lua",
    }
}

-- vim: syntax=lua
