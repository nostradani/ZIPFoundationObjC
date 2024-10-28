// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ZIPFoundationObjC",
    platforms: [
           .macOS(.v10_11), .iOS(.v9), .tvOS(.v9), .watchOS(.v2)
       ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ZIPFoundationObjC",
            targets: ["ZIPFoundationObjC"]),
    ],
    dependencies: [
        // Add the ZipFoundation dependency here.
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", from: "0.9.19"),
    ],
    targets: [
        // Targets define modules or test suites.
        .target(
            name: "ZIPFoundationObjC",
            dependencies: ["ZIPFoundation"]),
    ],
    swiftLanguageVersions: [.v4, .v4_2, .v5]
)
