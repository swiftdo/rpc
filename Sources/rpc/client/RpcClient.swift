//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/19.
//

import Foundation
import NIO
import GRPC

func great(name: String, client: EchoServerClient) throws {
    let request = EchoRequest.with {
        $0.message = name
    }

    let say = client.echo(request)

    let response = try say.response.wait()
    print("收到服务器返回：\(response.message)")
}

final class RpcClient {
    private let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

    private var host: String
    private var port: Int

    init(host: String, port: Int) {
        self.host = host
        self.port = port
    }

    func start(name: String) throws {
        let channel = ClientConnection.insecure(group: group)
            .connect(host: host, port: port)
        let echoClient = EchoServerClient(channel: channel)
        try great(name: name, client: echoClient)
        try channel.close().wait()
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

}

