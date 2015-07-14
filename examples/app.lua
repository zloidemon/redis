#!/usr/bin/env tarantool

box.cfg{slab_alloc_arena = 0.1}

r = require('redis')

local  function pp(self)
    self.s:write('+TEST\r\n')
end

redis = r.new('127.0.0.1', 6379)
    :command('ping', pp) 
    :space({id='0', name='main'})
    :space({id='1', name='ololo'})
    :start()
