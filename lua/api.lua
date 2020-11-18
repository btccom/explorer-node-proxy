local balancer = require "ngx.balancer"
local resty_roundrobin = require "resty.roundrobin"
local util = require 'lua/utils'

local request_uri = ngx.var.uri
local c = config[request_uri]
local server_list = c.upstream
if server_list == nil then util.response(403) end

-- roundrobin load balancing
local rr_up = resty_roundrobin:new(server_list)
package.loaded.my_rr_up = rr_up

local server = rr_up:find()
balancer.set_current_peer(server)