## Demo

### Nginx 配置

```
location /demo {
    default_type text/html;
    content_by_lua_file "/lua/demo.lua";
}
```

### Lua 代码

```
ngx.say("hello world")
```