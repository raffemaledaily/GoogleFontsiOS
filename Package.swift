// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoogleFontsiOS",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "GoogleFontsiOS",
            targets: ["GoogleFontsiOS"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "GoogleFontsiOS",
            path: "Pod",
            sources: ["Classes"],
            resources: [
                .process("Assets/Fonts/Roboto"),
                .process("Assets/Fonts/Poppins"),
            ],
            publicHeadersPath: "Include",
            cSettings: [
                .headerSearchPath("Roboto"),
                .headerSearchPath("Poppins"),
                .headerSearchPath("Loader"),
            ]
        ),
    ]
)
