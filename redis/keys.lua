local function dummy(self)
    self:e_cstm("Not implimented")
end

local function del(self)
    local counter = 0
    for i=2, self.len do
        if self:space():delete({self[i].data}) then
            counter = counter + 1
        end
    end
    self:number(counter)
end

local function exists(self)
    if self.len ~= 2 then
        self:e_miss()
    end
    if self:space():get({self[2].data}) then
        self:number(1)
    else
        self:number(0)
    end
end

return {
    del       = del,
    dump      = dummy,
    exists    = exists,
    expire    = dummy,
    expireat  = dummy,
    keys      = dummy,
    migrate   = dummy,
    move      = dummy,
    object    = dummy,
    persist   = dummy,
    pexpire   = dummy,
    pexpireat = dummy,
    pttl      = dummy,
    randomkey = dummy,
    rename    = dummy,
    renamenx  = dummy,
    restore   = dummy,
    scan      = dummy,
    sort      = dummy,
    ttl       = dummy,
    type      = dummy,
    wait      = dummy,
}
