//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/16.
//

import Foundation

public protocol IRpcHelloServer {
    func hello(name: String) -> String
}
