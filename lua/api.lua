local cjson = require 'cjson'
local args = ngx.req.get_uri_args()

local response = ngx.location.capture('/bitcoind', {
    method = ngx.HTTP_POST,
    body = ngx.req.get_body_data()
})

local body = response.body

ngx.header.content_type = response.header['Content-Type']