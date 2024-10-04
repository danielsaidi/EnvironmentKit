// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "EnvironmentKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v11),
        .tvOS(.v13),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "EnvironmentKit",
            targets: ["EnvironmentKit"]
        )
    ],
    targets: [
        .target(
            name: "EnvironmentKit"
        ),
        .testTarget(
            name: "EnvironmentKitTests",
            dependencies: ["EnvironmentKit"]
        )
    ]
)
