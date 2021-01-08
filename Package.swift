// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QMobileAPI",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "QMobileAPI",
            targets: ["QMobileAPI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.0.0-rc.3"),
        .package(url: "https://github.com/Moya/Moya.git", from: "14.0.0-beta.5"),
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", .revision("HEAD")),
        .package(url: "https://github.com/DaveWoodCom/XCGLogger.git", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "QMobileAPI",
            dependencies: ["XCGLogger", "Moya", "Alamofire", "SwiftyJSON"],
            path: "Sources")
    ]
)
