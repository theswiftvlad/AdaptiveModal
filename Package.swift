// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "AdaptiveModal",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "AdaptiveModal", targets: ["AdaptiveModal"])
    ],
    targets: [
        .target(name: "AdaptiveModal")
    ]
)
