//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/17.
//

import Foundation

public class RpcHelloServerImpl : IRpcHelloServer {
    public func hello(name: String) -> String {
        "Hello " + name + "!"
    }
}
