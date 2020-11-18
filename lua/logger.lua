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

local receive_headers = ngx.req.get_headers()
local content_type = receive_headers["content-type"] or receive_headers["Content-Type"]
ngx.log(ngx.ERR, content_type)
-- application/json
if string.sub(content_type, 1, 16) == "application/json" then
    ngx.req.read_body()
    local args = cjson.decode(ngx.req.get_body_data())
    req["post_args"] = args
end
-- application/x-www-form-urlencoded
if string.sub(content_type, 1, 32) == "application/x-www-form-urlencoded" then
    req["post_args"] = ngx.req.get_post_args()
end
req["body"] = ngx.var.request_body

content_type = getval(ngx.var.CONTENT_TYPE, "")

resp["headers"] = ngx.resp.get_headers()
resp["status"] = ngx.status
resp["duration"] = ngx.var.upstream_response_time
resp["time"] = ngx.now()
resp["body"] = ngx.var.response_body

ngx.log(ngx.CRIT, cjson.encode(data));