local M = {}

M.die = function(msg, code)
    code = code or ngx.HTTP_INTERNAL_SERVER_ERROR
    ngx.log(ngx.DEBUG, msg)
    ngx.status = code
	  ngx.header.content_type = 'text/html'
    ngx.say(msg)
    ngx.exit(ngx.OK)
end

M.response = function(code, body)
  body = body or 'bad request'
  ngx.header.content_type = 'text/html'
  ngx.status = code
  ngx.say(body)
  ngx.exit(code)
end

M.response_unauthorized = function()
	M.die('unauthorized', ngx.HTTP_UNAUTHORIZED)
end

M.get_file = function(file_name)
  local f = assert(io.open(file_name, 'r'))
  local string = f:read("*all")
  f:close()
  return string
end

M.is_valid_method = function(method, valid_methods)
    for _, m in ipairs(valid_methods) do
        if (m == method) then return true end
    end

    return false
end

return M