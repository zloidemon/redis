local connection = require('redis.connection')
local strings    = require('redis.strings')
local keys       = require('redis.keys')
local sets       = require('redis.sets')

return {
    -- Connection section
    ['auth']   = connection.auth,
    ['echo']   = connection.echo,
    ['ping']   = connection.ping,
    ['quit']   = connection.quit,
    ['select'] = connection.select,
    -- Strings section
    ['append']   = strings.append,
    ['bitcount'] = strings.bitcount,
    ['bitop']    = strings.bitop,
    ['bitpos']   = strings.bitpos,
    ['decr']     = strings.decr,
    ['decrby']   = strings.decrby,
    ['get']      = strings.get,
    ['getbit']   = strings.getbit,
    ['getrange'] = strings.getrange,
    ['getset']   = strings.getset,
    ['incr']     = strings.incr,
    ['incrby']   = strings.incrby,
    ['incrbyfloat']= strings.incrbyfloat,
    ['mget']     = strings.mget,
    ['mset']     = strings.mset,
    ['msetnx']   = strings.msetnx,
    ['psetex']   = strings.psetex,
    ['set']      = strings.set,
    ['setbit']   = strings.setbit,
    ['setex']    = strings.setex,
    ['setnx']    = strings.setnx,
    ['setrange'] = strings.setrange,
    ['strlen']   = strings.strlen,
    -- Keys section
    ['del']       = keys.del,
    ['dump']      = keys.dump,
    ['exists']    = keys.exists,
    ['expire']    = keys.expire,
    ['expireat']  = keys.expireat,
    ['keys']      = keys.keys,
    ['migrate']   = keys.migrate,
    ['move']      = keys.move,
    ['object']    = keys.object,
    ['persist']   = keys.persist,
    ['pexpire']   = keys.pexpire,
    ['pexpireat'] = keys.pexpireat,
    ['pttl']      = keys.pttl,
    ['randomkey'] = keys.randomkey,
    ['rename']    = keys.rename,
    ['renamenx']  = keys.renamenx,
    ['restore']   = keys.restore,
    ['scan']      = keys.scan,
    ['sort']      = keys.sort,
    ['ttl']       = keys.ttl,
    ['type']      = keys.type,
    ['wait']      = keys.wait,
    -- Sets section
    ['sadd']        = sets.sadd,
    ['scard']       = sets.scard,
    ['sdiff']       = sets.sdiff,
    ['sdiffstore']  = sets.sdiffstore,
    ['sinter']      = sets.sinter,
    ['sinterstore'] = sets.sinterstore,
    ['sismember']   = sets.sismember,
    ['smembers']    = sets.smembers,
    ['smove']       = sets.smove,
    ['spop']        = sets.spop,
    ['srandmember'] = sets.srandmember,
    ['srem']        = sets.srem,
    ['sscan']       = sets.sscan,
    ['sunion']      = sets.sunion,
    ['sunionstore'] = sets.sunionstore,
}
