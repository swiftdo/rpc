//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/19.
//

import GRPC
import NIO
import SwiftProtobuf
import Foundation

final class EchoServerImpl : EchoServerProvider {

    /// 这是个拦截器，这里我们不需要拦截器，跟 Vapor 的中间件很像
    var interceptors: EchoServerServerInterceptorFactoryProtocol?

    /// 方法具体实现。将接收数据打屏，并设置返回数据到response中。
    func echo(request: EchoRequest, context: StatusOnlyCallContext) -> EventLoopFuture<EchoResponse> {

        print("接收到客户端的数据: \(request.message)")

        let response = EchoResponse.with {
            $0.message = "oldbirds server echo get: " + request.message
        }
        return context.eventLoop.makeSucceededFuture(response)
    }
}
