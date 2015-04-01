-- Tests extracted from suite/files.lua
local t = os.time()
T = os.date("*t", t)
loadstring(os.date([[assert(T.year==%Y and T.month==%m and T.day==%d and
  T.hour==%H and T.min==%M and T.sec==%S and
  T.wday==%w+1 and T.yday==%j and type(T.isdst) == 'boolean')]], t))()

assert(os.time(T) == t)

T = os.date("!*t", t)
loadstring(os.date([[!assert(T.year==%Y and T.month==%m and T.day==%d and
  T.hour==%H and T.min==%M and T.sec==%S and
  T.wday==%w+1 and T.yday==%j and type(T.isdst) == 'boolean')]], t))()

do
  local T = os.date("*t")
  local t = os.time(T)
  assert(type(T.isdst) == 'boolean')
  T.isdst = nil
  local t1 = os.time(T)
  assert(t == t1)   -- if isdst is absent uses correct default
end   

t = os.time(T)
T.year = T.year-1;
local t1 = os.time(T)
-- allow for leap years
assert(math.abs(os.difftime(t,t1)/(24*3600) - 365) < 2)

t = os.time()
t1 = os.time(os.date("*t"))
assert(os.difftime(t1,t) <= 2)

local t1 = os.time{year=2000, month=10, day=1, hour=23, min=12, sec=17}
local t2 = os.time{year=2000, month=10, day=1, hour=23, min=10, sec=19}
assert(os.difftime(t1,t2) == 60*2-2)

-- Test specified date
t = os.time{year=2000, month=2, day=29, hour=23, min=59, sec=59}
T = os.date("!*t", t)
loadstring(os.date([[!assert(T.year==%Y and T.month==%m and T.day==%d and
  T.hour==%H and T.min==%M and T.sec==%S and
  T.wday==%w+1 and T.yday==%j and type(T.isdst) == 'boolean')]], t))()

-- Test specified date
t = os.time{year=2000, month=3, day=30, hour=23, min=59, sec=59}
T = os.date("!*t", t)
loadstring(os.date([[!assert(T.year==%Y and T.month==%m and T.day==%d and
  T.hour==%H and T.min==%M and T.sec==%S and
  T.wday==%w+1 and T.yday==%j and type(T.isdst) == 'boolean')]], t))()

io.output(io.stdout)
local d = os.date('%d')
local m = os.date('%m')
local a = os.date('%Y')
local ds = os.date('%w') + 1
local h = os.date('%H')
local min = os.date('%M')
local s = os.date('%S')
io.write(string.format('test done on %2.2d/%2.2d/%d', d, m, a))
io.write(string.format(', at %2.2d:%2.2d:%2.2d\n', h, min, s))
io.write(string.format('%s\n', _VERSION))
