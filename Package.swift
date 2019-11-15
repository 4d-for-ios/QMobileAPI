// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QMobileAPI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "QMobileAPI",
            targets: ["QMobileAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/DaveWoodCom/XCGLogger.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "QMobileAPI",
            dependencies: ["XCGLogger"],
            path: "Sources")
    ]
)
