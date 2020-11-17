FROM openresty/openresty:alpine-fat
RUN apk add git
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-balancer
