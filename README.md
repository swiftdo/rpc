# rpc

SwiftNIO simple RPC, just for learn!

##  模块

* Registry 注册中心，负责保存所有可用的服务名称和服务地址
* Provider 服务端，实现对外提供的所有服务的具体工鞥
* Consumer 客户端
* Monitor 监控中心，完成调用链监控
* API  主要定义对外开发的功能与服务接口
* Protocol 主要定义自定义传输协议的内容
