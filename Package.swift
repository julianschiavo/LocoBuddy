// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocoBuddy",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .executable(name: "LocoBuddy", targets: ["LocoBuddy"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.2")
    ],
    targets: [
        .target(name: "LocoBuddy", dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")])
    ]
)
