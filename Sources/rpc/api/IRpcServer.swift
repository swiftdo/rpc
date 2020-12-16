//
//  File.swift
//  
//
//  Created by laijihua on 2020/12/16.
//

import Foundation

public protocol IRpcServer {
    func add(a: Int, b: Int) -> Int
    func sub(a: Int, b: Int) -> Int
    func mult(a: Int, b: Int) -> Int
    func div(a: Int, b: Int) -> Int 
}
