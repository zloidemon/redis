local socket   = require('socket')
local logger   = require('log')
local commands = require('redis.commands')

local tools = {
    e_miss = function(self)
        self.s:write("-ERR wrong number of arguments for '" .. self[1].data .. "' command\r\n")
    end,
    e_cstm = function(self, text)
        self.s:write(string.format("-ERR %s\r\n", text))
    end,
    number = function(self, num)
        self.s:write(string.format(":%s\r\n", num))
    end,
    null   = function(self)
        self.s:write("$-1\r\n")
    end,
    ok     = function(self)
        self:string("OK")
    end,
    string = function(self, str)
        self.s:write("+" .. str .. "\r\n")
    end,
    bulk   = function(self, str)
        self.s:write("$" .. string.len(str) .. "\r\n")
        self.s:write(str .. "\r\n")
    end,
    array  = function(self, size)
        self.s:write("*" .. size .. "\r\n")
    end,
    space  = function(self, mult)
        if mult then
            local name = string.format('redis_%s_kk', self.index)
            if not box.space[name] then
                space = box.schema.space.create(name)
                space:create_index('keykey',
                    {type='HASH', parts = {1, 'STR', 2, 'STR'}})
                space:create_index('primary',
                    {type='TREE', parts = {1, 'STR'}, unique = false})
            end
            return box.space[name]
        end
        local name = string.format('redis_%s_kv', self.index)
        if not box.space[name] then
            space = box.schema.space.create(name)
            space:create_index('primary',
                {type='HASH', parts = {1, 'STR'}})
        end
        return box.space[name]
    end,
}

local function process_request(self, s, peer)
    local request = {
        index = '0'
    }
    local command = nil
    local counter = 0
    while true do
        local req = s:read({delimiter='\r\n'})

        if not req then
            break
        end

        if request.len ~= nil then
            if request[counter] then
                if request[counter].size and request[counter].size > 0 then
                    request[counter].data = string.match(req, '^(.+)\r\n$')
                    if request[counter].data then
                        counter = counter + 1
                    end
                end
            else
                request[counter] = {
                    size = tonumber(string.match(req, '^$(%d+)\r\n$'))
                }
            end
        else
            request.len = tonumber(string.match(req, '^*(%d+)\r\n$'))
            counter = counter + 1
            -- Close connection if client closed socket
            if not request.len then
                logger.debug('Close connection')
                break
            end
        end
        if request.len and counter > request.len then
            request.s      = s
            request.spaces = self.spaces

            setmetatable(request, {__index=tools})

            command = string.lower(request[1].data)
            if self.commands[command] then
                self.commands[command](request)
            else
                request:e_cstm(string.format("unknown command '%s'", command))
            end
            request = {
                index = request.index
            }
            command = nil
            counter = 0
        end
    end
end

local function redis_stop(self)
    if type(self) ~= 'table' then
        error('redis server can not stopped')
    end
    if self.is_run then
        self.is_run = false
    else
        error('server is already stopped')
    end

    if self.tcp_server ~= nil then
        self.tcp_server:close()
        self.tcp_server = nil
    end
    return self
end

local function redis_start(self)
    if type(self) ~= 'table' then
        error('redis server can not start')
    end

    local server = socket.tcp_server(self.host, self.port, {name='redis',
        handler = function(...) process_request(self, ...) end})

    rawset(self, 'is_run', true)
    rawset(self, 'tcp_server', server)
    rawset(self, 'self', redis_stop)
    return self
end

local function redis_command(self, name, sub)
    if not name or type(name) ~= 'string' then
        error('incorrect name, must be string')
    end

    if not sub or type(sub) ~= 'function' then
        error('incorrect id type, must be function')
    end

    self.commands[name] = sub
    logger.info("Redis command %s customized", name)
    return self
end

local export = {
    new = function(host, port, opts)
        local options = {}
        if type(host) ~= 'string' then
            error('host must to be string')
        end
        if type(port) ~= 'number' then
            error('port must to be number')
        end
        local self = {
            host     = host,
            port     = port,
            is_run   = false,
            spaces   = {},
            start    = redis_start,
            stop     = redis_stop,
            command  = redis_command,
            commands = commands,
        }
        return self
    end
}
return export
