local balancer = require "ngx.balancer"
local resty_roundrobin = require "resty.roundrobin"

local server_list = {
  ["127.0.0.1:1985"] = 2,
  ["127.0.0.1:1986"] = 2,
  ["127.0.0.1:1987"] = 1,
}

local rr_up = resty_roundrobin:new(server_list)
package.loaded.my_rr_up = rr_up

local server = rr_up:find()
balancer.set_current_peer(server)