//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/17.
//

import Foundation
import NIO


public class RpcRegistry {

    private let group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
    private var host: String
    private var port: Int

    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }

    func start() throws {
        do {
            let channel = try serverBootstrap.bind(host: host, port: port).wait()
            print("Listening on \(String(describing: channel.localAddress))...")
            try channel.closeFuture.wait()
        } catch let error {
            throw error
        }
    }

    func stop() {
        do {
            try group.syncShutdownGracefully()
        } catch let error {
            print("Error shutting down \(error.localizedDescription)")
            exit(0)
        }
        print("Client connection closed")
    }

    private var serverBootstrap: ServerBootstrap {
        return ServerBootstrap(group: group)
            // Specify backlog and enable SO_REUSEADDR for the server itself
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .serverChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .childChannelInitializer { channel in
                // Ensure we don't read faster than we can write by adding the BackPressureHandler into the pipeline.
                channel.pipeline.addHandler(BackPressureHandler()).flatMap { v in
                    channel.pipeline.addHandler(RegistryHandler())
                }
            }
            .childChannelOption(ChannelOptions.socket(IPPROTO_TCP, TCP_NODELAY), value: 1)
            // Enable SO_REUSEADDR for the accepted Channels
            .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
            .childChannelOption(ChannelOptions.maxMessagesPerRead, value: 16)
            .childChannelOption(ChannelOptions.recvAllocator, value: AdaptiveRecvByteBufferAllocator())
    }

}


class RegistryHandler: ChannelInboundHandler {
    typealias InboundIn = ByteBuffer
    typealias OutboundOut = ByteBuffer

    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        // 将 NIOAny 转化为 ByteBuffer
        var buffer = unwrapInboundIn(data)

        // 获取可读的字节数
        let readableBytes = buffer.readableBytes

        // 从 buffer 读取
        guard let received = buffer.readBytes(length: readableBytes) else {
            return
        }

        // 将 bytes 转化为 data
        let receivedData = Data(bytes: received, count: received.count)

        do {
            // 反序列化
            let movie = try Movie(serializedData: receivedData)
            print("收到: \(movie)")
            // 做其他事情
        } catch let error {
            print("error: \(error.localizedDescription)")
        }
    }

    func channelReadComplete(context: ChannelHandlerContext) {
        context.flush()
    }

    func errorCaught(context: ChannelHandlerContext, error: Error) {
        print("error: \(error.localizedDescription)")
        context.close(promise: nil)
    }
}
