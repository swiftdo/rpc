// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rpc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.14.0"),
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.0.0-alpha.21"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
    ],
    targets: [

        .target(
            name: "rpc",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "GRPC", package: "grpc-swift"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "SwiftProtobuf"
            ]),
        .testTarget(
            name: "rpcTests",
            dependencies: ["rpc"]),
    ]
)
