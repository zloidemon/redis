local function ping(self)
    self:string("PONG")
end

local function quit(self)
    self:ok()
end 

local function dummy(self)
    self:e_cstm("Not implimented")
end

local function echo(self)
    self:bulk(self[2].data)
end

local function select(self)
    if self.spaces[self[2].data] then
        self.space = self.spaces[self[2].data]
        self:ok()
    else
        self:s_cstm("Space not found")
    end
end

return {
    auth = dummy,
    echo = echo,
    ping = ping,
    quit = quit,
    select = select,
}
