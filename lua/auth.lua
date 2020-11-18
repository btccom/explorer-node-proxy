local cjson = require 'cjson'
local os = require 'os'
local util = require 'lua/utils'
local config = require 'lua/config'

ngx.req.read_body()
local body = ngx.req.get_body_data()

if body == nil then
    local file_name = ngx.req.get_body_file()
    if file_name then
        body = util.get_file(file_name)
    end
end

local request_uri = ngx.var.uri
local c = config[request_uri]
if c == nil then util.response(403) end

local valid_methods = c.valid_method
-- if not body then util.response(400) end
-- local json = cjson.decode(body)
-- local method = json.method or ''
-- if not utils.is_valid_method(method, valid_methods) then
--     util.response(400, 'invalid method: ' .. method)
-- end

ngx.req.set_header('Authorization', 'Basic ' .. c.authorization.baseauthorization)