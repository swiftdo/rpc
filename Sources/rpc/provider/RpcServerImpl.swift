//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/17.
//

import Foundation

public class RpcServiceImpl : IRpcServer {

    public func add(a: Int, b: Int) -> Int {
        a + b
    }

    public func sub(a: Int, b: Int) -> Int {
        a - b
    }

    public func mult(a: Int, b: Int) -> Int {
        a * b
    }

    public func div(a: Int, b: Int) -> Int {
        a / b
    }
}
