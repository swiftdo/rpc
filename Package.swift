// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rpc",
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(name: "SwiftProtobuf", url: "https://github.com/apple/swift-protobuf.git", from: "1.14.0")
    ],
    targets: [

        .target(
            name: "rpc",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                "SwiftProtobuf"
            ]),
        .testTarget(
            name: "rpcTests",
            dependencies: ["rpc"]),
    ]
)
