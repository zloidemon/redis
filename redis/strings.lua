local function dummy(self)
    self:e_cstm("Not implimented")
end

local function get(self)
    if not self[2] or type(self[2].data) ~= 'string' then
        self:e_cstm("WRONGTYPE wrong kind of value")
    end
    local ret = box.space[self.space]:get({self[2].data})
    if not ret then
        self:null()
    else
        self:bulk(ret[2])
    end
end

local function set(self)
    if self[2] and type(self[2].data) == 'string' then
        if self[3] and type(self[3].data) == 'string' then
            box.space[self.space]:replace({self[2].data, self[3].data})
            self:ok()
        else
            self:e_miss()
        end
    else
        self:e_miss()
    end
end

local function mget(self)
    local ret = nil
    self:array(self.len - 1)
    for i=2, self.len do
        ret = box.space[self.space]:get({self[i].data})
        if ret then
            self:bulk(ret[2])
        else
            self:null()
        end
    end
end

local function strlen(self)
    if not self[2] then
        self:e_miss()
    else
        self:number(string.len(self[2].data))
    end
end

return {
    append      = dummy,
    bitcount    = dummy,
    bitop       = dummy,
    bitpos      = dummy,
    decr        = dummy,
    decrby      = dummy,
    get         = get,
    getbit      = dummy,
    getrange    = dummy,
    getset      = dummy,
    incr        = dummy,
    incrby      = dummy,
    incrbyfloat = dummy,
    mget        = mget,
    mset        = dummy,
    msetnx      = dummy,
    psetex      = dummy,
    set         = set,
    setbit      = dummy,
    setex       = dummy,
    setnx       = dummy,
    setrange    = dummy,
    strlen      = strlen,
}
