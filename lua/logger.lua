ngx.log(ngx.ERR, "REQUEST capturing started")
local cjson = require 'cjson'

function getval(v, def)
  if v == nil then
     return def
  end
  return v
end

local data = {request={}, response={}}

local req = data["request"]
local resp = data["response"]
req["host"] = ngx.var.host
req["uri"] = ngx.var.uri
req["headers"] = ngx.req.get_headers()
req["time"] = ngx.req.start_time()
req["method"] = ngx.req.get_method()
req["get_args"] = ngx.req.get_uri_args()


req["post_args"] = ngx.req.get_post_args()
req["body"] = ngx.var.request_body

content_type = getval(ngx.var.CONTENT_TYPE, "")

resp["headers"] = ngx.resp.get_headers()
resp["status"] = ngx.status
resp["duration"] = ngx.var.upstream_response_time
resp["time"] = ngx.now()
resp["body"] = ngx.var.response_body

ngx.log(ngx.CRIT, cjson.encode(data));