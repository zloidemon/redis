local function dummy(self)
    self:e_cstm("Not implimented")
end

local function sadd(self)
    if self[2] and type(self[2].data) == 'string' then
        if self[3] and type(self[3].data) == 'string' then
            self:space(true):replace({self[2].data, self[3].data})
            self:number(1) -- Always return 1, because replace without check
        else
            self:e_miss()
        end
    else
        self:e_miss()
    end
end

local function smembers(self)
    if self[2] and type(self[2].data) == 'string' then
        self:array(self:space(true).index.primary
            :count(self[2].data, {iterator = box.index.EQ}))

        for _, v in self:space(true).index.primary
                        :pairs(self[2].data, {iterator = box.index.EQ}) do
            self:bulk(v[2])
        end
    else
        self:e_miss()
    end
end

return {
    sadd        = sadd,
    scard       = dummy,
    sdiff       = dummy,
    sdiffstore  = dummy,
    sinter      = dummy,
    sinterstore = dummy,
    sismember   = dummy,
    smembers    = smembers,
    smove       = dummy,
    spop        = dummy,
    srandmember = dummy,
    srem        = dummy,
    sscan       = dummy,
    sunion      = dummy,
    sunionstore = dummy,
}
