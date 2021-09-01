# explorer-node-proxy

区块链节点 Proxy

## 介绍

lua 实现的一种面对多币种 rpc 的代理


## 设计

配置文件 yaml / json

## 安装

```
$ luarocks install lua-resty-balancer
```

## 使用

```
cp lua/config.example.lua lua/config.lua
docker-compose up -d

准备好节点

开始了
```

## 未来特性

+ 健康检查

## 目前问题

+ lua 负载均衡后端暂不支持域名方式
+ 增加 rpc 方法验证

## 参考资料

+ [apisix](https://github.com/apache/apisix)
+ [phi](https://github.com/Justinmad/phi)