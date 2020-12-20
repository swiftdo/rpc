//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/19.
//


import Foundation
import GRPC
import NIO

final class RpcServer {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
    private var host: String
    private var port: Int

    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }

    func start() throws {
        let server = Server.insecure(group: group)
            .withServiceProviders([EchoServerImpl()])
            .bind(host: host, port: port)

        server.map {
            $0.channel.localAddress
        }.whenSuccess { address in
            print("server started on port \(address!.port!)")
        }

        _ = try server.flatMap {
            $0.onClose
        }.wait()
    }

    func stop() {
        do {
            try group.syncShutdownGracefully()
        } catch {
            print("Error shutting down \(error.localizedDescription)")
            exit(0)
        }
        print("Client connection closed")
    }
}
